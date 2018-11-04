//
//  ProjectView.swift
//  Resume
//
//  Created by Kelly Huberty on 10/14/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

class ProjectView: ResumeElementView {

    var project:Resume.Project?{
        didSet{
            resumeElement = project
        }
    }

}
