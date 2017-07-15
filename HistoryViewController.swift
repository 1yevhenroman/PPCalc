//
//  HistoryViewController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 15.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let  matrix = [#imageLiteral(resourceName: "usingTouchID.png"),#imageLiteral(resourceName: "Touch_ID-512.png"),#imageLiteral(resourceName: "TouchIDWithLabel.png")]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (matrix.count)
    }
   
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryViewControllerTableViewCell
        cell.savedNumber.text = ""
        
        return (cell)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
