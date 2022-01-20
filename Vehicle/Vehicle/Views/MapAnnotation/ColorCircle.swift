//
//  ColorCircle.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import UIKit

class ColorCircle: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init (color: String) {
        let circleWidthHeight = 20
        self.init(frame: CGRect(x:0, y: 0, width: circleWidthHeight, height: circleWidthHeight))
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.borderWidth = 1.0
        self.backgroundColor = UIColor(hex: color)
        return
    }
}
