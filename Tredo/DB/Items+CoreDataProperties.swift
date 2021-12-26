//
//  Items+CoreDataProperties.swift
//  Tredo
//
//  Created by Alexander Lee on 26.12.2021.
//
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items")
    }

    @NSManaged public var folderId: Int64
    @NSManaged public var folderTitle: String?

}

extension Items : Identifiable {

}
