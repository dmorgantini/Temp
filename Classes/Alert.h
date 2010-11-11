//
//  Alert.h
//  YouTour
//
//  Created by dmorgant on 10/31/10.
//  Copyright (c) 2010 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Alert : NSObject {

}

+(void) showAlert:(NSString*) title
      withMessage:(NSString*) message;

@end
