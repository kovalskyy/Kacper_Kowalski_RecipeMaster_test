//
//  MainViewController.swift
//  RecipeMaster_recruitment
//
//  Created by Kacper Kowalski on 24.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class MainViewController: UIViewController, FBSDKLoginButtonDelegate {

    
    //MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style:.plain, target:nil, action:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: Facebook
    
    func handleCustomFacebookLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) {
            (result, error) in
            
            if error != nil {
                print("something went wrong", error ?? "")
                return
            }
            self.fetchProfile()
        }
    }
    
    func fetchProfile() {
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start {
            (connection, result, err) in guard
                
                let result = result as? NSDictionary,
                let email = result["email"] as? String,
                let userName = result["name"] as? String,
                let userID = result["id"] as? String
                
                else { return }
                print("email:", email, "name:", userName, "userId:", userID)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {}
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {}

    
    // MARK: ActionSheet
    
    @IBAction func actionSheet(_ sender: UIButton) {
        
        let actionSheetController = UIAlertController(title: "Please select one of the options", message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        let recipeActionButton = UIAlertAction(title: "Get The Recipe", style: .default) { action in self.performSegue(withIdentifier: "GetRecipeID", sender: self) }
    
        let facebookActionButton = UIAlertAction(title: "Login with Facebook", style: .default) { action in self.handleCustomFacebookLogin() }

        //actions
        actionSheetController.addAction(cancelActionButton)
        actionSheetController.addAction(recipeActionButton)
        actionSheetController.addAction(facebookActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }

}

