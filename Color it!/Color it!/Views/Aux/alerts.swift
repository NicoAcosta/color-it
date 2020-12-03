//
//  alerts.swift
//  Hue
//
//  Created by Nicolás Acosta on 24/11/2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    func okAlert(title: String, message: String) {
        let alert = OkAlert(title: title, message: message)
        present(alert, animated: true, completion: nil)
    }
    
    func deleteAlert(title: String, message: String, deleteBlock: @escaping (UIAlertAction) -> Void) {
        let alert = DeleteAlert(title: title, message: message, deleteBlock: deleteBlock)
        present(alert, animated: true, completion: nil)
    }
    
}


class OkAlert : UIAlertController {
    
    let okAction = UIAlertAction(title: "Ok", style: .default)
    
    convenience init(title: String?, message: String?) {
        self.init(title: title, message: message, preferredStyle: .alert)
        addAction(okAction)
        
    }
    
}


class DeleteAlert : UIAlertController {
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    func deleteAction(block: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: block)
        return deleteAction
    }
    
    
    convenience init(title: String?, message: String?, deleteBlock: @escaping (UIAlertAction) -> Void) {
        
        self.init(title: title, message: message, preferredStyle: .alert)
        
        //Add the actions to the alert controller
        addAction(cancelAction)
        addAction(deleteAction(block: deleteBlock))
        
    }
    
    
}
