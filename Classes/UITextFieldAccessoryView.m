//
//  UITextFieldAccessoryView.m
//  YouTour
//
//  Created by dmorgant on 11/21/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import "UITextFieldAccessoryView.h"


@implementation UITextFieldAccessoryView

@synthesize inputAccessoryView;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
    [super dealloc];
}


@end
