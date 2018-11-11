//
//  Fonts.swift
//  Resume
//
//  Created by Kelly Huberty on 10/20/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

class Fonts {

    static func setBaseFonts(fontDictionary:[String:Font]){
        
        var fonts:[String:UIFont] = [:]

        for (name, font) in fontDictionary{
            fonts[name] = font.uiFont
        }
        
        changing = Fonts(fonts, dynamic: true)
        still = Fonts(fonts, dynamic: false)

        
    }
    
    private(set) static var changing = Fonts(defaultBaseFonts, dynamic:true)
    private(set) static var still = Fonts(defaultBaseFonts, dynamic:false)

    static let defaultBaseFonts:[String:UIFont] = [
        "header" : UIFont(name: "Futura", size: 20)!,
        "sectionHeader" : UIFont(name: "Arial-BoldMT", size: 24)!,
        "namedHeader" : UIFont(name: "Futura", size: 24)!,
        "missionTitle" : UIFont(name: "Georgia-Bold", size: 30)!,
        "missionDetail" : UIFont(name: "Georgia", size: 28)!,
        "info" : UIFont(name: "Futura", size: 19)!,
        "title" : UIFont(name: "Futura", size: 16.5)!,
        "detail" : UIFont(name: "ArialMT", size: 14.5)!,
        "body" : UIFont(name: "Arial-BoldMT", size: 14.5)!,
        "label" : UIFont(name: "Arial-BoldMT", size: 7.5)!
    ]
    
    private static let metrics = UIFontMetrics(forTextStyle: .body )
    
    private let dynamic:Bool
    private let baseFonts:[String:UIFont]

    
    init(_ baseFonts:[String:UIFont], dynamic:Bool) {

        self.baseFonts = baseFonts
        self.dynamic = dynamic
    }
    
    var sectionHeader:UIFont{
        return scaledFontForFont(baseFonts["sectionHeader"]!)
    }
    
    var namedHeader:UIFont{
        return scaledFontForFont(baseFonts["namedHeader"]!)
    }
    
    var info:UIFont{
        return scaledFontForFont(baseFonts["info"]!)
    }
    
    var missionTitle:UIFont{
        return scaledFontForFont(baseFonts["missionTitle"]!)
    }
    var missionDetail:UIFont{
        return scaledFontForFont(baseFonts["missionDetail"]!)
    }
    
    var header:UIFont{
        return scaledFontForFont(baseFonts["header"]!)
    }
    var title:UIFont{
        return scaledFontForFont(baseFonts["title"]!)
    }
    var detail:UIFont{
        return scaledFontForFont(baseFonts["detail"]!)
    }
    var body:UIFont{
        return scaledFontForFont(baseFonts["body"]!)
    }
    var label:UIFont{
        return scaledFontForFont(baseFonts["label"]!)
    }

    func scaledFontForFont(_ font:UIFont) -> UIFont{
        if dynamic {
            return Fonts.metrics.scaledFont(for:font)
        }else{
            return font
        }
    }
    
    
}
