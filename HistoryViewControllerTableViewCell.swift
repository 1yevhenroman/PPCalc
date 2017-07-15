//
//  HistoryViewControllerTableViewCell.swift
//  PPCalc
//
//  Created by Yevhen Roman on 15.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit

class HistoryViewControllerTableViewCell: UITableViewCell {
    @IBOutlet weak var savedNumber: UILabel!
    @IBOutlet weak var noteForSavedNumber: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
