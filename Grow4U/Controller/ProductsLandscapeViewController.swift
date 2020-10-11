import UIKit

struct CustomData {
    var title: String
    var url: String
    var backgroundImage: UIImage
}

class ProductsLandscapeViewController: UIViewController{
    private var imagesUrl = [String]()
    private var fruitsImagesUrl = [String]()
    private var fruitsType = [String]()
    private var fruits_tye_price = [String]()
    private var type = [String]()
    private var type_price = [String]()
    private var farmsImagesUrl = [String]()
    private var farms_name = [String]()
    private var farms_ratings = [String]()
    
    private var id = [String]()
    private var farms_file_name: String?
    private var num : Int?
    
    var farmsData: [FarmsModel.Data]?
    var productsData: [ProductDataModel.Data]?
    var file_name = "ProductsData"
    
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomSplitCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if file_name == "farms" {
            
            let farms_data = ProductsTableViewController.farms_model.getAllFarmsData()
            num = ProductsTableViewController.farms_model.getFarmsCount()
            self.setFarmsData(id:farms_data.id,images_Url: farms_data.images_Url, name: farms_data.farms_name, farm_ratings: farms_data.farms_ratings)
        }
        else if file_name == "products"
        {
            let products_data = ProductsTableViewController.products_model.getAllVegetableData()
            num = ProductsTableViewController.products_model.getVegetableCount()
            self.setProductsData(id:products_data.id,images_Url: products_data.image_url, type: products_data.type, type_price: products_data.price)
        }
        else{
            file_name = "products"
            let products_data = ProductsTableViewController.products_model.getAllFruitsData()
            num = ProductsTableViewController.products_model.getFruitsCount()
            self.setProductsData(id:products_data.id,images_Url: products_data.image_url, type: products_data.type, type_price: products_data.price)
        }
        view.backgroundColor = .white
        
        //old
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }
    
    private func setFarmsData(id:[String],images_Url: [String], name: [String], farm_ratings: [String]) {
        self.id = id
        self.farmsImagesUrl = images_Url
        self.farms_name = name
        self.farms_ratings = farm_ratings
    }
    private func setProductsData(id:[String],images_Url: [String], type: [String], type_price: [String]) {
        self.id = id
        self.imagesUrl = images_Url
        self.type = type
        self.type_price = type_price
    }
    
    
}
extension ProductsLandscapeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height/3)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if file_name == "farms"{
            let id = self.id[indexPath.item]
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detailController = storyBoard.instantiateViewController(withIdentifier:"FarmDetailViewController") as? FarmDetailViewController
            detailController!.id = id
            self.navigationController?.pushViewController(detailController!, animated: true)
        }
        else{
            let id = self.id[indexPath.item]
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detailController = storyBoard.instantiateViewController(withIdentifier:"DetailViewController") as? DetailViewController
            detailController!.id = id
            self.navigationController?.pushViewController(detailController!, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return num!    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if file_name == "farms"
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomSplitCell
            cell.ID = id[indexPath.item]
            cell.titleLabel.text =  farms_name[indexPath.item]
            let PictureURL = URL(string: farmsImagesUrl[indexPath.item])!
            let PictureData = NSData(contentsOf: PictureURL as URL) // nil
            let Picture = UIImage(data: PictureData! as Data)
            cell.bg.image = Picture
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomSplitCell
            cell.ID = id[indexPath.item]
            cell.titleLabel.text =  type[indexPath.item]
            let PictureURL = URL(string: imagesUrl[indexPath.item])!
            let PictureData = NSData(contentsOf: PictureURL as URL) 
            let Picture = UIImage(data: PictureData! as Data)
            cell.bg.image = Picture
            return cell
        }
        
    }
}

class CustomSplitCell: UICollectionViewCell {
    var nameLabel:  UILabel = UILabel(frame: CGRect.zero)
    var ID:String?
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
