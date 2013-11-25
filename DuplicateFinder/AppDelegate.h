//
//  AppDelegate.h
//  DuplicateFinder
//
//  Created by Orion Edwards on 25/11/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
- (IBAction)openDirectory:(id)sender;

@property (weak) IBOutlet NSToolbarItem *toolbarOpenDirectory;
@property (weak) IBOutlet NSMenuItem *menuOpenDirectory;

@end
