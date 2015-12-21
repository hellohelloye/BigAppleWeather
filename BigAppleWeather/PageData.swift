//
//  PageData.swift
//  BigAppleWeather
//
//  Created by Yukui Ye on 12/20/15.
//  Copyright © 2015 Yukui Ye. All rights reserved.
//

import Foundation

class PageData: NSObject {
    var dayTime: String?
    var highTemp: NSNumber?
    var lowTemp: NSNumber?
    var wdescription: String?
    
    init(dayTime: String, highTemp: NSNumber, lowTemp: NSNumber, wdescription: String) {
        self.dayTime = dayTime
        self.highTemp = highTemp
        self.lowTemp = lowTemp
        self.wdescription = wdescription
    }
}