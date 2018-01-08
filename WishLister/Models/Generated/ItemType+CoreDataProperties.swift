//
//  ItemType+CoreDataProperties.swift
//  WishLister
//
//  Created by Brandon Ha on 2018-01-08.
//  Copyright © 2018 Brandon Ha. All rights reserved.
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
