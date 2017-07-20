//
//  CalcNoteCell.swift
//  PPCalc
//
//  Created by Yevhen Roman on 19.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit

class CalcNoteCell: UITableViewCell {

    
    
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var noteTextView: UITextView!
    @IBOutlet var backgroundOfCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    override func didAddSubview(_ subview: UIView) {
        if backgroundOfCell != nil {
             backgroundOfCell.layer.cornerRadius = CGFloat(30.0)
        }
    }
}
