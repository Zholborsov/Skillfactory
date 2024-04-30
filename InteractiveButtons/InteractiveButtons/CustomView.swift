//
//  CustomView.swift
//  InteractiveButtons
//
//  Created by Mr President on 29.04.2024.
//

import UIKit

class CustomView: UIView {
    
    // MARK: @IBOutlets
    @IBOutlet weak var someView: UILabel!
    
    
    // MARK: Public properties
    @IBInspectable var labelText: String {
        get {
            someView.text!
        }
        set(labelText) {
            someView.text = labelText
        }
    }
    var workingView: UIView!
    var xibName: String = "CustomView"
    
    
    // MARK: Public inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCustomView()
    }
    
    // MARK: public methods
    func getFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let xib = UINib(nibName: xibName, bundle: bundle)
        let view = xib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    func setCustomView() {
        workingView = getFromXib()
        workingView.frame = bounds
        workingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        workingView.layer.cornerRadius = frame.size.width / 2
        addSubview(workingView)
    }
}
