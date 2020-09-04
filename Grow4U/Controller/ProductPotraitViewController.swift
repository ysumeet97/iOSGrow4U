//
//  ProductsViewController.swift
//  Grow4U
//
//  Created by vaishali wahi on 22/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import UIKit


private var num = 0
private var imagesUrl = [String]()
private var type = [String]()
private var type_price = [String]()
private var farmsImagesUrl = [String]()
private var farms_name = [String]()
private var farms_ratings = [String]()
struct CustomData {
    var title: String
    var url: String
    var backgroundImage: UIImage
}
class ProductsPotraitViewController: UIViewController{
    var pdata: [ProductDataModel.Data]?
    var farmsData: [FarmsModel.Data]?
    let collectionViewBIdentifier = "ProductsViewCell"
    
   
   
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet var search: UISearchBar!
    @IBOutlet weak var navigation: UINavigationBar!
    
    fileprivate let mainCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect(x: 200, y: 20, width: 200, height: 100), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "mainCell")
        return cv
    }()
    fileprivate let fruitsCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect(x: 200, y: 20, width: 200, height: 100), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomProductsCell.self, forCellWithReuseIdentifier: "fCell")
        return cv
    }()
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect(x: 200, y: 20, width: 200, height: 100), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomProductsCell.self, forCellWithReuseIdentifier: "pCell")
        return cv
    }()
    fileprivate let farmsCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadJsonFile()
        getAllData()
        getAllFarmsData()
        navigation.topItem?.titleView = search
        navigation.backgroundColor = .green
        //self.view.addSubview(scrollView)
        //scrollView.delegate = self
        //scrollView.delegate = self
        // constrain the scroll view to 8-pts on each side
       
        
        // constrain the scroll view to 8-pts on each side
        //view.addSubview(collectionView)
        //view.addSubview(farmsCollectionView)
        //view.addSubview(fruitsCollectionView)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.frame = scrollView.bounds
        mainCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.addSubview(mainCollectionView)
        
//
//        mainCollectionView.addSubview(farmsCollectionView)
//        mainCollectionView.addSubview(collectionView)
//        mainCollectionView.addSubview(fruitsCollectionView)
//
//        //collectionView.isPagingEnabled = true
//
//        farmsCollectionView.delegate = self
//        farmsCollectionView.dataSource = self
//        farmsCollectionView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8.0).isActive = true
//        farmsCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0).isActive = true
//        farmsCollectionView.heightAnchor.constraint(equalToConstant:  self.view.bounds.height/1.5).isActive = true
//        farmsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:0).isActive = true
//
//        fruitsCollectionView.delegate = self
//        fruitsCollectionView.dataSource = self
//        fruitsCollectionView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 100.0).isActive = true
//        fruitsCollectionView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8.0).isActive = true
//        fruitsCollectionView.heightAnchor.constraint(equalToConstant: scrollView.bounds.height/1.5 ).isActive = true
//         fruitsCollectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant:0).isActive = true
////
////
//////       // farmsCollectionView.isPagingEnabled = true
//////        //farmsCollectionView.backgroundColor = .white
//        collectionView.backgroundColor = .white
//        collectionView.delegate = self
//        collectionView.dataSource = self
        mainCollectionView.leftAnchor.constraint(equalTo:  scrollView.leftAnchor, constant: 8.0).isActive = true
        mainCollectionView.rightAnchor.constraint(equalTo:  scrollView.rightAnchor, constant: -8.0).isActive = true
        mainCollectionView.heightAnchor.constraint(equalToConstant:   scrollView.bounds.height/1.5).isActive = true
        mainCollectionView.trailingAnchor.constraint(equalTo:  scrollView.trailingAnchor, constant:0).isActive = true
//        collectionView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8.0).isActive = true
//        collectionView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8.0).isActive = true
//        collectionView.heightAnchor.constraint(equalToConstant:  scrollView.bounds.height/1.5).isActive = true
//        collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant:0).isActive = true
    }
    func getFarmsCount()->Int{
        var num = 0
        num = num + farmsData!.count
        return num
    }
    
    func getVegetableCount() -> Int{
        var num = 0
        for locations in pdata!{
            
            let vegetables = locations.vegetables
            num = num + vegetables!.count
            
        }
        return num
    }
    func getAllFarmsData(){
        
        
        for data in farmsData!{
            
                farmsImagesUrl.append(data.image!)
                farms_name.append(data.name!)
                farms_ratings.append(data.ratings!)
            
        }
        
    }
    func getAllData(){
        

        for locations in pdata!{
            for data in locations.vegetables!{
                imagesUrl.append(data.image!)
                type.append(data.type!)
                type_price.append(data.price!)
            }
        }
       
    }
    
    func loadJsonFile() {
        
        guard let productsPath = Bundle.main.path(forResource: "ProductsData", ofType: "json") else { return }
        guard let farmsPath = Bundle.main.path(forResource: "FarmsData", ofType: "json") else { return }
        
        let farmsUrl = URL(fileURLWithPath: farmsPath)
        do {
            
            let data = try Data(contentsOf: farmsUrl)
            //print("here is the data",data)
            
            
            let farms = try
                JSONDecoder().decode(FarmsModel.self, from: data)
            
             //print(farms.farms )
            
            self.farmsData = farms.farms
            
            
            
            //self.location = locations.locations
            
        } catch  {
            print(error)
            
        }
        let url = URL(fileURLWithPath: productsPath)
        do {
            
            let data = try Data(contentsOf: url)
            //print("here is the data",data)
            
            
            let products = try
                JSONDecoder().decode(ProductDataModel.self, from: data)
            
           // print(products.locations )
            
            self.pdata = products.locations
            
            
            
            //self.location = locations.locations
            
        } catch  {
            print(error)
            
        }
    }
    
    
}
extension ProductsPotraitViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.farmsCollectionView {
            return CGSize(width: collectionView.frame.width/1.5, height: collectionView.frame.width/1.3)}
        else if collectionView == self.collectionView {
            return CGSize(width: collectionView.frame.width/1.5, height: collectionView.frame.width/1.3)
        }
        else{
            return CGSize(width: collectionView.frame.width/1.5, height: collectionView.frame.width/1.3)
        }

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.farmsCollectionView{
        
            return getFarmsCount()
            
        }
    else if collectionView == self.collectionView
        {
            return getVegetableCount()
        }
        else if collectionView == self.fruitsCollectionView{
            return getVegetableCount()
        }
        else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        if collectionView == self.farmsCollectionView{
        let cell = farmsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.titleLabel.text =  farms_name[indexPath.item]
        let PictureURL = URL(string: farmsImagesUrl[indexPath.item])!
        let PictureData = NSData(contentsOf: PictureURL as URL) // nil
        let Picture = UIImage(data: PictureData! as Data)
        cell.bg.image = Picture
        return cell
            
        }
        else if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pCell", for: indexPath) as! CustomProductsCell
            cell.titleLabel.text =  type[indexPath.item]
            let PictureURL = URL(string: imagesUrl[indexPath.item])!
            let PictureData = NSData(contentsOf: PictureURL as URL) // nil
            let Picture = UIImage(data: PictureData! as Data)
            cell.bg.image = Picture
            return cell
            
        }
        else if collectionView == self.fruitsCollectionView{
            let cell = fruitsCollectionView.dequeueReusableCell(withReuseIdentifier: "fCell", for: indexPath) as! CustomProductsCell
            cell.titleLabel.text =  type[indexPath.item]
            let PictureURL = URL(string: imagesUrl[indexPath.item])!
            let PictureData = NSData(contentsOf: PictureURL as URL) // nil
            let Picture = UIImage(data: PictureData! as Data)
            cell.bg.image = Picture
            return cell
        }
        else{
            let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as! UICollectionViewCell
            
            cell.contentView.addSubview(collectionView)
            return cell
        }
        }
    }


class CustomProductsCell: UICollectionViewCell {
    var nameLabel:  UILabel = UILabel(frame: CGRect.zero)
    var data: CustomData? {
        didSet {
            guard let data = data else { return }
            bg.image = data.backgroundImage
            
        }
    }

    
    var titleLabel:UILabel = {
        let label = UILabel(frame: CGRect(x:50, y: 160, width: UIScreen.main.bounds.width , height: 40))
        label.textAlignment = .left
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    fileprivate let bg: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 160, width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/6.6))
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 28
        
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(bg)
        contentView.addSubview(self.titleLabel)
        
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomCell: UICollectionViewCell {
    var nameLabel:  UILabel = UILabel(frame: CGRect.zero)
    var data: CustomData? {
        didSet {
            guard let data = data else { return }
            bg.image = data.backgroundImage
            
        }
    }
    let overlay: UIView = {
        let overImg = UIView(frame: CGRect(x: 0, y: 160, width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/6.6))
        overImg.backgroundColor = .black
        overImg.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 28)
        overImg.alpha = 0.5
        return overImg
    }()
    
    var titleLabel:UILabel = {
        let label = UILabel(frame: CGRect(x:50, y: 160, width: UIScreen.main.bounds.width , height: 40))
        label.textAlignment = .left
        label.textColor = .white
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
      
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 28
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    
        contentView.addSubview(bg)
        contentView.addSubview(self.overlay)
        contentView.addSubview(self.titleLabel)
        
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
