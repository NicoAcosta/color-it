//
//  imageDataBuiler.swift
//  Color it!
//
//  Created by Nicolás Acosta on 28/11/2020.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

enum ImageDataError : Error {
    case preURLnil, gettingPostURL, nilUrlForGetImage, gettingImage, gettingPreImage, gettingPostImage
}

class ImageDataBuilder {
    
    let id              :   UUID                =   UUID()
    var name            :   String?             =   "Image name"
    var source          :   String?
    var preImageURL     :   String?
    var postImageURL    :   String?
    var preImage        :   UIImage?
    var postImage       :   UIImage?
    let creationDate    :   Date?               =   Date()
    
    
    convenience init(`fromURL` inputImageURL: String, data: @escaping (ImageData?) -> Void, error: @escaping (ImageDataError?) -> Void ) {
        
        self.init()
        source = "URL"
        preImageURL = inputImageURL
        
        getPostURL(preImageURL) { (localPostURL) in
            
            if let safeLocalPostURL = localPostURL {
                
                self.postImageURL = safeLocalPostURL
                
                self.getImage(self.preImageURL) { (localPreImage) in
                    
                    if let safeLocalPreImage = localPreImage {
                        
                        self.preImage = safeLocalPreImage
                        
                        self.getImage(self.postImageURL) { (localPostImage) in
                            
                            if let safeLocalPostImage = localPostImage {
                                
                                self.postImage = safeLocalPostImage
                                
                                data(self.imageData)
                                
                            } else { error(.gettingPostImage) }
                            
                        }
                        
                    } else { error(.gettingPreImage) }
                    
                }
                
            } else { error(.gettingPostURL) }
            
        }
        
    }
    
    
    
    
    
    
    func getImage(_ url: String?, handler: @escaping (UIImage?) -> Void ) {
        
        AF.request(URL(string: url!)!, method: .get).responseImage { (response) in
            
            if let safeImage = response.value {
                handler(safeImage)
            } else {
                handler(nil)
            }
        }
    }
    
    
    func getPostURL(_ url: String?, handler: @escaping (String?) -> Void ) {
        
        guard let localPreUrl = url else { return }
        
        NetworkingProvider.shared.getOutputImageURL(inputImageURL: localPreUrl) { (url) in
            handler(url)
        } error: { (_) in
            handler(nil)
        }
        
    }
    
    
    
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

}
