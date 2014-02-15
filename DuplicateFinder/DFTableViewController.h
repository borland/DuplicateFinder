//
//  MainTableViewDataSource.h
//  DuplicateFinder
//
//  Created by Orion Edwards on 7/12/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DFFile;

@interface DFTableViewController : NSViewController<NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;

@property (nonatomic, strong) NSMutableArray* files;

-(void)addFile:(DFFile*)file;

@end
