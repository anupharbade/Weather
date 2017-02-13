//
//  Location.swift
//  Weather
//
//  Created by Alex Stuart on 2/12/17.
//  Copyright © 2017 GUM. All rights reserved.
//

import Foundation


class Location {
    
    var city: String?
    var state: String?
    var country: String?
    
    var latitude: Float?
    var longitude: Float?
    
    var currentWeatherCondition: WeatherData?
    var futureWeatherConditions: [WeatherData]?
    
    init(with dictionary:(Dictionary<String, Any>?)) {
        
        
    }
    
}
