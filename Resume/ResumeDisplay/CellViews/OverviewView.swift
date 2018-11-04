//
//  OverviewView.swift
//  Resume
//
//  Created by Kelly Huberty on 10/14/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

class OverviewView: UIView {

    lazy var basicInfoStack:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
stackView.spacing = 16
        stackView.distribution = .fill

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(detailInfoStack)

        return stackView
    }()
    
    lazy var detailInfoStack:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.distribution = .fill
        stackView.addArrangedSubview(addressLabel)
        stackView.addArrangedSubview(phoneLabel)
        stackView.addArrangedSubview(emailLabel)
        
        return stackView
    }()
    
    
    lazy var fullStack:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill

        stackView.spacing = 30
        
        stackView.addArrangedSubview(basicInfoStack)
        stackView.addArrangedSubview(missionLabel)

        return stackView
    }()
    
    let missionLabel:UILabel = {
        let label = Label.make()
        
        label.textAlignment = .center
        return label
    }()
    
    let nameLabel:UILabel = {
        let label = Label.make()
        
        label.font = Fonts.changing.namedHeader
        return label
    }()
    
    let addressLabel:UILabel = {
        let label = Label.make()
        
        label.numberOfLines = 0
        return label
    }()
    
    let emailLabel:UILabel = {
        let label = Label.make()
        
        
        return label
    }()
    
    let phoneLabel:UILabel = {
        let label = Label.make()
        
        
        return label
    }()
    
    var resume:Resume?{
        didSet{
            nameLabel.text = resume?.name
            addressLabel.text = resume?.address
            phoneLabel.text = resume?.phone
            emailLabel.text = resume?.email
            
            let title = NSMutableAttributedString(string: resume?.missionStatement.title ?? "", attributes: [NSAttributedString.Key.font : Fonts.changing.missionTitle])
            let detail = NSAttributedString(string: resume?.missionStatement.detail ?? "", attributes: [NSAttributedString.Key.font : Fonts.changing.missionDetail])
            
            title.append(NSAttributedString(string: "\n"))
            title.append(detail)
            
            missionLabel.attributedText = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.addSubview(fullStack)
        
        NSLayoutConstraint.activate([
            fullStack.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            fullStack.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            fullStack.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            fullStack.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        loadTraitCollection(traitCollection)
    }
    
    func loadTraitCollection(_ traitCollection:UITraitCollection){
        
        detailInfoStack.axis = .vertical
        basicInfoStack.axis = .vertical

        
        if traitCollection.horizontalSizeClass == .regular{
            fullStack.axis = .horizontal
            basicInfoStack.axis = .vertical

            
        }else{
            fullStack.axis = .vertical
            
            if traitCollection.preferredContentSizeCategory > UIContentSizeCategory.large{
                basicInfoStack.axis = .vertical
            }else{
                basicInfoStack.axis = .horizontal
            }
            
        }
    
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        
        super.traitCollectionDidChange(previousTraitCollection)
        
        self.loadTraitCollection(traitCollection)
        
    }
    
    

}
