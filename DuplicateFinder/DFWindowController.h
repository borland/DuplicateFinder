//
//  MainTableViewDataSource.h
//  DuplicateFinder
//
//  Created by Orion Edwards on 7/12/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DFFile;

@interface DFWindowController : NSWindowController<NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSToolbarItem *deleteLeftToolbarItem;
@property (weak) IBOutlet NSToolbarItem *deleteRightToolbarItem;

- (IBAction)openDirectory:(id)sender;
- (IBAction)deleteLeft:(id)sender;
- (IBAction)deleteRight:(id)sender;


@property (nonatomic, strong) NSMutableArray* files;

-(void)addFile:(DFFile*)file;

@end
