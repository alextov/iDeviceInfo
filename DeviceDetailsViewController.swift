//
//  DeviceDetailsViewController.swift
//  iDeviceInfo
//
//  Created by Alexander Tovstonozhenko on 26.11.14.
//  Copyright (c) 2014 Alexander Tovstonozhenko. All rights reserved.
//

import Foundation
import UIKit

class DeviceDetailsViewController: UIViewController {
    
    var deviceName = String()
    let webView: UIWebView!
    
    
    // MARK: - Instance initialization
    
    init(initWithDeviceName deviceName: String) {
        super.init(nibName: nil, bundle: nil)

        self.deviceName = deviceName
        webView = UIWebView(frame: self.view.bounds)
        self.view.addSubview(webView)
        let URLPath: String! = String("http://en.wikipedia.org/wiki/\(deviceName)").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let url: NSURL? = NSURL(string: URLPath)
        if url != nil {
            let request: NSURLRequest? = NSURLRequest(URL: url!)
            if request != nil {
                webView.loadRequest(request!)
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Overridden methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.deviceName
    }
}