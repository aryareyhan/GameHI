//
//  UserDatas+CoreDataProperties.swift
//  GameHI1
//
//  Created by Matthew Anderson on 18/12/23.
//
//

import Foundation
import CoreData


extension UserDatas {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDatas> {
        return NSFetchRequest<UserDatas>(entityName: "UserDatas")
    }

    @NSManaged public var email: String?
    @NSManaged public var username: String?
    @NSManaged public var password: String?

}

extension UserDatas : Identifiable {

}
