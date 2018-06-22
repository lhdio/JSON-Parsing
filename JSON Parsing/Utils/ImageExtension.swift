//
//  ImageDescriptor.swift
//  JSON Parsing
//
//  Created by BS-195 on 6/22/18.
//  Copyright © 2018 rajubd49. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageFromUrlString(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
    
    func showUnavailableImage() {
        self.image = UIImage(named: "unavailable")
    }
}
