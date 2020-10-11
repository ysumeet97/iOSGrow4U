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
    var farmID:String?
    var cellImageName:String?
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var view: UIView!
    
    class var CustomCell : CustomFarmCollectionViewCell {
        
        let cell = Bundle.main.loadNibNamed("CustomFarmCollectionViewCell", owner: self, options: nil)?.last
        return cell as! CustomFarmCollectionViewCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.white
        farmName.textColor = .white
        Name.textColor = .white
        
        
    }
    
    //update the cell
    func updateCellWithImage(image_name:String, image_label:String, id: String,name:String) {
        farmID = id
        self.cellImageName = image_name
        let PictureURL = URL(string: image_name)!
        let PictureData = NSData(contentsOf: PictureURL as URL) // nil
        let Picture = UIImage(data: PictureData! as Data)
        self.farmImage.image = Picture
        self.farmImage.contentMode = .scaleToFill
        self.farmImage.translatesAutoresizingMaskIntoConstraints = false
        self.farmImage.layer.cornerRadius = 30.0
        self.farmImage.clipsToBounds = true
       // view.clipsToBounds = true
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        farmName.text = "Rating: " + image_label + "/5"
        farmName.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.015)
        Name.font =  UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)
        self.Name.text = name.capitalized + " Farm"
    }
    
}
extension UIView {
    func roundedCorners(top: Bool){
        let corners:UIRectCorner = (top ? [.topLeft , .topRight] : [.bottomRight , .bottomLeft])
        let maskPAth1 = UIBezierPath(roundedRect: self.bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii:CGSize(width:30.0, height:30.0))
        let maskLayer1 = CAShapeLayer()
        maskLayer1.frame = self.bounds
        maskLayer1.path = maskPAth1.cgPath
        self.layer.mask = maskLayer1
    }
}
