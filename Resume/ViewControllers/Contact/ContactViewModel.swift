//
//  ContactViewModel.swift
//  Resume
//
//  Created by Kelly Huberty on 2/8/22.
//  Copyright © 2022 Kelly Huberty. All rights reserved.
//

import UIKit

class ContactViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var fields: [Resume.Contact.Field] = []

    var contact: Resume.Contact? {
        didSet{
            
            guard let contact = contact else {
                name = ""
                fields = []
                return
            }
            
            name = contact.firstName + " " + contact.lastName
            fields = contact.fields
        }
    }
    
    func tapped(_ contactField: Resume.Contact.Field) {
        guard let url = contactField.url else {
            return
        }
        UIApplication.shared.open(url, options: [:]) { _ in
            
        }
    }
}

