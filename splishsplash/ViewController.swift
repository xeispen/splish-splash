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
        
        
        self.view.addGestureRecognizer(touchDownGesture)
        

    }


    @objc func touchPressed(gesture: UITapGestureRecognizer) {
        // Only trigger on touch down
        if gesture.state == .began {
            let point = gesture.location(in: self.view)
            let radius = CGFloat(Int.random(in: 60 ..< 150))
            let circle = Circle(frame: CGRect(x: point.x, y: point.y, width: radius, height: radius))
            view.addSubview(circle)
            circle.animate()
        }
    }

}

