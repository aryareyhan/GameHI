//
//  Game.swift
//  GameHI1
//
//  Created by Dierta Pasific on 17/12/23.
//

import Foundation

struct Game {
    // Texts
    let name: String
    let price: String
    let minimumAge: String
    let size: String
    let category: String
    let description: String
    let ratingText: String
    
    // Images
    let logo: String
    let bannerImage: String
    let ratingImage: String
    let screenshot1: String
    let screenshot2: String
    let screenshot3: String
    
    init(gameDatas: GameDatas) {
        self.name = gameDatas.name ?? ""
        self.price = gameDatas.price ?? ""
        self.minimumAge = gameDatas.minimumAge ?? ""
        self.size = gameDatas.size ?? ""
        self.category = gameDatas.category ?? ""
        self.description = gameDatas.gameDescription ?? ""
        self.ratingText = gameDatas.ratingText ?? ""
        
        self.logo = gameDatas.logo ?? ""
        self.bannerImage = gameDatas.bannerImage ?? ""
        self.ratingImage = gameDatas.ratingImage ?? ""
        self.screenshot1 = gameDatas.screenshot1 ?? ""
        self.screenshot2 = gameDatas.screenshot2 ?? ""
        self.screenshot3 = gameDatas.screenshot3 ?? ""
    }
}
