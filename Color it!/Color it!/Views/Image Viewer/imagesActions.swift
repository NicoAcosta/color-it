//
//  imagesActions.swift
//  Color it!
//
//  Created by Nicolás Acosta on 02/12/2020.
//

import Foundation
import UIKit



extension ImageViewerVC {
    
    func deleteIt(_ item: ImageData) {
        
        deleteAlert(title: "Delete", message: "This action cannot be undone") { (_) in
            
            do {
                try DataHelper.shared.delete(item)
            } catch {
                self.okAlert(title: "Error", message: "Could not save data")
            }
            
            
            if let dataCollectionSender = self.sender {
                dataCollectionSender.fetchAndRoload()
                self.sender = nil
            }
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
    }
    
    
    //MARK: - Save Image callback

    @objc override func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            okAlert(title: "Error saving images", message: "\(error.localizedDescription)")
        } else {
            
            imagesSaved += 1
            
            if imagesSaved == 2 {
                
                okAlert(title: "Images saved", message: "")
                
                imagesSaved = 0
                
            }
            
        }
        
    }
    
}
    
    
    
