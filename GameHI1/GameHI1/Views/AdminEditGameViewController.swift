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

}
