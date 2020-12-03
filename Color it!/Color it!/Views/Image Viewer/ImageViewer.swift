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
    
    var imagesSaved : Int = 0
    
    var images : [UIImage] {
        return [preImageView.image!, postImageView.image!]
    }
    
    var amountOfImages : Int {
        return images.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        nameTextField.delegate = self
        nameTextField.returnKeyType = .done
        nameTextField.borderStyle = .none
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sender = nil
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
        share(items: images)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        saveImages(images)
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        deleteIt(imageData!)
    }
    
    @IBAction func editNameButtonAction(_ sender: Any) {
        nameTextField.becomeFirstResponder()
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
