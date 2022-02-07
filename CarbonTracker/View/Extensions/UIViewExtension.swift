//
//  UIViewExtension.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 7/2/22.
//

import UIKit

extension UIView {
    
    /// This function creates a rotation animation.
    func rotate() {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 0.35
        rotation.isCumulative = true
        rotation.repeatCount = 0.5
        layer.add(rotation, forKey: "rotationAnimation")
    }
}
