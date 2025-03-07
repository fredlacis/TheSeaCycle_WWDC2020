//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  A source file which is part of the auxiliary module named "BookCore".
//  Provides the implementation of the "always-on" live view.
//

import UIKit
import SpriteKit
import PlaygroundSupport

@objc(BookCore_LiveViewController)
public class LiveViewController3: UIViewController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer {
    
    public var gameScene : GameScene3?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = SKView(frame: self.view.bounds)
        
        let fontURL = Bundle.main.url(forResource: "ConnectionII", withExtension: "otf")
        CTFontManagerRegisterFontsForURL(fontURL! as CFURL, CTFontManagerScope.process, nil)
        
        if let view = self.view as? SKView{
            gameScene = GameScene3(size: view.bounds.size)
            gameScene?.scaleMode = .resizeFill
            view.presentScene(gameScene)
        }
    }
    
    public func receive(_ message: PlaygroundValue) {

    }
    
    /*
    public func liveViewMessageConnectionOpened() {
        // Implement this method to be notified when the live view message connection is opened.
        // The connection will be opened when the process running Contents.swift starts running and listening for messages.
    }
    */

    /*
    public func liveViewMessageConnectionClosed() {
        // Implement this method to be notified when the live view message connection is closed.
        // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
        // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
    }
    */
    

    
//    public func receive(_ message: PlaygroundValue) {
//        // Implement this method to receive messages sent from the process running Contents.swift.
//        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
//        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
//    }
}
