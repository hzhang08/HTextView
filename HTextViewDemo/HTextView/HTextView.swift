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
    
    func countParagraphs() -> Int
    {
        let stringComponents = self.text.componentsSeparatedByString("\n")
        var paragraphCount = 0
        
        for oneString in stringComponents
        {
            let oneMutableString = NSMutableString(string: oneString)
            while( oneMutableString.rangeOfString("\n").length > 0 )
            {
                oneMutableString.deleteCharactersInRange( oneMutableString.rangeOfString("\n"))
            }
            
            if oneMutableString.length > 0
            {
                paragraphCount++
            }
        }
        
        return paragraphCount
        
    }
    
    func getLineHeight() -> CGFloat
    {
        return self.font.lineHeight
    }
    
    func getTextRect() -> CGRect
    {
        if self.window == nil
        {
            NSException(name: "View Hierarchy Exception", reason: "The HTextView is not in the view hierarchy", userInfo: nil).raise()
        }
        
        let layoutManager = self.layoutManager
        let textContainer = self.textContainer
        let glyphCount = layoutManager.numberOfGlyphs
        let textRect = layoutManager.boundingRectForGlyphRange(NSMakeRange(0, glyphCount), inTextContainer: textContainer)
        
        return textRect
    }
    
    func highlightText(range: NSRange, color: UIColor)
    {
        let mutableString = self.attributedText.mutableCopy() as! NSMutableAttributedString
        
        var startingIndex = range.location
        
        while(startingIndex < range.location + range.length)
        {
        
        var effectiveRange = NSMakeRange(0, 0)
        var attributes = mutableString.attributesAtIndex(range.location, effectiveRange: &effectiveRange)
        attributes.updateValue(color, forKey: NSBackgroundColorAttributeName)
        
        if range.location + range.location > effectiveRange.location + effectiveRange.length
        {
            mutableString.setAttributes(attributes, range: effectiveRange)
        }
        else
        {
            let realStart = max(effectiveRange.location, range.location) //this edge case... effective range location might even be greater at first place
            let realEnd = range.location + range.length - 1
            let realLength = realEnd - realStart + 1
            mutableString.setAttributes(attributes, range: NSMakeRange(realStart, realLength))
        }
            
        startingIndex = effectiveRange.location + effectiveRange.length
            
        }
        self.attributedText = mutableString
    }
    
    func testGetAttributedText()->NSAttributedString
    {
        return self.attributedText
        //self.textContainer.
    }
    
    func testAlign()
    {
        let textStyle = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textStyle.alignment = NSTextAlignment.Center
        let textStyle1 = textStyle.mutableCopy() as! NSMutableParagraphStyle
        
        
        let mutableText = self.attributedText.mutableCopy() as! NSMutableAttributedString
        
        mutableText.setAttributes([NSParagraphStyleAttributeName : textStyle, NSFontAttributeName : self.font], range: NSMakeRange(0, 1))
        mutableText.setAttributes([NSFontAttributeName : self.font], range: NSMakeRange(1, 4))
        mutableText.setAttributes([NSParagraphStyleAttributeName : textStyle1, NSFontAttributeName : self.font], range: NSMakeRange(6, 1))
        mutableText.setAttributes([NSFontAttributeName : self.font], range: NSMakeRange(7, mutableText.length - 7))
        
        self.attributedText = mutableText
    }

}
