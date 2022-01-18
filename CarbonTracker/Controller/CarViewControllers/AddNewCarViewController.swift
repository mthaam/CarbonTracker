//
//  AddNewCarViewController.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 15/1/22.
//

import UIKit

// MARK: - CLASS
class AddNewCarViewController: UIViewController {

    var carMakesToPrepareForSegway: [CarMakesData]!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
}

// MARK: - FUNCTIONS OVERRIDES

extension AddNewCarViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleActivityIndicator(shown: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToVehicleMake" {
            let destinationVC = segue.destination as! SelectMakeViewController
            destinationVC.carMakes = carMakesToPrepareForSegway
        }
    }
}

// MARK: - @IBACTIONS

extension AddNewCarViewController {
    
    @IBAction func addNewCarButtonTapped(_ sender: Any) {
        fetchCarMakes()
    }
}

// MARK: - FUNCTIONS

extension AddNewCarViewController {
    
    private func fetchCarMakes() {
        toggleActivityIndicator(shown: true)
        CarMakeServiceAF.shared.fetchCarMakes { result in
            self.toggleActivityIndicator(shown: false)
            guard case .success(let datas) = result else {
                self.presentAlert(with: "Unable to fetch car makes.")
                return
            }
            self.carMakesToPrepareForSegway = datas
            self.performSegue(withIdentifier: "segueToVehicleMake", sender: nil)
        }
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
    }
}
