//
//  Created by fevue on 5/7/14.
//  Copyright (c) 2014 fevue. All rights reserved.
//

#import "GlobalClass.h"

@implementation GlobalClass
-(id)init
{
    if(self=[super init])
    {
        self.imageName=@"";
        self.isLocationSelected=NO;
        self.date=[[NSDate alloc]init];
    }
    return self;
}
+(GlobalClass*)sharedObject
{
    static GlobalClass *sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedInstance=[[GlobalClass alloc]init];
    });
    return sharedInstance;
}

@end

