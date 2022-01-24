//
//  PinProfileImage.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import UIKit

class PinProfileImage: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        let imgWidthHeight = 44.0
        self.frame.size = CGSize(width: imgWidthHeight, height: imgWidthHeight)
        self.contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
