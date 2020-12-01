//
//  File.swift
//  Color it!
//
//  Created by Nicolás Acosta on 30/11/2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    func imageFromData(_ data: Data?) -> UIImage? {
        if let safeData = data {
            return UIImage(data: safeData) ?? nil
        }
        return nil
    }
    
    
}

extension UIImageView {
    
    func borders() {
        
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 5
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
    }
    
}
