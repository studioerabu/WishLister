//
//  ItemType+CoreDataProperties.swift
//  WishLister
//
//  Created by Brandon Ha 
//  Copyright © 2019 Brandon Ha. All rights reserved.
//
//

import Foundation
import CoreData

extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
