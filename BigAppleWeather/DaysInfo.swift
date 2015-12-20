//
//  DaysInfo.swift
//  BigAppleWeather
//
//  Created by Yukui Ye on 12/20/15.
//  Copyright © 2015 Yukui Ye. All rights reserved.
//

import Foundation
import SwiftyJSON

class DaysInfo: NSObject {
    let temp: NSNumber?
    let temp_min: NSNumber?
    let temp_max: NSNumber?
    let pressure: NSNumber?
    let sea_level: NSNumber?
    let grnd_level: NSNumber?
    let humidity: NSNumber?
    let temp_kf: NSNumber?
    let weather: WeatherInfo?
    let cloudsAll: NSNumber?
    let windSpeed: NSNumber?
    let windDeg: NSNumber?
    //  let rain: NSNumber?
    let sysPod: String?
    let dt_txt: String?
    
    required init?(json: SwiftyJSON.JSON) {
        print(json)
        self.temp = json["main"]["temp"].number!
        self.temp_min = json["main"]["temp_min"].number!
        self.temp_max = json["main"]["temp_max"].number!
        self.pressure = json["main"]["pressure"].number!
        self.sea_level = json["main"]["sea_level"].number!
        self.grnd_level = json["main"]["grnd_level"].number!
        self.humidity = json["main"]["humidity"].number!
        self.temp_kf = json["main"]["temp_kf"].number!
        
        self.weather = WeatherInfo.init(json: json["weather"])
        
        self.cloudsAll = json["clouds"]["all"].number!
        self.windSpeed = json["wind"]["speed"].number!
        self.windDeg = json["wind"]["deg"].number!
        
        // self.rain = json["rain"].number!
        self.sysPod = json["sys"]["pod"].string
        self.dt_txt = json["dt_txt"].string
    }
}


//"list": [{
//"dt": 1449262800,
//"main": {
//"temp": 282.95,
//"temp_min": 281.935,
//"temp_max": 282.95,
//"pressure": 1040.1,
//"sea_level": 1043.9,
//"grnd_level": 1040.1,
//"humidity": 76,
//"temp_kf": 1.02
//},
//"weather": [{
//"id": 800,
//"main": "Clear",
//"description": "sky is clear",
//"icon": "01d"
//}],
//"clouds": {
//"all": 0
//},
//"wind": {
//"speed": 2.85,
//"deg": 283.507
//},
//"rain": {},
//"sys": {
//"pod": "d"
//},
//"dt_txt": "2015-12-04 21:00:00"
//}
//]