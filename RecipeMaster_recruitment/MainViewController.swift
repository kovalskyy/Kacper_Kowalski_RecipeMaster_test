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
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16.0, y: 500.0, width: view.frame.width - 32, height: 50)
        
        loginButton.delegate = self
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logged out indeed")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        print("success")
    }
    
    @IBAction func actionSheet(_ sender: UIButton) {
        
        let actionSheetController = UIAlertController(title: "Please select one of the options", message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        
        let recipeActionButton = UIAlertAction(title: "Get The Recipe", style: .default) { action in self.performSegue(withIdentifier: "GetRecipeID", sender: self)
            print("Get the recipe")
        }
    
        let facebookActionButton = UIAlertAction(title: "Login with Facebook", style: .default) { action -> Void in
            print("Facebook")
        }

        //actions
        actionSheetController.addAction(cancelActionButton)
        actionSheetController.addAction(recipeActionButton)
        actionSheetController.addAction(facebookActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
}

