//
//  Color+Hex.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        let rgbValue = Int(hex.clear(), radix: 16) ?? 0
        self.init(red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: Double((rgbValue & 0xFF00) >> 8) / 255.0,
                  blue: Double(rgbValue & 0xFF) / 255.0,
                  alpha: 1.0)
        return
    }
}
