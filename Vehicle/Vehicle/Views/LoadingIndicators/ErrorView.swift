//
//  ErrorView.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import UIKit

class ErrorView: BaseView {

    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet var contentView: UIView!
    
    weak var delegate: ReloadDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit("ErrorView")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit("ErrorView")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        reloadButton.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @IBAction func reloadPressed(_ sender: Any) {
        delegate?.reloadData()
    }
}
