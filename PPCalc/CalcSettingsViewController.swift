//
//  SettingsViewController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 25.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit

class CalcSettingsViewController: UIViewController {
    
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet var emailOflastUserLoggedByFacebook: UILabel!

    @IBAction func soundSwitch(_ sender: UISwitch) {
        if soundSwitch.isOn {
            soundSwitch.isOn = false
            UserDefaults.standard.set(false, forKey: "Sound")
        }
        else {
            soundSwitch.isOn = true
            UserDefaults.standard.set(true, forKey: "Sound")
        }
    }
    
    @IBOutlet var deleteDataForAnotherUser: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.isFirstLaunch() {
        UserDefaults.standard.set(true, forKey: "Sound")
            UserDefaults.standard.set(false, forKey: "DeleteIfAnotherUserLogged")
            UserDefaults.standard.set("Nobody", forKey: "FacebookEmail")
        }
        else {
            deleteDataForAnotherUser.isOn = UserDefaults.standard.bool(forKey: "DeleteIfAnotherUserLogged")
            soundSwitch.isOn = UserDefaults.standard.bool(forKey: "Sound")
            emailOflastUserLoggedByFacebook.text = UserDefaults.standard.string(forKey: "FacebookEmail")
        }
        
    }

}
