//
//  Location.swift
//  Weather
//
//  Created by ABC on 2/12/17.
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
    
    init(with dictionary:(Dictionary<String, AnyObject>)) {
        
        guard let data = dictionary["data"] as? Dictionary<String, AnyObject> else {
            print("Data is invalid")
            return
        }
        
        if let requestFor = data["request"] as? [Dictionary<String, AnyObject>] {
            let queryDict = requestFor[0]
            let queryString = queryDict["query"] as! String
            let queryComponents = queryString.components(separatedBy: ", ")
            self.city = queryComponents.first
            self.country = queryComponents.last
        }
        
        if let currentCondition = data["current_condition"] as? [Dictionary<String, AnyObject>] {
            let currenConditionDict = currentCondition[0]
            self.currentWeatherCondition = WeatherData(with: currenConditionDict)
        }
        
        if let futureConditions = data["weather"] as? [Dictionary<String, AnyObject>] {
            self.futureWeatherConditions = [WeatherData]()
            for futureCondDict in futureConditions {
                let futureWeatherModel = WeatherData(with: futureCondDict)
                self.futureWeatherConditions?.append(futureWeatherModel)
            }
        }
    }
    
}
