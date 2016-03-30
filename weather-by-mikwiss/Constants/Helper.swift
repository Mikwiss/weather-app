//
//  ViewConstants.swift
//  weather-by-mikwiss
//
//  Created by Mathieu Bret on 09/03/2016.
//  Copyright © 2016 Mikwiss. All rights reserved.
//

import Foundation

let DayCellIdentifier = "DayCell"
let HourCellIdentifier = "HourCell"

class CalendarHelper {
    static let Instance = CalendarHelper();
    
    static let SECONDS_PER_DAY : Int = 86400;
    
    static func dayOfWeek() -> Int? {
        
        if let date : NSDate = NSDate(), let cal : NSCalendar = NSCalendar.currentCalendar(), let comp : NSDateComponents = cal.components(.Weekday, fromDate: date) {
            return comp.weekday;
        }
        else
        {
            return nil
        }
    }
    
    static func hourOfDay() -> Int? {
        
        if let date : NSDate = NSDate(), let cal : NSCalendar = NSCalendar.currentCalendar(), let comp : NSDateComponents = cal.components(.Hour, fromDate : date) {
            return comp.hour;
        }
        else {
            return nil;
        }
    }
    
    static func hourOfDay(date : NSDate) -> Int? {
        
        if let cal : NSCalendar = NSCalendar.currentCalendar(), let comp : NSDateComponents = cal.components(.Hour, fromDate : date) {
            return comp.hour;
        }
        else {
            return nil;
        }
    }
    
    static func dayOfYear(date : NSDate) -> Int {
        let calendar = NSCalendar.currentCalendar();
        let day = calendar.ordinalityOfUnit(.Day, inUnit: .Year, forDate: date);
        
        return day;
    }
    
    static func convertHourDayIntoDayMoment(hour : Int) -> Int {
        var result = Int(ceil(Double(hour) / Double(3)));
        
        // Case midnight
        if result == 0 {
            result = 1;
        }
        return result;
    }
    
    static func getDayName(idDay : Int) -> String{
        switch idDay
        {
        case 0 :
            return "Aujourd'hui";
        case 1:
            return "Dimanche";
        case 2 :
            return "Lundi";
        case 3 :
            return "Mardi";
        case 4 :
            return "Mercredi";
        case 5 :
            return "Jeudi";
        case 6 :
            return "Vendredi";
        case 7 :
            return "Samedi";
        default :
            return "---";
        }
    }
    
    static func getHourName(idDay : Int) -> String{
        switch idDay
        {
        case 0 :
            return "Maintenant";
        case 1 :
            return "01h";
        case 2:
            return "04h";
        case 3 :
            return "07h";
        case 4 :
            return "10h";
        case 5 :
            return "13h";
        case 6 :
            return "16h";
        case 7 :
            return "19h";
        case 8 :
            return "22h";
        case 25 :
            return "22h";
        case 26 :
            return "01h";
        default :
            return "---";
        }
    }
    
    static func convertUTCTimeToDate(time : Int) -> NSDate {
        let date : NSDate = NSDate(timeIntervalSince1970: NSTimeInterval(time));

        return date;
    }
    
    static func convertUTCTimeToIndexDay(time : Int) -> Int {
        let date : NSDate = NSDate(timeIntervalSince1970: NSTimeInterval(time));
        
        return convertHourDayIntoDayMoment(hourOfDay(date)!);
    }
    
    static func isSameDay(date1 : Int, date2 : Int) -> Bool {
        let d1 = convertUTCTimeToDate(date1);
        let d2 = convertUTCTimeToDate(date2);
        
        return (dayOfYear(d1) == dayOfYear(d2));
    }

}

///
///
///
class WeatherHelpers {
    static let instance = WeatherHelpers();
    
    static func getFormattedTemperature(temp : Double, metric : String) -> String{
        if temp.isNaN
        {
            return "---°";
        }
        return "\(Int(round(temp)))°"
    }
    
    static func getFormattedPressure(pressure : Double, metric : String) -> String{
        if pressure.isNaN
        {
            return "--- hpa";
        }
        return "\(Int(round(pressure))) hpa"
    }
    
    static func getFormattedHumidity(humidity : Int, metric : String) -> String{
        if humidity == 0
        {
            return "--- %";
        }
        return "\(Int(humidity)) %"
    }
    
    static func getFormattedSpeed(speed : Double, metric : String) -> String{
        if speed.isNaN
        {
            return "--- m/s";
        }
        return "\(Int(round(speed))) m/s"
    }
}