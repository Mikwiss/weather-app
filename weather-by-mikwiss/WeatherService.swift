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
    private let urlDailyForCityID : String = "daily?id="
    private let urlWeatherForCityID : String = "weather?id="
    private let urlAPPID : String = "&APPID=";
    private let urlLanguage : String = "&lang=";
    private let urlUnitMetric : String = "&units=metric";
    
    private let fr : String = "fr"
    private let en : String = "en"
    
    typealias downloadComplete = ([WeatherDay]) -> ();
    typealias downloadCurrentWeatherComplete = (WeatherDay) -> ();
    typealias downloadForecastWeatherComplete = ([HourWeather]) -> ();
    
    ///
    /// MARK : Init
    ///
    init()
    {
        
    }
    
    ///
    /// MARK : Methods
    ///
    func getWeatherForecastDailyForCity(id : Int, completed : downloadComplete)
    {
        let url = NSURL(string: "\(urlBAse)\(urlData25)\(urlForecast)\(urlDailyForCityID)\(id)\(urlUnitMetric)\(urlLanguage)\(fr)\(urlAPPID)\(apiKey)")!;
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
                        for i in 0  ..< listDay.count 
                        {
                            let w = WeatherDay();
                            
                            if let date = listDay[i]["dt"] as? Int
                            {
                                w.TimeUTC = date;
                            }
                            
                            /*if let weather = listDay[i]["weather"] as? [Dictionary<String, AnyObject>]
                            {
                                if let id = weather[0]["id"] as? Int, let desc = weather[0]["description"] as? String
                                    
                                {
                                    w.MainWeather = Weather(id: id, desc: desc, main: "", icon: "");
                                }
                            }*/
                            
                            /*if let humidity = listDay[i]["humidity"] as? Int
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
                            }*/
                            
                            if let temps = listDay[i]["temp"] as? Dictionary<String, AnyObject>
                            {
                                /*if let currentTemp = temps["eve"] as? Double{
                                    w.Temp = currentTemp;
                                }*/
                                
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
    
    func getCurrentWeatherForCity(id : Int, completed : downloadCurrentWeatherComplete)
    {
        let url = NSURL(string: "\(urlBAse)\(urlData25)\(urlWeatherForCityID)\(id)\(urlUnitMetric)\(urlLanguage)\(fr)\(urlAPPID)\(apiKey)")!;
        Alamofire.request(.GET, url).responseJSON { response in
            
            let resultWeather = HourWeather();
            
            let result = response.result;
            
            print(".GET \(url) : \(result)");
            
            if (result.isSuccess)
            {
                print(result.value.debugDescription);
                
                if let dict = result.value as? Dictionary<String, AnyObject>
                {
                    if let date = dict["dt"] as? Int
                    {
                        resultWeather.TimeUTC = date;
                    }
                    
                    if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]
                    {
                        if let id = weather[0]["id"] as? Int, let desc = weather[0]["description"] as? String
                            
                        {
                            resultWeather.CurrentWeather = Weather(id: id, desc: desc, main: "", icon: "");
                        }
                    }
                    
                    if let wind = dict["wind"] as? Dictionary<String, AnyObject>
                    {
                        if let currentSpeed = wind["speed"] as? Double{
                            resultWeather.Speed = currentSpeed;
                        }
                    }
                    
                    if let currentWeather = dict["main"] as? Dictionary<String, AnyObject>
                    {
                        if let currentTemp = currentWeather["temp"] as? Double{
                            resultWeather.Temp = currentTemp;
                        }
                        
                        if let currentPressure = currentWeather["pressure"] as? Double{
                            resultWeather.Pressure = currentPressure;
                        }
                        
                        if let currentHumidity = currentWeather["humidity"] as? Int{
                            resultWeather.Humidity = currentHumidity;
                        }
                    }
                }
            }
            
            let weather : WeatherDay = WeatherDay();
            // Specified time
            weather.TimeUTC = resultWeather.TimeUTC;
            weather.appendHourWeather(0, hw: resultWeather);
            completed(weather);
        }
    }
    
    func getWeatherForecastWeatherForCity(id : Int, completed : downloadForecastWeatherComplete)
    {
        let url = NSURL(string: "\(urlBAse)\(urlData25)\(urlForecast)\(urlWeatherForCityID)\(id)\(urlUnitMetric)\(urlLanguage)\(fr)\(urlAPPID)\(apiKey)")!;
        Alamofire.request(.GET, url).responseJSON { response in
            
            var resultWeather = [HourWeather]();
            
            let result = response.result;
            
            print(".GET \(url) : \(result)");
            
            if (result.isSuccess)
            {
                print(result.value.debugDescription);
                
                if let dict = result.value as? Dictionary<String, AnyObject>
                {
                    if let listHourWeather = dict["list"] as? [Dictionary<String, AnyObject>]
                    {
                        for i in 0  ..< listHourWeather.count
                        {
                            let w = HourWeather();
                            
                            if let date = listHourWeather[i]["dt"] as? Int
                            {
                                w.TimeUTC = date;
                            }
                            
                            if let main = listHourWeather[i]["main"] as? Dictionary<String, AnyObject>
                            {
                                if let temp = main["temp"] as? Double{
                                    w.Temp = temp;
                                }
                                
                                if let pressure = main["pressure"] as? Double{
                                    w.Pressure = pressure;
                                }
                                
                                if let humidity = main["humidity"] as? Int{
                                    w.Humidity = humidity;
                                }
                            }
                        
                            if let wind = listHourWeather[i]["wind"] as? Dictionary<String, AnyObject>
                            {
                                if let speed = wind["speed"] as? Double{
                                    w.Speed = speed;
                                }
                            }
                            
                            if let weather = listHourWeather[i]["weather"] as? [Dictionary<String, AnyObject>]
                            {
                                if let id = weather[0]["id"] as? Int, let desc = weather[0]["description"] as? String
                                    
                                {
                                    w.CurrentWeather = Weather(id: id, desc: desc, main: "", icon: "");
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
