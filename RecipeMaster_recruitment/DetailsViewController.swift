//
//  DetailsViewController.swift
//  RecipeMaster_recruitment
//
//  Created by Kacper Kowalski on 24.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var recipe: Recipe!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descr: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var preparings: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var acitivityIndicator: UIActivityIndicatorView!
    
    
    //MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        hideTestDataOnLoad()
        recipe = Recipe()
        
        recipe.fetchRecipe {
        self.updateUI()
        self.acitivityIndicator.stopAnimating()
        DispatchQueue.main.async {
            }
        }
    }

    func hideTestDataOnLoad() {
        descr.text = ""
        ingredients.text = ""
        preparings.text = ""
        firstImage.image = nil
        secondImage.image = nil
    }
    
    func updateUI () {
        name.text = recipe.title
        descr.text = recipe.description
        ingredients.text = recipe.ingredients
        preparings.text = recipe.preparing
    }
}
