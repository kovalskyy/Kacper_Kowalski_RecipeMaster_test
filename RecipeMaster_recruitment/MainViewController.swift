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
    @IBOutlet weak var facebookButton: FBSDKLoginButton!
    
    private var viewModel: FacebookManager!
    let disposeBag = DisposeBag()
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style:.plain, target:nil, action:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = FacebookManager()
        self.facebookButton.delegate = self
        setupBinding()
        
        self.mainImage.layer.cornerRadius = mainImage.frame.height / 2
        self.mainImage.clipsToBounds = true
    }
    
    // MARK: - Facebook/Rx binding
    
    private func setupBinding() {

        facebookButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.facebookSignIn()
            })
            .disposed(by: disposeBag)
    }

    private func facebookSignIn() {
        FBSDKLoginManager()
            .logIn(withReadPermissions:facebookPermissions,
                   from: self, handler:viewModel.facebookHandler)
                    self.fetchProfileInfo()
    }

    // MARK: ActionSheet
    
    @IBAction func actionSheet(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Please select one of the options", message: nil, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        let recipeActionButton = UIAlertAction(title: "Get The Recipe", style: .default) { action in self.performSegue(withIdentifier: "GetRecipeID", sender: self) }

        //actions
        alert.addAction(cancelActionButton)
        alert.addAction(recipeActionButton)
        
        // support ipad
        alert.popoverPresentationController?.sourceView = self.view;
        alert.popoverPresentationController?.sourceRect = self.view.frame;
        self.present(alert, animated: true, completion: nil)
    }
}
    // MARK: Extension

extension MainViewController {
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
    }
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {}
    
    func fetchProfileInfo() {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, name, id"])
            .start(completionHandler:  { (connection, result, error) in
                guard let result = result as? NSDictionary,
                    let user = result["name"] as? String
                    else { return }
                print(result)
                //self.navigationItem.setTitle(title: "Recipe Master", subtitle: ("Logged in as: \(user)"))
            })
    }
}
