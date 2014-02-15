//
//  MainTableViewDataSource.m
//  DuplicateFinder
//
//  Created by Orion Edwards on 7/12/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import "DFTableViewController.h"
#import "DFFile.h"

@implementation DFTableViewController

- (id)init {
    self = [super init];
    if(self ) {
        self.foundFiles = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
