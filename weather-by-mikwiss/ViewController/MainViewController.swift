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
    
    ///
    /// MARK : outlets
    ///
    @IBOutlet weak var dayCollectionView: UICollectionView!
    
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
        
            // Lauch event
            //print(_days[indexPath.row]);
            
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
}
