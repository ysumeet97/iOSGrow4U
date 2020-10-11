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
    var file_name = "farms"
    
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
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            if #available(iOS 11.0, *) {
                flowLayout.sectionInsetReference = .fromSafeArea
            }
        }
        if file_name == "farms" {
            
            let farms_data = ProductsTableViewController.farms_model.getFarmsData()
            num = ProductsTableViewController.farms_model.getFarmsCount()
            self.setFarmsData(data: farms_data)
        }
        else if file_name == "products"
        {
            let products_data = ProductsTableViewController.products_model.getVegetableData()
            num = ProductsTableViewController.products_model.getVegetableCount()
            self.setVegetableData(data: products_data)
        }
        else{
            file_name = "products"
            let products_data = ProductsTableViewController.products_model.getFruitData()
            num = ProductsTableViewController.products_model.getFruitsCount()
            
            self.setFruitData(data: products_data)
            
        }
        view.backgroundColor = .white
        
        //old
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
      
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        //collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
    }
    private func setFarmsData(data:[FarmsModel.Data]) {
        for farm in data{
            self.id.append(farm.id!)
            self.farmsImagesUrl.append(farm.img_url!)
            self.farms_name.append(farm.name!)
            self.farms_ratings.append(farm.rating!)
        }
    }
    private func setFruitData(data:[ProductDataModel.Data]){
        for fruit in data{
           
            self.id.append(fruit.id!)
            self.imagesUrl .append(fruit.img_url!)
            self.type.append(fruit.name!) // here type means the fruit name
            self.type_price.append(fruit.price!)
        }
        
    }
    private func setVegetableData(data:[ProductDataModel.Data]) {
        for veg in data{
            
            self.id.append(veg.id!)
            self.imagesUrl.append(veg.img_url!)
            self.type.append(veg.name!)  // here type means the vegetable name
            self.type_price.append(veg.price!)
        }
        
        
        
    }
    
    
    
}
extension ProductsLandscapeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3.5, height: collectionView.frame.height/3)
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
            let name = UILabel(frame: CGRect(x:0, y: cell.frame.height/3 + 25, width: cell.frame.width , height: 40))
            let name_ratings = UILabel(frame: CGRect(x:0, y: cell.frame.height/3 + 40, width: cell.frame.width , height: 40))
            name.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)
            name_ratings.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.015)
            cell.ID = id[indexPath.item]
            
            let text =  self.farms_name[indexPath.item].capitalized + "Farm"
            let ratings =  "Ratings: " + self.farms_ratings[indexPath.item] + "/5"
            name.text = text
          
            name_ratings.text = ratings
//            titleLabel.textColor = .black
//            titleLabel.text =  farms_name[indexPath.item]
          //  cell.addSubview(titleLabel)
            let PictureURL = URL(string: farmsImagesUrl[indexPath.item])!
            let PictureData = NSData(contentsOf: PictureURL as URL) // nil
            let Picture = UIImage(data: PictureData! as Data)
            cell.bg.image = Picture
            cell.bg.layer.cornerRadius = 30.0
            cell.addSubview(name)
            cell.addSubview(name_ratings)
            return cell
        }
        else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomSplitCell
            
            let name = UILabel(frame: CGRect(x:0, y: cell.frame.height/3 + 10, width: cell.frame.width , height: 40))
            let name_price = UILabel(frame: CGRect(x:0, y: cell.frame.height/3 + 25, width: cell.frame.width , height: 40))
            name.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)
            name_price.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.015)
            
            name.textColor = .black
            
            cell.ID = id[indexPath.item]
            view.backgroundColor = .white
            let text =  self.type[indexPath.item]
            let price = "$" + self.type_price[indexPath.item] + "/kg"
            var pos = 0
            for p in price{
                
                if(p == "/"){
                    break
                }
                pos = pos + 1
            }
            name.text = text
            name_price.setAttributedTextWithSubscripts(text: price, indicesOfSubscripts: [pos,pos+1,pos+2])
            let PictureURL = URL(string: imagesUrl[indexPath.item])!
            let PictureData = NSData(contentsOf: PictureURL as URL) // nil
            let Picture = UIImage(data: PictureData! as Data)
            cell.bg.image = Picture
            cell.bg.layer.cornerRadius = 30.0
            cell.addSubview(name)
            cell.addSubview(name_price)
            
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
    
    
    
   
    fileprivate let bg: UIImageView = {
        let iv = UIImageView(frame: CGRect(x:0, y: 0 , width: UIScreen.main.bounds.width/7 , height: UIScreen.main.bounds.height/5))
        iv.layer.cornerRadius = 28
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
      
        contentView.addSubview(bg)
    

        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


