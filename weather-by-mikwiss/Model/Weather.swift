//
//  Weather.swift
//  weather-by-mikwiss
//
//  Created by Mathieu Bret on 17/03/2016.
//  Copyright © 2016 Mikwiss. All rights reserved.
//

import Foundation

class Weather {
    
    ///
    /// MARK : properties
    ///
    private var _id : Int;
    private var _desc : String;
    private var _main : String;
    private var _icon : String;
    
    ///
    /// MARK : Init
    ///
    init()
    {
        _id = 0;
        _desc = "";
        _main = "";
        _icon = "";
    }
    
    init(id : Int, desc : String, main : String, icon : String)
    {
        _id = id;
        _desc = desc;
        _main = main;
        _icon = icon;
    }
    
    ///
    /// MARK : members
    ///
    var Description : String{
        get{
            return _desc;
        }
    }
    
    var Id : Int{
        get{
            return _id;
        }
    }

    var Icon : String{
        get{
            switch _id {
            /*case 200..<299 :
                return "thunderstorm";
            case 300..<399 :
                return "drizzle";*/
            case 500, 501 :
                return "PartlyRainySun";
            case 502..<504 :
                return "Rain";
            case 504..<531 :
                return "ShowerRain";
            /*case 600..<699 :
                return "snow";
            case 700..<799 :
                return "atmosphere";*/
            case 800 :
                return "Clear";
            case 801 :
                return "CloudySun";
            case 802, 803 :
                return "Clouds";
            case 804..<810 :
                return "OvercastClouds";
            /*case 900..<909 :
                return "extreme";*/
            default :
                return "None";
            }
        }
    }

}
