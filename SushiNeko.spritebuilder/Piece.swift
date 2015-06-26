//
//  Piece.swift
//  SushiNeko
//
//  Created by Boris Yue on 6/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Piece: CCNode {
    weak var left: CCSprite!
    weak var right: CCSprite!
    
    var side: Side = .None {
        didSet {
            left.visible = false
            right.visible = false
            if side == .Right {
                right.visible = true
            } else if side == .Left {
                left.visible = true
            }
        }
    }
    func setObstacle(lastSide: Side) -> Side {
        if lastSide == Side.Left || lastSide == Side.Right {
            side = .None
        }
        else{
            var rand = CCRANDOM_0_1()
            if rand <= 0.45{
                side = .Right
            }
            else if rand > 0.45 && rand <= 0.9 {
                side = .Left
            }
            else{
                side = .None
            }
        }
        return side
    }
}
