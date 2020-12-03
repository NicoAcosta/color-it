//
//  ImageViewerSegue.swift
//  Color it!
//
//  Created by Nicolás Acosta on 29/11/2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    func imageViewerSegue() {
        let segue = UIStoryboardSegue(identifier: "goToImageViewer", source: self, destination: ImageViewerVC())
        self.prepare(for: segue, sender: self)
        self.performSegue(withIdentifier: "goToImageViewer", sender: self)
    }
    
}
