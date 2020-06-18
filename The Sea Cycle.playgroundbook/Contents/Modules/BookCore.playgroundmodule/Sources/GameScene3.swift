//
//  GameScene.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 11/05/20.
//

import Foundation
import SpriteKit
import PlaygroundSupport

public class GameScene3: SKScene {
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = .white
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let cycleTexture = SKTexture(imageNamed: "Cycle")
        cycleTexture.filteringMode = .nearest
        let cycle = SKSpriteNode(texture: cycleTexture)
        cycle.size = CGSize(width: 650, height: 650)
        cycle.position = CGPoint(x: 0, y: 0)
        
        addChild(cycle)
        
        let humansTexture = SKTexture(imageNamed: "Humans")
        humansTexture.filteringMode = .nearest
        let humans = SKSpriteNode(texture: humansTexture)
        humans.size = CGSize(width: 204.82, height: 204.82)
        humans.position = CGPoint(x: 0, y: 216.67)
        
        cycle.addChild(humans)
        
        let productsTexture = SKTexture(imageNamed: "Products")
        productsTexture.filteringMode = .nearest
        let products = SKSpriteNode(texture: productsTexture)
        products.size = CGSize(width: 204.82, height: 204.82)
        products.position = CGPoint(x: -216.67, y: 0)
        
        cycle.addChild(products)
        
        let seaTexture = SKTexture(imageNamed: "Sea")
        seaTexture.filteringMode = .nearest
        let sea = SKSpriteNode(texture: seaTexture)
        sea.size = CGSize(width: 204.82, height: 204.82)
        sea.position = CGPoint(x: 0, y: -216.67)
        
        cycle.addChild(sea)
        
        let foodTexture = SKTexture(imageNamed: "Food")
        foodTexture.filteringMode = .nearest
        let food = SKSpriteNode(texture: foodTexture)
        food.size = CGSize(width: 204.82, height: 204.82)
        food.position = CGPoint(x: 212, y: 0)
        
        cycle.addChild(food)
        
        cycle.run(SKAction.repeatForever(SKAction.rotate(byAngle: 360, duration: 7000)))
        humans.run(SKAction.repeatForever(SKAction.rotate(byAngle: -360, duration: 7000)))
        products.run(SKAction.repeatForever(SKAction.rotate(byAngle: -360, duration: 7000)))
        sea.run(SKAction.repeatForever(SKAction.rotate(byAngle: -360, duration: 7000)))
        food.run(SKAction.repeatForever(SKAction.rotate(byAngle: -360, duration: 7000)))
        
        createBackground()
    }
    
    func createBackground(){
        self.backgroundColor = .black
        
        let backgroundTexture = SKTexture(imageNamed: "Background3")
        backgroundTexture.filteringMode = .nearest
        let background1 = SKSpriteNode(texture: backgroundTexture)
        background1.name = "Background"
        background1.size = CGSize(width: 1300, height: 1300)
        background1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background1.position = CGPoint(x: 0, y: 0)
        background1.zPosition = -1
        background1.alpha = 0.6
        addChild(background1)
    }
}
