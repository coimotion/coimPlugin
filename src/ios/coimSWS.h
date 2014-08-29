//
//  coimSWS.h
//  coimSWS
//
//  Created by Mac on 2014/8/14.
//  Copyright (c) 2014年 Gocharm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "coimSDK.h"
@interface coimSWS : NSObject

+ (void)initSWS:(void (^)(NSError *))errBlock;

+ (void)checkFBWithDelegate:(id)aDelegate;
+ (void)checkFBWithDelegate:(id)aDelegate andScope:(NSString *)scope;
+ (void)FBLoginFromVC:(UIViewController *)VC withDelegate:(id)aDelegate;
+ (void)FBLoginFromVC:(UIViewController *)VC withDelegate:(id)aDelegate andScope:(NSString *)scopes;
+ (void)FBPostMessage:(NSString *)message delegate:(id)aDelegate;
//+ (void)FBPostPhoto:(NSString *)imageSource delegate:(id)aDelegate;
//+ (void)FBPostPhoto:(NSString *)imageSource withMessage:(NSString *)message delegate:(id)aDelegate;
+ (void)FBPostPhoto:(NSMutableDictionary *)params delegate:(id)aDelegate;
+ (void)FBGraph:(NSDictionary *)params delegate:(id)aDelegate;

+ (void)checkGLWithDelegate:(id)aDelegate;
+ (void)checkGLWithDelegate:(id)aDelegate andScope:(NSString *)scope;
+ (void)GLLoginFromVC:(UIViewController *)VC withDelegate:(id)aDelegate;
+ (void)GLLoginFromVC:(UIViewController *)VC withDelegate:(id)aDelegate andScope:(NSString *)scopes;
+ (void)GooglePlus:(NSDictionary *)params delegate:(id)aDelegate;

+(void)checkLogin:(id)aDelegate;
@end
