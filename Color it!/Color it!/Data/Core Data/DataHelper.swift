//
//  DataHelper.swift
//  Color it!
//
//  Created by Nicolás Acosta on 29/11/2020.
//

import Foundation
import UIKit


final class DataHelper {
    
    static let shared = DataHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items : [ImageData]?
    
    
    init() {
        fetch()
        
    }
    
    
    func newItem() -> ImageData {
        return ImageData(context: context)
    }
    
    
    func saveData() throws {
        do {
            try context.save()
        } catch {
            throw error
        }
    }
    
    func fetch() {
        do {
            self.items = try context.fetch(ImageData.fetchRequest())
        } catch {}
    }

    
}
