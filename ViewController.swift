//
//  ViewController.swift
//  Atari-Breakout
//
//  Created by period2 on 5/3/17.
//  Copyright © 2017 period2. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet weak var paddleView: UIView!
    @IBOutlet weak var ballView: UIView!
    @IBAction func startBreakoutButton(_ sender: UIButton)
    {
    }
   
    
    @IBAction func dragPaddle(_ sender: UIPanGestureRecognizer)
    {
    paddleView.center = CGPoint(x: sender.location(in: self.view).x, y: paddleView.center.y)
    dynamicAnimator.updateItem(usingCurrentState: paddleView)
    }
    
    var dynamicAnimator:UIDynamicAnimator!
    var pushBehavior:UIPushBehavior!
    var collisionBehavior:UICollisionBehavior!
    var ballDynamicBehavior:UIDynamicItemBehavior!
    var paddleDynamicBehavior:UIDynamicItemBehavior!
    //DONT FORGET "!" AT END OF VARIABLE
    
    override func viewDidAppear(_ animated: Bool)
    {
    self.ballView.layer.cornerRadius = 0.0
    dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
    //***//
    pushBehavior = UIPushBehavior(items: [ballView], mode: .instantaneous)
    pushBehavior.pushDirection = CGVector(dx: 0.5, dy: 1.0)
    pushBehavior.active = true
    pushBehavior.magnitude = 0.5
    dynamicAnimator.addBehavior(pushBehavior)
    //***//
    collisionBehavior = UICollisionBehavior(items: [ballView, paddleView])
    collisionBehavior.collisionMode = UICollisionBehaviorMode.everything
    collisionBehavior.translatesReferenceBoundsIntoBoundary = true
    dynamicAnimator.addBehavior(collisionBehavior)
    //***//
    ballDynamicBehavior = UIDynamicItemBehavior(items: [ballView])
    ballDynamicBehavior.allowsRotation = false
    ballDynamicBehavior.elasticity = 1.0
    ballDynamicBehavior.friction = 0.0
    ballDynamicBehavior.resistance = 0.0
    dynamicAnimator.addBehavior(ballDynamicBehavior)
    //***//
    //Start of paddle//
    paddleDynamicBehavior = UIDynamicItemBehavior(items: [paddleView])
    paddleDynamicBehavior.allowsRotation = false
    paddleDynamicBehavior.density = 99999.0
    paddleDynamicBehavior.friction = 99999.0
    paddleDynamicBehavior.resistance = 99999.0
    paddleDynamicBehavior.elasticity = 0.0
    dynamicAnimator.addBehavior(paddleDynamicBehavior)
    //***//
    collisionBehavior.collisionDelegate = self
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}

