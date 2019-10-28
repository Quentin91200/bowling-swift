//
//  ViewController.swift
//  Bowling
//
//  Created by Quentin LUBACK on 21/10/2019.
//  Copyright © 2019 Quentin LUBACK. All rights reserved.
//
/*
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgImage:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
            
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        imgImage.addGestureRecognizer(leftSwipe)
        imgImage.addGestureRecognizer(rightSwipe)
    }
    
     @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
                
            if (sender.direction == .left) {
                    print("Swipe Left")
                let labelPosition = CGPoint(x: imgImage.frame.origin.x - 50.0, y: imgImage.frame.origin.y)
                imgImage.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: imgImage.frame.size.width, height: imgImage.frame.size.height)
            }
                
            if (sender.direction == .right) {
                print("Swipe Right")
                let labelPosition = CGPoint(x: self.imgImage.frame.origin.x + 50.0, y: self.imgImage.frame.origin.y)
                imgImage.frame = CGRect(x: labelPosition.x, y: labelPosition.y, width: self.imgImage.frame.size.width, height: self.imgImage.frame.size.height)
            }
        }
}
 */

import UIKit

class ViewController: UIViewController {
    
    var panGesture = UIPanGestureRecognizer()
    @IBOutlet weak var imgImage: UIImageView!
    let friction: CGFloat = 0.5;
    var done = false;

    override func viewDidLoad() {
        super.viewDidLoad()
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(_:)))
        imgImage.isUserInteractionEnabled = true
        imgImage.addGestureRecognizer(panGesture)
    }
    
//    overridefunc draw(_: CGRect) {
//        let rect = UIView(frame: rect)
//        rect.backgroundColor = .red
//        print(rect)
//    }
    
    func moveUp(img: UIImageView, velocity: CGPoint) {
        print("y : \(img.center.y)")
        img.isUserInteractionEnabled = false
        var vx = velocity.x // Velocity x px
        var vy = abs(velocity.y) // Velocity y px
        var x = img.center.x // Initial position x
        var y = img.center.y // Initial position y
        var coord: [[CGFloat]] = [];
        //var vx = velocity.x
        while(vy > 0.5) {
            x = x - vx
            y = y - vy
            coord.append([x, y])
            UIImageView.animate(withDuration: 1) {
                //img.center.y += velocity.y
                //print("\(vy)")
                img.center.x += vx
                img.center.y -= vy
                vx = vx * self.friction;
                vy = vy * self.friction;
                //print("\(vy)")
            }
        }
        print("vx : \(velocity.x)")
        print("vy : \(velocity.y)")
        print("\(coord)")
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        self.view.bringSubviewToFront(imgImage)
        
        let translation = sender.translation(in: self.view);
        let velocity = sender.velocity(in: self.view);
        // print("y : \(imgImage.center.y)")
        // print("coord : \(coord)")
        // print("v : \(velocity.x)")
        imgImage.center = CGPoint(x: imgImage.center.x + translation.x, y: imgImage.center.y + translation.y)
//        sender.setTranslation(CGPoint.zero, in: self.view)
        if(imgImage.center.y <= 717 && !self.done) {
            print(done)
            self.done = true;
            self.moveUp(img: self.imgImage, velocity: velocity)
            sender.isEnabled = false
//            UIImageView.animate(withDuration: 2) {
//                self.moveUp(img: self.imgImage, velocity: velocity)
//            }
        } else {
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
    }
}

