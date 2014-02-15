//
//  AppDelegate.m
//  DuplicateFinder
//
//  Created by Orion Edwards on 25/11/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import "AppDelegate.h"
#import "DFWindowController.h"
#import "DFFile.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    DFFile* f1 = [DFFile fileWithLeft:@"/Users/Foo/Bar.jpg" right:@"/Users/Bar/Bar.jpg" size:1024 hash:300];
    DFFile* f2 = [DFFile fileWithLeft:@"/Users/Foo/X.jpg" right:@"/Users/Bar/X-2.jpg" size:2034951 hash:92];
    
    [self.windowController addFile:f1];
    [self.windowController addFile:f2];
}

@end
