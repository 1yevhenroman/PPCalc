//
//  CalculatorViewController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit

class CalcMainController: UIViewController {
    
    var screen: CalcScreenController!
    var keyboard: CalcKeybordController!
    let inputAdapter = IntputAdapter.shared
    
    func onNumericTap(num: Int) {
        inputAdapter.enterNum(num)
    }
    
    func onUtilityTap(symbol: Int) {
        inputAdapter.enterUtility(symbol)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "CalcScreenControllerSegue", let controller = segue.destination as? CalcScreenController {
            screen = controller
            
        } else if segue.identifier == "KeyboardControllerSegue", let controller = segue.destination as? CalcKeybordController {
            keyboard = controller
            keyboard.onNumTap = { [weak self] num in self?.onNumericTap(num: num) }
            keyboard.onUtilityTap = { [weak self] symbol in self?.onUtilityTap(symbol: symbol) }
        }
        
    }
    func enterToPrivateMode() {
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(enterToPrivateMode),
                                               name: NSNotification.Name(rawValue: notificationPrivateMode),
                                               object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
}
