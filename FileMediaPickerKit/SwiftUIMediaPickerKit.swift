//
//  SwiftUIMediaPickerKit.swift
//  FileMediaPickerKit
//
//  Created by Noman belim  
//

import Foundation
import SwiftUI
import UIKit
import UniformTypeIdentifiers

// MARK: - Media Type
public enum SwiftUIMediaType {
    case image
    case video
    case pdf
}

// MARK: - SwiftUI Media Picker View
public struct SwiftUIMediaPicker: UIViewControllerRepresentable {

    let type: SwiftUIMediaType
    let onResult: (Result) -> Void

    public enum Result {
        case image(UIImage)
        case video(URL)
        case file(URL)
    }

    public init(
        type: SwiftUIMediaType,
        onResult: @escaping (Result) -> Void
    ) {
        self.type = type
        self.onResult = onResult
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public func makeUIViewController(
        context: Context
    ) -> UIViewController {

        let controller = UIViewController()
        DispatchQueue.main.async {
            presentPicker(from: controller, coordinator: context.coordinator)
        }
        return controller
    }

    public func updateUIViewController(
        _ uiViewController: UIViewController,
        context: Context
    ) {}

    // MARK: - Picker Presentation
    private func presentPicker(
        from vc: UIViewController,
        coordinator: Coordinator
    ) {
        switch type {
        case .image:
            let picker = UIImagePickerController()
            picker.delegate = coordinator
            picker.mediaTypes = ["public.image"]
            vc.present(picker, animated: true)

        case .video:
            let picker = UIImagePickerController()
            picker.delegate = coordinator
            picker.mediaTypes = ["public.movie"]
            vc.present(picker, animated: true)

        case .pdf:
            let picker = UIDocumentPickerViewController(
                forOpeningContentTypes: [.pdf],
                asCopy: true
            )
            picker.delegate = coordinator
            vc.present(picker, animated: true)
        }
    }

    // MARK: - Coordinator
    public final class Coordinator: NSObject,
        UIImagePickerControllerDelegate,
        UINavigationControllerDelegate,
        UIDocumentPickerDelegate {

        private let parent: SwiftUIMediaPicker

        init(_ parent: SwiftUIMediaPicker) {
            self.parent = parent
        }

        public func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            if let image = info[.originalImage] as? UIImage {
                parent.onResult(.image(image))
            }

            if let url = info[.mediaURL] as? URL {
                parent.onResult(.video(url))
            }

            picker.dismiss(animated: true)
        }

        public func imagePickerControllerDidCancel(
            _ picker: UIImagePickerController
        ) {
            picker.dismiss(animated: true)
        }

        public func documentPicker(
            _ controller: UIDocumentPickerViewController,
            didPickDocumentsAt urls: [URL]
        ) {
            if let url = urls.first {
                parent.onResult(.file(url))
            }
        }
    }
}
