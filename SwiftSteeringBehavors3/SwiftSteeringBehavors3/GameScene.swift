//
//  GameScene.swift
//  SwiftSteeringBehavors3
//
//  Created by yangboz on 12/04/2017.
//  Copyright © 2017 ___SMARTKIT.INFO___. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var spaceshipNode : SKSpriteNode?//define a SpriteKit node
    //define the position of spaceship related
    private var rightPoint = CGPoint(x:0.5,y:0.5)
    private var leftPoint = CGPoint(x:1.0,y:1.0)
    
    override func didMove(to view: SKView) {
        // Setup your scene here
        spaceshipNode = SKSpriteNode(imageNamed:"Spaceship");//init SpriteKit with image file.
        //Add the spaceship to the scene
        self .addChild(spaceshipNode!)
        //Change position,just from right to left.
        spaceshipNode?.position = rightPoint;
        spaceshipNode?.position = leftPoint;
        //TODO:Run action......
        //Physics World
        // 1.You create an edge-based body. In contrast to the volume-based body you added to the ball, an edge-based body does not have mass or volume, and is unaffected by forces or impulses.
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        // 2.simulate friction on border contact
        borderBody.friction = 0
        // 3.body with border frame.
        self.physicsBody = borderBody
        //
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0)
        //
        physicsWorld.contactDelegate = self
        //get child node by pre-defined name
        let spaceship = childNode(withName: "Spaceship") as! SKSpriteNode
        //
        let bottomRect = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: 1)
        //
        let bottom = SKNode()
        bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomRect)
        addChild(bottom)
        //
        //1. mass:the mass of body.
        spaceship.physicsBody?.mass = 0.1;
        //2.density:the density of body.
        spaceship.physicsBody?.density = 1;
        //3.area:the area of body.get-only.
//        spaceship.physicsBody?.area
        //4.friction:determines the "roughness" for the surface of physic body(0.0-1.0)
        spaceshipNode?.physicsBody?.friction = 0.01;
        //5. velocity:as know as a physic vector quantity.
        spaceship.physicsBody?.velocity = self.physicsBody!.velocity
        
        //1.apply force,to the center of gravity of center of physics body.
        spaceship.physicsBody!.applyForce(CGVector())
        //2.apply torque,to an object.
        spaceship.physicsBody!.applyTorque(CGFloat())
        //3.apply impulse,to the center of gravity of center of physics body.
        spaceship.physicsBody!.applyImpulse(CGVector())
        //4.apply impulse with angular value.
        spaceship.physicsBody!.applyAngularImpulse(CGFloat())
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let label = self.label {
            label.alpha = 0.0
            label.run(SKAction.fadeIn(withDuration: 2.0))
        }

        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let label = self.label {
            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // MARK: - SKPhysicsContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        //TODO
    }
}
