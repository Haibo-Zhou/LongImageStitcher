//
//  PHImagePicker.swift
//  LongImageStitcher
//
//  Created by HaiboZhou on 2021/9/25.
//

import UIKit
import PhotosUI

public protocol PHImagePickerDelegate: AnyObject {
    func didSelect(images: [UIImage]?)
}

class PHImagePicker: NSObject {
    
    private let pickerController: PHPickerViewController
    private weak var presentationController: UIViewController?
    private weak var delegate: PHImagePickerDelegate?
    private var images = [UIImage]()
    
    public init(presentationController: UIViewController, delegate: PHImagePickerDelegate) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 8
        // only show images
        config.filter = PHPickerFilter.images
        
        self.pickerController = PHPickerViewController(configuration: config)
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        self.pickerController.delegate = self
    }
    
    private func pickerController(_ controller: PHPickerViewController, didSelect images: [UIImage]?) {
        controller.dismiss(animated: true, completion: nil)
        
        self.delegate?.didSelect(images: images)
    }
    
    public func present(from sourceView: UIView) {
        self.presentationController?.present(pickerController, animated: true)
    }
}

extension PHImagePicker: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // clear images array
        self.images = []
        
        // dismiss the picker
        picker.dismiss(animated: true, completion: nil)
        print("picker: ", picker)
        print("results: ", results)
        
        for result in results {
            print("💄assetIdentifier", result.assetIdentifier ?? "")
            print("💄itemProvider", result.itemProvider)
            
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let error = error {
                    print("ERROR: 💄", error)
                    return
                }
                print(object as Any)
                
                if let image = object as? UIImage {
                    self?.images.append(image)
                    
                    if self?.images != nil && self?.images.count == results.count {
                        DispatchQueue.main.async {
                            self?.pickerController(picker, didSelect: self?.images)
                        }
                    }
                }
            }
        }
    }
}
