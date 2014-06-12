//
//  RWFNoFilterAPIHelper.h
//  NoFilter
//
//  Created by Rick Feuer on 2/9/14.
//  Copyright (c) 2014 Rick Feuer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWFWebServiceHelper : NSObject

+ (id)sharedInstance;

-(NSString*)getDataForIdSynchronous:(int)itemId;

-(void)getDataForIdAsynchronous:(int)itemId completionBlock:(void (^)(NSString *responseString))completionBlock;

@end
