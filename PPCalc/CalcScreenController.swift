//
//  CalcScreenController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit
let notificationForSavingResult = "needToSaveResult"

class CalcScreenController: UIViewController {
    let securedPassword = "1415926535"
    @IBOutlet var screenLabel: UILabel!

    private let outputAdapter = OutputAdapter.shared
    
    func presentResult(_ result: String) {
        screenLabel.text = result
        checkForSecretMode()
    }
    override func viewDidLoad() {
        outputAdapter.resultDisplay = self
        super.viewDidLoad()
        
    }
    func checkForSecretMode() {
        //засунути в брейн
        if screenLabel.text == securedPassword {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
    func sendResultForSaving() {
    
    }
    
}
