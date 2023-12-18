//
//  ListGamesViewController.swift
//  GameHI1
//
//  Created by Dierta Pasific on 18/12/23.
//

import UIKit
import CoreData

class ListGamesViewController: UIViewController {
    
    var category: GameCategory!
    
    @IBOutlet weak var tableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var games: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = category.name
        registerCells()
        
        if (category.name == "All Games") {
            fetchGames()
        } else if(category.name == "Action"){
            fetchGames(forCategory: "Action")
        } else if (category.name == "Adventure"){
            fetchGames(forCategory: "Adventure")
        } else if( category.name == "Strategy"){
            fetchGames(forCategory: "Strategy")
        } else if (category.name == "Puzzle"){
            fetchGames(forCategory: "Puzzle")
        } else if (category.name == "Racing"){
            fetchGames(forCategory: "Racing")
        }
    }
    
    private func fetchGames(forCategory category: String? = nil) {
        let fetchRequest: NSFetchRequest<GameDatas> = GameDatas.fetchRequest()

        // Apply a predicate to filter by category if provided
        if let category = category {
            fetchRequest.predicate = NSPredicate(format: "category == %@", category)
        }

        do {
            let fetchedGamesDatas = try context.fetch(fetchRequest)

            // Convert 'fetchedGamesDatas' to 'games' array
            games = fetchedGamesDatas.map { Game(gameDatas: $0) }

        } catch {
            print("Error fetching games from Core Data: \(error)")
        }
    }
    
    private func registerCells(){
        tableView.register(UINib(nibName: GameListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GameListTableViewCell.identifier)
    }

}

extension ListGamesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameListTableViewCell.identifier) as! GameListTableViewCell
        
        cell.setup(game: games[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = GameDetailViewController.instantiate()
        controller.game = games[indexPath.row]
        navigationController?.present( controller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
