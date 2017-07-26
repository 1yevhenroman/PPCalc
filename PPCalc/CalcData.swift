//
//  File.swift
//  PPCalc
//
//  Created by Yevhen Roman on 19.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import Foundation
import CoreData

class CalcHistoryCoreData {
    
    static let shared = CalcHistoryCoreData()
    private let brain = Perfected.shared
    var noteItems = [NSManagedObject]()
    init() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notificationForSavingResult), object: nil, queue: nil, using: saveResult)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteAll) ,name: NSNotification.Name(rawValue:notificationForDeleteAllNotes),object: nil)
    }
    func saveResult (notification: Notification) {
        
        guard let note = notification.userInfo?["note"] else { return }
        
        let numberForSaving = brain.input
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "NoteEntity", in: managedContext)
        let item = NSManagedObject(entity: entity!, insertInto: managedContext)
        item.setValue(note, forKey: "note")
        item.setValue(numberForSaving, forKey: "numberForNote")
        do {
            try managedContext.save()
            self.noteItems.append(item)
        }
        catch {
            print("Error in saving data")
        }
        
    }
    func removeNote(_ row: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete((noteItems[row]))
        noteItems.remove(at: row)
    }
    func fetch () {
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
    func getResult(by row: Int)->String {
        return noteItems[row].value(forKey: "numberForNote") as! String
    }
    func getNote(by row: Int) -> String {
        return noteItems[row].value(forKey: "note") as! String
    }
    @objc func deleteAll() {
        noteItems.removeAll()
    }
}

