//
//  CalcLoginPageByFacebook.swift
//  PPCalc
//
//  Created by Yevhen Roman on 25.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import Foundation

class CalcLoginWithFacebook {
    static let shared = CalcLoginWithFacebook()
    
    func processOfLogging() {
        
        if (FBSDKAccessToken.current() != nil) {
            
        guard let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email"]) else { return print("error") }
            
        graphRequest.start(completionHandler: { (connection, parameters, error) -> Void in
            if ((error) != nil)
            {
                // Process error
                print("Error: \(String(describing: error))")
            }
            else
            {
                guard let email:[String:AnyObject] = parameters as? [String : Any] as [String : AnyObject]? else { return print("error with getting email") }
                self.checkingEmail(email["email"]! as! String)
            }
        })
    }
    
        
    
}
   private func checkingEmail(_ email: String) {
        
        if !(email == UserDefaults.standard.string(forKey: "FacebookEmail")) {
            
            if UserDefaults.standard.bool(forKey: "DeleteIfAnotherUserLogged") {
                NotificationCenter.default.post(name: Notification.Name(rawValue: notificationForDeleteAllNotes), object: self)
            }
            UserDefaults.standard.set(email, forKey: "FacebookEmail")
        }
    }
    
    
}
