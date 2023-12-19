//
//  RegisterViewController.swift
//  GameHI1
//
//  Created by Arya Reyhan on 07/12/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {
    

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButtonOnClick(_ sender: Any) {
        validateAndSaveUserInfo()
    }
    
    func validateAndSaveUserInfo() {
        guard let username = usernameTextField.text, !username.isEmpty else {
            showAlert(message: "Username cannot be empty.")
            return
        }
        
        guard username.count >= 5 else {
            showAlert(message: "Username must be at least 5 characters.")
            return
        }
        
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Email cannot be empty.")
            return
        }
        
        guard email.hasSuffix(".com") else {
            showAlert(message: "Invalid email format. It must end with '.com'.")
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Password cannot be empty.")
            return
        }
        
        saveUserInfo(username: username, email: email, password: password)
    }
    
    func saveUserInfo(username: String, email: String, password: String) {
        // Check if a user with the same username already exists
        if userExists(withUsername: username) {
            showAlert(message: "Username already exists. Please choose a different username.")
            return
        }

        // If no duplicate username, proceed to save the user
        let newUser = UserDatas(context: context)
        newUser.username = username
        newUser.email = email
        newUser.password = password

        do {
            try context.save()
            print("User saved successfully!")
            performSegue(withIdentifier: "registerSegue", sender: nil)
        } catch {
            print("Error saving user: \(error)")
        }
    }

    func userExists(withUsername username: String) -> Bool {
        let fetchRequest: NSFetchRequest<UserDatas> = UserDatas.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let users = try context.fetch(fetchRequest)
            return !users.isEmpty
        } catch {
            print("Error checking for duplicate user: \(error)")
            return false
        }
    }

    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

}
