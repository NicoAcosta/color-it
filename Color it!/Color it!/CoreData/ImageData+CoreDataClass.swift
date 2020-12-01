//
//  ImageData+CoreDataClass.swift
//  
//
//  Created by Nicolás Acosta on 28/11/2020.
//
//

import Foundation
import CoreData
import UIKit

@objc(ImageData)
public class ImageData: NSManagedObject {

    public func postImage() -> UIImage? {
        return UIImage(data: (postImagePNG)!)
    }
    
    public func preImage() -> UIImage? {
        return UIImage(data: (pretImagePNG)!)
    }
    
}
