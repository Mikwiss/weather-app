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
    private var _day : Int!;
    private var _temp : Double!;
    private var _tempMax : Double!;
    private var _tempMin : Double!;
    private var _pressure : Double!;
    private var _humidity : Int!;
    private var _speed : Double!;
    private var _mainWeather : Weather!;
    
    ///
    /// MARK : init
    ///
    init()
    {
        _day = 0;
        _temp = Double.NaN;
        _tempMax = Double.NaN;
        _tempMin = Double.NaN;
        _pressure = Double.NaN;
        _speed = Double.NaN;
        _humidity = 0;
        _mainWeather = Weather(id: 0, desc: "---", main: "---", icon: "---");
    }
    
    ///
    /// MARK : members
    ///
    var Day : Int {
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
    
    var Pressure : Double {
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
    
    var MainWeather : Weather {
        get {
            return _mainWeather;
        }
        set(value)
        {
            _mainWeather = value;
        }
    }
}