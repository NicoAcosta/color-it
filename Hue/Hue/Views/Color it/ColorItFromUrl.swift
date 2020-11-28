//
//  ColorItViewController.swift
//  Hue
//
//  Created by Nicolás Acosta on 25/11/2020.
//

import Foundation
import UIKit


class ColorItFromUrlVC : UIViewController {
    
    @IBOutlet weak var inputImageURL: UITextField!
    
    @IBOutlet weak var colorItButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imageDataForSegue : ImageData? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputImageURL.layer.cornerRadius = 5
        inputImageURL.layer.borderWidth = 1
        inputImageURL.layer.borderColor = white.cgColor
        
        colorItButton.layer.cornerRadius = 5
        colorItButton.setTitleColor(white, for: .normal)
        colorItButton.gradientLayer(colors: [violet, red, orange])
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blueGradientLayer()
    }
    
    @IBAction func colorItButton(_ sender: Any) {
        
        inputImageURL.resignFirstResponder()
        activityIndicator.startAnimating()
        
        imageDataForSegue = ImageData(fromURL: inputImageURL.text!) { (success) in
            
            if success {
                let segue = UIStoryboardSegue(identifier: "goToImageViewer", source: self, destination: ImageViewerVC())
                self.prepare(for: segue, sender: self)
                self.activityIndicator.stopAnimating()
                self.performSegue(withIdentifier: "goToImageViewer", sender: self)
            } else {
                self.okAlert(title: "Error", message: "Error processing your photo. Check the URL")
            }
            
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imageVC = segue.destination as! ImageViewerVC
        imageVC.imageData = imageDataForSegue
    }
    
}



extension ColorItFromUrlVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
