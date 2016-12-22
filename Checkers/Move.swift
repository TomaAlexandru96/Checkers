//
//  Move.swift
//  Checkers
//
//  Created by Toma Alexandru on 22/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation

class Move {
    let trail: [Tile]
    let captures: [Tile]
    let piece: Piece
    
    init(trail: [Tile], captures: [Tile], piece: Piece) {
        self.trail = trail
        self.captures = captures
        self.piece = piece.copy()
    }
}
