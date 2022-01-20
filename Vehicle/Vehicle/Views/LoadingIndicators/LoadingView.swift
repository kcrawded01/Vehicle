//
//  LoadingView.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import UIKit

class LoadingView: BaseView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit("LoadingView")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit("LoadingView")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        activityIndicator.startAnimating()
    }
}
