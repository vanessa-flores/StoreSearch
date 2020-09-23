//
//  MenuViewController.swift
//  StoreSearch
//
//  Created by Vanessa Flores on 9/23/20.
//  Copyright © 2020 Rising Dev Habits. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class {
    func menuViewControllerSendEmail(_ controller: MenuViewController)
}

class MenuViewController: UITableViewController {
    
    // MARK: - Properties
    
    weak var delegate: MenuViewControllerDelegate?
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            delegate?.menuViewControllerSendEmail(self)
        }
    }

}
