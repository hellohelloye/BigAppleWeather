//
//  WeatherPageViewController.swift
//  BigAppleWeather
//
//  Created by Yukui Ye on 12/20/15.
//  Copyright © 2015 Yukui Ye. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    let dataController = WeatherDataController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let placeholderVC = storyboard.instantiateViewControllerWithIdentifier("PlaceHolderViewController")
        self.setViewControllers([placeholderVC], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        
        dataController.loadQuoteItems{ (data) in
            if data == nil
            {
                let alert = UIAlertController(title: "Error", message: "Could not load quotes)", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                
                
            } else {
                // set first view controller to display
                if let firstVC = self.viewControllerAtIndex(0) {
                    let viewControllers = [firstVC]
                    self.setViewControllers(viewControllers, direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
                }
            }
        }
    }
    
    // MARK: UIPageViewControllerDataSource & UIPageViewControllerDelegate
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let currentPageViewController = viewController as? SinglePageViewController, currentDayWeather:DaysInfo = currentPageViewController.dayWeatherInfo {
            let currentIndex = dataController.indexOfWeatherData(currentDayWeather)
            return viewControllerAtIndex(currentIndex - 1)
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let currentPageViewController = viewController as? SinglePageViewController, currentDayWeather:DaysInfo = currentPageViewController.dayWeatherInfo {
            let currentIndex = dataController.indexOfWeatherData(currentDayWeather)
            return viewControllerAtIndex(currentIndex + 1)
        }
        return nil
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        if let dayWeather = dataController.dayInfoAtIndex(index) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("SinglePageViewController") as! SinglePageViewController
            vc.dayWeatherInfo = dayWeather
            return vc
        }
        return nil
    }
}