//
//  AdminGameListTableViewCell.swift
//  GameHI1
//
//  Created by Dierta Pasific on 18/12/23.
//

import UIKit

class AdminGameListTableViewCell: UITableViewCell {

    static let identifier = "AdminGameListTableViewCell"
    
    @IBOutlet weak var gameTitleLabel: UILabel!
    @IBOutlet weak var gameLogoImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(game: Game){
        gameTitleLabel.text = game.category
        gameLogoImageView.image = UIImage(named: game.logo)
    }

}
