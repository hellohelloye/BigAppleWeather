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
    var dataHelper = NSMutableArray()
    
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
                            self.dataHelper.addObject(dayInfo!)
                        }
                       
                        //Algorithm for caculating the entire day's high and low temperature.
                        self.createHighLowWeatherPage(self.dataHelper, uniqueDaysArray: self.uniqueDays(self.dataHelper))
                        
                        print("day weather: \(self.dataObjects)")
                    }
                }
            case .Failure(let error):
                print(error)
            }
            completionHandler(self.dataObjects)
        }
    }
    
    func indexOfWeatherData(day: PageData) -> Int {
        return self.dataObjects.indexOfObject(day)
    }
    
    func dayInfoAtIndex(index: Int) -> PageData? {
        if (index < 0 || index > dataObjects.count - 1) {
            return nil
        }
        return dataObjects[index] as? PageData
    }
    
    //My Algorithm to showing one screen *per day* with the high and low temperature for the Entire day,
    // NOT one screen for every temperature entry in the feed.
    
    func createHighLowWeatherPage(arrayWeathers: NSArray, uniqueDaysArray: NSArray) {
        let daysArray = NSMutableArray()
        
        for dayString in uniqueDaysArray {
            for object in arrayWeathers  {
                let weather = object as! DaysInfo
                let weatherTime: NSString = weather.dt_txt! as NSString
                print(weatherTime)
                let dayValue = weatherTime.substringWithRange(NSRange(location: 0, length: 10))
                print(dayValue)
                
                if dayValue == dayString as! String {
                    daysArray.addObject(weather)
                }
            }
            
            self.dataObjects.addObject( self.generateNewPage(daysArray) )
        }
    }
    
    func uniqueDays(weatherArray: NSArray) -> NSArray {
        let daysArray = NSMutableArray()
        for object in weatherArray  {
            let weather = object as! DaysInfo
            let weatherTime: NSString = weather.dt_txt! as NSString
            print(weatherTime)
            let dayValue = weatherTime.substringWithRange(NSRange(location: 0, length: 10))
            print(dayValue)
            
            daysArray.addObject(dayValue);
        }

        let unique = NSMutableArray()
        let processedSet = NSMutableSet()
        for object in daysArray {
            if (!processedSet.containsObject(object)) {
                unique.addObject(object)
                processedSet.addObject(object)
            }
        }
        
        return unique
    }
    
    func generateNewPage(daysArray: NSArray) -> PageData {
        let newPage = PageData(dayTime: "", highTemp: 0, lowTemp: 0, wdescription: "")
        var dayValue = ""
        var weatherDescription = ""
        var maxTemp: NSNumber = 0;
        var minTemp: NSNumber = 10000;
        
        for object in daysArray {
            let weather = object as! DaysInfo
            
            if (weather.temp_max!.intValue > maxTemp.intValue) {
                maxTemp = weather.temp_max!
            }
            if (weather.temp_min!.intValue < minTemp.intValue) {
                minTemp = weather.temp_min!
            }
            
            let weatherTime: NSString = weather.dt_txt! as NSString
            print(weatherTime)
            dayValue = weatherTime.substringWithRange(NSRange(location: 0, length: 10))
            weatherDescription = weather.weather!.wdescription!
        }
        
        newPage.dayTime = dayValue
        newPage.highTemp = maxTemp
        newPage.lowTemp = minTemp
        newPage.wdescription = weatherDescription
        return newPage
    }
}