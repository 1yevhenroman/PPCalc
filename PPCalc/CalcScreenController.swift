//
//  CalcScreenController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit


class CalcScreenController: UIViewController {
   
    @IBOutlet var screenLabel: UILabel!

    private let outputAdapter = OutputAdapter.shared
    
    func presentResult(_ result: String) {
        screenLabel.text = result
    }
    override func viewDidLoad() {
        outputAdapter.resultDisplay = self
        super.viewDidLoad()
    }
    
}
