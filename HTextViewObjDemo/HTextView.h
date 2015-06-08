//
//  HTextView.h
//  HTextViewObjDemo
//
//  Created by Change to ur account when u use on 6/4/15.
//  Copyright (c) 2015 com.foxit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTextView : UITextView

-(int) countLines;
-(CGRect) getRectForLineAtIndex: (int) index;
-(int) countParagraphs;
-(void) centerParagraphAtIndex:(int)index;
-(void) leftAlignParagraphAtIndex: (int)index;
-(void) rightAlignParagraphAtIndex: (int)index;
-(CGFloat) getLineHeight;
-(CGRect) getTextRect;
-(void) highlightTextIn: (NSRange) range with: (UIColor*)color;


@end
