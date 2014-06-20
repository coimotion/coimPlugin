//
//  coimPlugin.h
//  pluginTest
//
//  Created by Mac on 2014/5/22.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "coimSDK.h"

@interface coimPlugin : CDVPlugin

@property (strong, nonatomic) CDVInvokedUrlCommand *command;
- (void) getToken:(CDVInvokedUrlCommand *)command;
- (void) send:(CDVInvokedUrlCommand *)command;
- (void) login:(CDVInvokedUrlCommand *)command;
- (void) register:(CDVInvokedUrlCommand *)command;
- (void) updPasswd:(CDVInvokedUrlCommand *)command;
- (void) logout:(CDVInvokedUrlCommand *)command;
- (void) attach:(CDVInvokedUrlCommand *)command;
@end
