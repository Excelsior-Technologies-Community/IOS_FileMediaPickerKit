# 📁 File & Media Picker (SwiftUI)

A simple SwiftUI utility to select **Images**, **Videos**, and **PDF / Files** from the device using **system pickers**, with clean result handling and minimal setup.

This project focuses on **easy implementation**, not complex APIs.

---

## ✨ Features

* 📸 Pick Images from Photo Library
* 🎥 Pick Videos from Photo Library
* 📄 Pick PDF / Files using system document picker
* 🧩 Clean SwiftUI API
* 🧼 Minimal code in your View
* 📱 iOS 15+ compatible
* 🔐 App Store safe (uses system pickers)

---

## 📦 Files Included

| File                          | Purpose                       |
| ----------------------------- | ----------------------------- |
| `SwiftUIMediaPickerKit.swift` | Reusable SwiftUI media picker |
| `ContentView.swift`           | Example usage                 |

---

## 🚀 How It Works (High Level)

* Uses **system pickers** (Photo Library & Document Picker)
* Wraps UIKit internally (hidden from you)
* Returns selected media via a **single callback**
* You decide how to store or display the result

You **do not** deal with delegates or permissions logic.

---

## 🛠 Setup

### 1️⃣ Add Permission (Required)

Add this to **Info.plist**:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>Allow access to select images and videos.</string>
```

📌 No permission needed for PDF / file picker.

---

### 2️⃣ Add the Media Picker File

Copy this file into your project:

* `SwiftUIMediaPickerKit.swift` 

---

## 🧑‍💻 Usage in SwiftUI

### Step 1: Create State Variables

```swift
@State private var showPicker = false
@State private var pickerType: SwiftUIMediaType = .image

@State private var pickedImage: UIImage?
@State private var pickedVideoURL: URL?
@State private var pickedPDFURL: URL?
```

---

### Step 2: Trigger Picker (Buttons)

```swift
Button("Pick Image") {
    pickerType = .image
    showPicker = true
}

Button("Pick Video") {
    pickerType = .video
    showPicker = true
}

Button("Pick PDF") {
    pickerType = .pdf
    showPicker = true
}
```

---

### Step 3: Present Picker & Handle Result

```swift
.sheet(isPresented: $showPicker) {
    SwiftUIMediaPicker(type: pickerType) { result in
        switch result {
        case .image(let image):
            pickedImage = image

        case .video(let url):
            pickedVideoURL = url

        case .file(let url):
            pickedPDFURL = url
        }
        showPicker = false
    }
}
```

---

### Step 4: Use Picked Data

```swift
if let pickedImage {
    Image(uiImage: pickedImage)
        .resizable()
        .scaledToFit()
}

if let pickedVideoURL {
    Text(pickedVideoURL.lastPathComponent)
}

if let pickedPDFURL {
    Text(pickedPDFURL.lastPathComponent)
}
```

📄 Full working example is available in `ContentView.swift` 

---

## 📂 Supported Media Types

| Type  | Picker Used            |
| ----- | ---------------------- |
| Image | Photo Library          |
| Video | Photo Library          |
| PDF   | System Document Picker |

---

## ❓ FAQ

### Do I need camera permission?

❌ No — unless you add camera capture manually.

### Does this work on Simulator?

* Image/Video → Limited
* PDF/File → Yes
  👉 Best tested on a real device.

### Can I extend this?

Yes. You can easily add:

* Multiple selection
* More file types
* Video preview
* Image compression
 