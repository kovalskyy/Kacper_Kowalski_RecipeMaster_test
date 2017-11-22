//
//  MainViewController.swift
//  RecipeMaster_recruitment
//
//  Created by Kacper Kowalski on 24.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    
    private var viewModel: FacebookViewModel!
    let disposeBag = DisposeBag()
    
    //MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style:.plain, target:nil, action:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FacebookViewModel()
        
//        self.loginButton.delegate = self
        mainImage.layer.cornerRadius = mainImage.frame.height/2
        mainImage.clipsToBounds = true
    }
    
    // MARK: - Facebook/Rx binding
    
    private func setupBinding() {

        loginButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.facebookSignIn()
            })
            .disposed(by: disposeBag)
    }
    
    private func facebookSignIn() {
        FBSDKLoginManager()
            .logIn(withReadPermissions: Settings.facebookPermissions,
                   from: self, handler:viewModel.facebookHandler)
    }
    
    // MARK: ActionSheet
    
    @IBAction func actionSheet(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Please select one of the options", message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        let recipeActionButton = UIAlertAction(title: "Get The Recipe", style: .default) { action in self.performSegue(withIdentifier: "GetRecipeID", sender: self) }
    
        let facebookActionButton = UIAlertAction(title: "Login with Facebook", style: .default) { action in self.handleCustomFacebookLogin() }

        //actions
        alert.addAction(cancelActionButton)
        alert.addAction(recipeActionButton)
        alert.addAction(facebookActionButton)
        
        // support ipad
        alert.popoverPresentationController?.sourceView = self.view;
        alert.popoverPresentationController?.sourceRect = self.view.frame;
        self.present(alert, animated: true, completion: nil)
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
    
        func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {}
    
        func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {}
    
        func fetchProfile() {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name, id"]).start(completionHandler:  { (connection, result, error) in
                guard let result = result as? NSDictionary,
                    let name = result["name"] as? String
                    else {
                        return
                }
                self.navigationItem.setTitle(title: "Recipe Master", subtitle: ("Logged in as: \(name)"))
                print(result)
            })
        }
}



