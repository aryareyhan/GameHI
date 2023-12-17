//
//  UIView+Extensions.swift
//  GameHI1
//
//  Created by Dierta Pasific on 17/12/23.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
