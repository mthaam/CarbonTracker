//
//  FootprintsViewController.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 15/1/22.
//

import UIKit

class FootprintsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func callCarMakes(_ sender: Any) {
//        CarMakeServiceAF.shared.fetchCars()
        CarMakeServiceAF.shared.fetchCarMakes { result in
            
        }
    }

}
