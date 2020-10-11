//
//  SearchResult.swift
//  Grow4U
//
//  Created by Sainath Reddy K on 2/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import UIKit

class SearchResultController: UITableViewCell {

    var product_info: String?
    var searchVC: SearchViewController?
    var productVC: ProductInfoViewController?
    var indexPath: IndexPath?
    var data: (name: String, price: String, information: String, img_url: String, farmers: [(name: String, rating: String, contact: String, offered_price: String)])?
    
    // MARK:- Properties
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.productVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductInfoViewController") as? ProductInfoViewController
        productVC!.setSearchVC(searchVC: self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    public func getData() -> (name: String, price: String, information: String, img_url: String, farmers: [(name: String, rating: String, contact: String, offered_price: String)]) {
        return data!
    }
    
    public func setSearchVC(searchVC: SearchViewController, indexPath: IndexPath){
        self.searchVC = searchVC
        self.indexPath = indexPath
    }
    
    // MARK:- Actions
    @IBAction func showProductDetails(_ sender: UIButton) {
        self.searchVC!.showProductInfo(productVC: productVC!)
    }
    
}

extension UIImageView {
    
    //// Returns activity indicator view centrally aligned inside the UIImageView
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        self.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        self.addConstraints([centerX, centerY])
        return activityIndicator
    }
    
    /// Asynchronous downloading and setting the image from the provided urlString
    func setImageFrom(_ urlString: String, completion: (() -> Void)? = nil) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let activityIndicator = self.activityIndicator
        
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }
        
        let downloadImageTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let imageData = data {
                    DispatchQueue.main.async {[weak self] in
                        var image = UIImage(data: imageData)
                        self?.image = nil
                        self?.image = image
                        image = nil
                        completion?()
                    }
                }
            }
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
            session.finishTasksAndInvalidate()
        }
        downloadImageTask.resume()
    }
}
