//
//  SkillView.swift
//  Resume
//
//  Created by Kelly Huberty on 10/14/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

class SkillView: ResumeElementView {

    var contentLabel:UILabel = {
        let label = Label.make()

        return label
    }()
    
    var skill:Resume.Skill?{
        didSet{
            resumeElement = skill
            contentLabel.text = skill?.content.joined(separator: ", ")
        }
    }

    override func layoutDetail() {
        addLabel(contentLabel)
    }
    
    
}
