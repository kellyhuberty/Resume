//
//  ResumeElementView.swift
//  Resume
//
//  Created by Kelly Huberty on 10/14/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

class ResumeElementView: UIView {

    //MARK: public interface
    
    var resumeElement:ResumeElement? = nil{
        didSet{
            guard let el = resumeElement else{
                titleLabel.text = ""
                detailLabel.text = nil
                return
            }
            
            titleLabel.text = el.title
            detailLabel.text = el.detail
            
        }
    }
    
    //MARK: Basic structure
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = Fonts.changing.title
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        return label
    }()
    
    let detailLabel:UILabel = {
        let label = UILabel()
        label.font = Fonts.changing.title
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    private let stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.setContentCompressionResistancePriority(.required, for: .vertical)
        return stackView
    }()
    
    //MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layoutTitle()
        self.layoutDetail()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutTitle(){
        
        self.addSubview(titleLabel)
        self.addSubview(detailLabel)
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),

            detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant:3),
            detailLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant:16),
            detailLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: self.detailLabel.bottomAnchor, constant:6),
            layoutMarginsGuide.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant:16),
            stackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),

        ])
        
        
        
    }
    
    func layoutDetail(){
        
        
    }
    
    func addLabel(_ label:UILabel){
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        stackView.addArrangedSubview(label)
        
    }
    
}


class Label{
    
    
    static func make() -> UILabel{
        
        let label = UILabel()
        label.font = Fonts.changing.title
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = Fonts.changing.body
    
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
        
    }
    
}
