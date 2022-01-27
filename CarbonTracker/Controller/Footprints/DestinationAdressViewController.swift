//
//  DestinationAdressViewController.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 23/1/22.
//

import UIKit
import CoreLocation

// MARK: - Class
class DestinationAdressViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet var adressTextFields: [UITextField]!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nextButton: UIButton!

    // MARK: - Properties

}

// MARK: - Functions overrides
extension DestinationAdressViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        toggleActivityIndicator(shown: false)
    }
    
}

// MARK: - @IBActions
extension DestinationAdressViewController {
    
    @IBAction func unwindToDestinationAdressVC(segue: UIStoryboardSegue) {}
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        proceedToNextVC()
    }
}

// MARK: - Functions
extension DestinationAdressViewController {
    
    private func setDelegates() {
        for textField in adressTextFields {
            if textField.tag == 1 {
                textField.becomeFirstResponder()
            }
            textField.delegate = self
        }
    }
    
    /// This function gathers all textfields information
    /// before performing segue to Destination Adress VC.
    private func proceedToNextVC() {
        guard noTextFieldIsEmpty() == true else {
            presentAlert(with: "An information is missing. \nCheck fields before proceeding.")
            return
        }
        guard let streetNbr = adressTextFields[0].text, let streetType = adressTextFields[1].text, let streetName = adressTextFields[2].text, let postCode = adressTextFields[3].text, let country = adressTextFields[4].text else {
            presentAlert(with: "Unable to decode this adress.")
        return
        }
        toggleActivityIndicator(shown: true)
        var concatenatedAdress = String()
        concatenatedAdress = "\(streetNbr), \(streetType.capitalized) \(streetName.capitalized), \(postCode), \(country.capitalized)"
        getCoordinatesFrom(concatenatedAdress) { placemark in
            self.toggleActivityIndicator(shown: false)
            guard case .success(let location) = placemark else {
                self.presentAlert(with: "Unable to find coordinates for this location.")
                return
            }
            #warning("to be completed after interface update. city missing")
            let locationToSend = Location(streetNumber: streetNbr, streetType: streetType.capitalized, streetName: streetName.capitalized, cityName: "Saint-Maur des fossés", postCode: postCode, country: country.capitalized, placemark: location)
            LocationDatas.sharedLocations.destinationPlacemark = locationToSend
            self.performSegue(withIdentifier: "segueToConfirmVC", sender: nil)
        }
    }
    
    /// This function returns a boolean value.
    /// It checks if any of the textfields is empty.
    private func noTextFieldIsEmpty() -> Bool {
        for textField in adressTextFields {
            if textField.text == "" {
                return false
            }
        }
        return true
    }
    
    /// This function displays an alert to user.
    /// - Parameter message : A string value, which
    /// is the message displayed in case of an Alert.
    private func presentAlert(with message: String) {
        let alertViewController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertViewController, animated: true, completion: nil)
    }
    
#warning("maybe this function should be embedded into a model class")
/// This function get coordinates from a given
/// string location entered by user in textfields.
///  - Parameter string: a string value, eg an adress.
///  - Parameter completion: a closure
///  returning a result type, including a placemark struct if success.
func getCoordinatesFrom(_ string: String, completion: @escaping (Result<Placemark, NetworkErrors>) -> Void) {
    let geocoder = CLGeocoder()
    geocoder.geocodeAddressString(string) { placemarks, error in
        DispatchQueue.main.async {
            guard error == nil else {
                completion(.failure(.unableToFindLocation))
                return
            }
            if let placemark = placemarks?.first {
                let name = placemark.name ?? ""
                let lat = placemark.location?.coordinate.latitude ?? 0.0
                let lon = placemark.location?.coordinate.longitude ?? 0.0
                let city = Placemark(name: name, lat: lat, lon: lon)
                completion(.success(city))
            } else {
                completion(.failure(.unableToFindLocation))
            }
        }
    }
}
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        nextButton.isHidden = shown
    }
    
}

// MARK: - TextField delegate conformance
extension DestinationAdressViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

