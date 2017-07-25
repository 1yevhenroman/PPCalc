//
//  CalcKeybordController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit
import AVFoundation

let notificationForSendResult = "'ScreenController'PleaseSendResultTo'CalcHistory'"
class CalcKeybordController: UIViewController {
    let systemSoundID: SystemSoundID = 1103
    @IBOutlet var allKeyboardButtons: [UIButton]!
    var onNumTap: ((_ num: Int)->())?
    var onUtilityTap: ((_ symbol: Int)->())?
  
    @IBAction func changeSize(pinch: UIPinchGestureRecognizer) {
        for button in allKeyboardButtons {
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30*pinch.scale)
        }
    }
    @IBAction func saveResult(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "Save result", message: "Please, add note to result", preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: ({(_) in
            if let field = alertController.textFields?[0] {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationForSavingResult), object: nil, userInfo: ["note": field.text!])
            }}))
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addTextField(configurationHandler: ({
            (textField) in
            textField.placeholder = "Your note..."}))
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }

    @IBAction func onNumericTap(_ button: UIButton) {
        onNumTap?(button.tag)
        if UserDefaults.standard.bool(forKey: "Sound") {
        AudioServicesPlaySystemSound(systemSoundID)
        }
    }
    
    @IBAction func onUtilityTap(_ button: UIButton) {
        onUtilityTap?(button.tag)
        if UserDefaults.standard.bool(forKey: "Sound") {
            AudioServicesPlaySystemSound(systemSoundID)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
