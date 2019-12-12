//
//  timeString.swift
//  1971
//
//  Created by Mobioapp on 12/12/19.
//  Copyright © 2019 Mobioapp. All rights reserved.
//

import Foundation
@objcMembers class Converter: NSObject {
    
    static var sharedManager: Converter?
    
    @discardableResult
    static func shared() -> Converter {
        if sharedManager == nil {
            sharedManager = Converter()
        }
        return sharedManager!
    }
    
    static func timeString(time: TimeInterval) -> String {
       // let hour = Int(time) / 3600
        let minute = Int(time) / 60 % 60
        let second = Int(time) % 60

        // return formated string
        return String(format: "%02i:%02i", minute, second)
    }
    
}

