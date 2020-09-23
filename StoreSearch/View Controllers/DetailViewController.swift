//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by Vanessa Flores on 9/16/20.
//  Copyright © 2020 Rising Dev Habits. All rights reserved.
//

import MessageUI
import UIKit

class DetailViewController: UIViewController {
    
    enum AnimationStyle {
        case slide
        case fade
    }
    
    // MARK: - Outlets
    
    @IBOutlet private weak var popupView: UIView!
    @IBOutlet private weak var artworkImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var kindLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var priceButton: UIButton!
    
    // MARK: - Properties
    
    var searchResult: SearchResult! {
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }
    var isPopUp: Bool = false
    private var downloadTask: URLSessionDownloadTask?
    private var dismissStyle: AnimationStyle = .fade
    
    // MARK: - Initialization
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isPopUp {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(close))
            gestureRecognizer.cancelsTouchesInView = false
            gestureRecognizer.delegate = self
            view.addGestureRecognizer(gestureRecognizer)
            
            view.backgroundColor = UIColor.clear
        } else {
            view.backgroundColor = UIColor(patternImage: UIImage(named: "LandscapeBackground")!)
            popupView.isHidden = true
            
            if let displayName = Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String {
                title = displayName
            }
        }

        view.tintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)
        popupView.layer.cornerRadius = 10
        
        if searchResult != nil {
            updateUI()
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func close() {
        dismissStyle = .slide
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
            artistNameLabel.text = NSLocalizedString("Unknown", comment: "Localized kind: Unknown")
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
            priceText = NSLocalizedString("Free", comment: "Localized kind: Free")
        } else if let text = formatter.string(from: searchResult.price as NSNumber) {
            priceText = text
        } else {
            priceText = ""
        }
        
        priceButton.setTitle(priceText, for: .normal)
        
        if let largeURL = URL(string: searchResult.imageLarge!) {
            downloadTask = artworkImageView.loadImage(url: largeURL)
        }
                
        if popupView.isHidden && !isPopUp {
            popupView.alpha = 0
            self.popupView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            popupView.isHidden = false
            
            UIView.animate(withDuration: 0.3, animations: {
                self.popupView.alpha = 1
                self.popupView.transform = CGAffineTransform.identity
            })
        } else {
            popupView.isHidden = false
        }
        
        
    }
    
    deinit {
        downloadTask?.cancel()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMenu" {
            let controller = segue.destination as! MenuViewController
            controller.delegate = self
        }
    }

}

// MARK: - UIViewControllerTransitioningDelegate

extension DetailViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BounceAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch dismissStyle {
        case .slide:
            return SlideOutAnimationController()
        case .fade:
            return FadeOutAnimationController()
        }
    }
}

// MARK: - UIGestureRecognizerDelegate

extension DetailViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}

// MARK: - MenuViewControllerDelegate

extension DetailViewController: MenuViewControllerDelegate {
    
    func menuViewControllerSendEmail(_ controller: MenuViewController) {
        dismiss(animated: true) {
            if MFMailComposeViewController.canSendMail() {
                let controller = MFMailComposeViewController()
                controller.mailComposeDelegate = self
                controller.setSubject(NSLocalizedString("Support Request", comment: "Email subject"))
                controller.setToRecipients(["your@email-adress-here.com"])
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - MFMailComposeViewControllerDelegate

extension DetailViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
