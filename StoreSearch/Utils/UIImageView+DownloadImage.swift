//
//  UIImageView+DownloadImage.swift
//  StoreSearch
//
//  Created by Vanessa Flores on 9/15/20.
//  Copyright © 2020 Rising Dev Habits. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        
        let downloadTask = session.downloadTask(with: url, completionHandler: { [weak self] url, response, error in
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    guard let self = self else {
                        return
                    }
                    
                    self.image = image
                }
            }
        })
        
        downloadTask.resume()
        
        return downloadTask
    }
}
