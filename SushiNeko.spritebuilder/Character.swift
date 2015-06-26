//
//  Character.swift
//  SushiNeko
//
//  Created by Boris Yue on 6/26/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit

class Character: CCSprite {
   
    func left(){
        scaleX = 1
    }
    func right(){
        scaleX = -1
    }
}
