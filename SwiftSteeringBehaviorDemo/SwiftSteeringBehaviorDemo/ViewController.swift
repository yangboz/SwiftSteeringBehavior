//
//  ViewController.swift
//  SwiftSteeringBehaviorDemo
//
//  Created by yangboz on 14-8-7.
//  Copyright (c) 2014年 GODPAPER. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let square = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100));
        square.backgroundColor = UIColor.gray;
        view.addSubview(square);
        //
        var animator:UIDynamicAnimator!;
        var gravity:UIGravityBehavior!;
        //
        animator = UIDynamicAnimator(referenceView: view);
        gravity = UIGravityBehavior(items: [square]);
        animator.addBehavior(gravity);
        //
        let barrier = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20));
        barrier.backgroundColor = UIColor.red;
        view.addSubview(barrier);
        //Handle collision
        var collision:UICollisionBehavior!;
        collision = UICollisionBehavior(items: [square,barrier]);
        collision.translatesReferenceBoundsIntoBoundary = true;
        animator.addBehavior(collision);
        //
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

