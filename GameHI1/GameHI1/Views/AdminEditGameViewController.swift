//
//  AdminEditGameViewController.swift
//  GameHI1
//
//  Created by Dierta Pasific on 19/12/23.
//

import UIKit

class AdminEditGameViewController: UIViewController {
    
    var game: Game!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var ratingTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var sizeTF: UITextField!
    @IBOutlet weak var descriptionTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Text View Customizations
        descriptionTV.layer.borderWidth = 1.0
        descriptionTV.layer.borderColor = UIColor.systemGray5.cgColor
        descriptionTV.isScrollEnabled = false
        descriptionTV.textContainer.lineBreakMode = .byWordWrapping
        
        populateView()
    }
    
    private func populateView(){
        logoImageView.image = UIImage(named: game.logo)
        titleTF.text = game.name
        priceTF.text = game.price
        ratingTF.text = game.ratingText
        ageTF.text = game.minimumAge
        sizeTF.text = game.size
        descriptionTV.text = game.description
    }

}
