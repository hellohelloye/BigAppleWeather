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
                        self.createHighLowWeatherPage(self.dataHelper)
                        
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
    
    func createHighLowWeatherPage(arrayWeathers: NSArray) {
        let day1 = NSMutableArray()
        let day2 = NSMutableArray()
        let day3 = NSMutableArray()
        let day4 = NSMutableArray()
        let day5 = NSMutableArray()
        let day6 = NSMutableArray()
        
        for object in arrayWeathers  {
            let weather = object as! DaysInfo
            let weatherTime: NSString = weather.dt_txt! as NSString
            print(weatherTime)
            let dayValue = weatherTime.substringWithRange(NSRange(location: 0, length: 10))
            print(dayValue)
            
            if dayValue == "2015-12-04" {
                day1.addObject(weather)
                
            } else if dayValue == "2015-12-05" {
                day2.addObject(weather)
                
            } else if dayValue == "2015-12-06" {
                day3.addObject(weather)
                
            } else if dayValue == "2015-12-07" {
                day4.addObject(weather)
                
            } else if dayValue == "2015-12-08" {
                day5.addObject(weather)
                
            } else if dayValue == "2015-12-09" {
                day6.addObject(weather)
            }
        }
        
        self.dataObjects.addObject( self.generateNewPage(day1) )
        self.dataObjects.addObject( self.generateNewPage(day2) )
        self.dataObjects.addObject( self.generateNewPage(day3) )
        self.dataObjects.addObject( self.generateNewPage(day4) )
        self.dataObjects.addObject( self.generateNewPage(day5) )
        self.dataObjects.addObject( self.generateNewPage(day6) )
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