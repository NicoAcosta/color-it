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
    
    /*
    func dataTableSegue() {
        let segue = UIStoryboardSegue(identifier: "goToDataTable", source: self, destination: DataTableVC())
        self.prepare(for: segue, sender: self)
        self.performSegue(withIdentifier: "goToDataTable", sender: self)
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToImageViewer" {
            let imageVC = segue.destination as! ImageViewerVC
            imageVC.imageData = imageDataForSegue
        }
    }
    
}
