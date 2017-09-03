//
//  CalcKeybordController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit
import AVFoundation


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
