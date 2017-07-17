////
////  HistoryViewController.swift
////  PPCalc
////
////  Created by Yevhen Roman on 16.07.17.
////  Copyright © 2017 EugeneRoman. All rights reserved.
////
//import UIKit
//import CoreData
//class HistoryViewController: UITableViewController {
//    
//    private var number = "010101"//Можна потім напряму вставляти в функцію з Delegat'у
//    
//    var noteItems = [NSManagedObject]()
//    @IBAction func saveNumber(_ sender: UIBarButtonItem) {
//        let alertController = UIAlertController(title: "Save result", message: "Please, add note to result", preferredStyle: UIAlertControllerStyle.alert)
//        let confirmAction = UIAlertAction(title: "Confirm", style: .default, handler: ({(_) in
//            if let field = alertController.textFields?[0] {
//                self.saveItem(numberToSave: self.number,noteTosave: field.text!)
//                self.tableView.reloadData()
//            }}))
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
//        alertController.addTextField(configurationHandler: ({
//            (textField) in
//            textField.placeholder = "Placeholder"}))
//        alertController.addAction(confirmAction)
//        alertController.addAction(cancelAction)
//        
//        self.present(alertController, animated: true, completion: nil)
//        
//    }
//    func saveItem(numberToSave: String,noteTosave: String) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "NoteEntity", in: managedContext)
//        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
//        item.setValue(noteTosave, forKey: "note")
//        item.setValue(numberToSave, forKey: "numberForNote")
//        do {
//            try managedContext.save()
//            noteItems.append(item)
//        }
//        catch {
//            print("Error in saving data")
//        }
//    }
//    
//    ///overrides
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection numberOfRowSection: Int)->Int {
//        return noteItems.count
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        let item = noteItems[indexPath.row]
//        cell.textLabel?.text = item.value(forKey: "item") as? String
//        cell.detailTextLabel?.text = item.value(forKey: "number") as? String
//        return cell
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NoteEntity")
//        
//        do {
//            let results = try managedContext.fetch(fetchRequest)
//            noteItems = results
//        }
//        catch {
//            print("Error in fetch request")
//        }
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.right)
//        managedContext.delete((noteItems[indexPath.row]))
//        noteItems.remove(at: indexPath.row)
//        self.tableView.reloadData()
//        
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    
//}
