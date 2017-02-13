//
//  ViewController.swift
//  Weather
//
//  Created by Alex Stuart on 2/12/17.
//  Copyright © 2017 GUM. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherHomeViewController: UIViewController, CLLocationManagerDelegate {
    
    var currentLocation: CLLocation?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getWeatherData(placemark:CLPlacemark) -> Location? {
        
        var currentLocationData: Location?
        
        if let url = self.getURLForTheLocation(placemark) {
            
            Alamofire.request(url).responseJSON { response in
                print(response.request ?? "Empty request")  // original URL request
                print(response.response ?? "Empty response") // HTTP URL response
                print(response.data ?? "Empty data")     // server data
                print(response.result)   // result of response serialization
                
                if let JSONDict = response.result.value {
                    //!Parse the json in Model
                    currentLocationData = Location(with: (JSONDict as! Dictionary))
                    
                    if currentLocationData != nil {
                        //!Update the UI here
                    } else {
                        //!Read from the cache
                    }
                }
            }
        } else {
            print("URL creation failed.")
        }
    
        return currentLocationData
    }
    
    func getURLForTheLocation(_ placemark: CLPlacemark) -> String? {
        let apiKey = "e7853ce9e4c64428b2b211259171202"
        let baseURL = "https://api.worldweatheronline.com/premium/v1/weather.ashx?"
        var query = ""
        if (placemark.locality != nil && placemark.administrativeArea != nil) {
            query = placemark.locality! + placemark.administrativeArea!
        }
        
        let numberOfDays = 5
        
        if query.isEmpty == false {
            return baseURL+"key=\(apiKey)&q=\(query)&format=json&num_of_days=\(numberOfDays)"
        } else {
            return nil;
        }
        
    }
    
    func startLocationManager() {
        locationManager.delegate = self
        locationManager.distanceFilter = 20.0 //!We will consider movement of 20 miles to update the weather
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (!locations.isEmpty) {
            self.currentLocation = locations.last
            
            if self.currentLocation != nil  {
                CLGeocoder().reverseGeocodeLocation(self.currentLocation!, completionHandler: { (placemarks, error) in
                    if (error != nil && placemarks != nil) {
                        let placemark = (placemarks?.last)
                        
                        if placemark != nil {
                            if let location = self.getWeatherData(placemark: placemark!) {
                               //!Update UI here
                                
                            }
                        }
                    }
                })
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }

    
    /**
     - (void)viewDidLoad
     {
     // this creates the CCLocationManager that will find your current location
     CLLocationManager *locationManager = [[[CLLocationManager alloc] init] autorelease];
     locationManager.delegate = self;
     locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
     [locationManager startUpdatingLocation];
     }
     
     // this delegate is called when the app successfully finds your current location
     - (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
     {
     // this creates a MKReverseGeocoder to find a placemark using the found coordinates
     MKReverseGeocoder *geoCoder = [[MKReverseGeocoder alloc] initWithCoordinate:newLocation.coordinate];
     geoCoder.delegate = self;
     [geoCoder start];
     }
     
     // this delegate method is called if an error occurs in locating your current location
     - (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
     {
     NSLog(@"locationManager:%@ didFailWithError:%@", manager, error);
     }
     
     // this delegate is called when the reverseGeocoder finds a placemark
     - (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
     {
     MKPlacemark * myPlacemark = placemark;
     // with the placemark you can now retrieve the city name
     NSString *city = [myPlacemark.addressDictionary objectForKey:(NSString*) kABPersonAddressCityKey];
     }
     
     // this delegate is called when the reversegeocoder fails to find a placemark
     - (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
     {
     NSLog(@"reverseGeocoder:%@ didFailWithError:%@", geocoder, error);
     }
     */
}
