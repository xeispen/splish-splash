//
//  Circle.swift
//  splishsplash
//
//  Created by Peisen Xue on 2/8/19.
//  Copyright © 2019 Peisen Xue. All rights reserved.
//

import UIKit

class Circle: UIView {

    var size: CGFloat!

    override init(frame: CGRect) {
        
        let newFrame = CGRect(x: frame.origin.x, y: frame.origin.y, width: 0, height: 0)
        
        super.init(frame: newFrame)
        
        // 80% Opacity
        self.alpha = CGFloat(CircleParams.opacity.rawValue)
        
        // Starting corner radius for circle where r=0
        self.layer.cornerRadius = 0
        
        // Set the size variable to what was passed in
        // Will be used later to determine the end size
        self.size = frame.size.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func animate() {

        UIView.animateKeyframes(withDuration: 2.2, delay: 0, options: [], animations: {
            // Start Splish
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2/2.2, animations: {

                let centerX = self.frame.origin.x - (self.size / 2)
                let centerY = self.frame.origin.y - (self.size / 2)
                
                // End frame for animation
                let frame = CGRect(x: centerX, y: centerY, width: self.size, height: self.size)
                self.frame = frame
                
                // End corner radius
                self.layer.cornerRadius = CGFloat(self.size / 2)
            })
            // Fade out to full transparency
            UIView.addKeyframe(withRelativeStartTime: 1.7/2.2, relativeDuration: 0.5/2.2, animations: {
                self.alpha = 0
            })
            
        }, completion: { _ in
            print("Animation Completed")
        })

    }

}


class SplishSplash: UIView {

    var splish: Circle!
    var splashes: [Circle] = []
    
    override init(frame: CGRect) {
         super.init(frame: frame)

        // Assign a random radius between 60 and 150
        let radius = CGFloat(Float.random(in: CircleParams.minCircleRadius.rawValue...CircleParams.maxCircleRadius.rawValue))
        
        // Create a frame with randomly generated radius, passing in as diameter
        let splishFrame = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        
        // Initialize a Splish
        self.splish = Circle(frame: splishFrame)
        
        // Set background color of Splish
        self.splish.backgroundColor = UIColor.random
        
        // Populate the Splashes into an array
        self.populateSplash()
        
        // Add the Splish to the view
        self.addSubview(splish)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Function for converting a polar coordinate to a cartesian coordinate
    private func polarToCartesian(radius: Float, angle: Float) -> (Float, Float) {
        let x = radius * cos(angle)
        let y = radius * sin(angle)
        return (x, y)
    }
    
    func populateSplash() {
        // Randomly generate between 2 to 5 splashes and add them to the Splash array
        for _ in 1...Int.random(in: SplashCount.min.rawValue...SplashCount.max.rawValue) {
            // Convert Splish radius into a Float
            let splishDiameter = Float(splish.size)
            // Calculate the Splash radius to be 20% to 40% less than the Splish Radius
            let splashDiameter = splishDiameter - Float.random(in: SplashScale.min.rawValue...SplashScale.max.rawValue) * splishDiameter
            // Calculate the coordinates of Splash center to be to be 60 to 100 pixels away from center of Splish
            let (x, y) = polarToCartesian(radius: Float.random(in: SplashRadius.min.rawValue...SplashRadius.max.rawValue), angle: Float.random(in: 0...360))
            // Create a frame for the Splash with the newly calcualted coordinate and initialize a Splash
            let frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(splashDiameter), height: CGFloat(splashDiameter))
            let splash = Circle(frame: frame)
            // Set background color of the splash to the same as splish
            splash.backgroundColor = self.splish.backgroundColor
            self.addSubview(splash)
            // Add it to the array
            self.splashes.append(splash)
        }
    }
    
    
    func animate(completion: @escaping() -> Void) {
        // Start splish animation
        self.splish.animate()
        // Start splash animations for every splash in array with a .15 second delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
            for splash in self.splashes {
                splash.animate()
            }
        }
        // Call closure after 2.4 seconds when all animations end
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) {
            completion()
        }
    }
}



// Function to randomly generate a UIColor
extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}


