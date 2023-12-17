//
//  ListGamesViewController.swift
//  GameHI1
//
//  Created by Dierta Pasific on 18/12/23.
//

import UIKit

class ListGamesViewController: UIViewController {
    
    var category: GameCategory!
    
    @IBOutlet weak var tableView: UITableView!
    
    var games: [Game] = [
        .init(name: "PUBG Mobile", price: "IDR 53.000", minimumAge: "17+", size: "2.68 GB", category: "Action" , description: "PUBG Mobile is a battle royale game where 100 players parachute onto an island, scavenge for weapons, and compete to be the last one standing. The game offers realistic graphics, a variety of weapons, and intense combat.", ratingText: "5.0", logo: "pubgLogo", bannerImage: "pubgBanner", ratingImage: "fiveRating", screenshot1: "pubg1", screenshot2: "pubg2", screenshot3: "pubg3"),
        .init(name: "Candy Crush Saga", price: "IDR 52.000", minimumAge: "4+", size: "322 MB", category: "Puzzle", description: "Candy Crush Saga is a wildly popular match-three puzzle game that has captivated millions of players worldwide. Swap colorful candies to create matches and achieve objectives across a variety of levels. With its easy-to-learn gameplay, vibrant graphics, and social features, Candy Crush Saga offers a sweet and addictive puzzle experience suitable for players of all ages.", ratingText: "5.0", logo: "candyCrushLogo", bannerImage: "candyCrushBanner", ratingImage: "fiveRating", screenshot1: "candyCrush1", screenshot2: "candyCrush2", screenshot3: "candyCrush3"),
        .init(name: "Real Racing 3", price: "IDR 81.000", minimumAge: "4+", size: "743 MB", category: "Racing", description: "Real Racing 3 is a top-tier racing simulation that brings realism to the mobile platform. Featuring an extensive selection of licensed cars and real tracks, the game immerses players in a dynamic racing experience. Its free-to-play model offers a comprehensive career mode, real-time multiplayer races, and visually stunning graphics. Real Racing 3 continues to be a benchmark for mobile racing games, combining authenticity with accessible gameplay.", ratingText: "5.0", logo: "realRacingLogo", bannerImage: "realRacingBanner", ratingImage: "fiveRating", screenshot1: "realRacing1", screenshot2: "realRacing2", screenshot3: "realRacing3"),
        .init(name: "Fortnite", price: "IDR 86.000", minimumAge: "12+", size: "2.97 GB", category: "Action", description: "Fortnite is a popular battle royale game known for its unique building mechanic. Players compete to be the last one standing in a vibrant, ever-changing environment. The game also features creative modes and regular updates.", ratingText: "4.0", logo: "fortniteLogo", bannerImage: "fortniteBanner", ratingImage: "fourRating", screenshot1: "fortnite1", screenshot2: "fortnite2", screenshot3: "fortnite3"),
        .init(name: "Oceanhorn", price: "IDR 108.000", minimumAge: "9+", size: "403 MB", category: "Adventure", description: "Dive into the enchanting world of Oceanhorn, an action-adventure game that pays homage to the classics. Embark on a heroic journey to discover the secrets of the ancient sea monster, Oceanhorn. Explore islands, solve puzzles, and engage in epic battles as you unravel a compelling narrative. With its lush visuals, evocative music, and a vast open world to explore, Oceanhorn captures the spirit of classic adventure games while delivering a modern and engaging experience.", ratingText: "2.0", logo: "oceanhornLogo", bannerImage: "oceanhornBanner", ratingImage: "twoRating", screenshot1: "oceanhorn1", screenshot2: "oceanhorn2", screenshot3: "oceanhorn3"),
        .init(name: "Civilization VI", price: "IDR 58.000", minimumAge: "12+", size: "4.13 GB", category: "Strategy", description: "Civilization VI brings the beloved PC strategy game to mobile devices, allowing players to build and lead their own civilization from ancient times to the modern era. With complex systems for diplomacy, technology, culture, and warfare, Civilization VI offers a deep and immersive 4X strategy experience. The game challenges players to make strategic decisions, interact with historical leaders, and shape the course of their civilization's history on a global scale.", ratingText: "5.0", logo: "civilizationLogo", bannerImage: "civilizationBanner", ratingImage: "fiveRating", screenshot1: "civilization1", screenshot2: "civilization2", screenshot3: "civilization3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = category.name
        registerCells()
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
}
