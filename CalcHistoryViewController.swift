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
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CalcNoteCell", for: indexPath) as? CalcNoteCell {
            let item = noteItems[indexPath.row]

            cell.noteLabel.text =  item.value(forKey: "numberForNote") as? String
            cell.noteTextView.text! = item.value(forKey: "note") as! String
            cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
            cell.contentView.backgroundColor = UIColor(white: 1, alpha: 0.5)
            return cell
        }
        
        return UITableViewCell()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "MainBackgroundForPpcalc.png")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        imageView.contentMode = .scaleAspectFit
        
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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notificationForSavingResult),
                                               object: nil,
                                               queue: nil,
                                               using: resultReceived)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
        
        if editingStyle == UITableViewCellEditingStyle.delete {

            managedContext.delete((noteItems[indexPath.row]))
            noteItems.remove(at: indexPath.row)
            self.tableView.reloadData()
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }


}
