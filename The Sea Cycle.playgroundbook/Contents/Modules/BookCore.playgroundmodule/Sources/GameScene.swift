//
//  GameScene.swift
//  BookCore
//
//  Created by Frederico Lacis de Carvalho on 11/05/20.
//

import Foundation
import SpriteKit
import PlaygroundSupport

public class GameScene: SKScene {
    
    override public func didMove(to view: SKView) {
        self.backgroundColor = .white
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let backgroundCover = SKShapeNode(rect: CGRect(x: -2000/2, y: -1500/2, width: 2000, height: 1500))
        backgroundCover.fillColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6472335188)
        backgroundCover.zPosition = -1
        backgroundCover.name = "bgCover"
        backgroundCover.run(SKAction.fadeOut(withDuration: 0))
        addChild(backgroundCover)
                
        addChildNodes()
        createBackground()
    }
    
    func createBackground(){
        let backgroundTexture = SKTexture(imageNamed: "Background1")
        backgroundTexture.filteringMode = .nearest
        let background1 = SKSpriteNode(texture: backgroundTexture)
        background1.name = "Background"
        background1.size = CGSize(width: 1300, height: 1300)
        background1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background1.position = CGPoint(x: 0, y: 0)
        background1.zPosition = -1
        addChild(background1)
        
        let lampTexture = SKTexture(imageNamed: "Lamp")
        lampTexture.filteringMode = .nearest
        let lamp = SKSpriteNode(texture: lampTexture)
        lamp.size = CGSize(width: 200, height: 400)
        lamp.name = "lamp"
        lamp.position = CGPoint(x: 0, y: 790)
        lamp.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        lamp.zPosition = 2
        addChild(lamp)
        
        let bounceRight = SKAction.rotate(toAngle: -(7 * .pi / 180), duration: 2)
        bounceRight.timingMode = .easeInEaseOut
        let bounceLeft = SKAction.rotate(toAngle: 7 * .pi / 180, duration: 2)
        bounceLeft.timingMode = .easeInEaseOut
        let bounce = SKAction.repeatForever(SKAction.sequence([bounceRight,bounceLeft]))
        lamp.run(bounce)
    }
    
    var productDescription : SKLabelNode?
    var productTitle : SKLabelNode?
    var cart : SKSpriteNode?
    var textBox : SKSpriteNode?
    
    func addChildNodes(){
        
        //The Shelf
        let shelfTexture = SKTexture(imageNamed: "Shelf.png")
        shelfTexture.filteringMode = .nearest
        let shelf = SKSpriteNode(texture: shelfTexture)
        shelf.size = CGSize(width: 572, height: 544)
        shelf.name = "shelf"
        
        shelf.position = CGPoint(x: 0, y: 100)
        
        self.addChild(shelf)
        
        //Products in the shelf
        for i in 0 ... 11 {
            let productTexture = SKTexture(imageNamed: "product-\(i).png")
            productTexture.filteringMode = .nearest
            let product = SKSpriteNode(texture: productTexture)
            product.size = CGSize(width: 57, height: 114)
            product.name = "product\(i)"
            
            var xMult : CGFloat
            var yPos : CGFloat
            if i >= 0 && i <= 3 {
                xMult = CGFloat(i)
                yPos = shelf.position.y + 133
            } else if i >= 4 && i <= 7 {
                xMult = CGFloat(i % 4)
                yPos = shelf.position.y - 27
            } else {
                xMult = CGFloat(i % 8)
                yPos = shelf.position.y - 187
            }
            
            product.position = CGPoint(x: shelf.position.x - 215 + CGFloat(xMult * 128), y: yPos)
            
            product.zPosition = 115
            
            self.addChild(product)
        }
        
        //The Text Box
        let textBoxTexture = SKTexture(imageNamed: "TextBox.png")
        textBoxTexture.filteringMode = .nearest
        textBox = SKSpriteNode(texture: textBoxTexture)
        textBox?.size = CGSize(width: 610, height: 203)
        textBox?.name = "textBox"
        
        textBox?.position = CGPoint(x: 0, y: -271)
        textBox?.zPosition = 110
        
        self.addChild(textBox!)
        
        //Text in the Text Box
        //Product Title
        productTitle = SKLabelNode(fontNamed: "Connection II")
        if let text = productTitle{
            text.horizontalAlignmentMode = .center
            text.verticalAlignmentMode = .center
            text.preferredMaxLayoutWidth = 550
            text.position = CGPoint(x: 0, y: -210)
            text.fontColor = UIColor(red: 0, green: 0.427, blue: 0.651, alpha: 1)
            text.zPosition = 111
            text.fontSize = 40
            text.numberOfLines = 1

            text.name = "title"
            text.text = ""
            
            self.addChild(text)
        }
        
        //Product Description
        productDescription = SKLabelNode(fontNamed: "Connection II")
        if let text = productDescription{
            text.horizontalAlignmentMode = .center
            text.verticalAlignmentMode = .center
            text.preferredMaxLayoutWidth = 550
            text.position = CGPoint(x: 0, y: -271)
            text.fontColor = UIColor(red: 0, green: 0.427, blue: 0.651, alpha: 1)
            text.lineBreakMode = .byWordWrapping
            text.zPosition = 111
            text.fontSize = 30
            text.numberOfLines = 5
            
            text.name = "description"
            text.text = "Select a product to see its properties."
            
            self.addChild(text)
        }
        
        //For the execution fase
        let cartTexture = SKTexture(imageNamed: "Cart")
        cartTexture.filteringMode = .nearest
        cart = SKSpriteNode(texture: cartTexture)
        cart?.size = CGSize(width: 400, height: 400)
        cart?.run(SKAction.fadeOut(withDuration: 0))
        cart?.name = "cart"
        cart?.zPosition = 200
        cart?.position = CGPoint(x: -800, y: -250)
        addChild(cart!)
        
    }
    
    var selectedNode : SKSpriteNode? = nil
    var originalPosition : CGPoint?
    var originalZ : CGFloat?
    
    var productInteraction = true
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        let animationDuration = 0.3
        
        if let name = touchedNode.name{
            if name.contains("product") && productInteraction{
                productInteraction = false
                
                let touchedSNode = touchedNode as! SKSpriteNode
                
                selectedNode = touchedSNode
                originalPosition = touchedSNode.position
                originalZ = touchedSNode.zPosition
                
                let scale = SKAction.scale(to: 4, duration: animationDuration)
                let move = SKAction.move(to: CGPoint(x: 0, y: 65), duration: animationDuration)
                let actions = SKAction.group([scale, move])
                touchedSNode.run(actions)
                touchedSNode.zPosition = 160
                
                //Setting up the text
                productTitle?.text = getProductInfo(productId: name).0
                productDescription?.text = getProductInfo(productId: name).1
                productDescription?.position = CGPoint(x: 0, y: -285)
                
                let bgCover = self.childNode(withName: "bgCover")
                let fadeBg = SKAction.fadeIn(withDuration: animationDuration)
                bgCover?.run(fadeBg)
                bgCover?.zPosition = 109
                
            } else if name.contains("bgCover"){
                if let sNode = selectedNode{
                    let scale = SKAction.scale(to: 1, duration: animationDuration)
                    let move = SKAction.move(to: originalPosition!, duration: animationDuration)
                    let actions = SKAction.group([scale, move])
                    sNode.run(actions, completion: {
                        sNode.zPosition = self.originalZ!
                    })
                    selectedNode = nil
                }
                let bgCover = self.childNode(withName: "bgCover")
                let fadeBg = SKAction.fadeOut(withDuration: animationDuration)
                productTitle?.text = ""
                productDescription?.text = "Select a product to see its properties."
                productDescription?.position = CGPoint(x: 0, y: -271)
                bgCover?.run(fadeBg, completion: {
                    bgCover?.zPosition = -1
                    self.productInteraction = true
                })
                
            }
        }

    }
    
    public func buyStuff(products : [Int]){
        
        let uniqueProducts = Array(Set(products))
        
        if uniqueProducts.isEmpty{
            productDescription?.text = "You should get something!"
        } else {
            let wait = SKAction.wait(forDuration: 2.0)
            let moveCart = SKAction.moveTo(x: 0, duration: 0.7)
            moveCart.timingMode = .easeInEaseOut
            let showCart = SKAction.fadeIn(withDuration: 0.3)
            let cartActions = SKAction.group([wait, showCart, moveCart])
            
            cart?.run(cartActions, completion: {
                for (i, productNum) in uniqueProducts.enumerated(){
                    
                    let move = SKAction.move(to: CGPoint(x: -50 + (200/uniqueProducts.count) * i,y: -250), duration: 1.0)
                    let actions = SKAction.group([wait, move])
                    
                    if i == uniqueProducts.count - 1{
                        self.childNode(withName: "product\(productNum)")?.run(actions, completion: {
                            let moveOut = SKAction.moveBy(x: 800, y: 0, duration: 0.7)
                            moveOut.timingMode = .easeInEaseOut
                            self.cart?.run(moveOut)
                            for productNum in uniqueProducts{
                                self.childNode(withName: "product\(productNum)")?.run(moveOut, completion: {
                                    for (i,child) in self.children.enumerated() {
                                        if i == self.children.count - 1{
                                            child.run(SKAction.fadeOut(withDuration: 0.3), completion: {
                                                self.endScreen(products: uniqueProducts)
                                            })
                                        } else {
                                            child.run(SKAction.fadeOut(withDuration: 0.3))
                                        }
                                    }
                                })
                            }
                        })
                    } else {
                        self.childNode(withName: "product\(productNum)")?.run(actions)
                    }
                }
            })
        }
    }
    
    func endScreen(products : [Int]){
        
        createBackground2()
        
        let newTextBox = textBox?.copy() as! SKSpriteNode
        let newProductDescription = productDescription?.copy() as! SKLabelNode
        
        newProductDescription.position = CGPoint(x: 0, y: 0)
        newTextBox.position = CGPoint(x: 0, y: 0)
        
        newProductDescription.text = "Go to the next page!"
        
        newTextBox.alpha = 0.0
        newProductDescription.alpha = 0.0
        
        addChild(newProductDescription)
        addChild(newTextBox)
        
        newTextBox.run(SKAction.fadeIn(withDuration: 1))
        newProductDescription.run(SKAction.fadeIn(withDuration: 1))
        
        PlaygroundPage.current.assessmentStatus = .pass(message: "[Touch here to go to the next page!](@next)")
        
    }
    
    var background1 : SKSpriteNode!
    var background2 : SKSpriteNode!
    var background3 : SKSpriteNode!
    var groundsExist = false
    
    func createBackground2(){
        
        let backgroundTexture = SKTexture(imageNamed: "Background2")
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
        
        groundsExist = true
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
    
    public override func update(_ currentTime: TimeInterval) {
        if groundsExist{
            moveGrounds()
        }
    }
    
    func resetSelf(){
        self.removeAllChildren()
        self.didMove(to: self.view!)
    }
    
    func getProductInfo(productId:String) -> (String,String){
        
        switch productId {
            case "product0":
                return ("Glitter","Packaging made of plastic and made of microbeads.")
            case "product1":
                return ("Soap","Packaging made of paper and no chemicals harmful to the environment.")
            case "product2":
                return ("CottonSwabs","Packaging and rods made of plastic.")
            case "product3":
                return ("Makeup","Packaging mostly made of plastic and sometimes has glitter in it.")
            case "product4":
                return ("Moisturizer","Packaging made of plastic and can have microbeads inside.")
            case "product5":
                return ("Deodorant","Packaging mostly made of aluminum.")
            case "product6":
                return ("ShowerGel","Packaging made of plastic and can have microbeads inside.")
            case "product7":
                return ("Sunscreen","Packaging made of plastic and can have microbeads inside.")
            case "product8":
                return ("BabyPowder","Packaging made of plastic.")
            case "product9":
                return ("FaceScrubs","Packaging made of plastic and large microbeads inside it.")
            case "product10":
                return ("Toothpaste","Packaging made of plastic and microbeads inside it.")
            case "product11":
                return ("BodyScrubs","Packaging made of plastic and large microbeads inside it.")
            default:
                 return ("Select a product to see its properties.","")
        }
        
    }
    
}
