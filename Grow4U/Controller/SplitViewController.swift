//
//  SplitViewController.swift
//  Grow4U
//
//  Created by vaishali wahi on 31/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController ,  UISplitViewControllerDelegate{
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        preferredDisplayMode = .allVisible
    }

    
}
