//
//  main.swift
//  commandLine
//
//  Created by Nicolás Acosta on 24/11/2020.
//

import Foundation
import Alamofire

print("Hello, World!")

for _ in 1...100 {
    
    print("url")
    
    let inputURL = readLine()
    
    NetworkingProvider.shared.getOutputImageURL(inputImageUrl: inputURL!)
    
    
}
