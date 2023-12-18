//
//  CartDatas+CoreDataProperties.swift
//  GameHI1
//
//  Created by Matthew Anderson on 18/12/23.
//
//

import Foundation
import CoreData


extension CartDatas {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CartDatas> {
        return NSFetchRequest<CartDatas>(entityName: "CartDatas")
    }

    @NSManaged public var category: String?
    @NSManaged public var title: String?
    @NSManaged public var price: String?
    @NSManaged public var logo: String?
    @NSManaged public var username: String?

}

extension CartDatas : Identifiable {

}
