//
//  AdminViewController.swift
//  GameHI1
//
//  Created by Matthew Anderson on 18/12/23.
//

import UIKit
import CoreData

class AdminViewController: UIViewController {
    
    var games: [Game] = []
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var minimumAgeTF: UITextField!
    @IBOutlet weak var sizeTF: UITextField!
    @IBOutlet weak var categoryTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var logoTF: UITextField!
    @IBOutlet weak var bannerTF: UITextField!
    @IBOutlet weak var ratingTF: UITextField!
    @IBOutlet weak var ss1TF: UITextField!
    @IBOutlet weak var ss2TF: UITextField!
    @IBOutlet weak var ss3TF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addGameOnClicked(_ sender: Any) {
        saveNewGame()
        print("Test")
    }
    
    func saveNewGame() {
        // Check for empty fields
        guard
            let title = titleTF.text, !title.isEmpty,
            let price = priceTF.text, !price.isEmpty,
            let minimumAge = minimumAgeTF.text, !minimumAge.isEmpty,
            let size = sizeTF.text, !size.isEmpty,
            let category = categoryTF.text, !category.isEmpty,
            let description = descriptionTF.text, !description.isEmpty,
            let logo = logoTF.text, !logo.isEmpty,
            let banner = bannerTF.text, !banner.isEmpty,
            let rating = ratingTF.text, !rating.isEmpty,
            let ss1 = ss1TF.text, !ss1.isEmpty,
            let ss2 = ss2TF.text, !ss2.isEmpty,
            let ss3 = ss3TF.text, !ss3.isEmpty
        else {
            // Show an alert for empty fields
            showAlert(message: "Please fill in all fields.")
            return
        }

        // Check if a game with the same title already exists
        if gameWithTitleExists(title: title) {
            // Show an alert that a game with the same title already exists
            showAlert(message: "A game with the same title already exists.")
            return
        }

        // Create a new GameDatas object and set its properties
        let newGameData = GameDatas(context: context)
        newGameData.name = title
        newGameData.price = price
        newGameData.minimumAge = minimumAge
        newGameData.size = size
        newGameData.category = category
        newGameData.gameDescription = description
        newGameData.logo = logo
        newGameData.bannerImage = banner
        newGameData.ratingText = rating
        newGameData.ratingImage = "oneRating"
        newGameData.screenshot1 = ss1
        newGameData.screenshot2 = ss2
        newGameData.screenshot3 = ss3

        // Save the context to persist the new game data
        do {
            try context.save()
            print("New game saved successfully!")

            // Show a success alert
            showAlert(message: "New game added")

            // Clear the text fields
            clearTextFields()
        } catch {
            print("Error saving new game: \(error)")
        }
    }

    func gameWithTitleExists(title: String) -> Bool {
        let fetchRequest: NSFetchRequest<GameDatas> = GameDatas.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", title)

        do {
            let existingGames = try context.fetch(fetchRequest)
            return !existingGames.isEmpty
        } catch {
            print("Error checking for existing game: \(error)")
            return false
        }
    }

    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func clearTextFields() {
        titleTF.text = ""
        priceTF.text = ""
        minimumAgeTF.text = ""
        sizeTF.text = ""
        categoryTF.text = ""
        descriptionTF.text = ""
        logoTF.text = ""
        bannerTF.text = ""
        ratingTF.text = ""
        ss1TF.text = ""
        ss2TF.text = ""
        ss3TF.text = ""
    }
}
