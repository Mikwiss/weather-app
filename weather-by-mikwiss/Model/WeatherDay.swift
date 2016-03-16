//
//  WeatherDay.swift
//  weather-by-mikwiss
//
//  Created by Mathieu Bret on 16/03/2016.
//  Copyright © 2016 Mikwiss. All rights reserved.
//

import Foundation

class WeatherDay {
    
    ///
    /// MARK : properties
    ///
    private var _day : String!;
    private var _temp : Double!;
    private var _tempMax : Double!;
    private var _tempMin : Double!;
    private var _pressure : Int!;
    private var _humidity : Int!;
    private var _speed : Double!;
    private var _mainWeather : String!;
    
    ///
    /// MARK : init
    ///
    init()
    {
        
    }
    
    ///
    /// MARK : members
    ///
    var Day : String {
        get {
            return _day;
        }
        set(value)
        {
            _day = value;
        }
    }
    
    var Temp : Double {
        get {
            return _temp;
        }
        set(value)
        {
            _temp = value;
        }
    }
    
    var TempMax : Double {
        get {
            return _tempMax;
        }
        set(value)
        {
            _tempMax = value;
        }
    }
    
    var TempMin : Double {
        get {
            return _tempMin;
        }
        set(value)
        {
            _tempMin = value;
        }
    }
    
    var Pressure : Int {
        get {
            return _pressure;
        }
        set(value)
        {
            _pressure = value;
        }
    }
    
    var Humidity : Int {
        get {
            return _humidity;
        }
        set(value)
        {
            _humidity = value;
        }
    }
    
    var Speed : Double {
        get {
            return _speed;
        }
        set(value)
        {
            _speed = value;
        }
    }
    
    var MainWeather : String {
        get {
            return _mainWeather;
        }
        set(value)
        {
            _mainWeather = value;
        }
    }
    
    ///
    /// MARK : methods
    ///
}