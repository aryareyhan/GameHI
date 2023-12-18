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
            cartData = cartDatas.map { CartItem(title: $0.title ?? "", category: $0.category ?? "", price: $0.price ?? "", imageName: $0.logo ?? "") }

            // Reload the table view to reflect the fetched data
            cartTableView.reloadData()
            
            updateTotalPriceLabel()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartData.count
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
    
    
    
}
