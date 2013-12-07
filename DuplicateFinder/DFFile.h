//
//  DFFile.h
//  DuplicateFinder
//
//  Created by Orion Edwards on 7/12/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFFile : NSObject

@property(nonatomic, copy) NSString* leftFilePath;
@property(nonatomic, copy) NSString* rightFilePath;

@property(nonatomic) NSUInteger size;
@property(nonatomic) NSUInteger hash;

@end
