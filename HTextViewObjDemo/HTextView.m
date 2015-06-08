//  The MIT License (MIT)
//
//  Copyright (c) 2015 Hong Zhang
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.

#import "HTextView.h"

@implementation HTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(int)countLines
{
    if (self.window == nil) {
        [[NSException exceptionWithName:@"View Hierarchy Exception" reason:@"The HTextView is not in the view hierarchy" userInfo:nil] raise];
    }
    
    NSLayoutManager* layoutManager = self.layoutManager;
    NSTextContainer* textContainer = self.textContainer;
    int glyphCount = (int)[layoutManager numberOfGlyphs];
    CGRect textRect = [layoutManager boundingRectForGlyphRange:NSMakeRange(0, glyphCount) inTextContainer:textContainer];
    
    CGFloat fontHeight = self.font.lineHeight;
    
    return textRect.size.height / fontHeight;
}

- (CGRect)getRectForLineAtIndex:(int)index
{
    int lineCount = [self countLines];
    if (index >= lineCount) {
        [[NSException exceptionWithName:@"Parameter Error" reason:@"index out of bound" userInfo:nil] raise];
    }
    
    NSLayoutManager* layoutManager = self.layoutManager;
    NSTextContainer* textContainer = self.textContainer;
    int glyphCount = (int)layoutManager.numberOfGlyphs;
    
    int glyphIndex = 0;
    int lineIndex = -1;
    
    while (glyphIndex < glyphCount) {
        
        NSRange glyphRange = NSMakeRange(0, 0);
        CGRect lineRect = [layoutManager lineFragmentRectForGlyphAtIndex:glyphIndex effectiveRange:&glyphRange];
        
        lineRect.origin.x += textContainer.lineFragmentPadding;
        lineRect.size.width -= textContainer.lineFragmentPadding;
        
        lineIndex++;
        
        if (index == lineIndex) {
            return lineRect;
        }
        
        glyphIndex = (int)glyphRange.location + (int)glyphRange.length;
        
    }
    
    [[NSException exceptionWithName:@"HTextView Error" reason:@"Please contact the author mahone08@gmail.com for this SDK bug -- error info: getRectForLineAtIndex not supposed to reach here" userInfo:nil] raise];
    
    return CGRectMake(-1, -1, -1, -1);
}


-(int)countParagraphs
{

    NSArray* stringComponents = [self.text componentsSeparatedByString:@"\n"];
    int paragraphCount = 0;
    
    for(NSString* oneString in stringComponents)
    {
        NSMutableString* oneMutableString = [NSMutableString stringWithString:oneString];
        
        while ( [oneMutableString rangeOfString:@"\n"].length > 0 ) {
            [oneMutableString deleteCharactersInRange: [oneMutableString rangeOfString:@"\n"]];
        }
        
        if (oneMutableString.length > 0) {
            paragraphCount++;
        }
        
    }
    
    return paragraphCount;
    
}

-(void) centerParagraphAtIndex:(int)index
{
    [self changeAlignmentForParagraphAtIndex:index toAlignment:NSTextAlignmentCenter];
}

-(void)leftAlignParagraphAtIndex:(int)index
{
    [self changeAlignmentForParagraphAtIndex:index toAlignment:NSTextAlignmentLeft];
}

-(void)rightAlignParagraphAtIndex:(int)index
{
    [self changeAlignmentForParagraphAtIndex:index toAlignment:NSTextAlignmentRight];
}

-(void)changeAlignmentForParagraphAtIndex: (int)index toAlignment: (NSTextAlignment) alignment
{
    int paragraphCount = [self countParagraphs];
    if (index >= paragraphCount) {
        [[NSException exceptionWithName:@"HTextView Error" reason:@"Paragraph index is out of bound" userInfo:nil] raise];
    }
    
    NSArray* stringComponents = [self.text componentsSeparatedByString:@"\n"];
    
    int paragraphIndex = -1;
    int textLength = 0;
    NSMutableAttributedString* mutableString = [self.attributedText mutableCopy];
    
    for (NSString* oneString in stringComponents) {
        
        int oneStringLength = (int)oneString.length;
        if (oneStringLength > 0) {
            paragraphIndex++;
        }
        
        int startingIndex = textLength;
        
        int previousTextLength = textLength;
        textLength += oneStringLength;
        textLength += 1;
        
        if (paragraphIndex == index) {
            while (startingIndex < textLength) {
                
                NSRange effectiveRange = NSMakeRange(0, 0);
                NSDictionary* attributes = [mutableString attributesAtIndex:startingIndex effectiveRange:&effectiveRange];
                NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
                
                textStyle.alignment = alignment;
                [attributes setValue:textStyle forKey:NSParagraphStyleAttributeName];
                
                if (textLength > effectiveRange.location + effectiveRange.length) {
                    
                    int realStart = (int)MAX(effectiveRange.location, previousTextLength);
                    int realEnd = (int)(effectiveRange.location + effectiveRange.length);
                    
                    int realLength = realEnd - realStart;
                    [mutableString setAttributes:attributes range:NSMakeRange(realStart, realLength)];
                    
                }
                else
                {
                    
                    //actually should not reach here
                    int realStart = (int)MAX(effectiveRange.location, previousTextLength);
                    int realEnd = textLength - 1;
                    int realLength = realEnd - realStart;
                    [mutableString setAttributes:attributes range:NSMakeRange(realStart, realLength)];
                    
                }//else
                
                startingIndex = (int)(effectiveRange.location + effectiveRange.length);
                
            }//while
            
            self.attributedText = mutableString;
            return;
        }//if
        
    }//for
    
}//function

-(CGFloat)getLineHeight
{
    return self.font.lineHeight;
}

-(CGRect)getTextRect
{
    if (self.window == nil) {
        [[NSException exceptionWithName:@"View Hierarchy Exception" reason:@"The HTextView is not in the view hierarchy" userInfo:nil] raise];
    }
    
    NSLayoutManager* layoutManager = self.layoutManager;
    NSTextContainer* textContainer = self.textContainer;
    int glyphCount = (int)layoutManager.numberOfGlyphs;
    CGRect textRect = [layoutManager boundingRectForGlyphRange:NSMakeRange(0, glyphCount) inTextContainer:textContainer];
    
    
    return textRect;
    
}

-(void)highlightTextIn:(NSRange)range with:(UIColor *)color
{
    NSMutableAttributedString* mutableString = [self.attributedText mutableCopy];
    
    int startingIndex = (int)range.location;
    
    while (startingIndex < range.location + range.length) {
        NSRange effectiveRange = NSMakeRange(0, 0);
        
        NSDictionary* attributes = [mutableString attributesAtIndex:range.location effectiveRange:&effectiveRange];
        [attributes setValue:color forKey:NSBackgroundColorAttributeName];
        
        if (range.location + range.length > effectiveRange.location + effectiveRange.length) {
            [mutableString setAttributes:attributes range:effectiveRange];
        }
        else
        {
            int realStart = (int)MAX(effectiveRange.location, range.location);
            int realEnd = (int)(range.location + range.length - 1);
            int realLength = realEnd - realStart + 1;
            
            [mutableString setAttributes:attributes range:NSMakeRange(realStart, realLength)];
        }
        
        self.attributedText = mutableString;
        
    }
}

@end
