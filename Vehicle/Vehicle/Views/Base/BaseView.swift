//
//  BaseView.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import UIKit

class BaseView: UIView {
    func commonInit(_ nibName: String) {
        if let nib = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? UIView {
            self.translatesAutoresizingMaskIntoConstraints = false;
            nib.frame = self.bounds;
            nib.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nib)
        }
    }
}
