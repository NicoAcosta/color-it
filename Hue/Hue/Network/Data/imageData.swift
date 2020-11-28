//
//  imageData.swift
//  Hue
//
//  Created by Nicolás Acosta on 26/11/2020.
//

import Foundation
import CoreData
import Kingfisher
import UIKit
import Alamofire
import AlamofireImage

enum ImageDataError : Error {
    case preURLnil, couldNotGetPostURL, nilUrlForGetImage, gettingImage, gettingPreImage, gettingPostImage
}



//  Origen de al imagen
enum ImageOrigin {
    case library, url, camera, empty
}


class ImageData {
    
    var name        :   String?
    var origin      :   ImageOrigin?
    var preURL      :   String?
    var preImage    :   UIImage?
    var postURL     :   String?
    var postImage   :   UIImage?
    var error       :   ImageDataError?
    
    
    init() {
        name = nil
        origin = .empty
        preURL = nil
        preImage = nil
        postURL = nil
        postImage = nil
        error = nil
    }
    
    convenience init(`fromURL` inputImageURL: String, handler: @escaping (Bool) -> Void ) {
        
        self.init()
        name = "Some Name"
        origin = .url
        preURL = inputImageURL
        
        getPostURL(preURL) { (localPostURL) in
            
            if let safeLocalPostURL = localPostURL {
                
                self.postURL = safeLocalPostURL
                
                self.getImage(self.preURL) { (localPreImage) in
                    
                    if let safeLocalPreImage = localPreImage {
                        
                        self.preImage = safeLocalPreImage
                        
                        self.getImage(self.postURL) { (localPostImage) in
                            
                            if let safeLocalPostImage = localPostImage {
                                
                                self.postImage = safeLocalPostImage
                                handler(true)
                                
                            } else { self.error = .gettingPostImage; handler(false) }
                            
                        }
                        
                    } else { self.error = .gettingPreImage; handler(false) }
                    
                }
                
            } else { self.error = .couldNotGetPostURL; handler(false) }
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
        
        guard let localPreUrl = url else { self.error = .couldNotGetPostURL; return}
        
        NetworkingProvider.shared.getOutputImageURL(inputImageURL: localPreUrl) { (localPostUrl) in
            
            handler(localPostUrl)
            
        } failure: { (error) in
            
            handler(nil)
            
        }
        
    }
    
    

    
}

