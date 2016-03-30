//
//  MainViewController.swift
//  weather-by-mikwiss
//
//  Created by Mathieu Bret on 24/02/2016.
//  Copyright © 2016 Mikwiss. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // TODO LIST :
    // 1) GO to day 2 to 22H
    // Go to TODAY CRASH
    // 2) When hour index to today != hour index tomorrow
    // 3) start disappear when scroll began
    // 4) round
    // 5) rename WeatherDay to DayWeather
    
    // 6 ) DO IT with object to two collectionview

    ///
    /// MARK : properties
    ///
    private var _days : [Int]!;
    private var _hoursDay : [Int]!;
    private var _weathers : [WeatherDay]!;
    private var _weatherService : WeatherService!;
    
    private var _dayIndex : Int = 0;
    private var _hourIndex : Int = 0;
    
    private let _numberOfDay = 7;
    
    ///
    /// MARK : outlets
    ///
    @IBOutlet weak var dayCollectionView: UICollectionView!;
    @IBOutlet weak var hourCollectionView: UICollectionView!
    @IBOutlet weak var MainWeatherView: UIStackView!
    @IBOutlet weak var temp : UILabel!;
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    
    ///
    /// MARK: Init
    ///
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    ///
    /// MARK : Members
    ///
    var hourIndex : Int {
        get{
            return _hourIndex;
        }
        set (newIndex) {
            if newIndex < 0 {
                _hourIndex = 0;
            }
            else {
                _hourIndex = newIndex;
            }
        }
    }
    
    var dayIndex : Int {
        get{
            return _dayIndex;
        }
        set (newIndex) {
            if newIndex < 0 {
                _dayIndex = 0;
            }
            else {
                _dayIndex = newIndex;
            }
        }
    }

    ///
    /// MARK : View
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _days = [Int]();
        _hoursDay = [Int]();
        
        dayCollectionView.registerNib(UINib(nibName: "MomentViewCell", bundle: nil), forCellWithReuseIdentifier: DayCellIdentifier);
        hourCollectionView.registerNib(UINib(nibName: "MomentViewCell", bundle: nil), forCellWithReuseIdentifier: HourCellIdentifier);
        
        dayCollectionView.delegate = self;
        hourCollectionView.delegate = self;
        dayCollectionView.dataSource = self;
        hourCollectionView.dataSource = self;
        dayCollectionView.pagingEnabled = true;
        hourCollectionView.pagingEnabled = true;
        
        _weatherService = WeatherService();
    }
    
    override func viewDidAppear(animated: Bool) {
        
        initData()
        
        let id : Int = 3031582;
        // BDX :3031582
        // Miossens :2993778
        
        //  Get current weather
        _weatherService.getCurrentWeatherForCity(id, completed:  { (weather : WeatherDay) in
            
            // Append first day
            self._weathers.append(weather);
            
            self.SetData(self._weathers[self._dayIndex], hour: self._hourIndex);
            
            // Get daily weather
            self._weatherService.getWeatherForecastDailyForCity(id, completed:  { (daysWeather : [WeatherDay]) -> () in
                //After download
                if (daysWeather.count > 0)
                {
                    // Add week day
                    for i in 1 ..< daysWeather.count {
                        self._weathers.append(daysWeather[i]);
                    }
                    
                    // Update daily value
                    self._weathers[0].TempMax = daysWeather[0].TempMax;
                    self._weathers[0].TempMin = daysWeather[0].TempMin;
                    
                    self.setDayData(self._weathers[self._dayIndex]);

                    // Gat all data
                    self._weatherService.getWeatherForecastWeatherForCity(id, completed: { (hourWeather : [HourWeather]) in
                        for i in 0 ..< hourWeather.count {
                            for j in 0 ..< self._weathers.count {
                                if CalendarHelper.isSameDay(hourWeather[i].TimeUTC, date2: self._weathers[j].TimeUTC)
                                {
                                    //print(j)
                                    self._weathers[j].appendHourWeather(CalendarHelper.convertUTCTimeToIndexDay(hourWeather[i].TimeUTC), hw: hourWeather[i]);
                                    //self._weathers[j].appendHourWeather(hourWeather[i]);
                                }
                            }
                        }
                        
                        // Update if user change index before callback
                        //self.SetData(self._weathers[self._dayIndex], hour: self._hourIndex);
                    })
                    
                }
           });
        });
    }

    ///
    /// MARK : Methods
    ///
    private func initData()
    {
        _weathers = [WeatherDay]();
        
        // Init display with : ---°
        SetData(WeatherDay(), hour: 0);
        
        initDay();
        initHour();
    }
    
    private func initDay()
    {
        
        
        _days = [Int]();
        _days.append(0);
        
        // Saturday = 1, Monday = 1, ...
        // 0 it's today
        if let weekDay = CalendarHelper.dayOfWeek() {
            // Add end of week
            for i in (weekDay+1) ..< 8 {
                _days.append(i)
            }
            
            // Add start of week
            for i in 1  ..< (weekDay - 1)
            {
                _days.append(i);
            }
        }
        
        dayCollectionView.reloadData();
        dayIndex = 0;
    }
    
    private func initHour()
    {
        let currentHour = CalendarHelper.convertHourDayIntoDayMoment(CalendarHelper.hourOfDay()!);

        _hoursDay = [Int]();
        _hoursDay.append(0);
        
        // Add rest of the day
        for i in (currentHour + 1)  ..< 9
        {
            _hoursDay.append(i);
        }
        
        _hoursDay.append(26);

        hourCollectionView.reloadData();
        hourIndex = 0;
    }
    
    private func updateCollectionHours(dayIndex d : Int) {
        _hoursDay.removeAll();
        
        if d == 0 {
            initHour();
            // Avoid reload data
            //return;
        }
        else if d == _days.count {
            _hoursDay.append(25);

            for i in 1 ..< _weathers[d].Weathers.count
            {
                _hoursDay.append(i);
            }
        }
        else {
            _hoursDay.append(25);
            // Add day
            for i in 1 ..< 9
            {
                _hoursDay.append(i);
            }
            _hoursDay.append(26);
        }
        
        hourCollectionView.reloadData();

    }
    
    private func updateCollectionHours(dayIndex d : Int, hourIndex h : Int)
    {
        updateCollectionHours(dayIndex: d);
        
        hourCollectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: _hourIndex, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false);

    }
    
    private func updateCollectionHours(dayIndex d : Int, isNextDay : Bool)
    {
        updateCollectionHours(dayIndex: d);
        
        if isNextDay {
            hourIndex = 1;
            hourCollectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false);
        }
        else {
            hourIndex = _hoursDay.count - 2;
            hourCollectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: hourIndex, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false);
        }
    }
    
    private func updateCollectionDays(isNextDay isNextDay : Bool)
    {
        var indexToSet : Int!;
        if isNextDay {
            indexToSet = _dayIndex + 1;
        }
        else {
            indexToSet = _dayIndex - 1;
        }
        
        dayIndex = indexToSet;
        dayCollectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: dayIndex, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true);
    }
    
    private func updateInfoWeather(dayIndex d : Int, hourIndex h : Int)
    {
        let currentWeather = _weathers[d];
        print(h);
        SetData(currentWeather, hour: h);
    }
    
    // Set a day to display
    private func SetData(weather : WeatherDay, hour h: Int)
    {
        var hourWeather : HourWeather;
        
        if h > weather.Weathers.count {
            hourWeather = HourWeather();
        }
        else
        {
            hourWeather = weather.Weathers[h];
        }
        
        SetImageWeather(hourWeather.CurrentWeather.Icon, weatherText : hourWeather.CurrentWeather.Description.uppercaseString);
        self.temp.text = WeatherHelpers.getFormattedTemperature(hourWeather.Temp, metric: "");
        self.humidityLabel.text = WeatherHelpers.getFormattedHumidity(hourWeather.Humidity, metric: "");
        self.pressureLabel.text = WeatherHelpers.getFormattedPressure(hourWeather.Pressure, metric: "");
        self.speedLabel.text = WeatherHelpers.getFormattedSpeed(hourWeather.Speed, metric: "");
        
        setDayData(weather);
    }
    
    private func setDayData(weather : WeatherDay) {
        self.tempMax.text = WeatherHelpers.getFormattedTemperature(weather.TempMax, metric: "");
        self.tempMin.text = WeatherHelpers.getFormattedTemperature(weather.TempMin, metric: "");
    }
    
    // Set image day weather
    private func SetImageWeather(name : String, weatherText titleWeather : String)
    {
        var imgResult : UIImage!;
        
        if (UIImage(named: name) != nil)
        {
            imgResult = UIImage(named: name);
        }
        else
        {
           imgResult = UIImage(named: "None");
        }
 
        UIView.animateWithDuration(0.40, animations: {
            self.MainWeatherView.alpha = 0;
            }) { (success) in
                if (success)
                {
                    self.weatherImg.image = imgResult;
                    self.descLabel.text = titleWeather;
                    UIView.animateWithDuration(0.40, animations: {
                    self.MainWeatherView.alpha = 1;
                    });
                }
        }
    }
    
    ///
    /// MARK : UICollectionViewController
    ///
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if (collectionView == dayCollectionView)
        {
            if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(DayCellIdentifier, forIndexPath: indexPath) as? MomentViewCell
            {
                cell.configureCell(CalendarHelper.getDayName(_days[indexPath.row]).uppercaseString);
            
                return cell;
            }

        }
        
        if (collectionView == hourCollectionView)
        {
            if  let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HourCellIdentifier, forIndexPath: indexPath) as? MomentViewCell
            {
                cell.configureCell(CalendarHelper.getHourName(_hoursDay[indexPath.row]).uppercaseString);
            
                return cell;
            }
        }
        
        return UICollectionViewCell();
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == dayCollectionView)
        {
            return _days.count;
        }
        else if (collectionView == hourCollectionView)
        {
            return _hoursDay.count;
        }
        else {
            return 0;
        }
    }
    
    
    ///
    /// MARK : UICollectionViewDelegateFlowLayout
    ///
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(dayCollectionView.frame.width, 80);
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0;
    }
    
    ///
    /// MARK : UIScrollView
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if (scrollView == dayCollectionView)
        {
            let index = Int(scrollView.contentOffset.x) / Int(dayCollectionView.frame.width)
            
            // Update index
            if dayIndex != index {
                dayIndex = index;
                
                if (dayIndex != 0) && (hourIndex == 0)
                {
                    // Hour index = 0 equal NOW
                    hourIndex += 1;
                }
                updateCollectionHours(dayIndex: dayIndex, hourIndex: hourIndex);
                updateInfoWeather(dayIndex: dayIndex, hourIndex: hourIndex);
            }
        }
        else if (scrollView == hourCollectionView)
        {
            let index = Int(scrollView.contentOffset.x) / Int(hourCollectionView.frame.width)
            
            if hourIndex != index {
                // Update index
                hourIndex = index;
                
                // Index start to 0
                if (index + 1) >= _hoursDay.count
                {
                    if dayIndex <= (_days.count - 1) {
                        updateCollectionDays(isNextDay: true);
                        // Update day index, scrollViewDidEndDecelerating not called
                        //dayIndex += 1;
                        updateCollectionHours(dayIndex : dayIndex, isNextDay: true);
                    }
                    
                }
                else if index == 0 {
                    if dayIndex != 0 {
                        updateCollectionDays(isNextDay: false);
                        // Update day index, scrollViewDidEndDecelerating not called
                        //dayIndex -= 1;
                        updateCollectionHours(dayIndex : dayIndex, isNextDay: false);
                    }
                    
                    
                }
                
                if (dayIndex == 0) && (hourIndex != 0) {
                    // hourindex is not correct
                    let currentHour = CalendarHelper.convertHourDayIntoDayMoment(CalendarHelper.hourOfDay()!);
                    
                    hourIndex += currentHour;
                }


                updateInfoWeather(dayIndex: dayIndex, hourIndex: hourIndex);
            }
        }
    }
}
