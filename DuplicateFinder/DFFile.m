//
//  DFFile.m
//  DuplicateFinder
//
//  Created by Orion Edwards on 7/12/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import "DFFile.h"

@implementation DFFile

+(DFFile*)fileWithLeft:(NSString*)left right:(NSString*)right size:(NSUInteger)size hash:(NSUInteger)hash {
    DFFile* f = DFFile.new;
    f.leftFilePath = left;
    f.rightFilePath = right;
    f.size = size;
    f.hash = hash;
    return f;
}

@end
