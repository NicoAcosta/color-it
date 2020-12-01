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
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blueGradientLayer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToImageViewer" {
            let imageVC = segue.destination as! ImageViewerVC
            imageVC.imageData = imageDataForSegue
        }
    }
    
}
