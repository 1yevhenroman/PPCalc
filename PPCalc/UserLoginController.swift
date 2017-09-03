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
    
    let facebookModel = CalcLoginWithFacebook()
    var buttonConstraints: [NSLayoutConstraint] = []
    let facebookLoginButton: FBSDKLoginButton = {
        let loginButton = FBSDKLoginButton()
        return loginButton
    }()
    
    @IBAction func backToCalculator(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "fastLogOut", sender: self)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if !result.isCancelled {
            
            if (FBSDKAccessToken.current() != nil) {
                facebookModel.processOfLogging()
            }
            navigateToAuthenticatedViewController()
            FBSDKLoginManager().logOut()
        }
    }
    
    public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!)->Bool {
        return true
    }
    
    @IBAction func loginWithTouchId(_ sender: UIBarButtonItem) {
        let touchId = CalcLoginWithTouchId.shared
        touchId.logIn()
    }
    
    func navigateToAuthenticatedViewController() {
        performSegue(withIdentifier: "logged", sender: self)
    }
    
    
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
    }
    
    
}
