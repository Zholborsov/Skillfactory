//
//  CustomCell.swift
//  ToDoMVC
//
//  Created by Mr President on 05.05.2024.
//

import UIKit

protocol CustomCellDelegate {
    func editCell(cell: CustomCell)
    func deleteCell(cell: CustomCell)
}

class CustomCell: UITableViewCell {
    
    // MARK: @IBOutlets
    @IBOutlet weak var label: UILabel!
    
    // MARK: Public Properties
    var delegate: CustomCellDelegate?
    var labelText: String {
        get {
            label.text!
        }
        set(labelText) {
            label.text = labelText
        }
    }
    
    // MARK: Public Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
