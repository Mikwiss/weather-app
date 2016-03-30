//
//  HourWeather.swift
//  weather-by-mikwiss
//
//  Created by Mathieu Bret on 27/03/2016.
//  Copyright © 2016 Mikwiss. All rights reserved.
//

import Foundation

class HourWeather {
 
    ///
    /// MARK : properties
    ///
    private var _timeUTC : Int!;
    private var _temp : Double!;
    private var _pressure : Double!;
    private var _humidity : Int!;
    private var _speed : Double!;
    private var _weather : Weather!;
    
    ///
    /// MARK : init
    ///
    init()
    {
        _timeUTC = 0;
        _temp = Double.NaN;
        _pressure = Double.NaN;
        _speed = Double.NaN;
        _humidity = 0;
        _weather = Weather(id: 0, desc: "---", main: "---", icon: "---");
    }
    
    ///
    /// MARK : members
    ///
    var Hour : Int {
        get {
            return 0;
        }
    }
    
    var TimeUTC : Int {
        get {
            return _timeUTC;
        }
        set(value)
        {
            _timeUTC = value;
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
    
    var CurrentWeather : Weather {
        get {
            return _weather;
        }
        set(value)
        {
            _weather = value;
        }
    }
}