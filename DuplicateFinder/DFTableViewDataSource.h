//
//  MainTableViewDataSource.h
//  DuplicateFinder
//
//  Created by Orion Edwards on 7/12/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFTableViewDataSource : NSObject<NSTableViewDelegate>
@property (nonatomic, strong) NSMutableArray* foundFiles;

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView;
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)column row:(NSInteger)rowIndex;
@end
