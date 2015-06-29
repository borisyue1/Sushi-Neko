//
//  Character.swift
//  SushiNeko
//
//  Created by Boris Yue on 6/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Character: CCSprite {
   
    var side: Side = .Left
    func left(){
        side = .Left
        scaleX = 1
    }
    func right(){
        side = .Right
        scaleX = -1
    }
    func tap() {
        self.animationManager.runAnimationsForSequenceNamed("Tap")
    }
}
