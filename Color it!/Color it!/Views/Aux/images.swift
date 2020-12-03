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
    
    func whiteBorders() {
        
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 5
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
    }
    
}


extension UIViewController {
    
    
    func share(items: [Any]) {
        let share = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(share, animated: true)
    }
    
    
    //MARK: - Save image

    func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    func saveImages(_ images: [UIImage]) {
        for image in images {
            saveImage(image)
        }
    }
    
    //MARK: - Save Image callback

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {

        if let error = error {

            print(error.localizedDescription)

        } else {

            print("Success")
        }
    }

}


