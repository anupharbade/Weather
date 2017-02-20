//
//  WeatherData.swift
//  Weather
//
//  Created by Alex Stuart on 2/12/17.
//  Copyright © 2017 GUM. All rights reserved.
//

import Foundation

class WeatherData {
    
    var tempC: String?
    var tempF: String?
    
    var feelsLikeTempC: String?
    var feelsLikeTempF: String?
    
    var maxTempC: String?
    var maxTempF: String?
    
    var minTempC: String?
    var minTempF: String?
    
    
    var date: String?
    var description: String?
    var iconURL: String?
    
    init(with dictionary:Dictionary<String, Any>) {
        
        tempC = dictionary["temp_C"] as! String?
        tempF = dictionary["temp_F"] as! String?
        
        feelsLikeTempC = dictionary["FeelsLikeC"] as! String?
        feelsLikeTempF = dictionary["FeelsLikeF"] as! String?
        
        maxTempC = dictionary["maxtempC"] as! String?
        maxTempF = dictionary["maxtempF"] as! String?
        
        minTempC = dictionary["mintempC"] as! String?
        minTempF = dictionary["mintempF"] as! String?
        
        date = dictionary["date"] as! String?
        
        
        if let weatherDescs = dictionary["weatherDesc"] as! [Dictionary<String, String>]? {
            if weatherDescs.count > 0 {
                let weatherDescDict = weatherDescs[0]
                description = weatherDescDict["value"]
            }
        }
        
        if let iconURLs = dictionary["weatherIconUrl"] as! [Dictionary<String, String>]? {
            if iconURLs.count > 0 {
                let iconURLDict = iconURLs[0]
                iconURL = iconURLDict["value"]
            }
        }
    }
    
}




