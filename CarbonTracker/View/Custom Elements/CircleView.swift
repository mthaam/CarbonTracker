//
//  CircleView.swift
//  CarbonTracker
//
//  Created by JEAN SEBASTIEN BRUNET on 7/2/22.
//

import UIKit

@IBDesignable class CircleView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        if (frame.width != frame.height) {
            NSLog("Ended up with a non-square frame -- so it may not be a circle");
        }
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true
        self.backgroundColor = .carbonPurple
    }

}
