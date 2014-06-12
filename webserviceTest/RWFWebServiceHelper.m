//
//  RWFNoFilterAPIHelper.m
//  NoFilter
//
//  Created by Rick Feuer on 2/9/14.
//  Copyright (c) 2014 Rick Feuer. All rights reserved.
//

#import "RWFWebServiceHelper.h"

@interface RWFWebServiceHelper()



@end

@implementation RWFWebServiceHelper

//base url
NSString* const urlBase = @"http://testwcf.swivell.com/";

//endpoints
NSString* const urlDataEndpoint = @"/data/";
NSString* const urlData2Endpoint = @"/data2/";

+ (instancetype)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [self new];
    });
    
    return sharedInstance;
}

-(id)init
{
    if(self = [super init])
    {
        return self;
    }
    
    return nil;
}

#pragma mark - public methods


-(NSString*)getDataForIdSynchronous:(int)itemId
{
    
    NSString *strId = [[NSString alloc] initWithFormat:@"%i",itemId];
    
    NSString *fullURLPath = [[urlBase stringByAppendingPathComponent:urlDataEndpoint] stringByAppendingPathComponent:strId];

    NSURL *url = [NSURL URLWithString:fullURLPath];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:nil
                                                     error:nil];
    
    NSString *stringData = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"Content"];
    
    return stringData;
}


-(void)getDataForIdAsynchronous:(int)itemId completionBlock:(void (^)(NSString *responseString))completionBlock
{
    
    NSString *strId = [[NSString alloc] initWithFormat:@"%i",itemId];
    
    NSString *fullURLPath = [[urlBase stringByAppendingPathComponent:urlDataEndpoint] stringByAppendingPathComponent:strId];
    
    NSURL *url = [NSURL URLWithString:fullURLPath];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                            completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
                            {
                                
                                NSString *stringData = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] objectForKey:@"Content"];
                                
                                if(completionBlock)
                                    return completionBlock(stringData);
                                              
                            }];
    
}

@end
