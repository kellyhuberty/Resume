//
//  SectionHeaderView.swift
//  Resume
//
//  Created by Kelly Huberty on 10/21/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {

}


class GeneralTableViewHeaderFooterView : UITableViewHeaderFooterView{
    
    public var view:UIView? = nil{
        willSet{
            removeContentView()
        }
        didSet{
            guard let view = view else{
                return
            }
            addContentView(view)
        }
    }
    
    func removeContentView(){
        view?.removeFromSuperview()
    }
    
    func addContentView(_ view:UIView){
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
        
    }
    
    
}


class SectionTableHeaderView : GeneralTableViewHeaderFooterView{
    
    var label:UILabel = {
        let label = Label.make()
        label.font = Fonts.changing.header
        return label
    }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.addSubview(label)
        
        NSLayoutConstraint.activate([
            
                label.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
                label.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
                label.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
                label.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
            
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class OverviewTableHeaderView : UITableViewHeaderFooterView{
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 1.0)
            ])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
