//
//  HTextView.swift
//  HTextViewDemo
//
//  Created by Change to ur account when u use on 4/28/15.
//  Copyright (c) 2015 hangoutstudio. All rights reserved.
//

import UIKit

class HTextView : UITextView
{
    
    func countLines()->Int
    {
        
        if self.window == nil
        {
            NSException(name: "View Hierarchy Exception", reason: "The HTextView is not in the view hierarchy", userInfo: nil).raise()
        }
        
        let layoutManager = self.layoutManager
        let textContainer = self.textContainer
        let glyphCount = layoutManager.numberOfGlyphs
        let textRect = layoutManager.boundingRectForGlyphRange(NSMakeRange(0, glyphCount), inTextContainer: textContainer)
        let fontHeight = self.font.lineHeight
        
        
        return Int(textRect.height/fontHeight) //it will be an integer

    }
    
    func testGetAttributedText()->NSAttributedString
    {
        return self.attributedText
        //self.textContainer.
    }

}
