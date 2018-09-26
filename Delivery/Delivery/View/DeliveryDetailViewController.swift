//
//  DeliveryDetailViewController.swift
//  Delivery
//
//  Created by Gaurav Rastogi on 9/26/18.
//  Copyright © 2018 Gaurav Rastogi. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailViewController: UIViewController {
    
    @IBOutlet weak var deliveryLocationMapView: MKMapView!
    @IBOutlet weak var deliveryItemImageView: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    
    var viewModel:DeliveryDetailViewModel = DeliveryDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViewModel()
        customSetup()
        self.viewModel.didLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func didTapLeftNavigation(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Private Methods
    private func customSetup(){
        deliveryLocationMapView.mapType = .hybrid
        deliveryLocationMapView.showsCompass = true
        deliveryLocationMapView.showsScale = true
        
        self.title = viewModel.title()
    }
    
    private func setupViewModel(){
        viewModel.reload = { [unowned self] in
            self.deliveryItemImageView.sd_setImage(with: URL(string: self.viewModel.deliveryImageUrl()), placeholderImage: UIImage(named: "deliveryIcon"))
            self.descriptionLbl.text = self.viewModel.deliveryDescriptionStrig()
            self.locationLbl.text = self.viewModel.deliveryAddressString()
            
            /// Setting Reggion onto MapView
            let adjustedRegion = self.deliveryLocationMapView.regionThatFits(MKCoordinateRegionMakeWithDistance(self.viewModel.deliveryLocationCoordinates(), 500, 500))
            self.deliveryLocationMapView.setRegion(adjustedRegion, animated: true)
            
            /// Instantiating PointAnnotation and additing it to the MapView
            let annotation = MKPointAnnotation()
            annotation.coordinate = self.viewModel.deliveryLocationCoordinates()
            self.deliveryLocationMapView.addAnnotation(annotation)
        }
    }
}

extension DeliveryDetailViewController : MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
}
