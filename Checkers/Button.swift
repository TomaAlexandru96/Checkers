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
    var action: () -> Void = {fatalError("action not assigned")}

    func setAction(to action: @escaping () -> Void) -> Void {
        self.action = action
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        action()
    }
}
