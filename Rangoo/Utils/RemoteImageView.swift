//
//  RemoteImageView.swift
//  Rangoo
//
//  Created by Débora Cristina Silva Ferreira on 15/03/26.
//

import Foundation
import UIKit

// MARK: - Subclasse de UIImageView
// Herda tudo que um UIImageView faz, mas agora tem uma função extra para carregar imagens da internet.
class RemoteImageView: UIImageView {
    
    // MARK: - Definicao de variaveis
    //Guarda qual imagem essa view deveria estar mostrando.
    private var currentURL: URL?
    
    
    // MARK: - funcao que recebe a URL da imagem.
    func load(url: URL) {
        
        //Guarda a url atual , se a célula for reutilizada depois, esse valor muda.
        currentURL = url
        //Criação de uma thread em background porque baixar imagem da internet pode ser lento
        
        let key = url.absoluteString as NSString

        // Verifica cache
        if let cachedImage = ImageCache.shared.object(forKey: key) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            
            //Baixando  os dados da imagem
            if let data = try? Data(contentsOf: url),
               //Agora o iOS converte os bytes da imagem em um objeto que o UIKit consegue mostrar.
               let image = UIImage(data: data) {
                
                ImageCache.shared.setObject(image, forKey: key)

                
                // Volta para a thread principalpara atualizar a ui
                DispatchQueue.main.async {
                    
                    // Verifica se a UIImage View  ainda quer a imagem
                    if self?.currentURL == url {
                        self?.image = image
                    }
                }
            }
        }
    }
}

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}
