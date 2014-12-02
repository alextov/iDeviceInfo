//
//  DeviceViewController.swift
//  iDeviceInfo
//
//  Created by Alexander Tovstonozhenko on 26.11.14.
//  Copyright (c) 2014 Alexander Tovstonozhenko. All rights reserved.
//

import Foundation
import UIKit

class DeviceViewController: UIViewController, UITableViewDelegate, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating, AddDeviceViewProtocol {

    let searchController: UISearchController!
    let tableView = UITableView()
    let dataSource = DeviceDetailsDataSource()
    
    
    // MARK: - Instance initialization
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.tableView.frame), 44.0)
        searchController.searchResultsUpdater = self
        
        tableView.frame = self.view.bounds
        tableView.tableHeaderView = searchController.searchBar
        tableView.dataSource = self.dataSource
        tableView.delegate = self
        tableView.registerClass(DeviceCell.self, forCellReuseIdentifier: deviceCellIdentifier)
        self.view.addSubview(tableView)

    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Overridden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("iDevices", comment: "")

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "editDevice:")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: "addDevice:")
    }
    
    
    // MARK: - Action methods
    
    func editDevice(sender: AnyObject) {
        let button = sender as UIBarButtonItem
        self.tableView.editing = !self.tableView.editing
        if self.tableView.editing {
            button.title = "Done"
        } else {
            button.title = "Edit"
        }
    }
    
    func addDevice(sender: AnyObject) {
        let addDeviceController = AddDeviceViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(addDeviceController, animated: true)
    }

    
    // MARK: - Delegated methods
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedCell: UITableViewCell! = tableView.cellForRowAtIndexPath(indexPath)
        let iDeviceName: String! = selectedCell.textLabel.text
        
        let detailsViewController = DeviceDetailsViewController(initWithDeviceName: iDeviceName)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        dataSource.filteredDevices.removeAll(keepCapacity: false)
        let searchText = searchController.searchBar.text
        for (_, devices) in dataSource.devices {
            dataSource.filteredDevices += devices.filter({ $0.name.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil || equal(searchText, "") })
        }
        tableView.reloadData()
    }
    
    func addDeviceViewController(sender: AddDeviceViewController, shouldAddDevice device: Device) {
        //
    }
}