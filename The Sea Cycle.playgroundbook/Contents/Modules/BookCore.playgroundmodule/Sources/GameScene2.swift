//
//  GameScene.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 11/05/20.
//

import Foundation
import SpriteKit
import PlaygroundSupport

public class GameScene2: SKScene {
    
    var gameStarted = false
    var gameOver = false
    
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = UIColor(red: 0.99, green: 0.80, blue: 0.50, alpha: 1.00)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        if gameOver{
            displayGameOver()
        } else {
            setupStart()
        }
        createbackground()
    }
    
    func setupStart(){
        if !gameStarted{
            let startTexture = SKTexture(imageNamed: "Start")
            startTexture.filteringMode = .nearest
            let startBtn = SKSpriteNode(texture: startTexture)
            startBtn.size = CGSize(width: 300, height: 150)
            startBtn.name = "start"
            
            addChild(startBtn)
        } else {
            setupManta()
            setupScores()
        }
    }
    
    var manta : SKSpriteNode!
    var mantaMouth : SKSpriteNode!
    var mantaTextureArray : [SKTexture]! = []
    
    func setupManta(){
        
        for i in 0...7{
            let texture = SKTexture(imageNamed: "frameManta\(i)")
            texture.filteringMode = .nearest
            mantaTextureArray.append(texture)
        }

        manta = SKSpriteNode(texture: mantaTextureArray[0])
        manta.position = CGPoint(x: 0, y: -300)
        manta.size = CGSize(width: 220, height: 220)
        manta.zPosition = 50
        addChild(manta)
        
        manta.run(SKAction.repeatForever(SKAction.animate(with: mantaTextureArray, timePerFrame: 0.2)))
        
        mantaMouth = SKSpriteNode()
        mantaMouth.size = CGSize(width: 60, height: 15)
        mantaMouth.position = CGPoint(x: manta.position.x, y: manta.position.y + 100)
        
        addChild(mantaMouth)
    }
    
    var goodScoreLabel : SKLabelNode?
    var badScoreLabel : SKLabelNode?
    var goodScore : Int = 0{
        didSet {
            goodScoreLabel?.text = "\(goodScore)"
        }
    }
    var badScore : Int = 0{
        didSet {
            badScoreLabel?.text = "\(badScore)"
            if(badScore >= 15){
                highScores.append(goodScore - badScore)
                gameOver = true
                gameStarted = false
                badScore = 0
                goodScore = 0
                self.resetSelf()
            }
        }
    }

    
    var highScores : [Int] = []
    
    func setupScores(){
        let goodScoreLabelTitle = SKLabelNode(fontNamed: "Connection II")
        goodScoreLabelTitle.text = "Food eaten"
        goodScoreLabelTitle.fontSize = 40
        goodScoreLabelTitle.fontColor = UIColor(red: 0.5, green: 0.49, blue: 0.51, alpha: 1.0)
        goodScoreLabelTitle.position = CGPoint(x: -220, y: 500)
        goodScoreLabelTitle.horizontalAlignmentMode = .center
        goodScoreLabelTitle.verticalAlignmentMode = .center
        goodScoreLabelTitle.preferredMaxLayoutWidth = 300
        
        goodScoreLabel = SKLabelNode(fontNamed: "Connection II")
        goodScoreLabel?.text = "0"
        goodScoreLabel?.fontSize = 40
        goodScoreLabel?.fontColor = UIColor(red: 0.5, green: 0.49, blue: 0.51, alpha: 1.0)
        goodScoreLabel?.position = CGPoint(x: -220, y: 460)
        goodScoreLabel?.horizontalAlignmentMode = .center
        goodScoreLabel?.verticalAlignmentMode = .center
        goodScoreLabel?.preferredMaxLayoutWidth = 300
        goodScoreLabel?.lineBreakMode = .byClipping
        
        let badScoreLabelTitle = SKLabelNode(fontNamed: "Connection II")
        badScoreLabelTitle.text = "Plastic eaten"
        badScoreLabelTitle.fontSize = 40
        badScoreLabelTitle.fontColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        badScoreLabelTitle.position = CGPoint(x: 180, y: 500)
        badScoreLabelTitle.horizontalAlignmentMode = .center
        badScoreLabelTitle.verticalAlignmentMode = .center
        badScoreLabelTitle.preferredMaxLayoutWidth = 300
        
        badScoreLabel = SKLabelNode(fontNamed: "Connection II")
        badScoreLabel?.text = "0"
        badScoreLabel?.fontSize = 40
        badScoreLabel?.fontColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 1.0)
        badScoreLabel?.position = CGPoint(x: 180, y: 460)
        badScoreLabel?.horizontalAlignmentMode = .center
        badScoreLabel?.verticalAlignmentMode = .center
        badScoreLabel?.preferredMaxLayoutWidth = 300
        
        addChild(goodScoreLabel!)
        addChild(goodScoreLabelTitle)
        addChild(badScoreLabel!)
        addChild(badScoreLabelTitle)
    }
    
    func resetSelf(){
        self.removeAllChildren()
        self.didMove(to: self.view!)
    }
    
    func displayGameOver(){
        PlaygroundPage.current.assessmentStatus = .pass(message: "You did a nice try! [Next Page](@next)")
        
        let restartTexture = SKTexture(imageNamed: "Restart")
        restartTexture.filteringMode = .nearest
        let restartBtn = SKSpriteNode(texture: restartTexture)
        restartBtn.size = CGSize(width: 365, height: 150)
        restartBtn.name = "restart"
        restartBtn.alpha = 0.0
        self.addChild(restartBtn)
        
        
        //The Text Box
        let textBoxTexture = SKTexture(imageNamed: "TextBox.png")
        textBoxTexture.filteringMode = .nearest
        let textBox = SKSpriteNode(texture: textBoxTexture)
        textBox.size = CGSize(width: 610, height: 203)
        textBox.name = "textBox"
        
        textBox.position = CGPoint(x: 0, y: -260)
        textBox.zPosition = 110
        
        self.addChild(textBox)
        
        let text = SKLabelNode(fontNamed: "Connection II")
        text.horizontalAlignmentMode = .center
        text.verticalAlignmentMode = .center
        text.preferredMaxLayoutWidth = 550
        text.position = CGPoint(x: 0, y: -260)
        text.fontColor = UIColor(red: 0, green: 0.427, blue: 0.651, alpha: 1)
        text.lineBreakMode = .byWordWrapping
        text.zPosition = 111
        text.fontSize = 30
        text.numberOfLines = 5
        
        text.name = "description"
        text.text = "Now you know how easy it is to mistake trash for food. You can try again or go to the next page."
        
        self.addChild(text)
        
        let highScoreLabelTitle = SKLabelNode(fontNamed: "Connection II")
        highScoreLabelTitle.text = "High Score"
        highScoreLabelTitle.fontSize = 60
        highScoreLabelTitle.fontColor = UIColor(red: 0.00, green: 0.66, blue: 1.00, alpha: 1.00)
        highScoreLabelTitle.position = CGPoint(x: 0, y: 230)
        highScoreLabelTitle.horizontalAlignmentMode = .center
        highScoreLabelTitle.verticalAlignmentMode = .center
        highScoreLabelTitle.preferredMaxLayoutWidth = 300
        
        self.addChild(highScoreLabelTitle)
        
        let highScoreLabel = SKLabelNode(fontNamed: "Connection II")
        highScoreLabel.text = "\(highScores.max() ?? 0)"
        highScoreLabel.fontSize = 60
        highScoreLabel.fontColor = UIColor(red: 0.00, green: 0.66, blue: 1.00, alpha: 1.00)
        highScoreLabel.position = CGPoint(x: 0, y: 175)
        highScoreLabel.horizontalAlignmentMode = .center
        highScoreLabel.verticalAlignmentMode = .center
        highScoreLabel.preferredMaxLayoutWidth = 300
        highScoreLabel.lineBreakMode = .byClipping
        
        self.addChild(highScoreLabel)
        
        highScoreLabelTitle.run(SKAction.fadeIn(withDuration: 0.7))
        highScoreLabel.run(SKAction.fadeIn(withDuration: 0.7))
        restartBtn.run(SKAction.fadeIn(withDuration: 0.7))
        textBox.run(SKAction.fadeIn(withDuration: 0.7))
        text.run(SKAction.fadeIn(withDuration: 0.7))
    }
        
    
    func eat(){
        self.enumerateChildNodes(withName: "particle", using: ({
            (node,error) in
            
            let particle = node as! SKSpriteNode
            
            if self.mantaMouth.contains(particle.position){
                if particle.color.cgColor.components![0] <= 0.3{
                    self.badScore += 1;
                } else {
                    self.goodScore += 1;
                }
                particle.color = .red
                self.removeChildren(in: [particle])
            }
            
        }))
    }
    
    public override func update(_ currentTime: TimeInterval) {
        if gameStarted{
            createParticles()
            moveParticles()
            eat()
            mantaMouth.position = CGPoint(x: manta.position.x, y: manta.position.y + 100)
        }
        moveGrounds()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        for touch in touches {
            if let name = touchedNode.name{
                if name == "start" {
                    setupManta()
                    setupScores()
                    gameStarted = true
                    removeChildren(in: [touchedNode])
                } else if name == "restart" {
                    gameOver = false
                    gameStarted = true
                    self.resetSelf()
                }
            }
            if gameStarted {
                let location = touch.location(in: self)
                manta.run(SKAction.moveTo(x: location.x, duration: 0.5))
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if gameStarted {
                let location = touch.location(in: self)
                manta.run(SKAction.moveTo(x: location.x, duration: 0.5))
            }
        }
    }
    
    func createParticles(){
        if Int.random(in: 0...10) > 7{
            let xPosition = CGFloat.random(in: -400...400)
            let yPosition = CGFloat.random(in: 750...900)
            let scale = CGFloat.random(in: 10...15)
            let particle = SKSpriteNode()
            particle.size = CGSize(width: scale, height: scale)
            particle.position = CGPoint(x: xPosition, y: yPosition)
            
            let rotationTime = CGFloat.random(in: 300...1000)
            let oneRevolution = SKAction.rotate(byAngle: 360, duration: TimeInterval(rotationTime))
            let action = SKAction.repeatForever(oneRevolution)
            particle.run(action)
            
            particle.alpha = map(range: CGFloat(10)...CGFloat(15.0), domain: 0.1...1.0, value: scale)
            particle.zPosition = map(range: CGFloat(10)...CGFloat(15.0), domain: CGFloat(48)...CGFloat(52), value: scale)
            
            particle.name = "particle"
            
            var color = UIColor()
            
            if Int.random(in: 0...10) > 4 {
                color = UIColor(red: 0.2, green: map(range: CGFloat(10)...CGFloat(15), domain: CGFloat(0.5)...CGFloat(1), value: scale), blue: 0.2, alpha: 1.0)
            } else {
                color = UIColor(red: map(range: CGFloat(10)...CGFloat(15), domain: CGFloat(0.6)...CGFloat(1), value: scale), green: 0.89, blue: 0.81, alpha: 1.0)
            }
            particle.color = color
            particle.colorBlendFactor = 1.0
            addChild(particle)
        }
        
        if Int.random(in: 0...1000) > 996{
            
            var texture : SKTexture
            var blendFactor = 0.0
            if Int.random(in: 0...10) > 5 {
                texture = SKTexture(imageNamed: "Rock")
            } else {
                texture = SKTexture(imageNamed: "Star")
                blendFactor = 0.9
            }
            
            let xPosition = CGFloat.random(in: -400...400)
            let yPosition = CGFloat.random(in: 750...900)
            let scale = CGFloat.random(in: 25...60)
            let angle = CGFloat.random(in: 0...360)
            let rockStar = SKSpriteNode(texture: texture)
            rockStar.size = CGSize(width: scale, height: scale)
            rockStar.position = CGPoint(x: xPosition, y: yPosition)
            rockStar.run(SKAction.rotate(toAngle: angle * .pi / 180, duration: 0))
            rockStar.color = randomColor()
            rockStar.colorBlendFactor = CGFloat(blendFactor)
            rockStar.alpha = 0.6
            rockStar.name = "rockstar"
            
            addChild(rockStar)
        }
    }
    
    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func moveParticles(){
        
        self.enumerateChildNodes(withName: "particle", using: ({
            (node,error) in
            
            let particle = node as! SKSpriteNode
            particle.position.y -= particle.size.width/10
            
            if particle.position.y < -1100 {
                self.removeChildren(in: [particle])
            }
            
        }))
        
        self.enumerateChildNodes(withName: "rockstar", using: ({
            (node,error) in
            
            let particle = node as! SKSpriteNode
            particle.position.y -= 1.5
            
            if particle.position.y < -1100 {
                self.removeChildren(in: [particle])
            }
            
        }))
        
    }
    
    func map(range:ClosedRange<CGFloat>, domain:ClosedRange<CGFloat>, value:CGFloat) -> CGFloat {
        return domain.lowerBound + (domain.upperBound - domain.lowerBound) * (value - range.lowerBound) / (range.upperBound - range.lowerBound)
    }
    
    var background1 : SKSpriteNode!
    var background2 : SKSpriteNode!
    var background3 : SKSpriteNode!
    
    func createbackground(){
        let backgroundTexture = SKTexture(imageNamed: "gameBackground")
        backgroundTexture.filteringMode = .nearest
        
        background1 = SKSpriteNode(texture: backgroundTexture)
        background1.name = "Background"
        background1.size = CGSize(width: self.scene!.size.width, height: self.scene!.size.width)
        background1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background1.position = CGPoint(x: 0, y: background1.size.height)
        background1.zPosition = -1
        
        background2 = SKSpriteNode(texture: backgroundTexture)
        background2.name = "Background"
        background2.size = CGSize(width: self.scene!.size.width, height: self.scene!.size.width)
        background2.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background2.position = CGPoint(x: 0, y: 0)
        background2.zPosition = -1
        
        background3 = SKSpriteNode(texture: backgroundTexture)
        background3.name = "Background"
        background3.size = CGSize(width: self.scene!.size.width, height: self.scene!.size.width)
        background3.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background3.position = CGPoint(x: 0, y: -background1.size.height)
        background3.zPosition = -1
        
        addChild(background1)
        addChild(background2)
        addChild(background3)
    }
    
    func moveGrounds(){
        
        background1.position.y -= 1.5
        background2.position.y -= 1.5
        background3.position.y -= 1.5
        
        let heightFactor : CGFloat = 1100
        
        if background1.position.y < -heightFactor{
            background1.position.y = background2.position.y + background1.size.height
        }
        
        if background2.position.y < -heightFactor{
           background2.position.y = background3.position.y + background2.size.height
        }
        
        if background3.position.y < -heightFactor{
           background3.position.y = background1.position.y + background3.size.height
        }
        
    }
}
