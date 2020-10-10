//
//  MasterSplitTableViewController.swift
//  Grow4U
//
//  Created by vaishali wahi on 6/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import UIKit

class MasterSplitTableViewController: UITableViewController,UISplitViewControllerDelegate  {
    let allList = values
    override func viewDidLoad() {
   
             super.viewDidLoad()
        
       
 
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("i am in number of sections")
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("dont jugde me")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let list = values[indexPath.row]
        cell.textLabel?.text = list.name
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowDetailIdentifier") {
            
            var detail: ProductsLandscapeViewController
            
            if let navigationController = segue.destination as? UINavigationController {
                
                detail = navigationController.topViewController as! ProductsLandscapeViewController
                
            } else {
                
                detail = segue.destination as! ProductsLandscapeViewController
                
            }
            
            
            
            let indexPath = tableView.indexPathForSelectedRow
            let indexName = allList[indexPath!.row].name
            if indexName == "Farms"{
                detail.file_name = "farms"
                
            }
            else if indexName == "Vegetables"{
                detail .file_name = "products"
            }
            else{
                detail.file_name = "productsfruit"
            }
            
        }
    }

    
    
}
