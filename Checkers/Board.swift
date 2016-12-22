//
//  Board.swift
//  Checkers
//
//  Created by Toma Alexandru on 21/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation

class Board {
    static let BOARD_SIZE_X = 10
    static let BOARD_SIZE_Y = 10
    private var grid: [[Piece?]]
    
    init(first: Player, second: Player) {
        self.grid = []
        setStartGrid(first: first, second: second)
    }
    
    func setStartGrid(first: Player, second: Player) -> Void {
        grid = [[Piece?]](repeating: [Piece?](repeating: nil, count: Board.BOARD_SIZE_X), count: Board.BOARD_SIZE_Y)
        
        for y in (0..<grid.count).reversed() {
            for x in (0..<grid[y].count) {
                if (y % 2 == x % 2) {
                    if (y <= 3) {
                        // place white
                        grid[y][x] = Piece(board: self, position: Tile(y: y, x: x), player: first)
                        first.incrementNumberOfPiceces()
                    }
                    
                    if (y >= 6) {
                        // place red
                        grid[y][x] = Piece(board: self, position: Tile(y: y, x: x), player: second)
                        second.incrementNumberOfPiceces()
                    }
                }
            }
        }
    }
    
    func forEachTile(apply: (Piece?) -> Void) {
        grid.forEach({line in line.forEach({tile in apply(tile)})})
    }
    
    func isTileInBounds(tile: Tile) -> Bool {
        return tile.x >= 0 && tile.x < Board.BOARD_SIZE_X &&
                tile.y >= 0 && tile.y < Board.BOARD_SIZE_Y
    }
    
    func getPiece(from: Tile) -> Piece? {
        guard isTileInBounds(tile: from) else {
            return nil
        }
        
        return grid[from.y][from.x]
    }
    
    func setPiece(from: Tile, to: Piece?) {
        guard isTileInBounds(tile: from) else {
            fatalError("Not in bounds")
        }
        
        grid[from.y][from.x] = to
    }
    
    func isOccupied(tile: Tile) -> Bool {
        return getPiece(from: tile) != nil
    }
    
    func isOccupied(tile: Tile, by: Player) -> Bool {
        guard let piece = getPiece(from: tile) else {
            return false
        }
        
        return by == piece.getPlayer()
    }
}
