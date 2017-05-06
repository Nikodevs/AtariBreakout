//
//  ViewController.swift
//  Atari-Breakout
//
//  Created by period2 on 5/3/17.
//  Copyright © 2017 period2. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var paddle : AddedViews!
    var ball : AddedViews!
    var dynamicAnimator = UIDynamicAnimator()
    var ballBehavior = UIDynamicItemBehavior()
    var collisionBehavior = UICollisionBehavior()
    
    
    @IBOutlet weak var startBreakoutGameOutlet: UIButton!
    @IBAction func gameStartBreakout(_ sender: UIButton)
    {
        
    }
    
    
        override func viewDidLoad()
        {
            super.viewDidLoad()
        }
    
}

