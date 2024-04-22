//
//  Cell.swift
//  CollectionView
//
//  Created by Mr President on 22.04.2024.
//

import UIKit

class Cell: UICollectionViewCell {
    
    // Связи со Storyboard
    @IBOutlet weak var temperatureImage: UIImageView!
    @IBOutlet weak var smileImage: UIImageView!
    
    
    // Метод, отвечающий за отображения изображения
    func setTemperatureImage(imageName: String) {
        temperatureImage.image = UIImage(named: imageName)
    }
    func setSmile(imageName: String) {
        smileImage.image = UIImage(named: imageName)
    }
}
