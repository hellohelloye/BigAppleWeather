//
//  SinglePageViewController.swift
//  BigAppleWeather
//
//  Created by Yukui Ye on 12/20/15.
//  Copyright © 2015 Yukui Ye. All rights reserved.
//

import Foundation
import UIKit

class SinglePageViewController: UIViewController {
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var high_temp: UILabel!
    @IBOutlet var low_temp: UILabel!
    @IBOutlet var time: UILabel!
    
   // var dayWeatherInfo: DaysInfo?
    var dayWeatherInfo: PageData?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        print("day info \(dayWeatherInfo!)")
//        time.text = dayWeatherInfo!.dt_txt!
//        high_temp.text = "High Temperature \(dayWeatherInfo!.temp_min!)"
//        low_temp.text = "Low Temperature \(dayWeatherInfo!.temp_max!)"
        
        time.text = dayWeatherInfo!.dayTime
        high_temp.text = "High Temperature \(dayWeatherInfo!.highTemp!)"
        low_temp.text = "Low Temperature \(dayWeatherInfo!.lowTemp!)"
        weatherLabel.text = dayWeatherInfo!.wdescription
    }
}