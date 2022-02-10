//
//  CoreUserDefaults.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 10/2/22.
//

import Foundation

/// This class, using the singleton pattern,
/// saves in UserDefaults if a user
/// is new, to present onboarding if
/// he is not.
final class CoreUserDefaults {

    static let shared = CoreUserDefaults()
    
    private init() { }

    /// This functions returns a boolean,
    /// which states user is new.
    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }

    /// This function sets "isNewUser" to true.
    func isNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }

}
