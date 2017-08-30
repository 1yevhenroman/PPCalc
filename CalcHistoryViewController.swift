//
//  CalcHistoryViewController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 16.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit
import CoreData

class CalcHistoryViewController: UITableViewController {
    
    let dataHistory = CalcHistoryCoreData.shared
    var refresher: UIRefreshControl!
    ///overrides
    override func tableView(_ tableView: UITableView, numberOfRowsInSection numberOfRowSection: Int)->Int {
        return dataHistory.noteItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CalcNoteCell", for: indexPath) as? CalcNoteCell {
            cell.noteLabel.text = dataHistory.getResult(by: indexPath.row)
            cell.noteTextView.text! = dataHistory.getNote(by: indexPath.row)
            cell.backgroundColor = UIColor(white: 1, alpha: 0.0)
            cell.contentView.backgroundColor = UIColor(white: 1, alpha: 0.0)
            return cell
        }
        
        return UITableViewCell()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "MainBackgroundForPpcalc.png")
        let imageView = UIImageView(image: backgroundImage)
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
        dataHistory.fetch()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        refresher = UIRefreshControl()
        tableView.addSubview(refresher)
        refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresher.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    func reloadData () {
        tableView.reloadData()
        refresher.endRefreshing()
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            dataHistory.removeNote(indexPath.row)
            self.tableView.reloadData()
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
}
