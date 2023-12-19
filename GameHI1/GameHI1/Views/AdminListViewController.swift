//
//  AdminListViewController.swift
//  GameHI1
//
//  Created by Arya Reyhan on 19/12/23.
//

import UIKit
import CoreData

class AdminListViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var adminListTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var gamesData: [Game] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gamesData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameItem = gamesData[indexPath.row]
        let cell = adminListTableView.dequeueReusableCell(withIdentifier: "adminListCell", for: indexPath) as! AdminTableViewCell
        cell.logoImageView.image = UIImage(named: gameItem.logo)
        cell.nameLabel.text = gameItem.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "AdminEditGameViewController") as? AdminEditGameViewController {
            
            controller.game = gamesData[indexPath.row]
            
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchAllGames()
        adminListTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adminListTableView.dataSource = self
        adminListTableView.delegate = self
        
        fetchAllGames()
        adminListTableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    private func fetchAllGames() {
        let fetchRequest: NSFetchRequest<GameDatas> = GameDatas.fetchRequest()

        do {
            let allGamesDatas = try context.fetch(fetchRequest)

            // Convert 'allGamesDatas' to 'gamesData' array
            gamesData = allGamesDatas.map { Game(gameDatas: $0) }
            
            adminListTableView.reloadData()

        } catch {
            print("Error fetching games from Core Data: \(error)")
        }
    }

}
