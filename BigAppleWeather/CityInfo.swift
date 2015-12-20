//
//  CityInfo.swift
//  BigAppleWeather
//
//  Created by Yukui Ye on 12/20/15.
//  Copyright © 2015 Yukui Ye. All rights reserved.
//

import Foundation
import SwiftyJSON

class CityInfo: NSObject {
    let name: String?
    let coord: String?
    let country: String?
    let population: String?
    
    required init?(json: SwiftyJSON.JSON) {
        print(json)
        self.name = json["name"].string
        self.coord = json["coord"].string
        self.country = json["country"].string
        self.population = json["population"].string
    }
}

//"city": {
//    "id": 5128581,
//    "name": "New York",
//    "coord": {
//        "lon": -74.005966,
//        "lat": 40.714272
//    },
//    "country": "US",
//    "population": 0,
//    "sys": {
//        "population": 0
//    }
//},