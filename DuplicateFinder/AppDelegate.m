//
//  AppDelegate.m
//  DuplicateFinder
//
//  Created by Orion Edwards on 25/11/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import "AppDelegate.h"
#import "DFTableViewDataSource.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    self.dataSource = [[DFTableViewDataSource alloc] init];
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
