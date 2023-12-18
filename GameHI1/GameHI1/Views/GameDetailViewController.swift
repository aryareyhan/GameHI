//
//  GameDetailViewController.swift
//  GameHI1
//
//  Created by Dierta Pasific on 17/12/23.
//

import UIKit

class GameDetailViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    @IBOutlet weak var screenshotImageView: UIImageView!
    
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populateView()
    }
    
    private func populateView(){
        screenshotImageView.image = UIImage(named: game.screenshot1)
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

    @IBAction func getButtonOnClick(_ sender: Any) {
        saveToCart()
    }
    
    private func saveToCart() {

        // Create a new CartDatas object
        let cartData = CartDatas(context: context)

        // Set attributes
        cartData.category = game.category
        cartData.title = game.name
        cartData.price = game.price
        cartData.logo = game.logo

        // Assuming 'loggedInUsername' is a static property in your HomeViewController
        cartData.username = HomeViewController.loggedInUsername

        // Save the context to persist the changes
        do {
            try context.save()
            showAlert(message: "Item added to cart.")
            print("Item added to cart.")
        } catch {
            print("Error saving to cart: \(error)")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
