//
//  builderFromLibrary.swift
//  Color it!
//
//  Created by Nicolás Acosta on 30/11/2020.
//

import Foundation
import UIKit

extension ImageDataBuilder {
    
    func getPostURL(`fromImage` inputImage: UIImage?, handler: @escaping (String?) -> Void ) {
        
        if let safeImage = inputImage {
            
            NetworkingProvider.shared.getPostURL(fromImage: safeImage) { (url) in
                handler(url)
            } error: { (_) in
                handler(nil)
            }

        } else { handler(nil) }
        
    }
    
    
    
    convenience init(`fromImage` inputImage: UIImage?, data: @escaping (ImageData?) -> Void, error: @escaping (ImageDataError?) -> Void ) {
        
        self.init()
        source = "library"
        preImageURL = nil
        
        if let safePreImage = inputImage {
            
            preImage = safePreImage
            
            getPostURL(fromImage: safePreImage) { (localPostURL) in
               
                if let safePostURL = localPostURL {
                        
                        self.postImageURL = safePostURL
                        
                        self.getImage(fromURL: self.postImageURL) { (localPostImage) in
                            
                            if let safePostImage = localPostImage {
                                
                                self.postImage = safePostImage
                                
                                data(self.imageData)
                                
                            } else { error(.gettingPostImage) }
                        }
                        
                    } else { error(.gettingPostURL) }
            }
            
        }
        
    }
    
    
}

