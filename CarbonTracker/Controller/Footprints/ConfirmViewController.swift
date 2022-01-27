//
//  ConfirmViewController.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 23/1/22.
//

import UIKit
import MapKit

// MARK: - Class
class ConfirmViewController: UIViewController {
    
    // MARK: - Properties
    var locations = LocationDatas.sharedLocations
    var zeroPassengersOrSeats: Bool {
        return steppersLabels[0].text != "0" && steppersLabels[1].text != "1"
    }
    
    // MARK: - @IBOutlets
    @IBOutlet weak var darkGreenView: UIView!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var mapKitView: MKMapView!
    @IBOutlet weak var estimatedDistanceLabel: UILabel!
    @IBOutlet var steppersLabels: [UILabel]!
    @IBOutlet weak var startingAdressLabel: UILabel!
    @IBOutlet weak var destinationAdressLabel: UILabel!
    @IBOutlet var steppers: [UIStepper]!
    @IBOutlet weak var lowerStackView: UIStackView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var calculateButton: UIButton!
        
}

// MARK: - Functions overrides
extension ConfirmViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRoundCornersToViews()
        setLabels()
        setStepperImages()
        mapKitView.delegate = self
        toggleActivityIndicator(shown: true)
        createMapPath()
    }
}

// MARK: - @IBActions
extension ConfirmViewController {
    
    @IBAction func editStartingAdressButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToStartingAdressVC", sender: nil)
    }
    
    @IBAction func editDestinationAdressButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToDestinationAdressVC", sender: nil)
    }
    
    @IBAction func personsStepperValueChanged(_ sender: UIStepper) {
        steppersLabels[0].text = Int(sender.value).description
    }
    
    @IBAction func seatsStepperValueChanged(_ sender: UIStepper) {
        steppersLabels[1].text = Int(sender.value).description
    }
    
    @IBAction func didTapCalculateFootprintBtn(_ sender: Any) {
        proceedToNextVC()
    }
}

// MARK: - Functions

extension ConfirmViewController {
    
    /// This function makes rounded corners
    /// to views.
    private func makeRoundCornersToViews() {
        startView.layer.cornerRadius = 10
        startView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        darkGreenView.layer.cornerRadius = 10
        mapKitView.layer.cornerRadius = 10
        mapKitView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        lowerStackView.layer.cornerRadius = 10
        lowerStackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    /// This function sets labels's texts.
    private func setLabels() {
        guard let start = locations.startingPlacemark, let destination = locations.destinationPlacemark else {
            startingAdressLabel.text = "--"
            destinationAdressLabel.text = "--"
            return }
        startingAdressLabel.text = "\(start.streetNumber), \(start.streetType) \(start.streetName), \(start.postCode), \(start.cityName), \(start.country)"
        destinationAdressLabel.text = "\(destination.streetNumber), \(destination.streetType) \(destination.streetName), \(destination.postCode), \(destination.cityName), \(destination.country)"
        estimatedDistanceLabel.text = "-- km"
    }
    
    /// This function sets increment/decrement
    /// images for both steppers.
    private func setStepperImages() {
        for stepper in steppers {
            stepper.setDecrementImage(stepper.decrementImage(for: .normal), for: .normal)
            stepper.setIncrementImage(stepper.incrementImage(for: .normal), for: .normal)
        }
    }
    
    /// This function creates a path on map,
    /// based on starting and destination
    /// locations.
    private func createMapPath() {
        guard let start = locations.startingPlacemark, let destination = locations.destinationPlacemark else {
            presentAlert(with: "Unable to load path.")
            return }
        let placemarksArray = createPlacemarks(from: start, to: destination)
        let mapItemsArray = createMapItems(from: placemarksArray)
        let annotations = createMapAnnotations(from: start, to: destination, with: placemarksArray)
        
        mapKitView.showAnnotations(annotations, animated: true)
        
        let direction = createMKDirectionRequest(from: mapItemsArray)
        direction.calculate { response, error in
            guard let response = response else {
                if let error = error {
                    self.presentAlert(with: error.localizedDescription)
                }
                return
            }
            self.toggleActivityIndicator(shown: false)
            let route = response.routes[0]
            self.updateDistanceLabel(from: route.distance)
            self.mapKitView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
            self.setMapRegion(from: route)
        }
    }
    
    /// This function returns an array of MKPlacemark.
    /// - Parameter start : an instance of Location struct containing coordinates.
    /// - Parameter destination : an instance of Location struct containing coordinates.
    private func createPlacemarks(from start: Location, to destination: Location) -> [MKPlacemark] {
        let startingCoords = CLLocationCoordinate2D(latitude: start.placemark.lat, longitude: start.placemark.lon)
        let startingPlacemark = MKPlacemark(coordinate: startingCoords, addressDictionary: nil)
        let destinationCoords = CLLocationCoordinate2D(latitude: destination.placemark.lat, longitude: destination.placemark.lon)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoords, addressDictionary: nil)
        return [startingPlacemark, destinationPlacemark]
    }
    
    /// This function returns an array of MKMapItem, used to set MKDirection's request.
    /// - Parameter placemarks: an array of MKPlacemark used to
    /// create MKMapItem instances.
    private func createMapItems(from placemarks: [MKPlacemark]) -> [MKMapItem] {
        let startingMapItem = MKMapItem(placemark: placemarks[0])
        let destinationMapItem = MKMapItem(placemark: placemarks[1])
        return [startingMapItem, destinationMapItem]
    }
    
    /// This function returns an array of MKPointAnnotation, used to place annotations on map.
    /// - Parameter start : an instance of Location struct containing coordinates.
    /// - Parameter destination : an instance of Location struct containing coordinates.
    /// - Parameter placemarksArray: an array of MKPlacemark used to
    /// retrieve geo locations.
    private func createMapAnnotations(from start: Location, to destination: Location, with placemarksArray: [MKPlacemark]) -> [MKPointAnnotation] {
        let startingAnnotation = MKPointAnnotation()
        startingAnnotation.title = start.placemark.name
        if let location = placemarksArray[0].location {
            startingAnnotation.coordinate = location.coordinate
        }
        
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = destination.placemark.name
        if let location = placemarksArray[1].location {
            destinationAnnotation.coordinate = location.coordinate
        }
        return [startingAnnotation, destinationAnnotation]
    }
    
    /// This function returns a MKDirections instance.
    /// It is used to calculte direction between map items.
    private func createMKDirectionRequest(from mapItemsArray: [MKMapItem] ) -> MKDirections {
        let pathRequest = MKDirections.Request()
        pathRequest.source = mapItemsArray[0]
        pathRequest.destination = mapItemsArray[1]
        pathRequest.transportType = .automobile
        
        let direction = MKDirections(request: pathRequest)
        return direction
    }
    
    /// This function sets map's region based on
    /// calculated route.
    private func setMapRegion(from route: MKRoute) {
        let rect = route.polyline.boundingMapRect
        
        let point = MKMapPoint(x: rect.minX - 50000, y: rect.minY - 50000)
        let size = rect.size
        let correctedHeight = size.height + 100000
        let correctedWidth = size.width + 100000
        let finalSize = MKMapSize(width: correctedWidth, height: correctedHeight)
        let finalRect = MKMapRect(origin: point, size: finalSize)
        
        var region = MKCoordinateRegion(finalRect)
        region.span.latitudeDelta *= 1.5
        region.span.longitudeDelta *= 1.5
        
        mapKitView.setRegion(region, animated: true)
    }
    
    /// This function updates distance label
    /// after converting and formatting given distance to a string
    /// with max fraction digits of 1.
    private func updateDistanceLabel(from route: CLLocationDistance) {
        let distanceInMeters = Measurement(value: route, unit: UnitLength.meters)
        let distanceInKm = distanceInMeters.converted(to: UnitLength.kilometers)
        let value = distanceInKm.value
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false
        formatter.maximumFractionDigits = 1
        let doubleAsString =  formatter.string(from: NSNumber(value: value))!
        estimatedDistanceLabel.text = "\(doubleAsString) km"
    }
    
    /// This function displays an alert to user.
    /// - Parameter message : A string value, which
    /// is the message displayed in case of an Alert.
    private func presentAlert(with message: String) {
        let alertViewController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        calculateButton.isHidden = shown
    }
    
    private func proceedToNextVC() {
        
    }
}

extension ConfirmViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5
        renderer.strokeColor = .magenta
        return renderer
    }
}