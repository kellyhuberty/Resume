//
//  ContactHostingViewController.swift
//  Resume
//
//  Created by Kelly Huberty on 2/6/22.
//  Copyright © 2022 Kelly Huberty. All rights reserved.
//

import UIKit
import SwiftUI

class ContactHostingViewController: UIHostingController<ContactView> {

    var resume: Resume? {
        didSet {
            rootView.viewModel.contact = resume?.contact
        }
    }
    
    init() {
        super.init(rootView: ContactView(viewModel:ContactViewModel()))
        self.title = NSLocalizedString("Contact", comment: "ContactHostingViewController Contact")
        tabBarItem = UITabBarItem(title: self.title,
                                  image: UIImage(systemName: "person"),
                                  selectedImage: UIImage(systemName: "person"))
    }
    
    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
