//
//  ViewController.swift
//  HTextViewDemo
//
//  Created by Change to ur account when u use on 4/28/15.
//  Copyright (c) 2015 hangoutstudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var hTextView: HTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let filePath = NSBundle.mainBundle().pathForResource("text", ofType: "")!
        hTextView.text = String(contentsOfFile: filePath, encoding: NSUTF8StringEncoding, error: nil)
        //hTextView.testAlign()
        //println("this text view has \(hTextView.countLines()) lines")
        
        println("this text view has \(hTextView.countParagraphs()) paragraphs")
        println("this text view's line height is \(hTextView.getLineHeight())")
        
        
    }
    
    override func viewDidAppear(animated: Bool) {

        println("this text view has \(hTextView.countLines()) lines")
        println("this text view's text rect is \(hTextView.getTextRect())")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.All.rawValue)
    }
    
    @IBAction func buttonClicked(button: UIButton)
    {
        hTextView.removeFromSuperview()
        println("this text view has \(hTextView.countLines()) lines")
    }
    
    @IBAction func testButtonClicked(button: UIButton)
    {
        //hTextView.testAlign()
        hTextView.highlightText(NSMakeRange(120, 1), color: UIColor.greenColor())
        //hTextView.highlightText(NSMakeRange(7, 100), color: UIColor.redColor())
        
        for i in 0 ..< 3
        {
            println(hTextView.getRectForLineAtIndex(i))
        }
    }
}

