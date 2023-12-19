//
//  AdminEditGameViewController.swift
//  GameHI1
//
//  Created by Dierta Pasific on 19/12/23.
//

import UIKit
import CoreData

class AdminEditGameViewController: UIViewController {
    
    var game: Game!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    
    @IBAction func deleteButtonOnClick(_ sender: Any) {
            deleteGame()
        }
        
    private func deleteGame() {
        let confirmationAlert = UIAlertController(
            title: "Confirmation",
            message: "Are you sure you want to delete this game?",
            preferredStyle: .alert
        )

        confirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        confirmationAlert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            // Perform the delete operation
            self?.performDelete()
        }))

        present(confirmationAlert, animated: true, completion: nil)
    }

    private func performDelete() {
        let fetchRequest: NSFetchRequest<GameDatas> = GameDatas.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", game.name)

        do {
            let games = try context.fetch(fetchRequest)

            if let gameToDelete = games.first {
                context.delete(gameToDelete)
                try context.save()

                // Game deleted successfully, notify the user
                showAlertWithCompletion(message: "Game deleted successfully!") { [weak self] in
                    // Navigate back to the previous view controller
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        } catch {
            print("Error deleting game: \(error)")
        }
    }

    private func showAlertWithCompletion(message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion()
        }))
        present(alert, animated: true, completion: nil)
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Success",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func updateButtonOnClick(_ sender: Any) {
        updateGame()
    }

    private func updateGame() {
        // Check for empty fields
        guard
            let title = titleTF.text, !title.isEmpty,
            let price = priceTF.text, !price.isEmpty,
            let rating = ratingTF.text, !rating.isEmpty,
            let age = ageTF.text, !age.isEmpty,
            let size = sizeTF.text, !size.isEmpty,
            let description = descriptionTV.text, !description.isEmpty
        else {
            // Show an alert for empty fields
            showAlert(message: "Please fill in all fields.")
            return
        }

        // Fetch the game to be updated
        let fetchRequest: NSFetchRequest<GameDatas> = GameDatas.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", game.name)

        do {
            let games = try context.fetch(fetchRequest)

            if let gameToUpdate = games.first {
                // Update the game properties with the values from the text fields and text view
                gameToUpdate.name = title
                gameToUpdate.price = price
                gameToUpdate.ratingText = rating
                gameToUpdate.minimumAge = age
                gameToUpdate.size = size
                gameToUpdate.gameDescription = description

                // Save the context to persist the changes
                try context.save()

                // Game updated successfully, notify the user
                showAlertWithCompletion(message: "Game updated successfully!") { [weak self] in
                    // Navigate back to the previous view controller
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        } catch {
            print("Error updating game: \(error)")
        }
    }

}
