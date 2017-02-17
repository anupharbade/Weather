//
//  ViewController.swift
//  Weather
//
//  Created by ABC on 2/12/17.
//  Copyright © 2017 GUM. All rights reserved.
//

import UIKit

class WeatherHomeViewController: UIViewController {
    
    var weatherDataProvider = WeatherDataProviderService()
    var weatherData : Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getWeatherData(location:"Dallas,Texas")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getWeatherData(location:String?) {
        
        self.weatherDataProvider = WeatherDataProviderService()
        self.weatherDataProvider.getWeatherData(location) { (location, error) in
            
            guard error != nil else {
                print("Error received while fetching the weather data")
                //!Show error here
                return
            }
            
            self.weatherData = location
            //!update the UI here
        }
    }
}
