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
            
            removeAllLabels()
            
            guard let el = resumeElement else{
                titleLabel.text = ""
                detailLabel.text = nil
                return
            }
            
            titleLabel.text = el.title
            
            if let detail = el.detail{
                addLabel(detailLabel)
                detailLabel.text = detail
            }
            
            if let body = (el as? Bodyable)?.body {
                addLabel(bodyLabel)
                bodyLabel.text = body
            }
            
            
            layoutDetail()
            
            if let url = (el as? ExternallyLinkable)?.url {
                addLabel(urlLabel)
                let str = NSMutableAttributedString(string:url.absoluteString)
                str.addAttribute(.link, value: url.absoluteString, range: NSRange(location: 0, length: url.absoluteString.count))
                urlLabel.attributedText = str
                urlLabel.url = url
            }
            
            
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
        label.font = Fonts.changing.detail
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    let bodyLabel:UILabel = {
        let label = UILabel()
        label.font = Fonts.changing.body
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    let urlLabel:URLLabel = {
        let label = URLLabel()
        label.font = Fonts.changing.detail
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
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant:0),
            layoutMarginsGuide.bottomAnchor.constraint(greaterThanOrEqualTo: stackView.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant:16),
            stackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
        ])
        
        
        
    }
    
    func layoutDetail(){
        
        
    }
    
    func addLabel(_ label:UILabel){
        
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        stackView.addArrangedSubview(label)
        
    }
    
    func removeAllLabels(){
        
        for view in stackView.subviews {
            view.removeFromSuperview()
        }

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



class URLLabel : UILabel{
    
    var url : URL?
    
    //@objc func urlFrame() -> Frame
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let url = self.url else {
            return
        }
        
        let targ = target(forAction: #selector(URLReceiver.drawUrl(_:at:)), withSender: self)
        
        (targ as? URLReceiver)?.drawUrl(url, at: self.bounds)
                
    }
    
}
