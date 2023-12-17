//
//  GameDetailViewController.swift
//  GameHI1
//
//  Created by Dierta Pasific on 17/12/23.
//

import UIKit

class GameDetailViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var screenshotCollectionView: UICollectionView!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateView()
    }
    
    private func populateView(){
    bannerImageView.image = UIImage(named: game.bannerImage)
        logoImageView.image = UIImage(named: game.logo)
        titleLabel.text = game.name
        ratingLabel.text = game.ratingText
        ageLabel.text = game.minimumAge
        sizeLabel.text = game.size
        descriptionLabel.text = game.description
        priceLabel.text = game.price
        ratingImageView.image = UIImage(named: game.ratingImage)
    }

}
