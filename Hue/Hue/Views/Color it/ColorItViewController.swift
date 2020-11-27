//
//  ColorItViewController.swift
//  Hue
//
//  Created by Nicolás Acosta on 25/11/2020.
//

import Foundation
import UIKit


class ColorItViewController : UIViewController {
    
    @IBOutlet weak var inputImageURL: UITextField!
    
    @IBOutlet weak var colorItButton: UIButton!
    
    var outputImageURL : String? = nil
    
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
        
        NetworkingProvider.shared.getOutputImageURL(inputImageURL: inputImageURL.text!) { (url) in
            
            self.outputImageURL = url
            
            let segue = UIStoryboardSegue(identifier: "goToImageViewer", source: self, destination: ImageViewController())
            self.prepare(for: segue, sender: self)
            self.performSegue(withIdentifier: "goToImageViewer", sender: self)
            
            
        } failure: { (error) in
            self.okAlert(title: "Error", message: "Error \(error!)")
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imageVC = segue.destination as! ImageViewController
        imageVC.inputImageURL = inputImageURL.text!
        imageVC.outputImageURL = outputImageURL
    }
    
}



extension ColorItViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}
