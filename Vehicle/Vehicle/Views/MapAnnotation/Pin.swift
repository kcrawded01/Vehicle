//
//  Pin.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import UIKit
import MapKit

class Pin: MKAnnotationView {
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame.size = CGSize(width: 15, height: 44)
        image = UIImage(named: "car")
        canShowCallout = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
