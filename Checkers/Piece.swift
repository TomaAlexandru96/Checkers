//
//  Piece.swift
//  Checkers
//
//  Created by Toma Alexandru on 22/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation

class Tile: Equatable, Hashable {
    let x: Int
    let y: Int
    
    init(y: Int, x: Int) {
        self.x = x
        self.y = y
    }
    
    var hashValue: Int {
        get {
            return x * 13 + y * 113
        }
    }
}

func ==(this: Tile, other: Tile) -> Bool {
    return this.x == other.x && this.y == other.y
}

class Piece: Hashable, Equatable {
    fileprivate var position: Tile
    fileprivate var player: Player
    fileprivate var isKing: Bool = false
    fileprivate var board: Board
    
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
                if !board.isOccupied(tile: next) && board.isTileInBounds(tile: next) {
                    allMoves.append(Move(trail: [position, next], captures: [], piece: self))
                }
            }
        }
        
        return allMoves
    }
    
    func hasMoves() -> Bool {
        return !getAllPossibleMoves().isEmpty
    }
    
    func move(move: Move) {
        move.captures.forEach { tile in
            board.setPiece(from: tile, to: nil)
        }
        movePiece(to: move.getLastPosition())
    }
    
    func movePiece(to: Tile) {
        board.setPiece(from: position, to: nil)
        board.setPiece(from: to, to: self)
        position = to
    }
    
    private func getForwardMovementVectors() -> [(Int, Int)] {
        var y = 1
        
        if (!player.isWhite()) {
            y = -y
        }
        
        return [(y, -1), (y, 1)]
    }
    
    var hashValue: Int {
        get {
            return position.hashValue + player.hashValue + isKing.hashValue
        }
    }
}

func ==(this: Piece, other: Piece) -> Bool {
    return this.position == other.position &&
            this.player == other.player &&
            this.isKing == other.isKing
}
