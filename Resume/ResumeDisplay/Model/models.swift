//
//  models.swift
//  Resume
//
//  Created by Kelly Huberty on 10/13/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import Foundation



class Resume : Decodable{
    
    let name:String
    let address:String
    let phone:String
    let email:String
    let missionStatement:MissionStatement
    
    let style:Style
    
    struct MissionStatement : ResumeElement{
        var title: String
        var detail: String?
    }
    
    struct Sections : Codable{
        let schools: SectionInfo
        let jobs: SectionInfo
        let skills: SectionInfo
        let projects: SectionInfo
        let other: SectionInfo
    }
    
    struct School: ResumeElement{
        let title: String
        let detail: String?
        let gpa: String
        let degree: String
        let studied: [String]?
    }
    
    struct Job: ResumeElement{
        let title: String
        let detail: String?
        let position: String
        let content: [String]
        let startDate: Date?
        let endDate: Date?
    }
    
    struct Skill: ResumeElement{
        let title: String
        let detail: String?
        let content: [String]
    }
    
    struct Project: ResumeElement, ExternallyLinkable, Bodyable{
        let title: String
        let detail: String?
        let body: String?
        let url: URL?
    }
    
    struct Other: ResumeElement, Bodyable, ExternallyLinkable{
        let title: String
        let detail: String?
        let body: String?
        let url: URL?
    }
    
    let sections:Sections
    let schools:[School]
    let jobs:[Job]
    let skills:[Skill]
    let projects:[Project]
    let other:[Other]
}

protocol ResumeElement : Decodable{
    var title: String { get }
    var detail: String? { get }
}

protocol ExternallyLinkable : Decodable{
    var url: URL? { get }
}

protocol Bodyable : Decodable{
    var body: String? { get }
}

struct Style : Codable{
    var pageSize: Size
    var pageMargin: Double
    var fonts: [String:Font]
}

struct Size : Codable{
    let width:Double
    let height:Double
}

struct Font : Codable{
    let name:String
    let size:Double
}

struct SectionInfo : Codable{
    let title: String
    let pageOrientation: Orientation
}

enum Orientation : String, Codable{
    case vertical = "vertical"
    case horizontal = "horizontal"
}

