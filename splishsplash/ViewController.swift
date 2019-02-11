//
//  ViewController.swift
//  splishsplash
//
//  Created by Peisen Xue on 2/8/19.
//  Copyright © 2019 Peisen Xue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        
        // Configure long press to trigger on touchdown
        let touchDownGesture = UILongPressGestureRecognizer(target: self, action: #selector(touchPressed))
        touchDownGesture.minimumPressDuration = 0
        
        // Add gesture recognizer to view
        self.view.addGestureRecognizer(touchDownGesture)
    }


    @objc func touchPressed(gesture: UITapGestureRecognizer) {
        // Only trigger on touch down
        if gesture.state == .began {
            
            // Get point where user tapped
            let point = gesture.location(in: self.view)

            // Set CGRect based on where user tapped
            let frame = CGRect(x: point.x, y: point.y, width: 0, height: 0)

            // Initialize a SplishSplash instance with frame
            let splishsplash = SplishSplash(frame: frame)

            // Add the subview
            view.addSubview(splishsplash)
            
            // Animate
            splishsplash.animate() {
                print("Clean up SplishSplash")
                splishsplash.removeFromSuperview()
            }

        }
    }

}

