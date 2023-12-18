//
//  LoginViewController.swift
//  GameHI1
//
//  Created by Matthew Anderson on 07/12/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonOnClick(_ sender: Any) {
        attemptLogin()
    }
    
    func attemptLogin() {
        guard let username = usernameTextField.text, let enteredPassword = passwordTextField.text else {
            // Handle empty username or password
            return
        }

        if let user = fetchUser(username: username) {
            // User found, compare passwords
            let storedPassword = user.password ?? ""

            if storedPassword == enteredPassword {
                // Passwords match, login successful
                print("Login successful!")

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
