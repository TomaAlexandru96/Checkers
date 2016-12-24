//
//  ViewTile.swift
//  Checkers
//
//  Created by Toma Alexandru on 24/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation
import SpriteKit

class ViewActionTile: Button {
    init(position: Tile, board: SKTileMapNode, scene: GameScene) {
        super.init(texture: nil, color: UIColor.clear, size: board.tileSize)
        self.position = board.centerOfTile(atColumn: position.x, row: position.y)
        zPosition = 3
        setAction { sender in
            scene.tappedTile(tile: Tile(y: position.y, x: position.x))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
