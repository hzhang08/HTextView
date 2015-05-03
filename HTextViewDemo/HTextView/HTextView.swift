//
//  HTextView.swift
//  HTextViewDemo
//
//  Created by Hong Zhang on 4/28/15.
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
    
    func getRectForLineAtIndex(index: Int)->CGRect
    {
        
        let lineCount = countLines()
        if index >= lineCount
        {
            NSException(name: "Parameter Error", reason: "index out of bound", userInfo: nil).raise()
        }
        
        let layoutManager = self.layoutManager
        let textContainer = self.textContainer
        let glyphCount = layoutManager.numberOfGlyphs
        
        var glyphIndex = 0
        var lineIndex = -1
        while( glyphIndex < glyphCount )
        {
            var glyphRange = NSMakeRange(0, 0)
            
            var lineRect = layoutManager.lineFragmentUsedRectForGlyphAtIndex(glyphIndex, effectiveRange: &glyphRange)
            
            lineRect.origin.x += textContainer.lineFragmentPadding
            lineRect.size.width -= textContainer.lineFragmentPadding
            
            lineIndex++
            
            if index == lineIndex
            {
                return lineRect
            }
            
            glyphIndex = glyphRange.location + glyphRange.length
        }
        
        NSException(name: "HTextView Error", reason: "Please contact the author mahone08@gmail.com for this SDK bug -- error info: getRectForLineAtIndex not supposed to reach here", userInfo: nil).raise()

        return CGRectMake(-1, -1, -1, -1)
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
