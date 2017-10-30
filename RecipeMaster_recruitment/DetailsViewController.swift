//
//  DetailsViewController.swift
//  RecipeMaster_recruitment
//
//  Created by Kacper Kowalski on 24.10.2017.
//  Copyright © 2017 Kacper Kowalski. All rights reserved.
//

import UIKit
import SDWebImage

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
    
    @IBAction func saveFirstImage(_ sender: UIButton) {
        print("tapped here - first")
    }
    @IBAction func saveSecondImage(_ sender: UIButton) {
        print("tapped here - second")
    }
    func hideTestDataOnLoad() {
        descr.text = ""
        ingredients.text = ""
        preparings.text = ""
        firstImage.image = nil
        secondImage.image = nil
    }
    
    func updateUI () {
        
        let styleIngredients = " - 3 szklanki mąki pszennej \n - 1 łyżeczka soli \n - przyprawy do smaku (oregano, bazylia i słodka papryka) \n - 1 szklanka ciepłej wody \n - 50g swieżych drożdży \n - 3 łyżeczki oliwy z oliwek lub oleju \n - szczypta cukru \n - sos pomidorowy"
        let stylePreparings = " 1. Suche składniki dokładnie mieszamy \n 2.Drożdże zalewamy ciepłą wodą, olejem i cukrem \n 3. Odstawiamy do wyrośnięcia \n 4. Gotowy płyn wlewamy do mąki i mieszam najpierw łyżką, a potem zagniatamy ręką \n 5. Ciasto odstawiamy pod przykryciem do wyrośnięcia na ok. 30 minut \n 6. Rozgrzać piekarnik do 250 st.C \n 7. Na papierze do pieczenia uformować z gotowego ciasta placki. Wychodzą dwie cienkie pizze o średnicy 30cm. Jednak ciasto to również nadaje się na wykonanie pizzy na grubym cieście \n 8. Posmarować spody sosem pomidorowym. Można już w tym momencie nałożyć na wierzch pizzy swoje ulubione składniki. \n 9. Piec ok. 7-10 minut"
        
        if recipe.ingredients != "" && recipe.preparing != "" {
            ingredients.text = styleIngredients
            preparings.text = stylePreparings
        }
        name.text = recipe.title
        descr.text = recipe.description
    }
}
