//
//  MainTableViewDataSource.m
//  DuplicateFinder
//
//  Created by Orion Edwards on 7/12/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import "DFTableViewDataSource.h"
#import "DFFile.h"

@implementation DFTableViewDataSource

- (id)init {
    self = [super init];
    if(self ) {
        self.foundFiles = [[NSMutableArray alloc] init];
    }
    return self;
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
    // the return value is typed as (id) because it will return a string in all cases with the exception of the
    id returnValue=nil;
    
    // The column identifier string is the easiest way to identify a table column. Much easier
    // than keeping a reference to the table column object.
    NSString *columnIdentifer = [column identifier];
    
    // Get the name at the specified row in the namesArray
    DFFile *theFile = [self.foundFiles objectAtIndex:rowIndex];
    
    // Compare each column identifier and set the return value to
    // the Person field value appropriate for the column.
    if ([columnIdentifer isEqualToString:@"FirstFilePath"]) {
        returnValue = theFile.leftFilePath;
    }
    
    
    return returnValue;
}

@end
