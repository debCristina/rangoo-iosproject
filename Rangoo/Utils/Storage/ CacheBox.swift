//
//   CacheBox.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 15/03/26.
//
import Foundation

//Struct que guarda quando o dado foi salvo no cache e o dado que deve ser armazenado
// Permite codificar e decodificar o objeto em JSON para salvar no disco.
struct CachedData<T: Codable>: Codable {
    let timestamp: Date
    let data: T
}

//Envolve qualquer valor T para que possa ser armazenado no NSCache.
//Transforma qualquer valor em um objeto de classe que NSCache consegue armazenar.
final class CacheBox <T> {
    let value: T
    
    init(value: T) {
        self.value = value
    }
}

// Um wrapper genérico que permite usar qualquer tipo como chave
final class MemoryCache<Key: Hashable, Value> {
    // Cria um cache genérico na memoria
    private let cache = NSCache<WrappedKey, CacheBox<Value> > ()
    
    // Cria um WrappedKey para a chave → permite NSCache aceitar qualquer Hashable.
    // Cria um CacheBox para o valor, permite NSCache aceitar structs.
    // Salva no cache de memória.
    func set(_ value: Value, for key: Key) {
        let wrappedKey = WrappedKey(key)
        cache.setObject(CacheBox(value: value), forKey: wrappedKey)
    }
    
    // Cria WrappedKey com a chave fornecida.
    // Busca no NSCache.
    // Retorna o valor dentro do CacheBox (ou nil se não existir).
    func get(for key: Key) -> Value? {
        let wrappedKey = WrappedKey(key)
        return cache.object(forKey: wrappedKey)?.value
    }
    
    //Remove um item específico do cache de memória.
    // Mantém o cache limpo, evita que dados antigos fiquem ocupando memória.
    func remove(for key: Key) {
        cache.removeObject(forKey: WrappedKey(key))
    }
}

// Permite usar qualquer tipo Hashable como chave em NSCache (que precisa de NSObject).
final  class  WrappedKey : NSObject {
    
    //Armazena a chave original
    let key: AnyHashable
    
    //Recebe a chave
    //Salva na propriedade key.
    init ( _  key : AnyHashable ) {
        self .key = key
    }
    
    // NSCache usa hash para armazenar e localizar rapidamente os objetos.
    // Retorna o hash da chave original (key.hashValue).
    override  var hash: Int { key.hashValue }
    
    //NSCache também precisa saber quando duas chaves são iguais, não apenas o hash.
    override func isEqual(_ object: Any?) -> Bool {
        //Verifica se o outro objeto é do mesmo tipo.
        // Se não for, retorna false → não são iguais
        guard  let other = object as?  WrappedKey  else { return  false }
        
        // Compara a chave original (AnyHashable) para ver se são realmente iguais.
        return key == other.key
    }
}

// Funcao para salvar dados no disco
final class DiskCache<Value: Codable> {
    
    //armazena a URL da pasta no disco onde os dados serão salvos.
    private let directory: URL
    

    init (folderName: String) {
        //Garante que a pasta existe se não, cria.
        let baseURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        
        // Cria uma subpasta específica para o cache
        directory = baseURL.appendingPathComponent(folderName)
        
        //Pega a pasta de cache padrão do app no dispositivo
        try? FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
    }
    
    // salva um valor no disco.
    func set(_ value: Value, for key: String) {
        //cria o caminho completo para o arquivo
        let url = directory.appendingPathComponent(key)
        //transforma o valor em dados binários
        let data = try? JSONEncoder().encode(value)
        //escreve o arquivo no disco.
        try? data?.write(to: url)
    }
    
    //recupera um valor do disco.
    func get(for key: String) -> Value? {
        
        //cria o caminho do arquivo a ser lido.
        let url = directory.appendingPathComponent(key)
        
        // lê o arquivo e retorna nil se não existir ou houver erro.
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        //decodifica o JSON de volta para o tipo Value.
        return try? JSONDecoder().decode(Value.self, from: data)
    }

}

//Cache híbrido: combina memória (rápida) e disco (persistente).
final class HybridCache<Key: Hashable, Value: Codable> {
    //cache em memória usando MemoryCache.
    private let memoryCache = MemoryCache<Key, CachedData<Value>>()
    
    // cache persistente em disco, salva CachedData<Value> (incluindo timestamp).
    private let diskCache = DiskCache<CachedData<Value>>(folderName: "HybridCache")
    
    //empo de vida do cache, aqui definido como 3600 segundos (1 hora).
    private let ttl: TimeInterval = 3600
    
    func set(_ value: Value, for key: Key) {
        //encapsula o dado com o timestamp atual.
        let cached = CachedData(timestamp: Date(), data: value)
        //salva na memória para acesso rápido.
        memoryCache.set(cached, for: key)
        //salva no disco, convertendo a chave para String para criar o arquivo.
        diskCache.set(cached, for: "\(key)")
    }
    
    func get(for key: Key) -> Value? {
       // tenta buscar na memória.
        if let cached = memoryCache.get(for: key),
           // verifica se o cache ainda é válido (menos de 1 hora).
            Date().timeIntervalSince(cached.timestamp) < ttl {
            return cached.data
        }
        
        // Se memória não tiver ou expirou tenta no disco
        if let cached = diskCache.get(for: "\(key)"), Date().timeIntervalSince(cached.timestamp) < ttl {
            memoryCache.set(cached, for: key)
            return cached.data
        }
        
        return nil
    }
}
