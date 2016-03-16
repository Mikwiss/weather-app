//
//  WeatherService.swift
//  weather-by-mikwiss
//
//  Created by Mathieu Bret on 16/03/2016.
//  Copyright © 2016 Mikwiss. All rights reserved.
//

import Foundation
import Alamofire

class WeatherService {
    
    ///
    /// MARK : Properties
    ///
    private let apiKey : String = "8919a910467221c964821b0dd40f7916";
    private let urlBAse : String = "http://api.openweathermap.org/";
    private let urlData25 : String = "data/2.5/"
    private let urlForecast : String = "forecast/"
    private let urlWeatherForCityID : String = "daily?id="
    private let urlAPPID : String = "&APPID=";
    private let urlLanguage : String = "&lang=";
    private let urlUnitMetric : String = "&units=metric";
    
    private let fr : String = "fr"
    
    typealias downloadComplete = () -> ();
    
    ///
    /// MARK : Init
    ///
    init()
    {
        
    }
    
    ///
    /// MARK : Methods
    ///
    func getWeatherForCity(id : Int, completed : downloadComplete)
    {
        let url = NSURL(string: "\(urlBAse)\(urlData25)\(urlForecast)\(urlWeatherForCityID)\(id)\(urlUnitMetric)\(urlLanguage)\(fr)\(urlAPPID)\(apiKey)")!;
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result;
            print(".GET \(url) : \(result)");
            if (result.isSuccess)
            {
                
            }
        }
    }
}
