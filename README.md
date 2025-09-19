# Reader – News Reader App
Reader is a news reader app built using MVVM architecture, integrating Newsapi API to display
top headlines, enable search, and manage bookmarks with persistent local storage using
Core Data.

## Architecture
The app follows the **Model-View-ViewModel (MVVM)** architecture to maintain a clean
separation of concerns, modular code structure, and improved testability.

## Folder Structure
```
Reader/
├── App/ |── MainTab/
│ ├── Home/ │ │ 
│ │ ├── View/
│ │ ├── ViewModel/
│ ├── Bookmark/ │ ├── Model/
│ ├── View/
│ ├── ViewModel/
```

* Home screen features
* Bookmark screen features
* Custom Tab Bar Controller
* API Layer (requests, models, decoding, etc.)
* Local storage management (DataManager, entities)
## Summary
| Layer | Responsibility |
|---------------|-------------------------------------------|
| Model | API
| View | view controllers, cell
| ViewModel | Logic, data transformation, bindings
| Api Service  | API calls
| Core Data | Persistent storage

## Screenshots

<img height="400px" alt="Simulator Screenshot - iPhone 16 - 2025-09-19 at 10 38 30" src="https://github.com/user-attachments/assets/365c6967-4bed-4f41-ad25-3dd5fdfa1bfd" />
<img height="400px" alt="Simulator Screenshot - iPhone 16 - 2025-09-19 at 10 38 23" src="https://github.com/user-attachments/assets/cc105171-80b1-4966-ad43-7882c107f1d9" />

## Features (All the features implemented mentioned in Task doc)
* Home screen where user can see all the top headlines
* Pull to refreash feature
* User can bookmark any article
* Bookmark tab for accessing bookmark articles
* User can search article 
* Light/Dark Mode
  
