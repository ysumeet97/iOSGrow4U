import UIKit



class ProductsLandscapeViewController: UIViewController{
    var pdata: [ProductDataModel.Data]?
    
   // @IBOutlet var search: UISearchBar!
    //@IBOutlet weak var navigation: UINavigationBar!
    
    
    fileprivate let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJsonFile()
      
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self as? UICollectionViewDelegate
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: view.frame.width/1.3).isActive = true
    }
    func loadJsonFile() {
        
        guard let path = Bundle.main.path(forResource: "ProductsData", ofType: "json") else { return }
        
        let url = URL(fileURLWithPath: path)
        do {
            
            let data = try Data(contentsOf: url)
            //print("here is the data",data)
            
            
            let products = try
                JSONDecoder().decode(ProductDataModel.self, from: data)
            
            print(products)
            self.pdata = products.locations
            
            
            
            //self.location = locations.locations
            
        } catch  {
            print(error)
            
        }
    }
    
    
}
extension ProductsLandscapeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        //cell.backgroundColor = .red
        //cell.data = self.data[indexPath.item]
        return cell
    }
}
