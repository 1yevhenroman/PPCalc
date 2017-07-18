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
    var numberForSaving = "0"
    var noteItems = [NSManagedObject]()
    
    func resultReceived(notification: Notification) {
       
        guard let result = notification.userInfo?["result"] else { return }
        debugPrint(result)
         debugPrint(result as! String)
        savingNumber(result: result as! String)
        numberForSaving = result as! String
        
    }
    func savingNumber(result: String) {

       print("Number: \(result)")
        let alertController = UIAlertController(title: "Save result", message: "Please, add note to result", preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: ({(_) in
            if let field = alertController.textFields?[0] {
                self.saveItem(noteTosave: field.text!)
                self.tableView.reloadData()
            }}))
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        alertController.addTextField(configurationHandler: ({
            (textField) in
            textField.placeholder = "Your note..."}))
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    func saveItem(noteTosave: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "NoteEntity", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        item.setValue(noteTosave, forKey: "note")
        item.setValue(numberForSaving, forKey: "numberForNote")
        do {
            try managedContext.save()
            noteItems.append(item)
        }
        catch {
            print("Error in saving data")
        }
    }
    
    ///overrides
    override func tableView(_ tableView: UITableView, numberOfRowsInSection numberOfRowSection: Int)->Int {
        return noteItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let item = noteItems[indexPath.row]
        cell.textLabel?.text = item.value(forKey: "note") as? String
        cell.detailTextLabel?.text = item.value(forKey: "numberForNote") as? String
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notificationForSavingResult),
                                               object: nil,
                                               queue: nil,
                                               using: resultReceived)
    }
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NoteEntity")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            noteItems = results
        }
        catch {
            print("Error in fetch request")
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.right)
        managedContext.delete((noteItems[indexPath.row]))
        noteItems.remove(at: indexPath.row)
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        //NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
    
}

