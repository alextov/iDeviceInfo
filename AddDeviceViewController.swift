//
//  AddDeviceViewController.swift
//  iDeviceInfo
//
//  Created by Alexander Tovstonozhenko on 28.11.14.
//  Copyright (c) 2014 Alexander Tovstonozhenko. All rights reserved.
//

import Foundation
import UIKit

protocol AddDeviceViewProtocol {
    func addDeviceViewController(sender: AddDeviceViewController, shouldAddDevice device: Device)
}

class AddDeviceViewController: UIViewController {
    
    var deviceNameTextField: UITextField!
    var deviceYearDatePicker: UIDatePicker!
    var commitButton: UIButton!
    var delegate: AddDeviceViewProtocol?
    
    
    // MARK: - Instance initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Overridden methods
    
    override func viewDidLoad() {
        self.title = "Add a device"
        self.view.backgroundColor = UIColor.whiteColor()

        deviceNameTextField = UITextField(frame: CGRectMake(10, 75, CGRectGetWidth(self.view.frame)-20, 30))
        deviceNameTextField.font = UIFont.systemFontOfSize(14.0)
        deviceNameTextField.borderStyle = .RoundedRect
        deviceNameTextField.attributedPlaceholder = NSAttributedString(string: "Device name")
        self.view.addSubview(deviceNameTextField)
        
        deviceYearDatePicker = UIDatePicker(frame: CGRectMake(10, 105, CGRectGetWidth(self.view.frame)-20, 30))
        deviceYearDatePicker.datePickerMode = .Date
        self.view.addSubview(deviceYearDatePicker)
        
        commitButton = UIButton.buttonWithType(.System) as UIButton
        commitButton.frame = CGRectMake(10, 315, CGRectGetWidth(self.view.frame)-20, 30)
//        commitButton.backgroundColor = .greenColor()
        commitButton.setTitle("Add", forState: .Normal)
        self.view.addSubview(commitButton)
    }
    
    
    // MARK: - Action methods
    
    func addButtonTapped(sender: AnyObject) {
        var device = Device(name: deviceNameTextField.text, year: {
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(.YearCalendarUnit, fromDate: self.deviceYearDatePicker.date)
            return components.year
        }())
        delegate?.addDeviceViewController(self, shouldAddDevice: device)
    }
}