//
//  VehicleInfoViewController.swift
//  Vehicle
//
//  Created by Elvira Scablinska on 19/01/2022.
//

import UIKit
import MapKit

class VehicleInfoViewController: UIViewController, MKMapViewDelegate, FetchDelegate {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    private var _owner: Owner!
    var imageLoader: ImageLoader = ImageLoader()
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.register(Pin.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        map.delegate = self
        map.showsUserLocation = true
        
        userLabel.text = owner.fullName()
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        abortUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        runUpdate()
    }
    
    var owner: Owner {
        get
        {
            return _owner
        }
        set {
            self._owner = newValue
        }
    }
    
    func runUpdate() {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self,
            selector: #selector(VehicleInfoViewController.fetchData), userInfo: nil, repeats: true)
    }
    
    @objc func fetchData() {
        let tracker = LocationTracker.shared
        tracker.delegate = self
        tracker.fetchData(userId: _owner.userId)
    }
    
    func abortUpdate() {
        timer?.invalidate()
    }
    
    @IBAction func closePressed(_ sender: Any) {
        abortUpdate()
        dismiss(animated: true, completion: nil)
    }
    
    func region(_ coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate,
                           latitudinalMeters: Defines.distance,
                           longitudinalMeters: Defines.distance)
    }
    
    //MARK: FetchDelegate
    func fetchFailed() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "Unable to fetch vehicle location", preferredStyle:UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getVehicles() -> [Vehicle] {
        let vehicles = Database.shared.findUserVehicles(userId: owner.userId)
        vehicles.updateLocation()
        return vehicles
    }
    
    func updateSucceeded() {
        DispatchQueue.main.async {
            let vehicles = self.getVehicles()

            if(self.map.annotations.count > 0){
                self.map.removeAnnotations(self.map.annotations)
            }
            self.map.setRegion(self.region(vehicles.first!.coordinate), animated: true)
            self.map.addAnnotations(vehicles)
        }
    }
    
    //MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as! Vehicle
        imageLoader.loadImage(annotation.foto! as NSString as String) { image in
                view.leftCalloutAccessoryView = PinProfileImage(image: image)
            }
        annotation.coordinate.findAddress { address in
            view.detailCalloutAccessoryView = PinInfo(text: address)
        }
        
        if(annotation.color != nil || !annotation.color!.isEmpty){
            view.rightCalloutAccessoryView = ColorCircle(color: annotation.color!)
        }
        
//        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: annotation.coordinate))
//        calculateRout(mapItem)
    }
    
    //opens phone map and shows rout
    func calculateRout(_ mapItem: MKMapItem) {
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
}
