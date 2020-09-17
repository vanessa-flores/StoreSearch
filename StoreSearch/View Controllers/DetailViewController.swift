//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by Vanessa Flores on 9/16/20.
//  Copyright © 2020 Rising Dev Habits. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var popupView: UIView!
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var kindLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var priceButton: UIButton!
    
    // MARK: - Properties
    
    var searchResult: SearchResult!
    var downloadTask: URLSessionDownloadTask?
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.tintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)
        
        popupView.layer.cornerRadius = 10
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
        gestureRecognizer.cancelsTouchesInView = false
        gestureRecognizer.delegate = self
        view.addGestureRecognizer(gestureRecognizer)
        
        if searchResult != nil {
            updateUI()
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func openInStore() {
        if let url = URL(string: searchResult.storeURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    // MARK: - Helpers
    
    private func updateUI() {
        nameLabel.text = searchResult.name
        
        if searchResult.artist.isEmpty {
            artistNameLabel.text = "Unknown"
        } else {
            artistNameLabel.text = searchResult.artist
        }
        
        kindLabel.text = searchResult.type
        genreLabel.text = searchResult.genre
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = searchResult.currency
        
        let priceText: String
        if searchResult.price == 0 {
            priceText = "Free"
        } else if let text = formatter.string(from: searchResult.price as NSNumber) {
            priceText = text
        } else {
            priceText = ""
        }
        
        priceButton.setTitle(priceText, for: .normal)
        
        if let largeURL = URL(string: searchResult.imageLarge!) {
            downloadTask = artworkImageView.loadImage(url: largeURL)
        }
    }
    
    deinit {
        downloadTask?.cancel()
    }

}

// MARK: - UIViewControllerTransitioningDelegate

extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension DetailViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}
