//
//  MainTableViewDataSource.m
//  DuplicateFinder
//
//  Created by Orion Edwards on 7/12/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import "DFTableViewController.h"
#import "DFFile.h"
#import "AppDelegate.h"

@implementation DFTableViewController

- (id)init {
    self = [super init];
    if(self ) {
        self.files = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)awakeFromNib {
    AppDelegate* appDelegate = [NSApplication sharedApplication].delegate;
    appDelegate.tableViewController = self;
}

-(void)addFile:(DFFile*)file {
    [self.files addObject:file];
    
    [self.tableView beginUpdates];
    
    [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:self.files.count] withAnimation:NSTableViewAnimationEffectFade];
    
    [self.tableView endUpdates];
}

#pragma mark - TableView

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    if (self.files)
        return self.files.count;
    return 0;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)column row:(NSInteger)rowIndex
{
    // The column identifier string is the easiest way to identify a table column. Much easier
    // than keeping a reference to the table column object.
    NSString *columnIdentifer = [column identifier];
    
    // Get the name at the specified row in the namesArray
    DFFile *theFile = [self.files objectAtIndex:rowIndex];
    
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
