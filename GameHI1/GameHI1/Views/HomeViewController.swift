//
//  HomeViewController.swift
//  GameHI1
//
//  Created by Dierta Pasific on 17/12/23.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
        cell.setup(category: categories[indexPath.row])
        return cell
    }
    
    var categories: [GameCategory] = [
        .init(id: "id1", name: "All Games", image: "allCategory"),
        .init(id: "id2", name: "Action", image: "actionCategory"),
        .init(id: "id3", name: "Adventure", image: "adventureCategory"),
        .init(id: "id4", name: "Strategy", image: "strategyCategory"),
        .init(id: "id5", name: "Puzzle", image: "puzzleCategory"),
        .init(id: "id6", name: "Horror", image: "horrorCategory"),
        .init(id: "id7", name: "Arcade", image: "arcadeCategory"),
        .init(id: "id8", name: "Music", image: "musicCategory")
    ]

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "GameH1"
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        registerCells()
        
    }
    
    private func registerCells(){
        categoryCollectionView.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
    }
}

