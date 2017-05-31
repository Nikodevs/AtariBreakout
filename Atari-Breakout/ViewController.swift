//
//  ViewController.swift
//  Atari-Breakout
//
//  Created by period2 on 5/3/17.
//  Copyright © 2017 period2. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var everyBlock : [AddedViews] = []
    var everyBlockDeleted : [AddedViews] = []
    var allCollectiveViews : [AddedViews] = []
    var paddle : AddedViews!
    var ball : AddedViews!
    var dynamicAnimator = UIDynamicAnimator()
    var ballBehavior = UIDynamicItemBehavior()
    var collisionBehavior = UICollisionBehavior()
    var paddleBehavior = UIDynamicItemBehavior()
    var blockBehavior = UIDynamicItemBehavior()
    var blockCount = 0
    
    
    @IBAction func dragToMove(_ sender: UIPanGestureRecognizer)
    {
        paddle.center = CGPoint(x: sender.location(in: self.view).x, y: paddle.center.y)
        dynamicAnimator.updateItem(usingCurrentState: paddle)
    }
    
    
    
    @IBOutlet weak var startBreakoutGameOutlet: UIButton!
    @IBAction func gameStartBreakout(_ sender: UIButton)
    {
        ballBehavior.resistance = 0.0
        dynamicAnimator.updateItem(usingCurrentState: ball)
        ball.isHidden = false
        let pushBehavior = UIPushBehavior(items: [ball], mode: UIPushBehaviorMode.instantaneous)
        pushBehavior.magnitude = 0.2
        pushBehavior.angle = 1.1
        pushBehavior.active = true
        dynamicAnimator.addBehavior(pushBehavior)
        
        sender.isHidden = true
    }
    
    
    
        override func viewDidLoad()
        {
            super.viewDidLoad()
            dynamicAnimator = UIDynamicAnimator(referenceView: view)
            
            paddle = AddedViews(frame: CGRect(x: 330, y: 640, width: 130, height: 10))
            paddle.backgroundColor = UIColor.white
            view.addSubview(paddle)
            allCollectiveViews.append(paddle)
            
            ball = AddedViews(frame: CGRect(x: 150, y: 250, width: 15, height: 15))
            ball.backgroundColor = UIColor.white
            view.addSubview(ball)
            allCollectiveViews.append(ball)
            ball.isHidden = true
            gameBehavior() //Puts properties from below into these objects
            
            var x = 5 as CGFloat
            var y = 10 as CGFloat
            
            for i in 1...3
            {
                for e in 1...6
                {
                    let blockView = AddedViews(frame: CGRect(x: x, y: y, width: 60, height: 40))
                    blockView.backgroundColor = UIColor.white
                    view.addSubview(blockView)
                
                    everyBlock.append(blockView)
                    allCollectiveViews.append(blockView)
                    blockCount += 1
                
                    x += 65
                }
                x = 0
                y += 60
            }
        }
    

    
    func gameBehavior()
    {
    ballBehavior = UIDynamicItemBehavior(items: [ball])
    ballBehavior.friction = 0.0
    ballBehavior.resistance = 0.0
    ballBehavior.elasticity = 1.0
    ballBehavior.allowsRotation = false
    dynamicAnimator.addBehavior(ballBehavior)
    
    paddleBehavior = UIDynamicItemBehavior(items: [paddle])
    paddleBehavior.density = 99999.9
    paddleBehavior.elasticity = 1.0
    paddleBehavior.resistance = 99999.9
    paddleBehavior.allowsRotation = false
    dynamicAnimator.addBehavior(paddleBehavior)
    
    blockBehavior = UIDynamicItemBehavior(items: everyBlock)
    blockBehavior.density = 99999.9
    blockBehavior.elasticity = 1.0
    blockBehavior.allowsRotation = false
    dynamicAnimator.addBehavior(blockBehavior)
        
    collisionBehavior = UICollisionBehavior(items: allCollectiveViews)
    collisionBehavior.collisionMode = UICollisionBehaviorMode.everything
    collisionBehavior.translatesReferenceBoundsIntoBoundary = true
    collisionBehavior.collisionDelegate = self
    dynamicAnimator.addBehavior(collisionBehavior)
    }
    
    func ballReset()
    {
        ballBehavior.resistance = 100.0
        ball.center = CGPoint(x: 150, y: 250)
        ball.isHidden = true
        startBreakoutGameOutlet.isHidden = false
        dynamicAnimator.updateItem(usingCurrentState: ball)
    }

    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint)
    {
        if p.y > paddle.center.y && item.isEqual(ball)
        {
            ballReset()
            
            for block in everyBlockDeleted
            {
                block.isHidden = false
                collisionBehavior.addItem(block)
                dynamicAnimator.updateItem(usingCurrentState: block)
                block.blockHits = 0
                block.backgroundColor = UIColor.white
            }
            
            for aBlock in everyBlock
            {
                aBlock.blockHits = 0
                aBlock.backgroundColor = UIColor.white
            }
            
            everyBlockDeleted.removeAll(keepingCapacity: false)
        }

    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem)
    {
        for block in everyBlock
        {
            if item1.isEqual(ball) && item2.isEqual(everyBlock) || item1.isEqual(everyBlock) && item2.isEqual(ball)
            {
                if block.blockHits == 0
                {
                    block.blockHits = 1
                    block.backgroundColor = UIColor.purple
                }
                else
                {
                    block.isHidden = true
                    collisionBehavior.removeItem(block)
                    dynamicAnimator.updateItem(usingCurrentState: block)
                    everyBlockDeleted.append(block)
                }
                
            }
        }
