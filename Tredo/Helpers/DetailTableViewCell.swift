//
//  DetailTableViewCell.swift
//  Tredo
//
//  Created by Alexander Lee on 26.12.2021.
//

import Foundation
import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var loaderIcon: UIActivityIndicatorView!
    
    var imageURL : URL? {
        didSet {
            iconImageView.image = nil
            updateUI()
        }
    }
    
    func updateUI() {
        if let url = imageURL {
            loaderIcon?.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {
                let contentsOfURL = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if url == self.imageURL {
                        if let imageData = contentsOfURL {
                            self.iconImageView.image = UIImage(data: imageData)
                        }
                    }
                    self.loaderIcon?.stopAnimating()
                }
            }
        }
    }
}
