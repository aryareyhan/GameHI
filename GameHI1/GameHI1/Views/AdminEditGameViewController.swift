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
    @IBOutlet weak var descriptionTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateView()
    }
    
    private func populateView(){
        logoImageView.image = UIImage(named: game.logo)
        titleTF.text = game.name
        priceTF.text = game.price
        ratingTF.text = game.ratingText
        ageTF.text = game.minimumAge
        sizeTF.text = game.size
        descriptionTF.text = game.description
    }

}
