//
//  AppDelegate.swift
//  Resume
//
//  Created by Kelly Huberty on 10/13/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit
import SafariServices

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var tabBarController:UITabBarController!
    
    var tableResumeViewController:ResumeDisplayTableViewController!
    var pageResumeViewController:ResumeDisplayPageViewController!
    var contactViewController:ContactHostingViewController!

    
    
    let activityIndicator:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    fileprivate func loadResumeData() {
        
        activityIndicator.startAnimating()
        
        ResumeRepo.shared.fetchResume(success: { (resume) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()

                Fonts.setBaseFonts(fontDictionary: resume.style.fonts)
                
                
                self.tableResumeViewController.resume = resume
                self.pageResumeViewController.resume = resume
                self.contactViewController.resume = resume
            }
        },
                                      failure:  { (error) in
                                        DispatchQueue.main.async {
                                            self.activityIndicator.stopAnimating()

                                        
                                        }
                                        //TODO: failure code here
                                        print("debug description: \(error.debugDescription)")
        })
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    
        
        
        
        let resumeVC = ResumeDisplayTableViewController(nibName: nil, bundle: nil)
        let resumeNC = UINavigationController(rootViewController: resumeVC )
        
        let pageVC = ResumeDisplayPageViewController(nibName: nil, bundle: nil)
        let pageNC = UINavigationController(rootViewController: pageVC )
        
        let contactVC = ContactHostingViewController()
        let contactNC = UINavigationController(rootViewController: contactVC )
        
        tableResumeViewController = resumeVC
        pageResumeViewController = pageVC
        contactViewController = contactVC
        
        tabBarController = UITabBarController(nibName: nil, bundle: nil)
        
        tabBarController.viewControllers = [resumeNC, pageNC, contactNC]
        
        tabBarController.view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            tabBarController.view.topAnchor.constraint(equalTo:activityIndicator.topAnchor),
            tabBarController.view.bottomAnchor.constraint(equalTo:activityIndicator.bottomAnchor),
            tabBarController.view.leadingAnchor.constraint(equalTo:activityIndicator.leadingAnchor),
            tabBarController.view.trailingAnchor.constraint(equalTo:activityIndicator.trailingAnchor)
        ])

        loadResumeData()

        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    @objc func openRemoteUrlLocally(_ url:URL){
        
        let safariVC = SFSafariViewController(url: url)
        
        tabBarController.present(safariVC, animated: true, completion: nil)
        
    }
    
    @objc func openMailViewController(with email:String){
        
        
        
    }
    
    


}

