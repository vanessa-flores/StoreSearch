//
//  LandscapeViewController.swift
//  StoreSearch
//
//  Created by Vanessa Flores on 9/17/20.
//  Copyright © 2020 Rising Dev Habits. All rights reserved.
//

import UIKit

class LandscapeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.removeConstraints(view.constraints)
        view.translatesAutoresizingMaskIntoConstraints = true
        
        pageControl.removeConstraints(pageControl.constraints)
        pageControl.translatesAutoresizingMaskIntoConstraints = true
        
        scrollView.removeConstraints(scrollView.constraints)
        scrollView.translatesAutoresizingMaskIntoConstraints = true
    }
    
}
