//
//  Button.swift
//  Checkers
//
//  Created by Toma Alexandru on 21/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation
import SpriteKit

class Button: SKSpriteNode {
    private var action: (AnyObject) -> Void = {sender in fatalError("action not assigned")}
    var withAlpha: Bool = true

    func setAction(to action: @escaping (AnyObject) -> Void) -> Void {
        self.action = action
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let _ = touches.first else {
            return
        }
        if withAlpha {
            alpha = 0.7
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let position = touch.location(in: scene!)
        if withAlpha {
            alpha = 1
        }
        
        guard scene!.nodes(at: position).contains(self) else {
            return
        }
        
        action(self)
    }
}
