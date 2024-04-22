//
//  ShowImageVC.swift
//  CollectionView
//
//  Created by Mr President on 22.04.2024.
//

import UIKit

class ShowImageVC: UIViewController {
    
    @IBOutlet weak var currentImage: UIImageView!
    var imageName: String!  // не должна быть nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentImage.image = UIImage(named: imageName)
    }
    
    // Метод, отвечающий за отображение изображения по имени
    func setImageName(imageName: String) {
        self.imageName = imageName
    }
}
