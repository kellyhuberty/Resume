//
//  ResumeDisplayPageViewController.swift
//  Resume
//
//  Created by Kelly Huberty on 10/23/18.
//  Copyright © 2018 Kelly Huberty. All rights reserved.
//

import UIKit
import WebKit

class ResumeDisplayPageViewController: UIViewController {

    @IBOutlet var webView:WKWebView!
    

    
    var resume: Resume?{
        didSet{
            renderPDF()
        }
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
    
        super.viewDidAppear(animated)

        //pageView.resume = resume

        
        renderPDF()
        
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func renderPDF(){
        
        guard webView != nil else{
            return
        }
        
        
        let pdfData:NSMutableData = NSMutableData()
        
        let pdfWidth = resume?.style.pageSize.width ?? 1200
        let pdfHeight = resume?.style.pageSize.height ?? 1600

        
        
        let pageView = ResumePageView(frame: .zero)

        pageView.frame = CGRect(x: 0, y: 0, width: pdfWidth, height: pdfHeight)
        
        pageView.layoutMargins = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60)
        
        view.addSubview(pageView)
        pageView.resume = resume
                
        // Points the pdf converter to the mutable data object and to the UIView to be converted
        
        UIGraphicsBeginPDFContextToData(pdfData, CGRect(x: 0, y: 0, width: 612, height: 792), nil)
        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: pdfWidth, height: pdfHeight), nil)
        
        let pdfContext = UIGraphicsGetCurrentContext()!
        
        pageView.layer.render(in: pdfContext)

        UIGraphicsEndPDFContext()
        



        pageView.removeFromSuperview()
        
        let sandboxPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let url = URL(fileURLWithPath: sandboxPath).appendingPathComponent("blah").appendingPathExtension("pdf")
        
        print("url blah : \(url)")
        
        try! pdfData.write(to: url, options: [])
        
        webView.load(Data(referencing: pdfData), mimeType: "application/pdf", characterEncodingName: "UTF-8", baseURL: URL(string: "http://localhost")!)
        
    }
    
}
