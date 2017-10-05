//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import PlaygroundSupport

let spriteView = SKView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
spriteView.showsFPS = true

PlaygroundPage.current.liveView = spriteView

let scene = SKScene(size: spriteView.frame.size)
spriteView.presentScene(scene)

let path = CGMutablePath()
path.addArc(nil, x: 0, y: 0, radius: 50, startAngle: 0, endAngle: CGFloat(2*M_PI)*0.50, clockwise: true)
let ring = SKShapeNode(path: path, centered: true)

ring.lineCap = CGLineCap.round
ring.lineWidth = 20.0
ring.position = CGPoint(x: 50, y: 50)
ring.zRotation = CGFloat(M_PI_2)
scene.addChild(ring)

ring.run(SKAction.customAction(withDuration: 4.0, actionBlock: { (ring, timeElapsed) in
    if let ring = ring as? SKShapeNode {
        let percent = 1 - timeElapsed / 4.0
        let path = UIBezierPath(arcCenter: CGPoint(x: 0, y: 0), radius: 50, startAngle: 0, endAngle: max(CGFloat(2*M_PI)*percent, 0.001), clockwise: false)
        ring.path = path.cgPath
    }
}))
