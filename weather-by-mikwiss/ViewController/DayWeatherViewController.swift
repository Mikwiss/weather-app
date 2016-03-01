//
//  DayWeatherViewController.swift
//  weather-by-mikwiss
//
//  Created by Mathieu Bret on 27/02/2016.
//  Copyright © 2016 Mikwiss. All rights reserved.
//

import UIKit

@IBDesignable class DayWeatherViewController : UIView {
    
    ///
    /// MARK : properties
    private var _view : UIView!;
    private var _nibName : String = "DayWeatherView";
    //private var _dayTime : DayTime;
    
    ///
    /// MARK : members
    ///
    /*var DayTime : DayTime
    {
        get {
            return _dayTime;
        }
        set {
            
        }
    }*/
    
    @IBInspectable var BackGroundColor :  UIColor? {
        get {
            return self.backgroundColor;
        }
        set(color) {
            self.backgroundColor = color;
        }
        
    }
    
    ///
    /// Mark : 
    ///
    

    ///
    /// MARK : initialization
    ///
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        setup();
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setup();
    }
    
    ///
    /// Setup view
    ///
    func setup()
    {
        _view = instanceFromNib();
        
        _view.frame = self.bounds;
        //view.autoresizingMask = UIViewAutoresizing.FlexibleWidth;
        
        addSubview(_view);
    }
    
    func instanceFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType);
        let nib = UINib(nibName: _nibName, bundle: bundle);
        return nib.instantiateWithOwner(nil, options: nil)[0] as! UIView;
    }
    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
