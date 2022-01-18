//
//  SelectModelViewController.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 15/1/22.
//

import UIKit

class SelectModelViewController: UIViewController {
    
    var carModels: [CarModelDatas]!
    
    @IBOutlet weak var carModelsPickerView: UIPickerView!

}

// MARK: - FUNCTIONS OVERRIDES

extension SelectModelViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carModelsPickerView.delegate = self
        carModelsPickerView.dataSource = self
    }
    
}

extension SelectModelViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return carModels.count
    }

}

extension SelectModelViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let name = carModels[row].data.attributes.name
        let year = String(carModels[row].data.attributes.year)
        return name + " (\(year))"
    }
}
