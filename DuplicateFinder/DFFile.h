//
//  DFFile.h
//  DuplicateFinder
//
//  Created by Orion Edwards on 7/12/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFFile : NSObject

+(DFFile*)fileWithLeft:(NSString*)left right:(NSString*)right size:(NSUInteger)size hash:(NSUInteger)hash;

@property(nonatomic, copy) NSString* leftFilePath;
@property(nonatomic, copy) NSString* rightFilePath;

@property(nonatomic) NSUInteger size;
@property(nonatomic) NSUInteger hash;

@end
