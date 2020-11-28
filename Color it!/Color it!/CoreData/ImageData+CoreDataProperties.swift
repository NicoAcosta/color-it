//
//  ImageData+CoreDataProperties.swift
//  
//
//  Created by Nicolás Acosta on 28/11/2020.
//
//

import Foundation
import CoreData


extension ImageData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageData> {
        return NSFetchRequest<ImageData>(entityName: "ImageData")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var postImagePNG: Data?
    @NSManaged public var postImageURL: String?
    @NSManaged public var preImagePNG: Data?
    @NSManaged public var preImageURL: String?
    @NSManaged public var source: String?
    @NSManaged public var creationDate: Date?

}
