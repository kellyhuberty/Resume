//
//  UIFontCodable.swift
//  Resume
//
//  Created by Kelly Huberty on 11/3/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

extension Font{
    
    var uiFont:UIFont{
        return UIFont(name: name, size: CGFloat(size))!
    }
    
}

