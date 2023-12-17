//
//  CategoryCollectionViewCell.swift
//  GameHI1
//
//  Created by Dierta Pasific on 17/12/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    func setup(category: GameCategory){
        categoryLabel.text = category.name
        categoryImageView.image = UIImage(named: category.image)
    }

}
