//
//  ViewController.swift
//  d06
//
//  Created by Maksym SALIUTA on 2/12/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
    
//    var squareViews = [UIDynamicItem]()
//    var animator = UIDynamicAnimator()
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//
//        squareView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        squareView.backgroundColor = UIColor.green
//        squareView.center = view.center
//        view.addSubview(squareView)
//        animator = UIDynamicAnimator(referenceView: view)
//        let gravity = UIGravityBehavior(items: [squareView])
//        animator.addBehavior(gravity)
//    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        let numberOfView = 2
//        squareViews.reserveCapacity(numberOfView)
//        let colors = [UIColor.red, UIColor.green]
//        var currentCenterPoint: CGPoint = view.center
//        let eachViewSize = CGSize(width: 50, height: 50)
//
//        for counter in 0..<numberOfView{
//            let newView = UIView(frame: CGRect(x: 0, y: 0, width: eachViewSize.width, height: eachViewSize.height))
//            newView.backgroundColor = colors[counter]
//            newView.center = currentCenterPoint
//            currentCenterPoint.y += eachViewSize.height + 10
//            view.addSubview(newView)
//            squareViews.append(newView)
//        }
//
//        animator = UIDynamicAnimator(referenceView: view)
//
//        let gravity = UIGravityBehavior(items: squareViews)
//        animator.addBehavior(gravity)
//
//        let collision = UICollisionBehavior(items: squareViews)
//        collision.translatesReferenceBoundsIntoBoundary = true
//
//        animator.addBehavior(collision)
//    }
    
    var motionManager = CMMotionManager()
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var boundaries: UICollisionBehavior!
    var bounce: UIDynamicItemBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        
        // Gravity
        animator = UIDynamicAnimator(referenceView: self.view)
        self.gravity = UIGravityBehavior(items: [])
        self.gravity.gravityDirection = CGVector(dx: 0.0, dy: 1.0)
        animator.addBehavior(self.gravity)
        
        // Collision
        self.boundaries = UICollisionBehavior(items: [])
        self.boundaries.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(self.boundaries)
        
        // Elasticity
        self.bounce = UIDynamicItemBehavior(items: [])
        self.bounce.elasticity = 0.5
        animator.addBehavior(self.bounce)
        
        // Accelerometer
        if (motionManager.isAccelerometerAvailable) {
            motionManager.accelerometerUpdateInterval = 0.3
            motionManager.startAccelerometerUpdates(to: OperationQueue.main, withHandler: updateVector)
        }
    }

    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        let new = Items(frame: CGRect(x: Int(sender.location(in: self.view).x - 50), y: Int(sender.location(in: self.view).y - 50), width: 100, height: 100))
        self.view.addSubview(new)
        
        // Add behaviors
        self.gravity.addItem(new)
        self.boundaries.addItem(new)
        self.bounce.addItem(new)
        
        // Add user interaction
        new.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panAction)))
        new.addGestureRecognizer(UIPinchGestureRecognizer(target: self, action: #selector(pinchAction)))
        new.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(rotationAction)))
    }
    
    // User interaction process
    @objc func panAction(panGesture: UIPanGestureRecognizer) {
        let shape = panGesture.view as! Items
        
        switch panGesture.state {
        case .began:
            self.gravity.removeItem(shape)
        case .changed:
            shape.center = panGesture.location(in: self.view)
            self.animator.updateItem(usingCurrentState: shape)
        case .ended:
            self.gravity.addItem(shape)
        default:
            break
        }
    }
    
    @objc func pinchAction(pinGesture: UIPinchGestureRecognizer) {
        let shape = pinGesture.view as! Items
        
        switch pinGesture.state {
        case .began:
            self.gravity.removeItem(shape)
        case .changed:
            self.bounce.removeItem(shape)
            self.boundaries.removeItem(shape)
            shape.bounds.size.width = shape.oldBounds.width * pinGesture.scale
            shape.bounds.size.height = shape.oldBounds.height * pinGesture.scale
            self.bounce.addItem(shape)
            self.boundaries.addItem(shape)
            self.animator.updateItem(usingCurrentState: shape)
        case .ended:
            self.gravity.addItem(shape)
        default:
            break
        }
    }
    
    @objc func rotationAction(rotationGesture: UIRotationGestureRecognizer) {
        let shape = rotationGesture.view as! Items
        
        switch rotationGesture.state {
        case .began:
            self.gravity.removeItem(shape)
        case .changed:
            self.bounce.removeItem(shape)
            self.boundaries.removeItem(shape)
            shape.transform = shape.transform.rotated(by: rotationGesture.rotation)
            rotationGesture.rotation = 0
            self.bounce.addItem(shape)
            self.boundaries.addItem(shape)
            self.animator.updateItem(usingCurrentState: shape)
        case .ended:
            self.gravity.addItem(shape)
        default:
            break
        }
    }
    
    func updateVector(data: CMAccelerometerData?, error: Error?) -> Void {
        if let d = data {
            self.gravity.gravityDirection = CGVector(dx: d.acceleration.x, dy: d.acceleration.y)
        }
    }
}

