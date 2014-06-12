//
//  webserviceTestTests.m
//  webserviceTestTests
//
//  Created by Rick Feuer on 6/10/14.
//  Copyright (c) 2014 Rick Feuer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RWFWebServiceHelper.h"

@interface webserviceTestTests : XCTestCase

@end

@implementation webserviceTestTests

RWFWebServiceHelper *helper = nil;

- (void)setUp
{
    [super setUp];
    
    helper = [RWFWebServiceHelper sharedInstance];
}

- (void)tearDown
{
    [super tearDown];
    
    helper = nil;
}

- (void)testGetDataForIdSynchronous
{
    NSInteger myId = 1;
    NSString *response = [helper getDataForIdSynchronous:myId];
    
    NSLog(@"%@", response);
    
    NSString *compareString = [NSString stringWithFormat:@"You entered: %ld", (long)myId];
    
    XCTAssert([response isEqualToString: compareString], @"response is not as expected!");
}



- (void)testGetDataForIdAsynchronous
{
    NSInteger myId = 1;
    __block NSString *response = nil;
    [helper getDataForIdAsynchronous:myId completionBlock:^(NSString *responseString) {
        response = responseString;
    }];
    
    while (response == nil) {
        ;
    }
    
    NSString *compareString = [NSString stringWithFormat:@"You entered: %ld", (long)myId];
    
    XCTAssert([response isEqualToString: compareString], @"response is not as expected!");
}

@end
