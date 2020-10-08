//
//  DetailViewController.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 6/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import UIKit
class DetailViewController:UIViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var information: UITextView!
    @IBOutlet var famers: UITextView!
    var id:String?
    var categories = [ImageCategory]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage(from: "https://www.dw.com/image/47425871_401.jpg", imageViewToSet: self.image)
        self.name.text = "Apple"
        self.price.text = "$ " + "25.40" + " / Kg"
        self.information.text = "An apple is an edible fruit produced by an apple tree (Malus domestica). Apple trees are cultivated worldwide and are the most widely grown species in the genus Malus. The tree originated in Central Asia, where its wild ancestor, Malus sieversii, is still found today. Apples have been grown for thousands of years in Asia and Europe and were brought to North America by European colonists. Apples have religious and mythological significance in many cultures, including Norse, Greek, and European Christian tradition."
        self.famers.text = "Name: Jack\nContact: jack@grow4u.com\nRating: 4\nOffered Price: 25.40"
    }
    
    func setImage(from url: String, imageViewToSet: UIImageView) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                imageViewToSet.image = image
            }
        }
    }
}

