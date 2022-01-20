//
//  PinInfo.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import UIKit

class PinInfo: UILabel {
    init(text: String) {
        super.init(frame: CGRect.zero)
        textColor = .gray
        font = UIFont(name: "Avenir-Light", size: 12)
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
