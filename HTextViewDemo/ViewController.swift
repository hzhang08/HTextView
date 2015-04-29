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
        //println("this text view has \(hTextView.countLines()) lines")

    }
    
    override func viewDidAppear(animated: Bool) {

        println("this text view has \(hTextView.countLines()) lines")
        
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
}

