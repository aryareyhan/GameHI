//
//  TopGrossingTableViewCell.swift
//  GameHI1
//
//  Created by Dierta Pasific on 17/12/23.
//

import UIKit

class TopGrossingTableViewCell: UITableViewCell {

    @IBOutlet weak var gameCategoryLabel: UILabel!
    @IBOutlet weak var minimumAgeLabel: UILabel!
    @IBOutlet weak var gamePriceLabel: UILabel!
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(game: Game){
        gameCategoryLabel.text = game.category
        gamePriceLabel.text = game.price
        gameTitleLabel.text = game.name
        minimumAgeLabel.text = "Age \(game.minimumAge)"
        gameImageView.image = UIImage(named: game.logo)
    }

}
