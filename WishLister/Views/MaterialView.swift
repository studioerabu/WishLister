//
//  MaterialView.swift
//  WishLister
//
//  Created by Brandon Ha
//  Copyright © 2019 Brandon Ha. All rights reserved.
//

import UIKit

private var materialKey = false

// Anything that inherits UIView will have this implementation as well.
extension UIView {
    @IBInspectable var materialDesign: Bool {
        get {
            return materialKey
        }
        set {
            materialKey = newValue
            if materialKey {
                self.layer.masksToBounds = false
                self.layer.cornerRadius = 3.0
                self.layer.shadowOpacity = 0.8
                self.layer.shadowRadius = 3.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                self.layer.shadowColor = UIColor(
                    red: 157/255,
                    green: 157/255,
                    blue: 157/255,
                    alpha: 157/255).cgColor
            } else {
                self.layer.cornerRadius = 0
                self.layer.shadowOpacity = 0
                self.layer.shadowRadius = 0
                self.layer.shadowColor = nil
            }
        }
    }
}
