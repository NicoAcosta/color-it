//
//  imageResponse.swift
//  Hue
//
//  Created by Nicolás Acosta on 24/11/2020.
//

import Foundation

// Para decodear el JSON respuesta de la API
struct ImageResponse : Codable {
    
    let id  : String?           //  id
    let output_url : String?    //  output_url
    
}
