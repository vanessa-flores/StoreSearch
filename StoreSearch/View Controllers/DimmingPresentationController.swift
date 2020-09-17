//
//  DimmingPresentationController.swift
//  StoreSearch
//
//  Created by Vanessa Flores on 9/16/20.
//  Copyright © 2020 Rising Dev Habits. All rights reserved.
//

import UIKit

class DimmingPresentationController: UIPresentationController {
    
    lazy var dimmingView = GradientView(frame: CGRect.zero)
    
    override func presentationTransitionWillBegin() {
        dimmingView.frame = containerView!.bounds
        containerView?.insertSubview(dimmingView, at: 0)
    }
    
    override var shouldRemovePresentersView: Bool {
        return false
    }
}
