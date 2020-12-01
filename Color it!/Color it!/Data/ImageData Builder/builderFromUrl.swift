//
//  builderFromUrl.swift
//  Color it!
//
//  Created by Nicolás Acosta on 30/11/2020.
//

import Foundation


extension ImageDataBuilder {
    
    func getPostURL(`fromURL` url: String?, handler: @escaping (String?) -> Void ) {
        
        if let safePreUrl = url {
            
            NetworkingProvider.shared.getPostURL(fromURL: safePreUrl) { (url) in
                handler(url)
            } error: { (_) in
                handler(nil)
            }
            
        } else { handler(nil) }
        
    }
    
    
    convenience init(`fromURL` inputImageURL: String, data: @escaping (ImageData?) -> Void, error: @escaping (ImageDataError?) -> Void ) {
        
        self.init()
        source = "URL"
        preImageURL = inputImageURL
        
        getPostURL(fromURL: preImageURL) { (localPostURL) in
            
            if let safeLocalPostURL = localPostURL {
                
                self.postImageURL = safeLocalPostURL
                
                self.getImage(fromURL: self.preImageURL) { (localPreImage) in
                    
                    if let safeLocalPreImage = localPreImage {
                        
                        self.preImage = safeLocalPreImage
                        
                        self.getImage(fromURL: self.postImageURL) { (localPostImage) in
                            
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
    
    
}
