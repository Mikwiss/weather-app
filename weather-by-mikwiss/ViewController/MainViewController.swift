//
//  MainViewController.swift
//  weather-by-mikwiss
//
//  Created by Mathieu Bret on 24/02/2016.
//  Copyright © 2016 Mikwiss. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    ///
    /// MARK : properties
    ///
    private var _days : [Int]!;
    private var _weathers : [WeatherDay]!;
    private var _weatherService : WeatherService!;
    
    ///
    /// MARK : outlets
    ///
    @IBOutlet weak var dayCollectionView: UICollectionView!;
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
    /// MARK : View
    ///
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initData();
        
        print(_days);
        
        dayCollectionView.registerNib(UINib(nibName: "MomentViewCell", bundle: nil), forCellWithReuseIdentifier: MomentCellIdentifier);
        
        dayCollectionView.delegate = self;
        dayCollectionView.dataSource = self;
        dayCollectionView.pagingEnabled = true;
        
        _weatherService = WeatherService();
    }
    
    override func viewDidAppear(animated: Bool) {
        _weatherService.getWeatherForCity(3031582) { (daysWeather : [WeatherDay]) -> () in
            //After download
            if (daysWeather.count > 0)
            {
                self._weathers = daysWeather;
                self.SetData(daysWeather[0]);
            }
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///
    /// MARK : Methods
    ///
    
    func initData()
    {
        _weathers = [WeatherDay]();
        // Init display with : ---°
        SetData(WeatherDay());
        _days = [Int]();
        _days.append(0);

        // Saturday = 1, Monday = 1, ...
        // 0 it's today
        if let weekDay = CalendarHelper.dayOfWeek() {
            // Add end of week
            for var i = (weekDay + 1) ; i <= 7 ; i++
            {
                _days.append(i)
            }
            
            // Add start of week
            for var i = 1 ; i < weekDay ; i++
            {
                _days.append(i);
            }
        }

    }
    
    // Set a day to display
    func SetData(weather : WeatherDay)
    {
        self.temp.text = WeatherHelpers.GetFormattedTemperature(weather.Temp, metric: "");
        self.tempMax.text = WeatherHelpers.GetFormattedTemperature(weather.TempMax, metric: "");
        self.tempMin.text = WeatherHelpers.GetFormattedTemperature(weather.TempMin, metric: "");
        self.humidityLabel.text = WeatherHelpers.GetFormattedHumidity(weather.Humidity, metric: "");
        self.pressureLabel.text = WeatherHelpers.GetFormattedPressure(weather.Pressure, metric: "");
        self.speedLabel.text = WeatherHelpers.GetFormattedSpeed(weather.Speed, metric: "");
        self.descLabel.text = weather.MainWeather.Description.uppercaseString;
        
        SetImageWeather(weather.MainWeather.Icon);
    }
    
    // Set image day weather
    func SetImageWeather(name : String)
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
        
        // Effect here
        self.weatherImg.image = imgResult;
    }
    
    ///
    /// MARK : UICollectionViewController
    ///
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(MomentCellIdentifier, forIndexPath: indexPath) as? MomentViewCell
        {
            cell.configureCell(_days[indexPath.row]);
            
            return cell;
        }
        else
        {
            return UICollectionViewCell();
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _days.count;
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
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x) / Int(dayCollectionView.frame.width)
        
        SetData(_weathers[index]);
    }
}
