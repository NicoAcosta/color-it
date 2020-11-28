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
    
    func imageViewerSegue() {
        let segue = UIStoryboardSegue(identifier: "goToImageViewer", source: self, destination: ImageViewerVC())
        self.prepare(for: segue, sender: self)
        self.performSegue(withIdentifier: "goToImageViewer", sender: self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        blueGradientLayer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let imageVC = segue.destination as! ImageViewerVC
        imageVC.imageData = imageDataForSegue
    }
    
}
