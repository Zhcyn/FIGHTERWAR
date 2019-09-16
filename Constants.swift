//
//  Constants.swift
//  AVIWAR
//
//  Created by Kevin Hsia on 9/2/15.
//  Copyright © 2015 Laser Studio. All rights reserved.
//

import UIKit

// - MARK: Debugging options
let IS_DEBUGGING: Bool = false
let DEBUGGING_SCORE: Int = 20

// - MARK: Constants
let ENEMY_PLANE_EASY_TIME_INTERVAL: Double = 5.0
let ENEMY_PLANE_MEDIUM_TIME_INTERVAL: Double = 10.0
let ENEMY_PLANE_HARD_TIME_INTERVAL: Double = 20.0
let MY_BULLET_TIME_INTERVAL: Double = 0.25
let ENEMY_BULLET_TIME_INTERVAL: Double = 1.5
let ENEMY_PLANE_FORCE_MAGNITUDE: CGFloat = 600.0
let MY_BULLET_IMPULSE_MAGNITUDE: CGFloat = 3.0
let ENEMY_BULLET_IMPULSE_MAGNITUDE: CGFloat = 1.0
let RECHARGE_TIME: Double = 10.0

// - MARK: Layer
struct Layer {
    static let enemyBullet: CGFloat = 1
    static let myBullet: CGFloat = 2
    static let enemyPlane: CGFloat = 3
    static let myPlane: CGFloat = 4
    static let uiComponent: CGFloat = 50
}

// - MARK: Category
struct Category {
    static let myPlane: UInt32 = 1
    static let myBullet: UInt32 = 2
    static let enemyPlane: UInt32 = 4
    static let enemyBullet: UInt32 = 8
}
