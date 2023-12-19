//
//  CartViewController.swift
//  GameHI1
//
//  Created by Matthew Anderson on 18/12/23.
//

import UIKit
import CoreData

class CartViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalSizeLabel: UILabel!
    
    var cartData: [CartItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTableView.dataSource = self
        fetchCartData()
    }
    
    func fetchCartData() {
        guard let loggedInUsername = HomeViewController.loggedInUsername else {
            // Handle the case where the username is nil
            return
        }

        let fetchRequest: NSFetchRequest<CartDatas> = CartDatas.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", loggedInUsername)

        do {
            // Fetch CartDatas based on the logged-in username
            let cartDatas = try context.fetch(fetchRequest)

            // Convert CartDatas to CartItem
            cartData = cartDatas.map { CartItem(title: $0.title ?? "", category: $0.category ?? "", price: $0.price ?? "", imageName: $0.logo ?? "", size: $0.size ?? "") }

            // Reload the table view to reflect the fetched data
            cartTableView.reloadData()
            
            updateTotalPriceLabel()
            updateTotalSizeLabel()
        } catch {
            print("Error fetching cart data: \(error)")
        }
    }
    
    func updateTotalPriceLabel() {
        let totalPrice = cartData.reduce(0) { total, cartItem in
            // Extract the numeric value from the price string
            let priceString = cartItem.price.replacingOccurrences(of: "IDR ", with: "")
            let priceWithoutComma = priceString.replacingOccurrences(of: ".", with: "")
            
            if let priceValue = Int(priceWithoutComma) {
                return total + priceValue
            } else {
                return total
            }
        }

        // Format the total price back to IDR with commas
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedTotalPrice = numberFormatter.string(from: NSNumber(value: totalPrice)) ?? "0"

        totalPriceLabel.text = "Total Price: IDR \(formattedTotalPrice)"
    }
    
    func updateTotalSizeLabel() {
        let totalSize = cartData.reduce(0.0) { total, cartItem in
            // Extract the numeric value from the size string
            let sizeString = cartItem.size
            let sizeComponents = sizeString.components(separatedBy: " ")

            if let sizeValue = Double(sizeComponents[0]), let unit = sizeComponents.last {
                // Convert all sizes to MB
                let sizeInMB: Double
                switch unit {
                case "GB":
                    sizeInMB = sizeValue * 1024
                case "MB":
                    sizeInMB = sizeValue
                default:
                    sizeInMB = 0.0
                }
                return total + sizeInMB
            } else {
                return total
            }
        }

        let formattedTotalSize = formatSize(totalSize)
        totalSizeLabel.text = "Total Size: \(formattedTotalSize)"
    }

    // Format size to have two decimal places
    private func formatSize(_ sizeInMB: Double) -> String {
        let formattedSize = String(format: "%.2f", sizeInMB)
        return "\(formattedSize) MB"
    }
    
    func showAlert(message: String, title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartItem = cartData[indexPath.row]
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        cell.titleLabel.text = cartItem.title
        cell.categoryLabel.text = cartItem.category
        cell.priceLabel.text = cartItem.price
        cell.logoImageView.image = UIImage(named: cartItem.imageName)
        
        return cell
    }
    
    private func showAlertWithCompletion(title:String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Checkout Success!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion()
        }))
        present(alert, animated: true, completion: nil)
    }

    
    private func performClearCart() {
        guard let loggedInUsername = HomeViewController.loggedInUsername else {
            // Handle the case where the username is nil
            return
        }

        let fetchRequest: NSFetchRequest<CartDatas> = CartDatas.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", loggedInUsername)

        do {
            let cartItems = try context.fetch(fetchRequest)
            
            if (cartItems.count == 0) {
                showAlertWithCompletion(title:"Empty Cart Warning!", message: "Your cart is empty! Add items before checking out. Happy shopping!") { [weak self] in
                    // Dismiss the cart view controller
                    self?.presentingViewController?.dismiss(animated: true, completion: nil)
                }
                return
            }

            for cartItem in cartItems {
                context.delete(cartItem)
            }

            try context.save()

            // Cart cleared successfully, notify the user
            showAlertWithCompletion(title:  "Empty Cart Warning" ,message: "Order placed successfully. Enjoy!") { [weak self] in
                // Dismiss the cart view controller
                self?.presentingViewController?.dismiss(animated: true, completion: nil)
            }
        } catch {
            print("Error clearing cart: \(error)")
        }
    }

    @IBAction func checkoutButtonOnClick(_ sender: Any) {
        // Call the function to clear the cart
        performClearCart()
    }

}
