//
//  ImagePickerHelper.swift
//  SacrenaChat
//

import Foundation

import UIKit

class ImagePickerHelper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private weak var viewController: UIViewController?
    
    func configure(delegate: UIViewController & UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
        self.viewController = delegate
    }
    
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            let alert = UIAlertController(title: "Error", message: "Camera is not available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            viewController?.present(alert, animated: true)
            return
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = true
        viewController?.present(imagePickerController, animated: true)
    }
    
    // UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            print("Captured image: \(editedImage)")
        } else if let originalImage = info[.originalImage] as? UIImage {
            print("Captured image: \(originalImage)")
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
