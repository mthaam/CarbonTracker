//
//  MyCarViewController.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 14/1/22.
//

import UIKit

// MARK: - CLASS
class MyCarViewController: UIViewController {
    
    // MARK: - PROPERTIES AND OUTLETS
    
    var mycar: CarAttributes!
    var coreDataManager = CarModelObjectManager.sharedCarModelObjectManager
    
    @IBOutlet weak var noCarLabel: UILabel!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var carMakeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    // MARK: - @IBActions
    
    @IBAction func unwindToMyCarVC(segue: UIStoryboardSegue) {}
    
}

// MARK: - FUNCTIONS OVERRIDES

extension MyCarViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeRoundCornersToBlueView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavouriteCar()
    }
}

// MARK: - FUNCTIONS

extension MyCarViewController {
    
    /// This function makes round corners to blue view.
    private func makeRoundCornersToBlueView() {
        blueView.layer.cornerRadius = 10
    }
    
    /// This function retrieves current used car
    /// if one exists.
    private func fetchFavouriteCar() {
        let favCar = coreDataManager.fetchFavouriteCar()
        if favCar != nil {
            updateLabels(from: favCar)
        } else {
            updateDisplay(shown: false)
        }
    }
    
    private func updateLabels(from car: CarModels?) {
        guard let unwrappedCar = car else { return }
        carMakeLabel.text = unwrappedCar.attributes.vehicle_make
        modelLabel.text = unwrappedCar.attributes.name
        yearLabel.text = "(\(unwrappedCar.attributes.year))"
        updateDisplay(shown: true)
    }
    
    private func updateDisplay(shown: Bool) {
        blueView.isHidden = !shown
        noCarLabel.isHidden = shown
    }
    
    
}

