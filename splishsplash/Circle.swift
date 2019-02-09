//
//  Circle.swift
//  splishsplash
//
//  Created by Peisen Xue on 2/8/19.
//  Copyright © 2019 Peisen Xue. All rights reserved.
//

import UIKit

class Circle: UIView {

    var size:CGFloat?

    override init(frame: CGRect) {
        let centerX = frame.origin.x
        let centerY = frame.origin.y
        size = frame.size.height
        let newFrame = CGRect(x: centerX, y: centerY, width: 0, height: 0)

        
        super.init(frame: newFrame)
        // Drawing code
        self.backgroundColor = .random
        self.alpha = 0.8
        self.layer.cornerRadius = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func animate() {

        UIView.animateKeyframes(withDuration: 2.2, delay: 0, options: [], animations: {
            // Start Splish
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2/2.2, animations: {
                guard let newSize = self.size else {
                    return
                }
                
                let centerX = (self.frame.origin.x) - (newSize / 2)
                let centerY = (self.frame.origin.y) - (newSize / 2)
                
                let frame = CGRect(x: centerX, y: centerY, width: newSize, height: newSize)
                self.frame = frame
                self.layer.cornerRadius = CGFloat(newSize / 2)
            })
            // Fade out
            UIView.addKeyframe(withRelativeStartTime: 1.7/2.2, relativeDuration: 0.5/2.2, animations: {
                self.alpha = 0
            })
            
        }, completion: { _ in
            print("Done expanding circle")
        })

    }
    
    
    
    
}


extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
