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
    
    var sandboxUrlPath:URL {
        let sandboxPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return URL(fileURLWithPath: sandboxPath).appendingPathComponent("KellyHubertyResume").appendingPathExtension("pdf")
    }
    
    var currentRendererContext:UIGraphicsPDFRendererContext?

    var resume: Resume?{
        didSet{
            
            if resume != nil {
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareItemAction(_:)))
                navigationItem.rightBarButtonItem = barButtonItem
            }else{
                navigationItem.rightBarButtonItem = nil
            }
            
            renderPDF()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.title = NSLocalizedString("PDF Page", comment: "ResumeDisplayPageViewController PDF")
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(named: "ExportDoc"), tag: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.title = NSLocalizedString("PDF Page", comment: "ResumeDisplayPageViewController PDF")
        self.tabBarItem = UITabBarItem(title: self.title, image: UIImage(named: "ExportDoc"), tag: 0)
    }
    
    
    @objc func shareItemAction(_ sender:Any?){
        
        let pdfData = createPDFData()
        let activityVC = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
        activityVC.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        present(activityVC, animated: true) {
            
        }
    }
    
    override func viewDidLoad() {
        webView.navigationDelegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
        super.viewDidAppear(animated)
        renderPDF()
    }
    
    func renderPDF(){
        
        guard webView != nil else{
            return
        }
        
        let pdfData = createPDFData()
        let url = sandboxUrlPath
        print("url blah : \(url)")
        try! pdfData.write(to: url, options: [])
        webView.load(pdfData, mimeType: "application/pdf", characterEncodingName: "UTF-8", baseURL: URL(string: "http://localhost")!)
    }
    
    func createPDFData() -> Data{
        
        let pdfWidth = resume?.style.pageSize.width ?? 1200
        let pdfHeight = resume?.style.pageSize.height ?? 1500
        let pageView = ResumePageView(frame: .zero)
        pageView.frame = CGRect(x: 0, y: 0, width: pdfWidth, height: pdfHeight)
        pageView.layoutMargins = UIEdgeInsets(top: 0, left: 60, bottom: 20, right: 60)
        
        if #available(iOS 15.0, *) {
            view.overrideUserInterfaceStyle = .light
            view.minimumContentSizeCategory = .medium
            view.maximumContentSizeCategory = .medium
        } else {
            // Fallback on earlier versions
        }
        
        pageView.resume = resume
        
        let rect = CGRect(x: 0, y: 0, width: (8.5 * 600), height: (11 * 600))

        view.addSubview(pageView)

        let currentRenderer = UIGraphicsPDFRenderer(bounds: rect)
        
        let pdfData = currentRenderer.pdfData { (context) in
            context.beginPage()
            context.cgContext.scaleBy(x: 4.25, y: 4.25)
            
            self.currentRendererContext = context
            
            UIGraphicsPushContext(context.cgContext)
            PDFLabel.renderingPDF = true
            pageView.layer.render(in: context.cgContext)
            PDFLabel.renderingPDF = false
            UIGraphicsPopContext()
              
            self.currentRendererContext = nil
        }
        
        pageView.removeFromSuperview()
        return pdfData
    }
    
}

extension ResumeDisplayPageViewController : URLReceiver{
    
    @objc func drawUrl(_ url:URL, at rect:CGRect){
        guard let renderContext = currentRendererContext else{
            return
        }
        let urlRect = rect.applying(renderContext.cgContext.userSpaceToDeviceSpaceTransform)
        renderContext.setURL(url, for: urlRect)
    }
}

@objc protocol URLReceiver{
    func drawUrl(_ url:URL, at:CGRect)
}

extension ResumeDisplayPageViewController : WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else{
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        
        if url == URL(string: "http://localhost/") {
            decisionHandler(WKNavigationActionPolicy.allow)
        }else{
            decisionHandler(WKNavigationActionPolicy.cancel)

            (UIApplication.shared.delegate as? AppDelegate)?.openRemoteUrlLocally(url)
        }
    }
}

