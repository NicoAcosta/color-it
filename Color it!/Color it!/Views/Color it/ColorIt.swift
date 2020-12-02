//
//  ColorIt.swift
//  Color it!
//
//  Created by Nicolás Acosta on 28/11/2020.
//

import Foundation
import UIKit

class ColorItVC : UIViewController {
    
    var imageDataForSegue : ImageData? = nil
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer(colors: gradientColors)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToImageViewer" {
            let imageVC = segue.destination as! ImageViewerVC
            imageVC.imageData = imageDataForSegue
        }
    }
    
    var gradientColors : [UIColor] { return [violet, red, orange] }
    
    func buttonStyle(_ button: UIButton) {
        button.layer.cornerRadius = 5
        button.setTitleColor(red, for: .normal)
        button.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
    }
    
}
