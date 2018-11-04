//
//  ResumeRepo.swift
//  Resume
//
//  Created by Kelly Huberty on 10/14/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit

class ResumeRepo {

    static let shared = ResumeRepo()
    
    static let resumeUrl = URL(fileURLWithPath: "https://foobarbucket.com/resume.json")
    
    enum ResumeRepoError {
        case noUrl
        case parseError(Error)
    }
    
    func fetchResume(success:((Resume) -> Void), failure:((ResumeRepoError?) -> Void)){
        
        fetchRemote(success: { (resume) in
            success(resume)
        }) { (error) in
            fetchLocal(success:success, failure:failure)
        }
        
    }
    
    
    func fetchLocal(success:((Resume) -> Void), failure:((ResumeRepoError?) -> Void)){
        
        
        guard let url = Bundle.main.url(forResource: "resume", withExtension: "json") else {
            failure(ResumeRepoError.noUrl)
            return
        }
        
        
        let data:Data
        do{
            data = try Data(contentsOf: url)
        }catch{
            failure(ResumeRepoError.parseError(error))
            return
        }
        
        let jsonCoder = JSONDecoder()
        
        do{
            let resume = try jsonCoder.decode(Resume.self, from: data)
            success(resume)
        }catch{
            failure(ResumeRepoError.parseError(error))
        }
        
    }
    
    
    func fetchRemote(success:((Resume) -> Void), failure:((ResumeRepoError?) -> Void)){
        
        failure(.noUrl)
        
    }
    
    
    
    
    
}
