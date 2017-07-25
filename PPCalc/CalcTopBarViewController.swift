//
//  ViewController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 06.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit

class CalcTopBarViewController: UIViewController {

    @IBAction func logOut(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "fastLogOut", sender: self)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidAppear(_ animated: Bool) {
    }
}

