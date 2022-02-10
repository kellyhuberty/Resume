//
//  GeneralTableViewCell.swift
//  Resume
//
//  Created by Kelly Huberty on 10/14/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

public protocol GeneralCell: AnyObject {
    var view:UIView? { get set }
}

class GeneralTableViewCell: UITableViewCell, GeneralCell {
    
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
