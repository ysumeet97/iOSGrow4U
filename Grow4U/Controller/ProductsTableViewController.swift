import UIKit




class ProductsTableViewController: UIViewController {
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
    var categories = [ImageCategory]()
    var pdata: [ProductDataModel.Data]?
    var farmsData: [FarmsModel.Data]?
    let tableView = UITableView()
    let headerReuseId = "TableHeaderViewReuseId"
    let navBar = UINavigationBar(frame: CGRect(x:UIScreen.main.bounds.width - UIScreen.main.bounds.width , y: 0, width: UIScreen.main.bounds.width, height: 44))
    
    override func loadView() {
        super.loadView()
        
        file_name = "products"
        farms_file_name = "farms"
        let products_model = ProductsViewModel(file_name: file_name!)
        let products_data = products_model.getAllVegetableData()
        let fruits_data = products_model.getAllFruitsData()
        let farms_model = FarmsViewModel(file_name: farms_file_name!)
        let farms_data = farms_model.getAllFarmsData()
        self.setFarmsData(images_Url: farms_data.images_Url, name: farms_data.farms_name, farm_ratings: farms_data.farms_ratings)
        self.setProductsData(images_Url: products_data.image_url, type: products_data.type, type_price: products_data.price, fruits_images_Url: fruits_data.image_url, fruits_type: fruits_data.type, fruits_type_price : fruits_data.price)
        view.backgroundColor = .white
        setupTableView()

    }
    
    private func setFarmsData(images_Url: [String], name: [String], farm_ratings: [String]) {
        self.farmsImagesUrl = images_Url
        self.farms_name = name
        self.farms_ratings = farm_ratings
    }
    
    private func setProductsData(images_Url: [String], type: [String], type_price: [String],fruits_images_Url: [String], fruits_type: [String], fruits_type_price : [String]) {
        self.fruitsImagesUrl = fruits_images_Url
        self.fruitsType = fruits_type
        self.fruits_type_price = fruits_type_price
        self.imagesUrl = images_Url
        self.type = type
        self.type_price = type_price
        let navItem = UINavigationItem(title: "Home")
        navBar.backgroundColor =  #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        navBar.setItems([navItem], animated: false)
    }
    
    func setupTableView() {
        self.view.addSubview(navBar)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 44.0).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tcell")
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
            data["prod_name"] = "Farms"
            data["prod_id"]   = "\(index)"
            data["prod_description"] = farms_name
            data["prod_items"] = farmsImagesUrl
        case 1:
            data["prod_name"] = "Vegetables"
            data["prod_id"]   = "\(index)"
            data["prod_description"] = type
            data["prod_items"] = imagesUrl
        case 2:
            data["prod_name"] = "Fruits"
            data["prod_id"]   = "\(index)"
            data["prod_description"] = fruitsType
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
        view?.headerLabel.text = aCategory.name
        return view
    }
    
}
extension ProductsTableViewController:CustomFarmCollectionCellDelegate {
    func collectionView(collectioncell: CustomFarmCollectionViewCell?, didTappedInTableview TableCell: CustomFarmTableViewCell) {
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let detailController = storyBoard.instantiateViewController(withIdentifier:"DetailViewController") as? DetailViewController
               // detailController?.category = selCategory
                //detailController?.imageName = imageName
                self.navigationController?.pushViewController(detailController!, animated: true)
        
        }
    }

extension ProductsTableViewController:CustomCollectionCellDelegate {
    func collectionView(collectioncell: CustomCollectionViewCell?, didTappedInTableview TableCell: CustomTableViewCell) {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detailController = storyBoard.instantiateViewController(withIdentifier:"DetailViewController") as? DetailViewController
            //self.setImage(from: collectioncell!.cellImageName!, imageViewToSet: detailController!.image)
        self.navigationController?.pushViewController(detailController!, animated: true)
        }
    }
