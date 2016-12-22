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
        guard trail.count >= 2 else {
            fatalError("Trail needs at least 2 elements")
        }
        self.trail = trail
        self.captures = captures
        self.piece = piece.copy()
    }
    
    func getJumps() -> Int {
        return trail.count - 1
    }
    
    func getInitialPosition() -> Tile {
        return trail.first!
    }
    
    func getLastPosition() -> Tile {
        return trail.last!
    }
}
