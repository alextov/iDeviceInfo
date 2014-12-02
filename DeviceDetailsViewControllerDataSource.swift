//
//  DeviceDetailsViewControllerDataSource.swift
//  iDeviceInfo
//
//  Created by Alexander Tovstonozhenko on 26.11.14.
//  Copyright (c) 2014 Alexander Tovstonozhenko. All rights reserved.
//

import Foundation
import UIKit

let deviceCellIdentifier: String = "DeviceCellIdentifier"

struct Device: Equatable {
    var name: String
    var year: Int
}

func ==(lhs: Device, rhs: Device) -> Bool {
    return lhs.name == rhs.name && lhs.year == rhs.year
}

class DeviceDetailsDataSource: NSObject, UITableViewDataSource {
    
    var devices: [String: [Device]] = [
        "iPhones": [
            Device(name: "iPhone", year: 2007),
            Device(name: "iPhone", year: 2007),
            Device(name: "iPhone 3G", year: 2008),
            Device(name: "iPhone 3GS", year: 2009),
            Device(name: "iPhone 4", year: 2010),
            Device(name: "iPhone 4S", year: 2011),
            Device(name: "iPhone 5", year: 2012),
            Device(name: "iPhone 5S", year: 2013),
            Device(name: "iPhone 5C", year: 2013),
            Device(name: "iPhone 6", year: 2014),
        ],
        "iPads": [
            Device(name: "iPad", year: 2010),
            Device(name: "iPad 2", year: 2011),
            Device(name: "iPad 3", year: 2012),
            Device(name: "iPad 4", year: 2012),
            Device(name: "iPad Air", year: 2013),
            Device(name: "iPad Mini 2", year: 2013),
            Device(name: "iPad Air 2", year: 2014),
            Device(name: "iPad Mini 3", year: 2014)
        ]
    ]
    var sections: [String] {
        return devices.keys.array
    }
    var filteredDevices = [Device]()
    
    
    // MARK: - Overridden methods
    
    override init() {
        super.init()
        for (_, devices) in self.devices {
            filteredDevices += devices
        }
    }
    
    
    // MARK: - Delegated methods

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionTitle: String = sections[section]
        return devices[sectionTitle]!.filter({ contains(self.filteredDevices, $0) }).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let sectionTitle: String = sections[indexPath.section]
        let filteredDevicesInSection = devices[sectionTitle]!.filter({ contains(self.filteredDevices, $0) })
        let device: Device = filteredDevicesInSection[indexPath.row]
        
        let cell: DeviceCell = tableView.dequeueReusableCellWithIdentifier(deviceCellIdentifier, forIndexPath: indexPath) as DeviceCell
        cell.accessoryType = .DisclosureIndicator
        cell.textLabel.text = device.name
        cell.secondLabel.text = String(device.year)
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let sectionTitle = sections[indexPath.section]
        devices[sectionTitle]?.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
}