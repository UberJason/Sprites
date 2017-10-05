//
//  InterfaceController.swift
//  Sprites WatchKit Extension
//
//  Created by Jason Ji on 6/16/16.
//  Copyright © 2016 Jason Ji. All rights reserved.
//

import WatchKit
import Foundation
import SpriteKit

class InterfaceController: WKInterfaceController {

    @IBOutlet var sceneView: WKInterfaceSKScene!
    var ring: SKShapeNode!
    var label: SKLabelNode!
    var accumulation: Double = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        let scene = SKScene(size: CGSize(width: 100, height: 100))
        scene.backgroundColor = UIColor.clear
        sceneView.presentScene(scene)
        
        let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 40, startAngle: 0, endAngle: CGFloat(2*CGFloat.pi*0.999), clockwise: false)
        ring = SKShapeNode(path: path.cgPath, centered: false)
        ring.strokeColor = UIColor.yellow
        ring.lineCap = CGLineCap.round
        ring.lineWidth = 5.0
        ring.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2)
        ring.zRotation = CGFloat(CGFloat.pi/2)
        scene.addChild(ring)
        
        label = SKLabelNode(text: "0")
        label.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2)
        label.horizontalAlignmentMode = .center
        label.verticalAlignmentMode = .center
        scene.addChild(label)

        crownSequencer.delegate = self
        crownSequencer.focus()
    }

}

extension InterfaceController: WKCrownDelegate {
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        
        accumulation += rotationalDelta
        accumulation = max(accumulation, 0)
        accumulation = min(accumulation, 0.5)
        
        var percent = 1.0 - accumulation*2
        percent = floor( percent * 10 ) / 10
        percent = min(percent, 0.999)
        percent = max(percent, 0.001)
        print("rotationDelta: \(rotationalDelta), accumulated: \(accumulation), percent: \(percent)")
        
        let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 40, startAngle: 0, endAngle: CGFloat(2*Double.pi*percent), clockwise: false)
        ring.path = path.cgPath
        let labelValue = 10*(1 - percent)
        label.text = formatter.string(from: NSDecimalNumber(value: labelValue))
        
    }
}
