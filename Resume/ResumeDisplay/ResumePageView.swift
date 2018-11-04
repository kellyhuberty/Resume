//
//  ResumePageView.swift
//  Resume
//
//  Created by Kelly Huberty on 10/23/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

class ResumePageView: UIView {

    var resume:Resume?{
        didSet{
            
            reloadResume()
        }
    }
    
    let stack:UIStackView = {
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.addSubview(stack)
        
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo:self.layoutMarginsGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo:self.layoutMarginsGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo:self.layoutMarginsGuide.trailingAnchor),
            //stack.bottomAnchor.constraint(equalTo:self.layoutMarginsGuide.bottomAnchor)
        ])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)

        self.addSubview(stack)
        
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo:self.layoutMarginsGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo:self.layoutMarginsGuide.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo:self.layoutMarginsGuide.trailingAnchor),
            //stack.bottomAnchor.constraint(equalTo:self.layoutMarginsGuide.bottomAnchor)
            ])
        
        
    }
    
    
    

    
    func reloadResume(){
        
        guard let resume = resume else{
            return
        }
        
        
        let overviewView = OverviewView()
        overviewView.resume = resume
        stack.addArrangedSubview(overviewView)
        
        
        var views:[UIView] = []
        
        
        for item in resume.schools{
            let view = SchoolView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.school = item
            views.append(view)
        }
        var section = ResumePageSectionView()
        section.layoutDirection = .horizontal
        section.contentViews = views
        stack.addArrangedSubview(section)

        
        
        views = []
        for item in resume.jobs{
            let view = JobView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.job = item
            views.append(view)
        }
        section = ResumePageSectionView()
        section.layoutDirection = .horizontal
        section.contentViews = views
        stack.addArrangedSubview(section)
        
        
        
        views = []
        for item in resume.skills{
            let view = SkillView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.skill = item
            views.append(view)
        }
        section = ResumePageSectionView()
        section.contentViews = views
        stack.addArrangedSubview(section)
        
        
        
        views = []
        for item in resume.projects{
            let view = ProjectView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.project = item
            views.append(view)
        }
        section = ResumePageSectionView()
        section.contentViews = views
        stack.addArrangedSubview(section)

        
        views = []
        for item in resume.other{
            let view = OtherView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.other = item
            views.append(view)
        }
        section = ResumePageSectionView()
        section.contentViews = views
        stack.addArrangedSubview(section)
        
        
        
        
    }
    
    
    class ResumePageSectionView : UIView {
        
        var contentViews:[UIView] = []{
            didSet{
                
                for view in contentView.arrangedSubviews{
                    view.removeFromSuperview()
                }
                
                for view in contentViews{
                    contentView.addArrangedSubview(view)
                }
                
            }
        }
        
        var layoutDirection:NSLayoutConstraint.Axis = .vertical {
            didSet{
                if layoutDirection == .vertical {
                    contentView.axis = .vertical
                    contentView.distribution = .fill
                    contentView.spacing = 10
                }else{
                    contentView.axis = .horizontal
                    contentView.distribution = .fillEqually
                    contentView.spacing = 10
                }
            }
        }
        
        
        private var headerLabel:UILabel = {
            let label = Label.make()
            return label
        }()
        
        private var contentView:UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            return stackView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            loadLayout()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func loadLayout(){
            
            self.addSubview(headerLabel)
            self.addSubview(contentView)

            NSLayoutConstraint.activate([
                headerLabel.topAnchor.constraint(equalTo:self.layoutMarginsGuide.topAnchor),
                headerLabel.leadingAnchor.constraint(equalTo:self.layoutMarginsGuide.leadingAnchor),
                headerLabel.trailingAnchor.constraint(equalTo:self.layoutMarginsGuide.trailingAnchor),
                contentView.topAnchor.constraint(equalToSystemSpacingBelow:headerLabel.bottomAnchor, multiplier: 1),
                contentView.leadingAnchor.constraint(equalTo:self.layoutMarginsGuide.leadingAnchor),
                contentView.trailingAnchor.constraint(equalTo:self.layoutMarginsGuide.trailingAnchor),
                contentView.bottomAnchor.constraint(equalTo:self.layoutMarginsGuide.bottomAnchor),
            ])
            
        }
        
    }
    
    
}
