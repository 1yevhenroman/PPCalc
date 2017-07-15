//
//  CalcKeybordController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit

class CalcKeybordController: UIViewController {

    var onNumTap: ((_ num: Int)->())?
    var onUtilityTap: ((_ symbol: Int)->())?

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
