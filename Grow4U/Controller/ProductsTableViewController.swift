//
//  MasterSplitTableViewController.swift
//  Grow4U
//
//  Created by vaishali wahi on 6/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//
import UIKit

class ProductsTableViewController: UIViewController {
    private var vegetablesID = [String]()
    private var fruitsID = [String]()
    private var FarmsID = [String]()
    private var imagesUrl = [String]()
    private var fruitsImagesUrl = [String]()
    private var type = [String]()
    private var fruitsType = [String]()
    private var type_price = [String]()
    private var fruits_type_price = [String]()
    private var farmsImagesUrl = [String]()
    private var farms_name = [String]()
    private var farms_ratings = [String]()
    private var file_name: String?
    private var farms_file_name: String?
    static let products_model = ProductsViewModel() // public because to be accesed by diff classes
    static let farms_model = FarmsViewModel()
    // public because to be accesed by diff classes
    var categories = [ImageCategory]()
    var pdata: [ProductDataModel.Data]?
    var farmsData: [FarmsModel.Data]?
    let tableView = UITableView()
    let headerReuseId = "TableHeaderViewReuseId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (ProductsTableViewController.farms_model.getFarmsData().count < 1 && ProductsTableViewController.products_model.getFruitData().count < 1){
        self.activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
        
        let products_data = ProductsTableViewController.products_model.getVegetableData()
            let fruits_data = ProductsTableViewController.products_model.getFruitData()
        let farms_data = ProductsTableViewController.farms_model.getFarmsData()
           
        self.setFarmsData(data:farms_data)
        self.setFruitData(data: fruits_data)
        self.setVegetableData(data: products_data)
        self.view.backgroundColor = .white

    
        self.setupTableView()
            
            }
            self.activityIndicator.stopAnimating()
            
        }
        else{
            
            let products_data = ProductsTableViewController.products_model.getVegetableData()
            let fruits_data = ProductsTableViewController.products_model.getFruitData()
            let farms_data = ProductsTableViewController.farms_model.getFarmsData()
            
            self.setFarmsData(data: farms_data)
            self.setFruitData(data: fruits_data)
            self.setVegetableData(data: products_data)
            self.view.backgroundColor = .white
            
            
            self.setupTableView()
        }
    
    }
    
    private func setFarmsData(data:[FarmsModel.Data]) {
        for farm in data{
            self.FarmsID.append(farm.id!)
            self.farmsImagesUrl.append(farm.img_url!)
            self.farms_name.append(farm.name!)
            self.farms_ratings.append(farm.rating!)
        }
    }
    private func setFruitData(data:[ProductDataModel.Data]){
        for fruit in data{
            self.fruitsID.append(fruit.id!)
            self.fruitsImagesUrl.append(fruit.img_url!)
            self.fruitsType.append(fruit.name!) // here type means the fruit name
            self.fruits_type_price.append(fruit.price!)
        }
        
    }
    private func setVegetableData(data:[ProductDataModel.Data]) {
        for veg in data{
          
            self.vegetablesID.append(veg.id!)
            
            self.imagesUrl.append(veg.img_url!)
            self.type.append(veg.name!)  // here type means the vegetable name
            self.type_price.append(veg.price!)
        }
        
       

    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10.0).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        let headerNib = UINib(nibName: "CustomHeaderView", bundle: nil)
        self.tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: headerReuseId)
        setupData()
        self.tableView.reloadData()
    }
    
    //MARK: Data initlisers methods
    func setupData() {
        for index in 0..<3 {
            var infoDict = [String:Any]()
            infoDict = dataForIndex(index: index)
            let aCategory = ImageCategory(withInfo: infoDict)
            categories.append(aCategory)
        }
    }
    
    func dataForIndex(index:Int) -> [String:Any] {
        var data = [String:Any]()
        switch index {
        case 0:
            
            data["prod_ID"] = FarmsID
            data["prod_type"] = "Farms"
            data["prod_name"] = farms_name
            data["prod_index"]   = "\(index)"
            data["prod_description"] = farms_ratings //here description is same as farms ratings
            data["prod_items"] = farmsImagesUrl
        case 1:
            data["prod_ID"] = vegetablesID
            data["prod_type"] = "Vegetables"
            data["prod_name"] = type //here type is the name of vegetable
            data["prod_index"]   = "\(index)"
            data["prod_description"] = type_price // here description is vegetable price
            data["prod_items"] = imagesUrl
        case 2:
            data["prod_ID"] = fruitsID
            data["prod_type"] = "Fruits"
            data["prod_name"] = fruitsType //here type is the name of fruits
            data["prod_index"]   = "\(index)"
            data["prod_description"] = fruits_type_price // here description is fruits price
            data["prod_items"] = fruitsImagesUrl
        default:
            print("not possible")
        }
        return data
    }
    
    func setImage(from url: String, imageViewToSet: UIImageView) {
        guard let imageURL = URL(string: url) else { return }
        let cache = URLCache.shared
        let request = URLRequest(url: imageURL)
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    UIView.transition(with: imageViewToSet, duration: 0.2,
                                      options: [.transitionCrossDissolve],
                                      animations: { imageViewToSet.image = image
                    },
                                      completion: nil)
                }
            }  else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            UIView.transition(with: imageViewToSet, duration: 0.2,
                                              options: [.transitionCrossDissolve],
                                              animations: { imageViewToSet.image = image
                            },
                                              completion: nil)
                        }
                    }
                }).resume()
            }
        }
    }
    
}
extension ProductsTableViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return  categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section == 0){
            return UIScreen.main.bounds.height/3
        }
        return UIScreen.main.bounds.height/4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "CustomFarmTableViewCell") as? CustomFarmTableViewCell
            
            if cell == nil {
                
                cell = CustomFarmTableViewCell.customCell
            }
            
            
            let aCategory = self.categories[indexPath.section]
            cell?.updateCellWith(category: aCategory)
            cell?.cellDelegate = self
            return cell!
        }
        else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as? CustomTableViewCell
            
            if cell == nil {
                cell = CustomTableViewCell.customCell
            }
            
            let aCategory = self.categories[indexPath.section]
            cell?.updateCellWith(category: aCategory)
            cell?.cellDelegate = self
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return UIScreen.main.bounds.height * 0.06
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        var view = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerReuseId) as? CustomHeaderView
        if view == nil {
            view = CustomHeaderView.customView
        }
        let aCategory = self.categories[section]
        view?.headerLabel.text = aCategory.type
        return view
    }
    
    fileprivate var activityIndicator: UIActivityIndicatorView {
        get {
            let activityIndicator = UIActivityIndicatorView(style: .gray)
            activityIndicator.hidesWhenStopped = true
            activityIndicator.center = CGPoint(x:UIScreen.main.bounds.width/2,
                                               y: UIScreen.main.bounds.height/2)
            activityIndicator.stopAnimating()
            self.view.addSubview(activityIndicator)
            return activityIndicator
        }
    }

    
}
extension ProductsTableViewController:CustomFarmCollectionCellDelegate {
    func collectionView(collectioncell: CustomFarmCollectionViewCell?, didTappedInTableview TableCell: CustomFarmTableViewCell) {
                let id = collectioncell?.farmID
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let detailController = storyBoard.instantiateViewController(withIdentifier:"FarmDetailViewController") as? FarmDetailViewController
                detailController!.id = id
                self.navigationController?.pushViewController(detailController!, animated: true)
        
        }
    }

extension ProductsTableViewController:CustomCollectionCellDelegate {
    func collectionView(collectioncell: CustomCollectionViewCell?, didTappedInTableview TableCell: CustomTableViewCell) {
            let id = collectioncell?.ID
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detailController = storyBoard.instantiateViewController(withIdentifier:"DetailViewController") as? DetailViewController
            print(id!)
            detailController!.id = id
            detailController!.categories = self.categories
        self.navigationController?.pushViewController(detailController!, animated: true)
        }
    }
