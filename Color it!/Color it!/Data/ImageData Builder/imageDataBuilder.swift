//
//  imageDataBuiler.swift
//  Color it!
//
//  Created by Nicolás Acosta on 28/11/2020.
//

import Foundation
import UIKit

enum ImageDataError : Error {
    case preURLnil, gettingPostURL, nilUrlForGetImage, gettingImage, gettingPreImage, gettingPostImage, gettingPreImagePath
}

class ImageDataBuilder {
    
    let id              :   UUID                =   UUID()
    var name            :   String?             =   nil
    var source          :   String?
    var preImageURL     :   String?
    var postImageURL    :   String?
    var preImage        :   UIImage?
    var postImage       :   UIImage?
    let creationDate    :   Date?               =   Date()
    
    
    var imageData : ImageData {
        
        let imageData = DataHelper.shared.newItem()
        
        imageData.id            =   id
        imageData.name          =   name
        imageData.source        =   source
        imageData.creationDate  =   creationDate
        imageData.preImageURL   =   preImageURL
        imageData.preImagePNG   =   preImage!.pngData()
        imageData.postImageURL  =   postImageURL
        imageData.postImagePNG  =   postImage!.pngData()
        
        return imageData
        
    }
    
    
    func getImage(`fromURL` url: String?, handler: @escaping (UIImage?) -> Void ) {
        
        if let safePreUrl = url {
            
            NetworkingProvider.shared.getImage(fromURL: safePreUrl) { (image) in
                handler(image)
            }
            
        } else { handler(nil) }
        
    }
    
    

}
