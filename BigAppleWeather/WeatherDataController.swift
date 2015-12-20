//
//  WeatherDataController.swift
//  BigAppleWeather
//
//  Created by Yukui Ye on 12/20/15.
//  Copyright © 2015 Yukui Ye. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Alamofire

class WeatherDataController {
    var dataObjects = NSMutableArray()
    
    func endpointForFeed() -> String {
        let endpoint = "http://gwen.nyc/nypl/forecast.json"
        return endpoint
    }
    
    func loadQuoteItems(completionHandler: (NSMutableArray?) -> ()) -> () {
        Alamofire.request(.GET, self.endpointForFeed()).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    let cityInformation = CityInfo.init(json: json["city"])
                    print("cityInfo: \(cityInformation!)")
                    
                    if let daysInfos = json["list"].array {
                        for day in daysInfos {
                            let dayInfo = DaysInfo.init(json: day)
                            self.dataObjects.addObject(dayInfo!)
                        }
                        print("day weather: \(self.dataObjects)")
                    }
                }
            case .Failure(let error):
                print(error)
            }
            completionHandler(self.dataObjects)
        }
    }
    
    func indexOfWeatherData(day: DaysInfo) -> Int {
        return self.dataObjects.indexOfObject(day)
    }
    
    func dayInfoAtIndex(index: Int) -> DaysInfo? {
        if (index < 0 || index > dataObjects.count - 1) {
            return nil
        }
        return dataObjects[index] as? DaysInfo
    }
}