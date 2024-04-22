//
//  ViewController.swift
//  CollectionView
//
//  Created by Mr President on 22.04.2024.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // Связи со Storyboard
    @IBOutlet weak var collectionViewOne: UICollectionView!
    @IBOutlet weak var collectionViewTwo: UICollectionView!
    
    // Массивы элементов
    var arrayOfTemperatures: Array<String> = ["temp.green", "temp.blackGreen", "temp.lightYellow", "temp.darkYellow", "temp.orange", "temp.red"]
    var arrayOfSmiles = ["nice", "favorite", "routine", "notPleasant", "bad", "hate"]
    
    // Методы ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Подключение делегатов (доступ к методам протоколов)
        collectionViewOne.dataSource = self
        collectionViewOne.delegate = self
        collectionViewTwo.dataSource = self
        collectionViewTwo.delegate = self
    }
    
    // Методы протоколов
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewOne {
            return arrayOfTemperatures.count
        }
        if collectionView == collectionViewTwo {
            return arrayOfSmiles.count
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Проверка на существование файла с идентификатором
        if collectionView == collectionViewOne {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellOne", for: indexPath) as? Cell else { return UICollectionViewCell() }
            // Переменная, которая будет хранить каждое изображение по индексу
            let imageName = arrayOfTemperatures[indexPath.item]
            // Вызов метода, передающего название изображения в хранилище imageName (в классе ShowImageVC)
            cell.setTemperatureImage(imageName: imageName)
            return cell
        }
        if collectionView == collectionViewTwo {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellTwo", for: indexPath) as? Cell else { return UICollectionViewCell() }
            let imageName = arrayOfSmiles[indexPath.row]
            cell.setSmile(imageName: imageName)
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "ShowImageVC", creator: nil) as? ShowImageVC else { return }
        // Получение имени изображения
        var currentSelectedImage: String!
        
        if collectionView == collectionViewOne {
            currentSelectedImage = arrayOfTemperatures[indexPath.row]
        }
        if collectionView == collectionViewTwo{
            currentSelectedImage = arrayOfSmiles[indexPath.row]
        }
        
        // метод для передачи изображения
        vc.setImageName(imageName: currentSelectedImage)
        
        // Метод для перехода на следующий экран
        present(vc, animated: true, completion: nil)
    }
}

