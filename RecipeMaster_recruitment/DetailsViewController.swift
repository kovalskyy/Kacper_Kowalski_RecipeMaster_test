//
//  DetailsViewController.swift
//  RecipeMaster_recruitment
//
//  Created by Kacper Kowalski on 24.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit
import SDWebImage
import Photos

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descr: UILabel!
    @IBOutlet weak var ingredients: UILabel!
    @IBOutlet weak var preparings: UILabel!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var recipe: Recipe!
    var detailViewModel: DetailViewModel?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.prepareView()
        self.detailViewModel?.delegate = self
        self.hideTestDataOnLoad()
    }
    
    // MARK: Private methods
    
    fileprivate func updateUI () {
        var ingredients = ""

        guard let ingr = recipe.ingredients else { return }
            let ingrs = self.detailViewModel?.map(ingr)
        
        guard let pizzaIngrs = ingrs else { return }
            for ingredient in pizzaIngrs {
                ingredients.append(ingredient)
        }
        
        var preparings = ""
        
        guard let prep = recipe.preparings else { return }
            let preps = self.detailViewModel?.mapEnumerated(prep)
        
        guard let pizzaPreps = preps else { return }
            for preparing in pizzaPreps {
                preparings.append(preparing)
        }
        
        self.ingredients.text = ingredients
        self.preparings.text = preparings
        self.name.text = recipe.title
        self.descr.text = recipe.description
    }
    
    private func hideTestDataOnLoad() {
        self.descr.text = ""
        self.ingredients.text = ""
        self.preparings.text = ""
        self.firstImage.image = nil
        self.secondImage.image = nil
    }

    // MARK: Saving Images
    
    @IBAction func saveFirstImage(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(firstImage.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @IBAction func saveSecondImage(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(secondImage.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            presentAlert(withTitle: "An Error Occured!", message: error.localizedDescription)
        } else {
            presentAlert(withTitle: "Image Saved!", message: "Your delicious pizza image has been saved!")
        }
    }
}
    // MARK: Extensions

extension DetailsViewController: RecipeProtocol {
    func prepareView() {
        self.detailViewModel?.getRecipe()
    }
    func onError(error: Error) {
        presentAlert(withTitle: "An error occured!", message: error.localizedDescription)
    }
    func onCompleted(recipe: Recipe) {
        self.recipe = recipe
        self.updateUI()
        
        guard let urlst = URL(string: imgst) else { return }
            self.firstImage.sd_setImage(with: urlst, completed: nil)
        guard let urlsd = URL(string: imgsd) else { return }
            self.secondImage.sd_setImage(with: urlsd, completed: nil)
        
        self.activityIndicator.stopAnimating()
    }
}


