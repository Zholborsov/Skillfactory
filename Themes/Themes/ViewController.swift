//
//  ViewController.swift
//  Themes
//
//  Created by Mr President on 15.06.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var segmentControl = UISegmentedControl()
    var menuArray = ["light", "dark"]
    let imageArray = [UIImage(named: "light"), UIImage(named: "dark")]
    
    var imageView = UIImageView()
    
    var currentImage = UserDefaults.standard.value(forKey: "currentImage")
    var segmentIndex = UserDefaults.standard.integer(forKey: "currentSegment")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating a segment
        self.segmentControl = UISegmentedControl(items: self.menuArray)
        self.segmentControl.frame = CGRect(x: 280, y: 50, width: 100, height: 50)
        self.view.addSubview(self.segmentControl)
        
        // Creating an image
        self.imageView.frame = CGRect(x: 12, y: 110, width: 370, height: 450)
        imageView.image = self.imageArray[self.segmentIndex]
        self.view.addSubview(imageView)
        
        self.segmentControl.addTarget(self, action: #selector(selectedValue), for: .valueChanged)
        self.segmentControl.selectedSegmentIndex = self.segmentIndex
        
    }
    
    @objc func selectedValue(target: UISegmentedControl) {
        if target == self.segmentControl {
            let segmentIndex = target.selectedSegmentIndex
            
            self.imageView.image = self.imageArray[segmentIndex]
            UserDefaults.standard.set(segmentIndex, forKey: "currentSegment")
        }
    }
    
}

