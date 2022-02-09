//
//  SchoolView.swift
//  Resume
//
//  Created by Kelly Huberty on 10/14/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

class SchoolView: ResumeElementView {

    var gpaLabel:UILabel = {
        let label = Label.make()
        return label
    }()
    
    var degreeLabel:UILabel = {
        let label = Label.make()
        return label
    }()
    
    var studiedLabel:UILabel = {
        let label = Label.make()
        return label
    }()
    
    var school:Resume.School?{
        didSet{
            resumeElement = school
            gpaLabel.text = school?.gpa
            degreeLabel.text = school?.degree
            
            studiedLabel.text = school?.studied?.joined(separator: ", ")
        }
    }
    
    override func layoutDetail() {
        addLabel(gpaLabel)
        addLabel(degreeLabel)
        addLabel(studiedLabel)
    }
    
}
