//
//  Host.swift
//  MyFramwork
//
//  Created by Nicolás Acosta on 02/12/2020.
//

import Foundation
import UIKit

class Host: MenuContainerViewController {
    
    
    var myMenuViewController : MenuViewController? {
        return Menu.storyboardViewController()
    }
    
    var myMenuItemsViewControllers : [UIViewController]? {
        return [
            LibraryVC.storyboardViewController(),
            UrlVC.storyboardViewController(),
            DataCollectionVC.storyboardViewController(),
            Support.storyboardViewController(),
            Terms.storyboardViewController(),
            Privacy.storyboardViewController()
        ]
    }
    
}
