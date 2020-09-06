
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    
    var cellImageName:String?
    
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    class var CustomCell : CustomCollectionViewCell {
        let cell = Bundle.main.loadNibNamed("CustomCollectionViewCell", owner: self, options: nil)?.last
        return cell as! CustomCollectionViewCell
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
        self.cellImageView.image = Picture
        print(image_label)
        label.sizeToFit()
        label.text = image_label
    }
    
}
