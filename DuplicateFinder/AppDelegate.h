//
//  AppDelegate.h
//  DuplicateFinder
//
//  Created by Orion Edwards on 25/11/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DFWindowController;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong) DFWindowController* windowController;

@end
