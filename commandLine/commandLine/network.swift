//
//  network.swift
//  commandLine
//
//  Created by Nicolás Acosta on 24/11/2020.
//

import Foundation
import Alamofire

final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    
    
    
    let apiURL = URL(string: "https://api.deepai.org/api/colorizer")

    
    func getOutputImageURL(inputImageUrl: String) {
        /*
        var request = URLRequest(url: apiURL!)
        let body = "image=\(inputImageUrl)"
        
        request.httpMethod = "GET"
        request.addValue("quickstart-QUdJIGlzIGNvbWluZy4uLi4K", forHTTPHeaderField: "api-key")
        
        request.httpBody = body.data(using: String.Encoding.ascii, allowLossyConversion: false)
        
        
        AF.request(<#T##convertible: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Encodable?#>, encoder: <#T##ParameterEncoder#>, headers: <#T##HTTPHeaders?#>, interceptor: <#T##RequestInterceptor?#>, requestModifier: <#T##Session.RequestModifier?##Session.RequestModifier?##(inout URLRequest) throws -> Void#>)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
        
            if let resp = response.value {
                
            }
        
        
        }
        return "a"

         */
        
        let parameters = [
            "api-key" : "quickstart-QUdJIGlzIGNvbWluZy4uLi4K",
            "image" : inputImageUrl
        ]
            
        
        AF.request(apiURL!, method: .get, parameters: parameters).responseDecodable (of:ImageResponse.self) {
            
            response in
            
            if let correctResponse = response.value?.url {
                print(correctResponse)
            } else {
                print("error lpm")
            }
            
        }
        
        
        
        
    }
    
    
}
