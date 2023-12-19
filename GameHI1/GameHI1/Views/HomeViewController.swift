//
//  HomeViewController.swift
//  GameHI1
//
//  Created by Dierta Pasific on 17/12/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    static var loggedInUsername: String?
    
    @IBOutlet weak var topGrossingTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var topGrossingGames: [Game] = []
    
    var categories: [GameCategory] = [
        .init(id: "id1", name: "All Games", image: "allCategory"),
        .init(id: "id2", name: "Action", image: "actionCategory"),
        .init(id: "id3", name: "Adventure", image: "adventureCategory"),
        .init(id: "id4", name: "Strategy", image: "strategyCategory"),
        .init(id: "id5", name: "Puzzle", image: "puzzleCategory"),
        .init(id: "id6", name: "Racing", image: "racingCategory")
    ]
    
    private func fetchRandomGames() {
        let fetchRequest: NSFetchRequest<GameDatas> = GameDatas.fetchRequest()

        do {
            let allGamesDatas = try context.fetch(fetchRequest)

            guard allGamesDatas.count >= 10 else {
                print("Not enough games in Core Data.")
                return
            }

            // Shuffle the array of all games
            let shuffledGamesDatas = allGamesDatas.shuffled()

            // Take the first 5 games from the shuffled array and convert to Game
            topGrossingGames = shuffledGamesDatas.prefix(10).map { Game(gameDatas: $0) }

            // Reload the table view to display the new data
            topGrossingTableView.reloadData()
        } catch {
            print("Error fetching games from Core Data: \(error)")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GameH1"
        
        fetchRandomGames()
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        topGrossingTableView.dataSource = self
        topGrossingTableView.delegate = self
        
        registerCategoriesCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let loggedInUsername = HomeViewController.loggedInUsername {
            print("Logged in user: \(loggedInUsername)")
            // Do whatever you need with the username
        } else {
            print("Fail passing login")
        }
    }

    private func registerCategoriesCells(){
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topGrossingGames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopGrossingTableViewCell", for: indexPath) as! TopGrossingTableViewCell
        cell.setup(game: topGrossingGames[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 265
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.setup(category: categories[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == topGrossingTableView{
            let controller = GameDetailViewController.instantiate()
            controller.game = tableView == topGrossingTableView ? topGrossingGames[indexPath.row] : topGrossingGames[indexPath.row]
            navigationController?.present( controller, animated: true, completion: nil)
        } else{
           // Error
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView{
            let controller = ListGamesViewController.instantiate()
            controller.category = categories[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        } else{
            let controller = GameDetailViewController.instantiate()
            
            navigationController?.present( controller, animated: true, completion: nil)
        }
    }
    
}
