//
//  ColorItViewController.swift
//  Hue
//
//  Created by Nicolás Acosta on 25/11/2020.
//

import Foundation
import UIKit


class UrlVC : ColorItVC, SideMenuItemContent, Storyboardable  {
    
    @IBOutlet weak var inputImageURL: UITextField!
    
    @IBOutlet weak var colorItButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputImageURL.layer.cornerRadius = 5
        inputImageURL.layer.borderWidth = 1
        inputImageURL.layer.borderColor = white.cgColor
        
        inputImageURL.returnKeyType = .done
        
        buttonStyle(colorItButton)
        
    }
    
    @IBAction func colorItButton(_ sender: Any) {
        
        if let safeURL = inputImageURL.text, !safeURL.isEmpty {
            
            inputImageURL.resignFirstResponder()
            activityIndicator.startAnimating()
            
            let _ = ImageDataBuilder(fromURL: safeURL) {
                (data) in
                
                self.imageDataForSegue = data
                
                do {
                    try DataHelper.shared.saveData()
                } catch {
                    self.okAlert(title: "Error", message: "Could not save data")
                }
                
                self.activityIndicator.stopAnimating()
                
                self.imageViewerSegue()
                
                self.imageDataForSegue = nil
                
                
            } error: { (_) in
                
                self.okAlert(title: "Error", message: "Error processing your photo. Check the URL and your internet connection.")
                
            }
            
        } else { okAlert(title: "Empty URL", message: "Please enter a URL") }
        
    }
    
    
    
    @IBAction func menuButtonAction(_ sender: Any) {
        showSideMenu()
    }
    
}



extension UrlVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
