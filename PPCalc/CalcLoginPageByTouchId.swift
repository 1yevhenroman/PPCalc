//
//  CalcLoginPage.swift
//  PPCalc
//
//  Created by Yevhen Roman on 25.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import Foundation
import LocalAuthentication

class CalcLoginWithTouchId {
    
    // 1. Create a authentication context
    private let authenticationContext = LAContext()
    private var error:NSError?
    static let shared = CalcLoginWithTouchId()
    
    func logIn() {
        
        
        // 2. Check if the device has a fingerprint sensor
        // If not, show the user an alert view and bail out!
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            
            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
            
        }
        
        // 3. Check the fingerprint
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Logging in secret calculator",
            reply: { [unowned self] (success, error) -> Void in
                
                if success {
                    
                    // Fingerprint recognized
                    // Go to view controller
                    self.navigateToSecureScreen()
                    
                } else {
                    
                    // Check if there is an error
                    if let error = error {
                        debugPrint(error)
                    }
                }
                
        })
        
    }
    
    /**
     This method will present an UIAlertViewController to inform the user that the device has not a TouchID sensor.
     */
    func showAlertViewIfNoBiometricSensorHasBeenDetected() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationForShowAlert), object: nil, userInfo: ["title":"Error", "message": "This device does not have a TouchID sensor."])
        //showAlertWithTitle(title: "Error", message: "This device does not have a TouchID sensor.")
        
    }
    
    /**
     This method will present an UIAlertViewController to inform the user that there was a problem with the TouchID sensor.
     
     - parameter error: the error message
     
     */
    func showAlertViewAfterEvaluatingPolicyWithMessage( message:String ) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationForShowAlert), object: nil, userInfo: ["title":"Error", "message": message])
        //showAlertWithTitle(title: "Error", message: message)
        
    }
    
    /**
     This method presents an UIAlertViewController to the user.
     
     - parameter title:  The title for the UIAlertViewController.
     - parameter message:The message for the UIAlertViewController.
     
     */
    
    
    //    /
    //     This method will return an error message string for the provided error code.
    //     The method check the error code against all cases described in the `LAError` enum.
    //     If the error code can't be found, a default message is returned.
    //
    //     - parameter errorCode: the error code
    //     - returns: the error message
    //     */
    func errorMessageForLAErrorCode( errorCode:Int ) -> String {
        
        var message = ""
        
        switch errorCode {
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.appCancel.rawValue:
            
            message = "The user failed to provide valid credentials"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.touchIDLockout.rawValue:
            message = "Too many failed attempts."
            
        case LAError.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
            
        }
        
        return message
        
    }
    
    /**
     This method will push the authenticated view controller onto the UINavigationController stack
     */
   func navigateToSecureScreen() {
     NotificationCenter.default.post(name: Notification.Name(rawValue: notificationToNavigateToPrivateMode), object: self)
    }
    
}








