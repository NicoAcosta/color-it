//
//  ImageViewController.swift
//  Hue
//
//  Created by Nicolás Acosta on 25/11/2020.
//

import Foundation
import UIKit


class ImageViewerVC : UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var preImageView: UIImageView!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var editNameButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var sender : DataCollectionVC? = nil
    
    var imageData : ImageData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
        nameTextField.borderStyle = .none
        
        shareButton.layer.cornerRadius = 5
        nameTextField.text = imageData?.name
        preImageView.image = UIImage(data: (imageData?.preImagePNG)!)
        postImageView.image = UIImage(data: (imageData?.postImagePNG)!)
        
        if imageData?.name == nil {
            nameTextField.becomeFirstResponder()
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer(colors: [violet, red])
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        shareImages()
    }
    
    
    @IBAction func editNameButtonAction(_ sender: Any) {
        nameTextField.becomeFirstResponder()
    }
    
    
    func shareImages() {
        let items = [preImageView.image, postImageView.image]
        let share = UIActivityViewController(activityItems: items as [Any], applicationActivities: nil)
        present(share, animated: true)
    }
    
}


extension ImageViewerVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let safeName = textField.text, !safeName.isEmpty {
            
            if safeName != imageData?.name {
                
                imageData?.name = safeName
                
                do {
                    try DataHelper.shared.saveData()
                } catch {
                    okAlert(title: "Error", message: "Could not save the name")
                }
                
                if let dataCollectionSender = sender {
                    dataCollectionSender.fetchAndRoload()
                    sender = nil
                }
                
            }
            
            textField.resignFirstResponder()
            
            
        } else {
            okAlert(title: "Empty name", message: "Your image must have a name")
        }
        
        return true
    }
    
    
    
}
