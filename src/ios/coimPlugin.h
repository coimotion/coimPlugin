//
//  coimPlugin.h
//  pluginTest
//
//  Created by Mac on 2014/5/22.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>


@interface coimPlugin : CDVPlugin

@property (strong, nonatomic) CDVInvokedUrlCommand *command;
@end
