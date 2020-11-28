//
//  NetworkingProvider.swift
//  Hue
//
//  Created by Nicolás Acosta on 24/11/2020.
//

import Foundation
import Alamofire


//  Para la API - obtener la url de la imágen respuesta

final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    
    let apiURL = URL(string: "https://api.deepai.org/api/colorizer")
    
    let headers = HTTPHeaders([ "api-key" : "fd2e1c36-d059-4713-8b59-adb94fe7a8ce" ])
    
    let okStatusCodes = 200...299
    
    func getOutputImageURL(inputImageURL: String, success: @escaping (_ outputImageURL: String) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        let parameters = [ "image" : inputImageURL ]
        
        
        AF.request(apiURL!, method: .post, parameters: parameters, headers: headers).validate(statusCode: okStatusCodes).responseDecodable(of:ImageResponse.self) {
            response in
            
            if let url = response.value?.output_url {
                success(url)
            } else {
                failure(response.error)
            }
        }
        
    }
    
}
