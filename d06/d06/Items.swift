//
//  Items.swift
//  d06
//
//  Created by Maksym SALIUTA on 2/12/20.
//  Copyright © 2020 Maksym SALIUTA. All rights reserved.
//

import UIKit

enum Shapes {
    case Circle
    case Square
    
    static let allShapes = [Circle, Square]
}

class Items: UIView  {
    let shape: Shapes
    let color: UIColor
    var path: UIBezierPath!
    var oldBounds: CGRect!
    
    override init(frame: CGRect) {
        self.shape = Shapes.allShapes[Int(arc4random_uniform(UInt32(Shapes.allShapes.count)))]
        self.color = UIColor.random
        super.init(frame: frame)
        self.oldBounds = self.bounds
        self.backgroundColor = UIColor(white: 1, alpha: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.path = self.shape == .Circle ? UIBezierPath(ovalIn: rect) : UIBezierPath(rect: rect)
        self.color.setFill()
        path.fill()
    }
    
    override public var collisionBoundingPath: UIBezierPath{
        if self.shape == .Circle{
            let radius = min(self.bounds.size.width, self.bounds.size.height) / 2.0
            return UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        } else {
            return UIBezierPath(rect: CGRect(x: -self.bounds.width / 2, y: -self.bounds.height / 2, width: self.bounds.width, height: self.bounds.height))
        }
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
