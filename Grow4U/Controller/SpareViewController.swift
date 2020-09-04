//
//  SpareViewController.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 2/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import UIKit

class SpareViewController: UIViewController {
    
    private var productInfoViewModel: ProductInfoViewModel = ProductInfoViewModel(file_name: "product_info")
    
    // MARK: Properties
    @IBOutlet weak var carrot: UIButton!
    @IBOutlet weak var tomato: UIButton!
    @IBOutlet weak var watermelon: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let proinfoVC = segue.destination as! ProductInfoViewController
        if segue.identifier == "carrotSegue" {
            proinfoVC.setProductID(productInfoViewModel: productInfoViewModel, product_id: "P002")
        }
        if segue.identifier == "tomatoSegue" {
            proinfoVC.setProductID(productInfoViewModel: productInfoViewModel, product_id: "P001")
        }
        if segue.identifier == "appleSegue" {
            proinfoVC.setProductID(productInfoViewModel: productInfoViewModel, product_id: "P003")
        }
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        layoutCells()
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "ProductInfoViewController") as! ProductInfoViewController
//        let proid = ["P001", "P002", "P003"]
//        controller.setProductID(productInfoViewModel: productInfoViewModel, product_id: proid[indexPath.item])
//        self.navigationController?.pushViewController(controller, animated: true)
//
//    }
//
//    func layoutCells() {
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
//        layout.minimumInteritemSpacing = 5.0
//        layout.minimumLineSpacing = 5.0
//        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 40)/3, height: ((UIScreen.main.bounds.size.width - 40)/3))
//        collectionView!.collectionViewLayout = layout
//    }
//
//     func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 3
//    }

}
