//
//  HomeViewController.swift
//  GameHI1
//
//  Created by Dierta Pasific on 17/12/23.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var topGrossingTableView: UITableView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var topGrossingGames: [Game] = [
        .init(name: "PUBG Mobile", price: "IDR 53.000", minimumAge: "17+", size: "2.68 GB", category: "Action" , description: "PUBG Mobile is a battle royale game where 100 players parachute onto an island, scavenge for weapons, and compete to be the last one standing. The game offers realistic graphics, a variety of weapons, and intense combat.", ratingText: "5.0", logo: "pubgLogo", bannerImage: "pubgBanner", ratingImage: "fiveRating", screenshot1: "pubg1", screenshot2: "pubg2", screenshot3: "pubg3"),
        .init(name: "Candy Crush Saga", price: "IDR 52.000", minimumAge: "4+", size: "322 MB", category: "Puzzle", description: "Candy Crush Saga is a wildly popular match-three puzzle game that has captivated millions of players worldwide. Swap colorful candies to create matches and achieve objectives across a variety of levels. With its easy-to-learn gameplay, vibrant graphics, and social features, Candy Crush Saga offers a sweet and addictive puzzle experience suitable for players of all ages.", ratingText: "5.0", logo: "candyCrushLogo", bannerImage: "candyCrushBanner", ratingImage: "fiveRating", screenshot1: "candyCrush1", screenshot2: "candyCrush2", screenshot3: "candyCrush3"),
        .init(name: "Real Racing 3", price: "IDR 81.000", minimumAge: "4+", size: "743 MB", category: "Racing", description: "Real Racing 3 is a top-tier racing simulation that brings realism to the mobile platform. Featuring an extensive selection of licensed cars and real tracks, the game immerses players in a dynamic racing experience. Its free-to-play model offers a comprehensive career mode, real-time multiplayer races, and visually stunning graphics. Real Racing 3 continues to be a benchmark for mobile racing games, combining authenticity with accessible gameplay.", ratingText: "5.0", logo: "realRacingLogo", bannerImage: "realRacingBanner", ratingImage: "fiveRating", screenshot1: "realRacing1", screenshot2: "realRacing2", screenshot3: "realRacing3"),
        .init(name: "Fortnite", price: "IDR 86.000", minimumAge: "12+", size: "2.97 GB", category: "Action", description: "Fortnite is a popular battle royale game known for its unique building mechanic. Players compete to be the last one standing in a vibrant, ever-changing environment. The game also features creative modes and regular updates.", ratingText: "4.0", logo: "fortniteLogo", bannerImage: "fortniteBanner", ratingImage: "fourRating", screenshot1: "fortnite1", screenshot2: "fortnite2", screenshot3: "fortnite3"),
        .init(name: "Clash Royale", price: "IDR 42.000", minimumAge: "10+", size: "490 MB", category: "Strategy", description: "Success in Clash Royale hinges on careful deck construction and strategic decision-making. With a vast collection of cards at your disposal, ranging from mighty warriors and mystical spells to formidable siege weapons, every battle becomes a dynamic chess match where adaptability and foresight are crucial. As you progress, unlock and upgrade cards to enhance your arsenal, crafting a deck that reflects your preferred playstyle and tactics.", ratingText: "5.0", logo: "clashRoyaleLogo", bannerImage: "clashRoyaleBanner", ratingImage: "fiveRating", screenshot1: "clashRoyale1", screenshot2: "", screenshot3: ""),
        .init(name: "Asphalt 9: Legends", price: "IDR 41.000", minimumAge: "10+", size: "3.2 GB", category: "Racing", description: "Asphalt 9: Legends sets the standard for mobile arcade racing with its breathtaking visuals and high-speed gameplay. This free-to-play title offers an extensive roster of real hypercars, including Ferrari, Porsche, and Lamborghini. Engage in intense, multiplayer races or embark on a thrilling Career mode where you can unlock and upgrade your dream cars. The game's stunning graphics and easy-to-learn controls make it a must-play for racing enthusiasts seeking an adrenaline-packed experience on their mobile devices.", ratingText: "4.0", logo: "asphaltLogo", bannerImage: "asphaltBanner", ratingImage: "fourRating", screenshot1: "asphalt1", screenshot2: "", screenshot3: "")
    ]
    
    var categories: [GameCategory] = [
        .init(id: "id1", name: "All Games", image: "allCategory"),
        .init(id: "id2", name: "Action", image: "actionCategory"),
        .init(id: "id3", name: "Adventure", image: "adventureCategory"),
        .init(id: "id4", name: "Strategy", image: "strategyCategory"),
        .init(id: "id5", name: "Puzzle", image: "puzzleCategory"),
        .init(id: "id6", name: "Racing", image: "racingCategory")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "GameH1"
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        topGrossingTableView.dataSource = self
        topGrossingTableView.delegate = self
        
        registerCategoriesCells()
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
        return 140
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
