//
//  HourWeatherViewController.swift
//  weather-by-mikwiss
//
//  Created by Mathieu Bret on 07/03/2016.
//  Copyright © 2016 Mikwiss. All rights reserved.
//

import UIKit

@IBDesignable class HourWeatherView : UIView {
        
    ///
    /// MARK : properties
    ///
    private var _view : UIView!;
    private var _nibName : String = "HourWeatherView";
    
    ///
    /// MARK : members
    ///
    @IBInspectable var BackGroundColor : UIColor? {
        get {
            return self.backgroundColor;
        }
        set(color) {
            self.backgroundColor = color;
        }
        
    }
    
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
    /// MARK : Setup
    ///
    func setup()
    {
        _view = instanceFromNib();
        _view.frame = self.bounds;
        addSubview(_view);
    }
    
    func instanceFromNib() -> UIView
    {
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
