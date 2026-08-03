<div align="center">

# 🍳 Rangoo

**An iOS app for discovering and managing recipes**

Built with UIKit + ViewCode, following the MVVM-C architecture 💫

![Swift](https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white)
![UIKit](https://img.shields.io/badge/UIKit-2396F3?style=for-the-badge&logo=uikit&logoColor=white)
![Combine](https://img.shields.io/badge/Combine-FA7343?style=for-the-badge&logo=swift&logoColor=white)
![Core Data](https://img.shields.io/badge/Core%20Data-4B8BBE?style=for-the-badge&logo=apple&logoColor=white)
![Xcode](https://img.shields.io/badge/Xcode-147EFB?style=for-the-badge&logo=xcode&logoColor=white)

![Platform](https://img.shields.io/badge/platform-iOS-lightgrey?style=flat-square)
![Architecture](https://img.shields.io/badge/architecture-MVVM--C-blueviolet?style=flat-square)
![Status](https://img.shields.io/badge/status-in%20development-yellow?style=flat-square)

</div>

---

This project was created to practice fundamental and advanced concepts of native iOS development, including architecture, data persistence, API consumption, and reactive programming.

---

## 📱 Preview

<div align="center">

| 🏠 Home | 📖 Details | 🛒 Grocery List |
|:---:|:---:|:---:|
| <img width="200" height="400" alt="Home screen" src="https://github.com/user-attachments/assets/e54c6076-0f9c-4658-a755-788caf52de81" /> | <img width="200" height="400" alt="Recipe details screen" src="https://github.com/user-attachments/assets/f35a4fef-5dd6-42ab-b4b2-c38fa35a3571" /> | <img width="200" height="400" alt="Grocery list screen" src="https://github.com/user-attachments/assets/ca7bb32d-f3d9-4aeb-bccb-247a2ade1063" /> |

</div>

---

## ✨ Features

- 🔍 **Recipe search** through a REST API.
- 📖 **Recipe details**, displaying information such as ingredients, preparation steps, and other recipe details.
- 🛒 **Grocery list creation**, allowing users to add, edit, and remove items to organize the ingredients they need.

---

## 🛠 Tech Stack

<div align="center">

| Layer | Technologies |
|---|---|
| **Language** | Swift |
| **UI** | UIKit, ViewCode, Auto Layout |
| **Architecture** | MVVM-C |
| **Reactive** | Combine |
| **Persistence** | Core Data, FileManager |
| **Networking** | URLSession, Codable |

</div>

---

## 🏛 Architecture

This project was built using the **MVVM-C (Model-View-ViewModel-Coordinator)** architecture and organized by **features**, promoting a clear separation of concerns, better modularization, and easier maintenance.

Each feature has its own structure containing:

| Component | Responsibility |
|---|---|
| 🎨 **View** | Responsible for the UI, built with UIKit and ViewCode |
| 🧠 **ViewModel** | Holds the presentation logic and communication with the service layer |
| 🧭 **Coordinator** | Manages the feature's entire navigation flow |

The app's models are centralized in the **Model** folder, API consumption is handled by the **Service** layer, reusable components live in **Components**, and shared utilities are in **Utils**.

---

## 📂 Project Structure

```text
Rangoo
│
├── App
│   └── Initial app configuration
│
├── Components
│   └── Reusable components
│
├── Features
│   ├── Recipes
│   │   ├── Coordinator
│   │   ├── View
│   │   └── ViewModel
│   │
│   └── GroceryList
│       ├── Coordinator
│       ├── View
│       └── ViewModel
│
├── Model
│   └── App models
│
├── Service
│   └── API consumption and data management
│
└── Utils
    └── Extensions and utilities
```

---

## 🌐 API Consumption

The app performs HTTP requests using **URLSession**.

Data received from the API is decoded into Swift models using **Codable**, while **Combine** is used to manage the asynchronous data flow.

---

## 💾 Persistence

🗂️ Grocery lists are stored locally using **Core Data**, ensuring that items added by the user persist across app sessions.

⚡ Additionally, data fetched from the API is cached locally using **FileManager**, reducing unnecessary requests and improving the user experience in unstable connection scenarios.

---

## 📚 Concepts Applied

<div align="center">

`MVVM-C` `Coordinator Pattern` `Combine` `Core Data` `FileManager` `REST APIs` `Codable` `URLSession` `Auto Layout` `UIKit` `ViewCode` `Separation of Concerns`

</div>

---

## 🚀 Getting Started

1. Clone this repository
   ```bash
   git clone https://github.com/yourusername/Rangoo.git
   ```

2. Open the project in Xcode
   ```text
   Rangoo.xcodeproj
   ```

3. Run it on a simulator or physical device. 🎉

---

## 🎯 Goal

This project was built to deepen my knowledge of iOS development with UIKit, applying good practices in architecture, code organization, and data persistence.

---

## 🔮 Future Improvements

- [ ] Unit tests
- [ ] UI tests
- [ ] Internationalization
- [ ] Dark mode
- [ ] Advanced recipe search
- [ ] Accessibility improvements

---

<div align="center">

## 👩‍💻 Developed by

**Débora Cristina Silva Ferreira**

[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/yourusername)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/yourprofile)

</div>
