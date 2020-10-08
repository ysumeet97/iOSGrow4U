
import Foundation
import UIKit

protocol CustomCollectionCellDelegate:class {
    func collectionView(collectioncell:CustomCollectionViewCell?, didTappedInTableview TableCell:CustomTableViewCell)
    //other delegate methods that you can define to perform action in viewcontroller
}

class CustomTableViewCell:UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout  {
    weak var cellDelegate:CustomCollectionCellDelegate? //define delegate
    @IBOutlet weak var myCollectionView: UICollectionView!
    var aCategory:ImageCategory?
    let cellReuseId = "CollectionViewCell"
    class var customCell : CustomTableViewCell {
        let cell = Bundle.main.loadNibNamed("CustomTableViewCell", owner: self, options: nil)?.last
        return cell as! CustomTableViewCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //TODO: need to setup collection view flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.height/3)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        self.myCollectionView.collectionViewLayout = flowLayout
        
        //Comment if you set Datasource and delegate in .xib
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
        
        //register the xib for collection view cell
        let cellNib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        self.myCollectionView.register(cellNib, forCellWithReuseIdentifier: cellReuseId)
    }
    
    //MARK: Instance Methods
    func updateCellWith(category:ImageCategory) {
        self.aCategory = category
        self.myCollectionView.reloadData()
    }
    
    //MARK: Collection view datasource and Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell
        self.cellDelegate?.collectionView(collectioncell: cell, didTappedInTableview: self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let categoryItems = self.aCategory?.prodItems {
            return categoryItems.count
        } else {
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as? CustomCollectionViewCell
        //print(self.aCategory?.prodItems[0] as Any)
        let id = self.aCategory?.prod_ID[indexPath.item]
        let label = self.aCategory?.prodDescription[indexPath.item]
        if let categoryImageName = self.aCategory?.prodItems[indexPath.item] {
            cell?.updateCellWithImage(image_name: categoryImageName, image_label:label!, id: id! )
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}
