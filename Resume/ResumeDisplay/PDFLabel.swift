//
//  PDFLabel.swift
//  Resume
//
//  Created by Kelly Huberty on 3/15/22.
//  Copyright © 2022 Kelly Huberty. All rights reserved.
//

import UIKit

class PDFLabel: UILabel {

    static var renderingPDF: Bool = false
    
    var pdfTextColor: UIColor = .black
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {

        if PDFLabel.renderingPDF {
            let txtColor = self.textColor
            self.textColor = pdfTextColor
            self.draw(self.bounds)
            self.textColor = txtColor
        } else {
            super.draw(layer, in: ctx)
        }
    }

}
