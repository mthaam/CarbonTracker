//
//  StartingAdressViewController.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 23/1/22.
//

import UIKit
import CoreLocation
// MARK: - Class
class StartingAdressViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet var adressTextFields: [UITextField]!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var countryPickerView: UIPickerView!
    
    // MARK: - Properties

}

// MARK: - Functions overrides
extension StartingAdressViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        countryPickerView.selectRow(62, inComponent: 0, animated: true)
        toggleActivityIndicator(shown: false)
    }
}

// MARK: - @IBActions
extension StartingAdressViewController {
    
    @IBAction func unwindToStartingAdressVC(segue: UIStoryboardSegue) {}
    
    /// This function is called after sender was tapped.
    @IBAction func nextButtonTapped(_ sender: Any) {
        proceedToNextVC()
    }
    
    /// This function is called after sender was tapped.
    @IBAction func didTappedMainView(_ sender: Any) {
        for textField in adressTextFields {
            textField.resignFirstResponder()
        }
    }
}

// MARK: - Functions
extension StartingAdressViewController {
    
    /// This function sets self as textfields delagate.
    private func setDelegates() {
        for textField in adressTextFields {
            if textField.tag == 1 {
                textField.becomeFirstResponder()
            }
            textField.delegate = self
        }
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
    }
    
    /// This function gathers all textfields information
    /// before performing segue to Destination Adress VC.
    private func proceedToNextVC() {
        guard noTextFieldIsEmpty() == true else {
            presentAlert(with: "An information is missing. \nCheck fields before proceeding.")
            return
        }
        guard let streetNbr = adressTextFields[0].text, let streetType = adressTextFields[1].text, let streetName = adressTextFields[2].text, let postCode = adressTextFields[3].text, let city = adressTextFields[4].text else {
            presentAlert(with: "Unable to decode this adress.")
        return
        }
        let country = countryList[countryPickerView.selectedRow(inComponent: 0)]
        toggleActivityIndicator(shown: true)
        var concatenatedAdress = String()
        concatenatedAdress = "\(streetNbr), \(streetType.capitalized) \(streetName.capitalized), \(postCode), \(city.capitalized), "
        GeoCoderService.sharedGeoCoderHelper.getCoordinatesFrom(concatenatedAdress) { placemark in
            self.toggleActivityIndicator(shown: false)
            guard case .success(let location) = placemark else {
                self.presentAlert(with: "Unable to find coordinates for this location.")
                return
            }
            let locationToSend = Location(streetNumber: streetNbr, streetType: streetType.capitalized, streetName: streetName.capitalized, cityName: city.capitalized, postCode: postCode, country: country.capitalized, placemark: location)
            LocationDatas.sharedLocations.startingPlacemark = locationToSend
            self.performSegue(withIdentifier: "segueToDestinationAdressVC", sender: nil)
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
    
    /// This function toggles activity indicator and button
    /// - Parameter shown: a boolean used to
    /// apply to isHidden property.
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        nextButton.isHidden = shown
    }
    
}

// MARK: - TextField delegate conformance
extension StartingAdressViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.tag != 5 {
            for loopedTextfield in adressTextFields where loopedTextfield.tag == textField.tag + 1 {
                loopedTextfield.becomeFirstResponder()
            }
        }
        return true
    }
}

// MARK: - PickerView delegate conformance
extension StartingAdressViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  countryList.count
    }
}

// MARK: - PickerView data source conformance
extension StartingAdressViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryList[row]
    }
}




