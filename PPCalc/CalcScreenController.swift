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
    
    let outputAdapter = OutputAdapter.shared
    
    func presentResult(_ result: String) {
        screenLabel.text = result
        checkForSecretMode()
    }
    override func viewDidLoad() {
        outputAdapter.resultDisplay = self
        super.viewDidLoad()
    }
    func checkForSecretMode() {
        if screenLabel.text == "1415926535" {
           self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }

    
}
