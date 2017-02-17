//
//  WeatherDataProviderService.swift
//  Weather
//
//  Created by Alex Stuart on 2/14/17.
//  Copyright © 2017 GUM. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherDataProviderService {
    
    var dataTask = URLSessionDataTask()
    
    func getWeatherData(_ location:String?, _ completionHandler:@escaping (_ weatherData:Location?, _ error:String?) -> ()) {
        
        guard let request = self.createRequest(location) else {
            completionHandler(nil, "Failed to create the request")
            return
        }
        
        self.dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {
                completionHandler(nil, "No data received for the location.")
                return
            }
            
            //parse the data now into Location objects
            if let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject] {
                guard let jsonData = jsonData else {
                    completionHandler(nil, "Failed to parse the weather data")
                    return
                }
                
                let currentLocation = Location(with: jsonData)
                completionHandler(currentLocation, nil)
            }
            
        }
        
        self.dataTask.resume()
    }
    
    fileprivate func createRequest(_ location:String?) -> URLRequest? {
        
        guard let urlString = self.getURLString(location) else {
            print("Invalid URL String")
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL is received. Can not move ahead with the request.")
            return nil
        }
        
        return URLRequest(url: url)
    }
    
    
    fileprivate func getURLString(_ location: String?) -> String? {
        
        guard let location = location else {
            print("Can not generate the URL for the empty location.")
            return nil
        }
        
        let apiKey = "e7853ce9e4c64428b2b211259171202"
        let numberOfDays = 5
        let baseURL = "https://api.worldweatheronline.com/premium/v1/weather.ashx?"
        
        guard (location.isEmpty == false) else {
            print("Invalid or no location in input.")
            return nil
            
        }
        
        return baseURL+"key=\(apiKey)&q=\(location)&format=json&num_of_days=\(numberOfDays)"
    }
}
