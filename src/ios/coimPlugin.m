//
//  coimPlugin.m
//  pluginTest
//
//  Created by Mac on 2014/5/22.
//
//

#import "coimPlugin.h"
#import <Cordova/CDV.h>

@implementation coimPlugin
@synthesize command = _command;

- (void) getToken:(CDVInvokedUrlCommand *)command
{
    _command = command;
    [coimSDK initSDK:^(NSError *error){
        if (error) {
            [self.commandDelegate runInBackground:^{
                CDVPluginResult *pluginResult;
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        }
        else {
            NSString *token = [coimSDK getToken];
            if([token isEqualToString:@""]) {
                token = nil;
            }
            NSMutableDictionary *pluginResult = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"token", @"type", [coimSDK getToken], @"result", nil];
            [self.commandDelegate runInBackground:^{
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:pluginResult];
                [result setKeepCallbackAsBool:YES];
                [self.commandDelegate sendPluginResult:result callbackId:_command.callbackId];
            }];
            
            //CDVPluginResult *pluginResult;
            //pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[coimSDK getToken]];
            //[self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

- (void) checkNetwork:(CDVInvokedUrlCommand *)command
{
    _command = command;
    [coimSDK initSDK:^(NSError *error){
        if (error) {
            [self.commandDelegate runInBackground:^{
                CDVPluginResult *pluginResult;
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        }
        else {
            NSString *network = [coimSDK checkNetwork]? @"true":@"false";
            NSMutableDictionary *pluginResult = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"checkNetwork", @"type", network, @"result", nil];
            [self.commandDelegate runInBackground:^{
                CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:pluginResult];
                [result setKeepCallbackAsBool:YES];
                [self.commandDelegate sendPluginResult:result callbackId:_command.callbackId];
            }];
        }
    }];
}

- (void) send:(CDVInvokedUrlCommand *)command
{
    _command = command;
    [coimSDK initSDK:^(NSError *error){
        if (error) {
            [self.commandDelegate runInBackground:^{
                CDVPluginResult *pluginResult;
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        }
        else {
            NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[command.arguments objectAtIndex:0]];
            [coimSDK sendTo:[dic objectForKey:@"relativeURL"] withParameter:[dic objectForKey:@"param"] delegate:self];
        }
    }];
}

- (void) login:(CDVInvokedUrlCommand *)command
{
    _command = command;
    [coimSDK initSDK:^(NSError *error){
        if (error) {
            [self.commandDelegate runInBackground:^{
                CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        }
        else {
            NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[command.arguments objectAtIndex:0]];
            //if (dic != nil) {
            [coimSDK loginTo:[dic objectForKey:@"relativeURL"] withParameter:[dic objectForKey:@"param"] delegate:self];
            /*}
            else {
                [self.commandDelegate runInBackground:^{
                    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"failed"];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                }];
            }*/
        }
    }];
}

- (void) register:(CDVInvokedUrlCommand *)command
{
    _command = command;
    [coimSDK initSDK:^(NSError *error){
        if (error) {
            [self.commandDelegate runInBackground:^{
                CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        }
        else {
            NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[command.arguments objectAtIndex:0]];
            //if (dic != nil) {
            [coimSDK registerWithParameter:[dic objectForKey:@"param"] delegate:self];
            /*}
            else {
                [self.commandDelegate runInBackground:^{
                    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"failed"];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                }];
            }*/
            
        }
    }];
}

- (void) updPasswd:(CDVInvokedUrlCommand *)command
{
    _command = command;
    [coimSDK initSDK:^(NSError *error){
        if (error) {
            [self.commandDelegate runInBackground:^{
                CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        }
        else {
            NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[command.arguments objectAtIndex:0]];
            //if (dic != nil) {
            [coimSDK updatePasswd:[dic objectForKey:@"param"] delegate:self];
            /*}
            else {
                [self.commandDelegate runInBackground:^{
                    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"failed"];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                }];
            }*/
        }
    }];
}

- (void) logout:(CDVInvokedUrlCommand *)command
{
    _command = command;
    [coimSDK initSDK:^(NSError *error){
        if (error) {
            [self.commandDelegate runInBackground:^{
                CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        }
        else {
            //NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[command.arguments objectAtIndex:0]];
            //if (dic != nil) {
            [coimSDK logout:self];
            /*}
            else {
                [self.commandDelegate runInBackground:^{
                    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"failed"];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                }];
            }*/
        }
    }];
}

- (void) attach:(CDVInvokedUrlCommand *)command
{
    _command = command;
    [coimSDK initSDK:^(NSError *error){
        if (error) {
            [self.commandDelegate runInBackground:^{
                CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        }
        else {
            NSDictionary *dic = [[NSDictionary alloc] initWithDictionary:[command.arguments objectAtIndex:0]];
            //if (dic != nil) {
            NSArray *files = [dic objectForKey:@"files"];//[[NSArray alloc] initWithObjects:@"/Users/mac/Library/Application Support/iPhone Simulator/7.0/Applications/1B34C920-E3C5-4536-A8CB-7F4FF4341D50/Documents/latest_photo.png", nil];
            [coimSDK attachFiles:files To:[dic objectForKey:@"relativeURL"] withParams:[dic objectForKey:@"param"] delegate:self];
            /*}
            else {
                [self.commandDelegate runInBackground:^{
                    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"failed"];
                    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                }];
            }*/
        }
    }];
}

// coimDelegators

- (void)coimConnection:(NSURLConnection *)connection
        didReceiveData:(NSData *)data
{
    
}
    
// map to onFail
- (void)coimConnection:(NSURLConnection *)connection
      didFailWithError:(NSError *)error
{
        NSMutableDictionary *pluginResult = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"fail", @"type", [error localizedDescription], @"result", nil];
        [self.commandDelegate runInBackground:^{
            CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:pluginResult];
            [result setKeepCallbackAsBool:YES];
            [self.commandDelegate sendPluginResult:result callbackId:_command.callbackId];
        }];
}
// map to onSuccess
- (void)coimConnectionDidFinishLoading:(NSURLConnection *)connection
                              withData:(NSDictionary *)responseData
{
    NSMutableDictionary *pluginResult = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"success", @"type", responseData, @"result", nil];
    [self.commandDelegate runInBackground:^{
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:pluginResult];
        [result setKeepCallbackAsBool:YES];
        [self.commandDelegate sendPluginResult:result callbackId:_command.callbackId];
    }];
}
// map to onInvalidToken
- (void)coimConnectionInvalidToken:(NSURLConnection *)connection
{
    //[self.commandDelegate runInBackground:^(void){
        NSMutableDictionary *pluginResult = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"invalid", @"type", @"", @"result", nil];
        [self.commandDelegate runInBackground:^{
            CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:pluginResult];
            [result setKeepCallbackAsBool:YES];
            [self.commandDelegate sendPluginResult:result callbackId:_command.callbackId];
        }];
    //}];
    
}

//map to onProgress
- (void)coimConnection:(NSURLConnection *)connection progress:(float)percentage
{
    //[self.commandDelegate runInBackground:^(void){
        NSMutableDictionary *pluginResult = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"progress", @"type", [[NSString alloc] initWithFormat:@"%f", percentage] , @"result", nil];
        [self.commandDelegate runInBackground:^{
            CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:pluginResult];
            [result setKeepCallbackAsBool:YES];
            [self.commandDelegate sendPluginResult:result callbackId:_command.callbackId];
        }];
    //}];
}

@end
