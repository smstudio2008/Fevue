//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface GlobalClass : NSObject
@property(nonatomic,strong)NSString *imageName;
@property(nonatomic,strong)NSDate *date;
@property(assign)BOOL isLocationSelected;
+(GlobalClass*)sharedObject;
@end
