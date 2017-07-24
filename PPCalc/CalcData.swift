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
    let brain = Perfected.shared
    var noteItems = [NSManagedObject]()
    init() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notificationForSavingResult), object: nil, queue: nil, using: saveResult)
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
}
