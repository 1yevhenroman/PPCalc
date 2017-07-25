//
//  UserLoginController.swift
//  PPCalc
//
//  Created by Yevhen Roman on 06.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import UIKit
import LocalAuthentication
import FBSDKCoreKit
import FBSDKLoginKit

class UserLoginController: UIViewController, FBSDKLoginButtonDelegate {
    var buttonConstraints: [NSLayoutConstraint] = []
    let facebookLoginButton: FBSDKLoginButton = {
    let loginButton = FBSDKLoginButton()
    let touchId = CalcLoginWithTouchId.shared
    loginButton.readPermissions = ["email"]
        return loginButton
    }()
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        navigateToAuthenticatedViewController()
        if !result.isCancelled {
            
            if (FBSDKAccessToken.current() != nil) {
                fetchProfile()
            }
            FBSDKLoginManager().logOut()
        }
    }
    func loginButtonDidLogOut (loginButton: FBSDKLoginButton, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        fetchProfile()
    }
    func fetchProfile() {
        
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
                print(email["email"]!)

            }
        })
        
    }
    
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    func loginButtonWillLogin(_ lo4ginButton: FBSDKLoginButton!)->Bool {
        return true
    }
    
    @IBAction func loginWithTouchId(_ sender: UIBarButtonItem) {
       let touchId = CalcLoginWithTouchId.shared
         touchId.logIn()
    }
    
   func navigateToAuthenticatedViewController() {
     performSegue(withIdentifier: "logged", sender: self)
    }
    
    /**
     This method presents an UIAlertViewController to the user.
     
     - parameter title:  The title for the UIAlertViewController.
     - parameter message:The message for the UIAlertViewController.
     
     */
    func showAlertWithTitle(notification: Notification ) {
        
        guard let title = notification.userInfo!["title"] else { return }
        guard let message = notification.userInfo!["message"] else { return }
        
        let alertVC = UIAlertController(title: title as? String, message: message as? String, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async() { () -> Void in
            
            self.present(alertVC, animated: true, completion: nil)
            
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.prepareForInterfaceBuilder()
    }
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(facebookLoginButton)
        
        facebookLoginButton.center = CGPoint(x: (view.frame.size.width - facebookLoginButton.center.x)/2, y: view.frame.size.height - facebookLoginButton.frame.size.height)
        facebookLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        //Facebook button's constraints
        let equalWidth = facebookLoginButton.widthAnchor.constraint(equalTo: facebookLoginButton.widthAnchor)
        let equalHeight = facebookLoginButton.heightAnchor.constraint(equalTo: facebookLoginButton.heightAnchor)
        let bottomConstraint = facebookLoginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        let leftConstraint = facebookLoginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let rightConstraint = facebookLoginButton.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        
        buttonConstraints = [bottomConstraint,leftConstraint, rightConstraint,equalWidth,equalHeight]
        NSLayoutConstraint.activate(buttonConstraints)
        facebookLoginButton.delegate = self
        
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: notificationForShowAlert),
                                                object: nil,
                                                queue: nil,
                                                using:showAlertWithTitle)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(navigateToAuthenticatedViewController),
                                               name: NSNotification.Name(rawValue: notificationToNavigateToPrivateMode),
                                               object: nil)
        
        
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
