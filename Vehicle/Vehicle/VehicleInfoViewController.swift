//
//  VehicleInfoViewController.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import UIKit
import MapKit

class VehicleInfoViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    private var _screenTitle: String?
    var imageLoader: ImageLoader = ImageLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.register(Pin.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        map.delegate = self
        
        let vehicles: [Vehicle] = [
            Vehicle.init(dic: Dictionary<String, String>.init(), tag: true),
            Vehicle.init(dic: Dictionary<String, String>.init(), tag: false)]
        
        map.setRegion(region(vehicles.first!.coordinate), animated: true)
        map.addAnnotations(vehicles)
        
        userLabel.text = _screenTitle
    }
    
    public var screenTitle: String? {
        get
        {
            return self._screenTitle
        }
        set {
            self._screenTitle = newValue
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func region(_ coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate,
                           latitudinalMeters: Defines.distance,
                           longitudinalMeters: Defines.distance)
    }
    
    //MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as! Vehicle
            imageLoader.loadImage(annotation.pic as NSString) { image in
                view.leftCalloutAccessoryView = PinProfileImage(image: image)
            }
        annotation.coordinate.findAddress { address in
            view.detailCalloutAccessoryView = PinInfo(text: address)
        }
        
        view.rightCalloutAccessoryView = ColorCircle(color: annotation.color)
    }
}
