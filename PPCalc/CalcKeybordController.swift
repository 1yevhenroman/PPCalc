//
//  CalcKeybordController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit
let notificationForSendResult = "'ScreenController'PleaseSendResultTo'CalcHistory'"
class CalcKeybordController: UIViewController {
    
    @IBOutlet var allKeyboardButtons: [UIButton]!
    var onNumTap: ((_ num: Int)->())?
    var onUtilityTap: ((_ symbol: Int)->())?
    
    
    
    @IBAction func changeSize(pinch: UIPinchGestureRecognizer) {
        for button in allKeyboardButtons {
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40*pinch.scale)
        }
    }
    
    @IBAction func saveResult(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationForSendResult), object: nil)
    }
    @IBAction func onNumericTap(_ button: UIButton) {
        onNumTap?(button.tag)
    }
    
    @IBAction func onUtilityTap(_ button: UIButton) {
        onUtilityTap?(button.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
