//
//  GameListTableViewCell.swift
//  GameHI1
//
//  Created by Dierta Pasific on 18/12/23.
//

import UIKit

class GameListTableViewCell: UITableViewCell {

    static let identifier = "GameListTableViewCell"
    
    @IBOutlet weak var gameThumbnailImageView: UIImageView!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func setup(game: Game){
        gameThumbnailImageView.image = UIImage(named: game.screenshot1)
        gameImageView.image = UIImage(named: game.logo)
        ageLabel.text = "Age \(game.minimumAge)"
        categoryLabel.text = game.category
        priceLabel.text = game.price
        titleLabel.text = game.name
    }
}
