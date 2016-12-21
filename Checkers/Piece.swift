//
//  Piece.swift
//  Checkers
//
//  Created by Toma Alexandru on 22/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation

class Tile {
    let x: Int
    let y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

class Piece {
    private var position: Tile
    private var player: Player
    private var isKing: Bool = false
    
    init(position: Tile, player: Player) {
        self.position = position
        self.player = player
    }
    
    func getPlayer() -> Player {
        return player
    }
    
    func getPosition() -> Tile {
        return position
    }
    
    func isPieceKing() -> Bool {
        return isKing
    }
}
