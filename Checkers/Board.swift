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
                        grid[x][y] = Piece(position: Tile(x: x, y: y), player: first)
                        first.incrementNumberOfPiceces()
                    }
                    
                    if (y >= 6) {
                        // place red
                        grid[x][y] = Piece(position: Tile(x: x, y: y), player: second)
                        second.incrementNumberOfPiceces()
                    }
                }
            }
        }
    }
    
    func getGrid() -> [[Piece?]] {
        return grid
    }
}
