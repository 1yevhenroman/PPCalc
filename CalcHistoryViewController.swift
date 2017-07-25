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
    var blurConstraints: [NSLayoutConstraint] = []
    ///overrides
    override func tableView(_ tableView: UITableView, numberOfRowsInSection numberOfRowSection: Int)->Int {
        return dataHistory.noteItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CalcNoteCell", for: indexPath) as? CalcNoteCell {
            let item = dataHistory.noteItems[indexPath.row]

            cell.noteLabel.text =  item.value(forKey: "numberForNote") as? String
            cell.noteTextView.text! = item.value(forKey: "note") as! String
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NoteEntity")
    
        do {
            let results = try managedContext.fetch(fetchRequest)
            dataHistory.noteItems = results
        }
        catch {
            print("Error in fetch request")
        }
        
        

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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
        if editingStyle == UITableViewCellEditingStyle.delete {

            managedContext.delete((dataHistory.noteItems[indexPath.row]))
            dataHistory.noteItems.remove(at: indexPath.row)
            self.tableView.reloadData()
            
        }
    }
    
    
 
        
    
    
    func refresh(sender:AnyObject) {
        // Code to refresh table view  
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
   

}
