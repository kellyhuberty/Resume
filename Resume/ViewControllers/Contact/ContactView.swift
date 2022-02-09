//
//  SwiftUIView.swift
//  Resume
//
//  Created by Kelly Huberty on 2/6/22.
//  Copyright © 2022 Kelly Huberty. All rights reserved.
//

import SwiftUI

struct ContactView: View {
    
    @ObservedObject var viewModel: ContactViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 84))
                .foregroundColor(Color(UIColor.lightGray))
            Text(viewModel.name).font(.title)
            List {
                ForEach(viewModel.fields) { field in
                    ContactCellView(contactField: field)
                        .onTapGesture {
                            viewModel.tapped(field)
                        }
                }
            }
        }
        .tabItem {
            VStack {
                Image(systemName: "at").font(.system(size:30))
                Text("Contact")
            }
        }
    }
}

struct ContactCellView: View {
    
    var contactField: Resume.Contact.Field
    
    var body: some View {
        HStack {
            if let imageName = contactField.imageName {
                Image(systemName: imageName)
                    .frame(width: 24,
                           height: 24,
                           alignment: .center)
                    .foregroundColor(.blue)
            }
            VStack(alignment: .leading) {
                Text(contactField.label).font(.caption).foregroundColor(.gray)
                Text(contactField.value).font(.body)
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView(viewModel:ContactViewModel())
    }
}
