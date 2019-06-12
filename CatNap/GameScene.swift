//
//  GameScene.swift
//  CatNap
//
//  Created by Parrot on 2019-02-18.
//  Copyright © 2019 Parrot. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    

    //sprites
    var bed:SKNode?
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        self.bed = self.childNode(withName: "bed")
        self.bed!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        self.bed!.physicsBody?.categoryBitMask = 4
        self.bed!.physicsBody?.collisionBitMask = 0
        self.bed!.physicsBody?.pinned = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let mousePosition = touch.location(in: self)
        
        let spritTouched = self.atPoint(mousePosition)
        
        if(spritTouched.name == "block")
        {
            spritTouched.removeFromParent()
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let objectA = contact.bodyA.node
        let objectB = contact.bodyB.node
        
        print("+++ \(objectA!.name) hits \(objectB!.name) +++")
        
        if(objectA!.name == "ground" && objectB?.name == "cat"){
            print("Game Over")
        }
        
        if(objectB!.name == "ground" && objectA?.name == "cat"){
            print("Game Over")
        }
        
        if(objectA!.name == "bed" && objectB!.name == "cat"){
            objectB?.physicsBody?.isDynamic = false
            print("You Win")
        }
        
        if(objectB!.name == "bed" && objectA!.name == "cat"){
            objectA?.physicsBody?.isDynamic = false
            print("You Win")
        }
    }


}
