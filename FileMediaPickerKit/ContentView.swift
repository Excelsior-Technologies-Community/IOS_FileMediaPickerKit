//
//  ContentView.swift
//  FileMediaPickerKit
//
//  Created by Noman belim on 29/12/25.
//

import SwiftUI
struct ContentView: View {

    @State private var showPicker = false
    @State private var pickerType: SwiftUIMediaType = .image

    @State private var pickedImage: UIImage?
    @State private var pickedVideoURL: URL?
    @State private var pickedPDFURL: URL?

    var body: some View {
        VStack(spacing: 20) {

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

            if let pickedImage {
                Image(uiImage: pickedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }

            if let pickedVideoURL {
                Text("🎥 \(pickedVideoURL.lastPathComponent)")
            }

            if let pickedPDFURL {
                Text("📄 \(pickedPDFURL.lastPathComponent)")
            }
        }
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
        .padding()
    }
}


#Preview {
    ContentView()
}
