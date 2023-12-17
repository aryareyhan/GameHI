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
        .init(id: "id1", name: "Horror", image: "horrorCategory"),
        .init(id: "id1", name: "Horror", image: "horrorCategory"),
        .init(id: "id1", name: "Horror", image: "horrorCategory"),
        .init(id: "id1", name: "Horror", image: "horrorCategory"),
        .init(id: "id1", name: "Horror", image: "horrorCategory"),
        .init(id: "id1", name: "Horror", image: "horrorCategory")
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

