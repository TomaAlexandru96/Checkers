//
//  ViewTile.swift
//  Checkers
//
//  Created by Toma Alexandru on 24/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation
import SpriteKit

class ViewTile {
    let action: ViewActionTile
    let info: ViewInfoTile
    
    init(action: ViewActionTile, info: ViewInfoTile) {
        self.action = action
        self.info = info
    }
}
