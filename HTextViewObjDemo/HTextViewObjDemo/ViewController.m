//
//  ViewController.m
//  HTextViewObjDemo
//
//  Created by Change to ur account when u use on 6/4/15.
//  Copyright (c) 2015 com.foxit. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString* filePath = [[NSBundle mainBundle]pathForResource:@"text" ofType:@""];
    hTextView.text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    NSLog(@"this text view has %d paragraphs", [hTextView countParagraphs]);
    NSLog(@"this text view's line height is %f", [hTextView getLineHeight]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
