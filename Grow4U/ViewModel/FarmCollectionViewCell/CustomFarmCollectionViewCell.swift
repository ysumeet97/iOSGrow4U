//
//  CustomFarmCollectionViewController.swift
//  Grow4U
//
//  Created by vaishali wahi on 5/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//


import UIKit

class CustomFarmCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var farmName: UILabel!
    @IBOutlet weak var farmImage: UIImageView!
    
    var cellImageName:String?
    
    class var CustomCell : CustomFarmCollectionViewCell {
        
        let cell = Bundle.main.loadNibNamed("CustomFarmCollectionViewCell", owner: self, options: nil)?.last
        return cell as! CustomFarmCollectionViewCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.red
        
    }
    
    func updateCellWithImage(image_name:String, image_label:String) {
        self.cellImageName = image_name
        let PictureURL = URL(string: image_name)!
        let PictureData = NSData(contentsOf: PictureURL as URL) // nil
        let Picture = UIImage(data: PictureData! as Data)
        self.farmImage.image = Picture
        farmName.text = image_label
        farmName.sizeToFit()
    }
    
}
