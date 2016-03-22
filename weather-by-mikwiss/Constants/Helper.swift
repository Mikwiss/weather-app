//
//  ViewConstants.swift
//  weather-by-mikwiss
//
//  Created by Mathieu Bret on 09/03/2016.
//  Copyright © 2016 Mikwiss. All rights reserved.
//

import Foundation

let MomentCellIdentifier = "MomentCell"

class CalendarHelper {
    static let Instance = CalendarHelper();
    
    static func dayOfWeek() -> Int? {
        
        if let date : NSDate = NSDate(), let cal : NSCalendar = NSCalendar.currentCalendar(), let comp : NSDateComponents = cal.components(.Weekday, fromDate: date) {
            return comp.weekday;
        }
        else
        {
            return nil
        }
    }
    
    static func GetDayName(idDay : Int) -> String{
        switch idDay
        {
        case 0 :
            return "Today";
        case 1:
            return "Sunday";
        case 2 :
            return "Monday";
        case 3 :
            return "Tuesday";
        case 4 :
            return "Wednesday";
        case 5 :
            return "Thursday";
        case 6 :
            return "Friday";
        case 7 :
            return "saturday";
        default :
            return "---";
        }
    }
}

///
///
///
class WeatherHelpers {
    static let instance = WeatherHelpers();
    
    static func GetFormattedTemperature(temp : Double, metric : String) -> String{
        if temp.isNaN
        {
            return "---°";
        }
        return "\(Int(round(temp)))°"
    }
    
    static func GetFormattedPressure(pressure : Double, metric : String) -> String{
        if pressure.isNaN
        {
            return "--- hpa";
        }
        return "\(Int(round(pressure))) hpa"
    }
    
    static func GetFormattedHumidity(humidity : Int, metric : String) -> String{
        if humidity == 0
        {
            return "--- %";
        }
        return "\(Int(humidity)) %"
    }
    
    static func GetFormattedSpeed(speed : Double, metric : String) -> String{
        if speed.isNaN
        {
            return "--- m/s";
        }
        return "\(Int(round(speed))) m/s"
    }
}