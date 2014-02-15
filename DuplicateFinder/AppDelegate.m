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

    DFFile* f1 = [DFFile fileWithLeft:@"/Users/Foo/Bar.jpg" right:@"/Users/Bar/Bar.jpg" size:1024 hash:300];
    DFFile* f2 = [DFFile fileWithLeft:@"/Users/Foo/X.jpg" right:@"/Users/Bar/X-2.jpg" size:2034951 hash:92];
    
    [controller.foundFiles addObject:f1];
    [controller.foundFiles addObject:f2];
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


- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    // This is a defensive move
    // There are cases where the nib containing the NSTableView can be loaded before the data is populated
    // by ensuring the count value is 0 and checking to see if the namesArray is not nil, the application
    // is protecting itself agains that situation
    NSInteger count=0;
    if (self.foundFiles)
        count=[self.foundFiles count];
    return count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)column row:(NSInteger)rowIndex
{
    // The column identifier string is the easiest way to identify a table column. Much easier
    // than keeping a reference to the table column object.
    NSString *columnIdentifer = [column identifier];
    
    // Get the name at the specified row in the namesArray
    DFFile *theFile = [self.foundFiles objectAtIndex:rowIndex];
    
    // Compare each column identifier and set the return value to
    // the Person field value appropriate for the column.
    if ([columnIdentifer isEqualToString:@"leftFilePath"]) {
        return theFile.leftFilePath;
    } else if( [columnIdentifer isEqualToString:@"rightFilePath"]) {
        return theFile.rightFilePath;
    } else if( [columnIdentifer isEqualToString:@"fileSize"]) {
        return @(theFile.size);
    }
    
    return nil;
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    
}

@end
