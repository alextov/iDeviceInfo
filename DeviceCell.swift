//
//  DeviceCell.swift
//  iDeviceInfo
//
//  Created by Alexander Tovstonozhenko on 27.11.14.
//  Copyright (c) 2014 Alexander Tovstonozhenko. All rights reserved.
//

import Foundation
import UIKit

class DeviceCell: UITableViewCell {
    
    var secondLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.textLabel.backgroundColor = UIColor.clearColor()
        secondLabel = UILabel(frame: CGRect(x: 235.0, y: 14.0, width: 80.0, height: 15.0))
        secondLabel.textAlignment = .Right
        secondLabel.autoresizingMask = .FlexibleLeftMargin | .FlexibleHeight
        self.contentView.addSubview(secondLabel)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}