//
//  WeatherInfo.swift
//  BigAppleWeather
//
//  Created by Yukui Ye on 12/20/15.
//  Copyright © 2015 Yukui Ye. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherInfo: NSObject {
    let wid: NSNumber?
    let wmain: String?
    let wdescription: String?
    let wicon: String?
    
    required init?(json: SwiftyJSON.JSON) {
        print(json)
        
        self.wid = json[0]["id"].number!
        self.wmain = json[0]["main"].string!
        self.wdescription = json[0]["description"].string!
        self.wicon = json[0]["icon"].string!
    }
}


//"weather": [{
//"id": 800,
//"main": "Clear",
//"description": "sky is clear",
//"icon": "01d"
//}],
