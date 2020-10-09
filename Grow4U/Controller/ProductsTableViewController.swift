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
    let navBar = UINavigationBar(frame: CGRect(x:0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    
    override func viewDidLoad() {
        
        if (ProductsTableViewController.products_model.getVegetableData().count < 1){
            print("here")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
        
        let products_data = ProductsTableViewController.products_model.getAllVegetableData()
        let fruits_data = ProductsTableViewController.products_model.getAllFruitsData()
        let farms_data = ProductsTableViewController.farms_model.getAllFarmsData()
            print("fruit count", ProductsTableViewController.products_model.getFruitsCount())
        self.setFarmsData(id:farms_data.id, images_Url: farms_data.images_Url, name: farms_data.farms_name, farm_ratings: farms_data.farms_ratings)
        self.setProductsData(vegetable_ID:products_data.id,fruits_ID:fruits_data.id,images_Url: products_data.image_url, name: products_data.name, type_price: products_data.price, fruits_images_Url: fruits_data.image_url, fruits_name: fruits_data.name, fruits_type_price : fruits_data.price)
        self.view.backgroundColor = .white

    
        self.setupTableView()
            }
            
        }
        else{
            let products_data = ProductsTableViewController.products_model.getAllVegetableData()
            let fruits_data = ProductsTableViewController.products_model.getAllFruitsData()
            let farms_data = ProductsTableViewController.farms_model.getAllFarmsData()
            
            self.setFarmsData(id:farms_data.id, images_Url: farms_data.images_Url, name: farms_data.farms_name, farm_ratings: farms_data.farms_ratings)
            self.setProductsData(vegetable_ID:products_data.id,fruits_ID:fruits_data.id,images_Url: products_data.image_url, name: products_data.name, type_price: products_data.price, fruits_images_Url: fruits_data.image_url, fruits_name: fruits_data.name, fruits_type_price : fruits_data.price)
            self.view.backgroundColor = .white
            
            
            self.setupTableView()
        }
    
    }
    
    private func setFarmsData(id:[String],images_Url: [String], name: [String], farm_ratings: [String]) {
        self.FarmsID = id
        self.farmsImagesUrl = images_Url
        self.farms_name = name
        self.farms_ratings = farm_ratings
    }
    
    private func setProductsData(vegetable_ID:[String],fruits_ID:[String],images_Url: [String], name: [String], type_price: [String],fruits_images_Url: [String], fruits_name: [String], fruits_type_price : [String]) {
        self.vegetablesID = vegetable_ID
        self.fruitsID = fruits_ID
        self.fruitsImagesUrl = fruits_images_Url
        self.fruitsType = fruits_name // here type means the fruit name
        self.fruits_type_price = fruits_type_price
        self.imagesUrl = images_Url
        self.type = name // here type means the vegetable name
        self.type_price = type_price

    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 44.0).isActive = true
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
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                imageViewToSet.image = image
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
            return UIScreen.main.bounds.width/2
        }
        return UIScreen.main.bounds.width/3
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
        return 30
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
    
}
extension ProductsTableViewController:CustomFarmCollectionCellDelegate {
    func collectionView(collectioncell: CustomFarmCollectionViewCell?, didTappedInTableview TableCell: CustomFarmTableViewCell) {
                let id = collectioncell?.farmID
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let detailController = storyBoard.instantiateViewController(withIdentifier:"DetailViewController") as? DetailViewController
                print(id!)
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
        self.navigationController?.pushViewController(detailController!, animated: true)
        }
    }
