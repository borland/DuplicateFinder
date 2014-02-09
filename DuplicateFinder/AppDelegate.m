//
//  AppDelegate.m
//  DuplicateFinder
//
//  Created by Orion Edwards on 25/11/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import "AppDelegate.h"
#import "DFTableViewController.h"
#import "DFFile.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    DFTableViewController* controller = [[DFTableViewController alloc] init];

    DFFile* file = DFFile.new;
    file.leftFilePath = @"/Users/Foo/Bar.jpg";
    file.rightFilePath = @"/Users/Bar/Bar.jpg";
    file.size = 1024;
    file.hash = 300;
    
    [controller.foundFiles addObject:file];
    self.tableViewController = controller;
    
    self.mainTableView.delegate = controller;
    self.mainTableView.dataSource = controller;
}

- (IBAction)openDirectory:(id)sender {
    
    NSOpenPanel* openPanelDialog = [NSOpenPanel openPanel];
    openPanelDialog.canChooseFiles = NO;
    openPanelDialog.canChooseDirectories = YES;
    openPanelDialog.prompt = @"Select...";

    if([openPanelDialog runModal] == NSOKButton) {
        NSAlert* alert = [[NSAlert alloc] init];
        alert.messageText = [NSString stringWithFormat:@"You selected %@", [openPanelDialog.URL absoluteString]];
        [alert runModal];
    }
}
@end
