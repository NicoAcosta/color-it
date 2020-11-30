//
//  NetworkingProvider.swift
//  Hue
//
//  Created by Nicolás Acosta on 24/11/2020.
//

import Foundation
import Alamofire

// Para decodear el JSON respuesta de la API
struct ImageResponse : Codable {
    
    let id  : String?           //  id
    let output_url : String?    //  output_url
    
}

//  Para la API - obtener la url de la imágen respuesta

final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    
    let apiURL = URL(string: "https://api.deepai.org/api/colorizer")
    
    let headers = HTTPHeaders([ "api-key" : "fd2e1c36-d059-4713-8b59-adb94fe7a8ce" ])
    
    let okStatusCodes = 200...299
    
    //  Deep AI api from url
    func getOutputImageURL(inputImageURL: String, postImageURL: @escaping (_ outputImageURL: String) -> (), error: @escaping (_ error: Error?) -> ()) {
        
        let parameters = [ "image" : inputImageURL ]
        
        AF.request(apiURL!, method: .post, parameters: parameters, headers: headers).validate(statusCode: okStatusCodes).responseDecodable(of: ImageResponse.self) {
            
            response in
            
            if let url = response.value?.output_url {
                postImageURL(url)
            } else {
                error(response.error)
            }
            
        }
        
    }
    
}
