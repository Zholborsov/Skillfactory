//
//  ViewController.swift
//  InteractiveButtons
//
//  Created by Mr President on 29.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: @IBOutlets
    @IBOutlet var panActionOutlet: UIPanGestureRecognizer!
    
    @IBOutlet var customView: [CustomView]!
    
    // MARK: Public methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for view in customView {
            view.layer.cornerRadius = 45
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = 1
            animation.toValue = 0.5
            animation.duration = 3
            animation.autoreverses = true
            animation.repeatCount = .infinity
            view.layer.add(animation, forKey: "changeOpacity")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray4
    }


    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // MARK: @IBAction
    
    @IBAction func panAction(_ gesture: UIPanGestureRecognizer) {
        // Хранение перемещения
        let gestureTranslation = gesture.translation(in: view)
        // Жест
        guard let gestureView = gesture.view else { return }
        // Фиксация позиции view после перемещения
        gestureView.center = CGPoint(x: gestureView.center.x + gestureTranslation.x, y: gestureView.center.y + gestureTranslation.y)
        // Сброс перемещения
        gesture.setTranslation(.zero, in: view)
        
        
        // Если перемещение закончилось...
        guard gesture.state == .ended else { return }
        
        for i in 0..<customView.count {
            if customView[i] != gestureView {
                if customView[i].frame.intersects(gestureView.frame) {
                    customView[i].workingView.backgroundColor = UIColor.blue
                    UIView.animate(withDuration: 0.2, delay: 0.2) {
                        self.customView[i].transform.a = 1.2
                        self.customView[i].transform.d = 1.2
                        gestureView.isHidden = true
                    }
                }
            }
        }
    }
}
