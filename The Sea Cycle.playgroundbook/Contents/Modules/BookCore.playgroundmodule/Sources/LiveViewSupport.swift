//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  Provides supporting functions for setting up a live view.
//

import UIKit
import PlaygroundSupport

/// Instantiates a new instance of a live view.
///
/// By default, this loads an instance of `LiveViewController` from `LiveView.storyboard`.
public func instantiateLiveView() -> PlaygroundLiveViewable {
    
    let liveViewController = LiveViewController()

    return liveViewController
}

public func instantiateLiveView2() -> PlaygroundLiveViewable {
    
    let liveViewController = LiveViewController2()

    return liveViewController
}

public func instantiateLiveView3() -> PlaygroundLiveViewable {
    
    let liveViewController = LiveViewController3()

    return liveViewController
}
