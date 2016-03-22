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
    
    typealias downloadComplete = ([WeatherDay]) -> ();
    
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
            
            var resultWeather = [WeatherDay]();
            
            let result = response.result;
            
            print(".GET \(url) : \(result)");
            
            if (result.isSuccess)
            {
                print(result.value.debugDescription);
                
                if let dict = result.value as? Dictionary<String, AnyObject>
                {
                    if let listDay = dict["list"] as? [Dictionary<String, AnyObject>]
                    {
                        for var i = 0 ; i < listDay.count ; i++
                        {
                            let w = WeatherDay();
                            
                            if let date = listDay[i]["dt"] as? Int
                            {
                                w.Day = date;
                            }
                            
                            if let weather = listDay[i]["weather"] as? [Dictionary<String, AnyObject>]
                            {
                                if let id = weather[0]["id"] as? Int, let desc = weather[0]["description"] as? String
                                    
                                {
                                    w.MainWeather = Weather(id: id, desc: desc, main: "", icon: "");
                                }
                            }
                            
                            if let humidity = listDay[i]["humidity"] as? Int
                            {
                                w.Humidity = humidity;
                            }
                            
                            if let speed = listDay[i]["speed"] as? Double
                            {
                                w.Speed = speed;
                            }
                            
                            if let pressure = listDay[i]["pressure"] as? Double
                            {
                                w.Pressure = pressure;
                            }
                            
                            if let temps = listDay[i]["temp"] as? Dictionary<String, AnyObject>
                            {
                                if let currentTemp = temps["day"] as? Double{
                                    w.Temp = currentTemp;
                                }
                                
                                if let maxTemp = temps["max"] as? Double{
                                    w.TempMax = maxTemp;
                                }
                                
                                if let minTemp = temps["min"] as? Double{
                                    w.TempMin = minTemp;
                                }
                            }

                            resultWeather.append(w);
                        }
                    }
                }
            }
            
            completed(resultWeather);
        }
    }
}
