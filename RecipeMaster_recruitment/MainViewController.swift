//
//  MainViewController.swift
//  RecipeMaster_recruitment
//
//  Created by Kacper Kowalski on 24.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    //MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style:.plain, target:nil, action:nil)
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

