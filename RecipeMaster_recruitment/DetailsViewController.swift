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
        
        let imageUrl1:NSURL? = NSURL(string: "http://mooduplabs.com/test/pizza2.jpg")
        if let url = imageUrl1 {
            firstImage.sd_setImage(with: url as URL!)
        }
        
        let imageUrl2: NSURL? = NSURL(string: "http://mooduplabs.com/test/pizza3.jpg")
        if let url = imageUrl2 {
            secondImage.sd_setImage(with: url as URL!)
        }
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

    //MARK: Private methods
    
    private func hideTestDataOnLoad() {
        descr.text = ""
        ingredients.text = ""
        preparings.text = ""
        firstImage.image = nil
        secondImage.image = nil
    }
    
    private func updateUI () {
        ingredients.text = recipe.ingredients
        preparings.text = recipe.preparing
        name.text = recipe.title
        descr.text = recipe.description
    }

    //MARK: Saving Images
    
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

extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
