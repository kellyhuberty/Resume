//
//  JobView.swift
//  Resume
//
//  Created by Kelly Huberty on 10/14/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

class JobView: ResumeElementView {

    var positionLabel:UILabel = {
        let label = Label.make()
        return label
    }()
    
    var contentLabel:UILabel = {
        let label = Label.make()
        return label
    }()
    
    var job:Resume.Job?{
        didSet{
            resumeElement = job
            positionLabel.text = job?.position
            
            guard let content = job?.content.joined(separator:"\n• ") else{
                contentLabel.text = nil
                return
            }
            
            var contentText = content
            
            contentText = "• " + contentText
            
            contentLabel.text = contentText


        }
    }
    
    override func layoutDetail() {
        addLabel(positionLabel)
        addLabel(contentLabel)
    }
    
    

}
