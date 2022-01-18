//
//  CarModelObjectManager.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 18/1/22.
//

import Foundation
import CoreData

/// This class is used to manage CRUD operations
/// in core data for CarModel objects.
/// - Note that the shared static let
/// is used for singleton pattern and uses
/// app's context.
/// - Note that an instance of this class can
/// be initialized with a different context for testing
/// purposes.
final class CarModelObjectManager {
    
    static let sharedCarModelObjectManager = CarModelObjectManager(context: AppDelegate.viewContext)
    
    let carbonTrackerContext: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.carbonTrackerContext =  context
    }
    
    /// This computed property fetches all CarModelObjects entities stored in
    /// core data.
    var all: [CarModelObject] {
        let request: NSFetchRequest<CarModelObject> = CarModelObject.fetchRequest()
        request.sortDescriptors = [
        NSSortDescriptor(key: "vehicle_make", ascending: true),
        NSSortDescriptor(key: "name", ascending: true)
        ]
        var carObjects: [CarModelObject] = []
        if let cars = try? carbonTrackerContext.fetch(request) {
            carObjects = cars
        }
        return carObjects
    }
    
    /// This function saves new CarModelObject in core data.
    /// - Parameter carModel : a CarModel object to save.
    /// - Parameter completion : a closure returning
    /// a boolean value.
    func saveCarModel(with carModel: CarModelDatas, completion: (Bool) -> Void) {
        let carObject = CarModelObject(context: carbonTrackerContext)
        carObject.id = carModel.data.id
        carObject.year = Int16(carModel.data.attributes.year)
        carObject.name = carModel.data.attributes.name
        carObject.vehicle_make = carModel.data.attributes.vehicle_make
        carObject.isCurrentCar = true
        try? carbonTrackerContext.save()
        completion(true)
    }
    
    /// This function deletes a car object stored in core data.
    /// - Parameter carModelToDelete : a CarModel object to delete.
    /// - Parameter completion : a closure returning
    /// a boolean value.
    func deleteCarModel(with carModelToDelete: CarModelDatas, completion: (Bool) -> Void) {
        let request: NSFetchRequest<CarModelObject> = CarModelObject.fetchRequest()
        request.predicate = NSPredicate.init(format: "id == %@", carModelToDelete.data.id)
        if let foundCarModels = try? carbonTrackerContext.fetch(request) {
            for car in foundCarModels {
                carbonTrackerContext.delete(car)
            }
        }
        completion(true)
    }
    
    /// This function updates a car object stored in core data.
    /// - Parameter carModel : a CarModel object to udpate.
    /// - Parameter completion : a closure returning
    /// a boolean value.
    func updateFavouriteCar(with carModel: CarModelDatas, completion: (Bool) -> Void) {
        let request: NSFetchRequest<CarModelObject> = CarModelObject.fetchRequest()
        if let cars = try? carbonTrackerContext.fetch(request) {
            for car in cars {
                if car.id == carModel.data.id {
                    car.isCurrentCar = true
                    try? carbonTrackerContext.save()
                } else {
                    car.isCurrentCar = false
                    try? carbonTrackerContext.save()
                }
            }
        }
        completion(true)
    }
    
}
