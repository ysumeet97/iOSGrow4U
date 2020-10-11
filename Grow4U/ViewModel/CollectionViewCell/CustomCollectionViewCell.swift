
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    
    var cellImageName:String?
    var ID: String?
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    class var CustomCell : CustomCollectionViewCell {
        let cell = Bundle.main.loadNibNamed("CustomCollectionViewCell", owner: self, options: nil)?.last
        return cell as! CustomCollectionViewCell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.red
        
        
    }
    // update the cell
    
    func updateCellWithImage(image_name:String, image_price:String, id:String, imageOf: String) {
        self.cellImageName = image_name
        self.ID = id
        let PictureURL = URL(string: image_name)!
        let PictureData = NSData(contentsOf: PictureURL as URL) // nil
        let Picture = UIImage(data: PictureData! as Data)
        self.cellImageView.image = Picture
        self.cellImageView.contentMode = .scaleToFill
       
        let price = "$"+image_price+" /kg"
        var pos = 0
        for p in price{
            
            if(p == "/"){
               break
            }
            pos = pos + 1
        }
        
        label.text = imageOf
        label.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.02)
        label2.font = UIFont(name: "HelveticaNeue-Bold", size: UIScreen.main.bounds.height * 0.015)
        label2.setAttributedTextWithSubscripts(text: price, indicesOfSubscripts: [pos,pos+1,pos+2])
    
        }
        
    }

    extension UILabel {
        /// Sets the attributedText property of UILabel with an attributed string
        /// that displays the characters of the text at the given indices in subscript.
        func setAttributedTextWithSubscripts(text: String, indicesOfSubscripts: [Int]) {
            let font = self.font!
            let subscriptFont = font.withSize(font.pointSize * 0.7)
            let subscriptOffset = -font.pointSize * 0.3
            let attributedString = NSMutableAttributedString(string: text,
                                                             attributes: [.font : font])
            for index in indicesOfSubscripts {
                let range = NSRange(location: index, length: 1)
                attributedString.setAttributes([.font: subscriptFont,
                                                .baselineOffset: subscriptOffset],
                                               range: range)
            }
            self.attributedText = attributedString
        }
    }
    

