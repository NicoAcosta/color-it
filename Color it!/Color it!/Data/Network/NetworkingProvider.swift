//
//  NetworkingProvider.swift
//  Hue
//
//  Created by Nicolás Acosta on 24/11/2020.
//

import Foundation
import Alamofire
import AlamofireImage

// Para decodear el JSON respuesta de la API
struct ImageResponse : Codable {
    
    let id  : String?           //  id
    let output_url : String?    //  output_url
    
}

//  Para la API - obtener la url de la imágen respuesta

final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    
    let apiURL = URL(string: "https://api.deepai.org/api/colorizer")
    
    let headers = HTTPHeaders([ "api-key" : DeepAIKey().key ])
    
    let okStatusCodes = 200...299
    
    //  Deep AI api from url
    func getPostURL(`fromURL` inputImageURL: String?, postImageURL: @escaping (_ outputImageURL: String) -> (), error: @escaping (_ error: Error?) -> ()) {
        
        if let safeURL = inputImageURL {
            
            let parameters = [ "image" : safeURL ]
            
            AF.request(apiURL!, method: .post, parameters: parameters, headers: headers).validate(statusCode: okStatusCodes).responseDecodable(of: ImageResponse.self) {
                
                response in
                
                if let url = response.value?.output_url {
                    postImageURL(url)
                } else {
                    error(response.error)
                }
                
            }
            
        } else { error(ImageDataError.gettingPostURL) }
        
        
    }
    
    func getPostURL(`fromImage` preImage: UIImage?, postImageURL: @escaping (_ outputImageURL: String) -> (), error: @escaping (_ error: Error?) -> ()) {
        
        if let safeImage = preImage {
            
            let data = safeImage.pngData()!
            
            AF.upload(multipartFormData: { (form) in
                form.append(data, withName: "image", fileName: "image.png", mimeType: "image/png")
            }, to: apiURL!, headers: headers).validate(statusCode: okStatusCodes).responseDecodable(of: ImageResponse.self) {
                
                response in
                
                if let url = response.value?.output_url {
                    postImageURL(url)
                } else {
                    error(response.error)
                }
                
            }
            
        } else {
            error(ImageDataError.gettingPostURL)
        }
        
        
    }
    
    func getImage(`fromURL` url: String?, handler: @escaping (UIImage?) -> Void ) {
        
        if let safeURL = url {
            
            AF.request(URL(string: safeURL)!, method: .get).responseImage { (response) in
                
                if let safeImage = response.value {
                    handler(safeImage)
                } else {
                    handler(nil)
                }
            }
            
        } else { handler(nil) }
        
        
    }
    
    
    
}

