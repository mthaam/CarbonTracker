//
//  CarTableViewCell.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 20/1/22.
//

import UIKit

// MARK: - Class
class CarTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var coreDataManager = CarModelObjectManager.sharedCarModelObjectManager
    var carModel: CarModels!
    
    // MARK: - Outlets
    @IBOutlet weak var coloredView: UIView!
    @IBOutlet weak var carMakeLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var carImage: UIImageView!
    
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Functions
    
    /// This function makes round corners
    /// to cell
    private func setupCell() {
        coloredView.layer.cornerRadius = 10
    }
    
    func updateDisplay(with car: CarModels) {
        carMakeLabel.text = car.attributes.vehicle_make
        carModelLabel.text = "\(car.attributes.name)" + " (\(car.attributes.year))"
        updateImage()
    }
    
    private func updateImage() {
        let isCurrentCar = coreDataManager.isCarFavourite(with: carModel)
        if isCurrentCar {
            carImage.image = UIImage(imageLiteralResourceName: "carFromSide-2t-green")
        } else {
            carImage.image = UIImage(imageLiteralResourceName: "carFromSide")
        }
        
    }
}
