//
//  MasterSplitTableViewController.swift
//  Grow4U
//
//  Created by vaishali wahi on 6/9/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import UIKit

class MasterSplitTableViewController: UITableViewController {
    let allList = values
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let list = values[indexPath.row]
        cell.textLabel?.text = list.name
        return cell
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show"{
            let ctrl = segue.destination as! ProductsLandscapeViewController
            let indexPath = tableView.indexPathForSelectedRow
            let indexName = allList[indexPath!.row].name
            if indexName == "Farms"{
                ctrl.file_name = "FarmsData"
                
            }
            else{
                ctrl .file_name = "ProductsData"
            }
            
            
        }
    }


}
