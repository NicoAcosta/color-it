//
//  ViewController.swift
//  Hue
//
//  Created by Nicolás Acosta on 24/11/2020.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var inputURL: UITextField!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var outputURL: UITextField!
    @IBOutlet weak var outputButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad xd")
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        
        inputURL.delegate = self
    }
    
    
    
    @IBAction func buttonAction(_ sender: Any) {
        
        activityIndicator.startAnimating()
        
        
        NetworkingProvider.shared.getOutputImageURL(inputImageURL: inputURL.text!) { (url) in
            self.outputURL.text = url
            self.imageView.kf.setImage(with: URL(string: url))
            self.activityIndicator.stopAnimating()
        } failure: { (error) in
            self.okAlert(title: "Error", message: "Error \(error!)")
            self.activityIndicator.stopAnimating()
        }
        
        
        
        //outputURL.text = api(inputImageURL: inputURL.text)
        
        
        
    }
    
    
    
    @IBAction func openLink(_ sender: Any) {
        guard let url = URL(string: outputURL.text!) else { return }
        UIApplication.shared.open(url)
    }
    
    
    
    
}



extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

