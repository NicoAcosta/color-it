//
//  ColorItFromLibrary.swift
//  Color it!
//
//  Created by Nicolás Acosta on 30/11/2020.
//

import Foundation
import UIKit
import InteractiveSideMenu


class LibraryVC : ColorItVC, SideMenuItemContent, Storyboardable {
    
    @IBOutlet weak var selectImageButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedImage : UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonStyle(selectImageButton)
        
    }
    
    
    @IBAction func selectImageButtonAction(_ sender: Any) {
        showImagePickerController()
    }
    
    
}


extension LibraryVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showImagePickerController() {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        activityIndicator.startAnimating()
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        if let safeSelectedImage = selectedImage {
            
            let _ = ImageDataBuilder(fromImage: safeSelectedImage, data: { (data) in
                
                self.imageDataForSegue = data
                
                do {
                    try DataHelper.shared.saveData()
                } catch {
                    self.okAlert(title: "Error", message: "Could not save data")
                }
                
                self.activityIndicator.stopAnimating()
                
                self.imageViewerSegue()
                
                self.imageDataForSegue = nil
                
            }) { (error) in
                self.okAlert(title: "error", message: "error \(error!)")
            }
            
            
            
        }
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
}
