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
    
    init(y: Int, x: Int) {
        self.x = x
        self.y = y
    }
}

class Piece {
    private var position: Tile
    private var player: Player
    private var isKing: Bool = false
    private var board: Board
    
    init(board: Board, position: Tile, player: Player) {
        self.position = position
        self.player = player
        self.board = board
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
    
    func setKingTo(state: Bool) {
        isKing = state
    }
    
    func copy() -> Piece {
        let p = Piece(board: board, position: position, player: player)
        p.setKingTo(state: isKing)
        return p
    }
    
    // Follows the rules of capturing from international draughts
    func getAllPossibleMoves() -> [Move] {
        var allMoves: [Move] = []
        
        if (isPieceKing()) {
            // TODO
        } else {
            for pair in getForwardMovementVectors() {
                let next = Tile(y: position.y + pair.0, x: position.x + pair.1)
                if !board.isOccupied(tile: next) {
                    allMoves.append(Move(trail: [position, next], captures: [], piece: self))
                }
            }
        }
        
        return allMoves
    }
    
    func movePiece(move: Move) {
        move.captures.forEach { tile in
            board.setPiece(from: tile, to: nil)
        }
        board.setPiece(from: move.getInitialPosition(), to: nil)
        position = Tile(y: move.getLastPosition().y, x: move.getLastPosition().x)
        board.setPiece(from: position, to: self)
    }
    
    private func getForwardMovementVectors() -> [(Int, Int)] {
        var y = 1
        
        if (!player.isWhite()) {
            y = -y
        }
        
        return [(y, -1), (y, 1)]
    }
}
