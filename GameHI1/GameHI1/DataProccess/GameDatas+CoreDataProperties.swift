//
//  GameDatas+CoreDataProperties.swift
//  GameHI1
//
//  Created by Matthew Anderson on 18/12/23.
//
//

import Foundation
import CoreData


extension GameDatas {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameDatas> {
        return NSFetchRequest<GameDatas>(entityName: "GameDatas")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var minimumAge: String?
    @NSManaged public var size: String?
    @NSManaged public var category: String?
    @NSManaged public var gameDescription: String?
    @NSManaged public var ratingText: String?
    @NSManaged public var logo: String?
    @NSManaged public var bannerImage: String?
    @NSManaged public var ratingImage: String?
    @NSManaged public var screenshot1: String?
    @NSManaged public var screenshot2: String?
    @NSManaged public var screenshot3: String?

}

extension GameDatas : Identifiable {

}
