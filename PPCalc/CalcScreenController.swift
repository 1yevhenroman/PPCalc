//
//  CalcScreenController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit
let notificationForSavingResult = "needToSaveResult"
let notificationForResetBrain = "resetBrain"

class CalcScreenController: UIViewController {

    @IBOutlet var screenLabel: UILabel!

    private let outputAdapter = OutputAdapter.shared
    
    func presentResult(_ result: String) {
        screenLabel.text = result
        checkForSecretMode()
    }
    override func viewDidLoad() {
        outputAdapter.resultDisplay = self
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(sendResultForSaving),
                                               name: NSNotification.Name(rawValue: notificationForSendResult),
                                               object: nil)

    }
    func checkForSecretMode() { 
        if screenLabel.text == "1415926535" { //замінити число на ВАР
           self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
    func sendResultForSaving() {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationForSavingResult), object: nil, userInfo: ["result": screenLabel.text!])
    }
    
}
