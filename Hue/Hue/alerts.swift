//
//  alerts.swift
//  Hue
//
//  Created by Nicolás Acosta on 24/11/2020.
//

//
//  alerts.swift
//  BlackHack
//
//  Created by Nicolás Acosta on 15/11/2020.
//

import Foundation
import UIKit

extension UIViewController {
    
    func okAlert(title: String, message: String) {
        let alert = OkAlert(title: title, message: message)
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
