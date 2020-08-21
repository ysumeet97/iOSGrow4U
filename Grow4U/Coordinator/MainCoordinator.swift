//
//  MainCoordinator.swift
//  Grow4U
//
//  Created by Sumeet Yedula on 21/8/20.
//  Copyright © 2020 Grow4U. All rights reserved.
//

import Foundation
import UIKit

protocol MainCoordinator {
    var parentViewController: UIViewController { get }
    func start()
}
