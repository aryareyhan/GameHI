//
//  LoginViewController.swift
//  GameHI1
//
//  Created by Arya Reyhan on 07/12/23.
//

import UIKit
import CoreData


struct GameInfo {
    var name: String
    var price: String
    var minimumAge: String
    var size: String
    var category: String
    var description: String
    var ratingText: String
    var logo: String
    var bannerImage: String
    var ratingImage: String
    var screenshot1: String
    var screenshot2: String
    var screenshot3: String
}

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        GameDataManager.shared.saveGamesIfNeeded()
//        GameDataManager.shared.clearGameData()
    }

    @IBAction func loginButtonOnClick(_ sender: Any) {
        attemptLogin()
    }
    
    func attemptLogin() {
        guard let username = usernameTextField.text, let enteredPassword = passwordTextField.text else {
            // Handle empty username or password
            return
        }
        
        if username == "admin" && enteredPassword == "admin123" {
            // Admin credentials, perform adminSegue
            performSegue(withIdentifier: "adminSegue", sender: nil)
            return
        }

        if let user = fetchUser(username: username) {
            // User found, compare passwords
            let storedPassword = user.password ?? ""

            if storedPassword == enteredPassword {
                // Passwords match, login successful
                print("Login successful!")
                
                HomeViewController.loggedInUsername = username

                // Perform segue with identifier "loginSegue"
                performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                // Passwords do not match, login failed
                showAlert(message: "Incorrect Password")
                print("Incorrect password")
            }
        } else {
            // User not found, login failed
            print("User not found")
            showAlert(message: "Username not found")
        }
    }

    func fetchUser(username: String) -> UserDatas? {
        let fetchRequest: NSFetchRequest<UserDatas> = UserDatas.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let users = try context.fetch(fetchRequest)
            return users.first
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }

    // Override prepare(for:sender:) to pass data if needed before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginSegue" {
            // Customize preparation logic if needed
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
