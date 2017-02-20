//
//  ViewController.swift
//  Weather
//
//  Created by ABC on 2/12/17.
//  Copyright © 2017 GUM. All rights reserved.
//

import UIKit

class WeatherHomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //!Properties
    var weatherDataProvider = WeatherDataProviderService()
    var weatherData : Location?
    
    //!Outlets
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherLabel: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    fileprivate let itemsPerRow = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "WeatherCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "WeatherCellID")
        self.getWeatherData(location:"Dallas,Texas")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getWeatherData(location:String?) {
        
        self.weatherDataProvider = WeatherDataProviderService()
        self.weatherDataProvider.getWeatherData(location) { (location, error) in
            guard error == nil else {
                print("Error received while fetching the weather data")
                //!Show error here
                return
            }

            self.weatherData = location
            
            self.locationLabel.text = self.locationString
            
            if let description = self.weatherData?.currentWeatherCondition?.description {
                self.descriptionLabel.text = description
            }else {
                self.descriptionLabel.text = ""
            }
            
            if let currentWeather = self.weatherData?.currentWeatherCondition?.tempC {
                self.currentWeatherLabel.setTitle(currentWeather, for: UIControlState.normal)
            }else {
                self.currentWeatherLabel.setTitle("", for: UIControlState.normal)
            }
            
            self.collectionView.reloadData()
            
        }
    }
    
    var locationString : String {
        get {
            if (self.weatherData?.city != nil) {
                return (self.weatherData?.city)!
            } else {
                return "NA"
            }
        }
    }
    
    //!Collection view delegate & data source methods
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellID = "WeatherCellID"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! WeatherCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsPerRow;
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let weatherCondition = self.weatherData?.futureWeatherConditions?[indexPath.row] {
            let cell = cell as! WeatherCollectionViewCell
            
            cell.maxDayTemp.text = weatherCondition.maxTempC
            cell.minDayTemp.text = weatherCondition.minTempC
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = Double(sectionInsets.left) * Double(itemsPerRow + 1)
        let availableWidth = Double(view.frame.width) - paddingSpace
        let widthPerItem = availableWidth / Double(itemsPerRow)
        
        return CGSize(width: CGFloat(widthPerItem), height: self.collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

