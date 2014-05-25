//
//  MainTableViewDataSource.m
//  DuplicateFinder
//
//  Created by Orion Edwards on 7/12/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

#import "DFWindowController.h"
#import "DFFile.h"
#import "AppDelegate.h"

#pragma mark - Utility Class
@interface FileWithHash : NSObject
@property(nonatomic, readonly)NSURL* file;
@property(nonatomic, readonly)NSNumber* size;
@property(nonatomic)NSData* hash;

-(id)initWithFile:(NSURL*)file size:(NSNumber*)size;
@end

@implementation FileWithHash

-(id)initWithFile:(NSURL*)file size:(NSNumber*)size {
    if(self = [super init]) {
        _file = file;
        _size = size;
    }
    return self;
}

@end

#pragma mark - DFWindowController

@implementation DFWindowController {
    dispatch_queue_t _gathererQueue;
    dispatch_queue_t _verifierQueue;
    
    NSMutableDictionary*  _filesBySize; // only access via _gatherer. Keys are (NSNumber*)size and (FileWithHash*)file
}

- (id)init {
    self = [super init];
    if(self ) {
        self.files = [[NSMutableArray alloc] init];
        _gathererQueue = dispatch_queue_create("file gatherer", DISPATCH_QUEUE_SERIAL);
        _verifierQueue = dispatch_queue_create("file verifier", DISPATCH_QUEUE_SERIAL);
        _filesBySize = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)awakeFromNib {
    AppDelegate* appDelegate = [NSApplication sharedApplication].delegate;
    appDelegate.windowController = self; // TODO appdelegate may have multiple windows
}

-(void)addFile:(DFFile*)file {
    [self.files addObject:file];
    
    [self.tableView beginUpdates];
    
    [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:self.files.count] withAnimation:0];
    
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

# pragma mark - Event Handlers


- (IBAction)openDirectory:(id)sender {
    
    NSOpenPanel* openPanelDialog = [NSOpenPanel openPanel];
    openPanelDialog.canChooseFiles = NO;
    openPanelDialog.canChooseDirectories = YES;
    openPanelDialog.prompt = @"Select...";
    
    if([openPanelDialog runModal] == NSOKButton) {
        [self clearList];
        [self findDuplicatesInDirectory:openPanelDialog.URL];
    }
}

- (IBAction)deleteLeft:(id)sender {
}

- (IBAction)deleteRight:(id)sender {
}

#pragma mark - Logic

-(void)clearList {
    [self.files removeAllObjects];
    [self.tableView reloadData];
}

-(void)findDuplicatesInDirectory:(NSURL*)directoryURL {
    dispatch_async(_gathererQueue, ^{
        _filesBySize = [[NSMutableDictionary alloc] init];
        NSFileManager *fileManager = NSFileManager.new;
        
        NSDirectoryEnumerator *enumerator = [fileManager
                                             enumeratorAtURL:directoryURL
                                             includingPropertiesForKeys:@[ NSURLIsDirectoryKey ]
                                             options:0
                                             errorHandler:^(NSURL *url, NSError *error) {
                                                 // Handle the error.
                                                 // Return YES if the enumeration should continue after the error.
                                                 return YES;
                                             }];
        
        for (NSURL *url in enumerator) { 
            NSError *error;
            NSNumber *isDirectory = nil;
            if (![url getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error]) {
                // if we can't ask if something is a directory, something is wrong, just ignore it
            }
            else if (! [isDirectory boolValue]) {
                [self processFile:url]; // processFile will add a bunch of stuff to _verifierQueue
            }
        }
        
        dispatch_async(_verifierQueue, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSAlert *alert = [[NSAlert alloc] init];
                alert.messageText = @"Done";
                [alert runModal];
            });
        });
    });
}

-(void)verifyFiles:(NSArray*) files {
    NSMutableSet* hashes = NSMutableSet.new;
    
    for(FileWithHash* f in files) {
        if(!f.hash) {
            // read the first 1k and hash it
            NSError* error;
            NSFileHandle* fileHandle = [NSFileHandle fileHandleForReadingFromURL:f.file error:&error];
            if(error) { // can't read the file, bail. TODO we should take it out of the array
                continue;
            }
            
            NSData* data = [fileHandle readDataOfLength:1000];
            uint8_t digest[CC_SHA1_DIGEST_LENGTH];
            
            CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
            
            f.hash = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
            
//            NSLog(@"hashed %@ to %@", f.file, [f.hash base64EncodedStringWithOptions:0]);
        }
        
        if([hashes containsObject:f.hash]) { // duplicate!
            NSIndexSet* duplicateOfIndexes = [files indexesOfObjectsPassingTest:^BOOL(FileWithHash* obj, NSUInteger idx, BOOL *stop) {
                return obj != f && [obj.hash isEqualToData:f.hash];
            }];
            
            NSArray* duplicateOf = [files objectsAtIndexes:duplicateOfIndexes];

            for(FileWithHash* dupe in duplicateOf) {
                DFFile* dff = [DFFile fileWithLeft:f.file.absoluteString
                                             right:dupe.file.absoluteString
                                              size:f.size.unsignedIntegerValue
                                              hash:0];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self addFile:dff];
                });
            }
        } else {
            [hashes addObject:f.hash];
        }
    }
}

-(void)processFile:(NSURL*)url {
    NSNumber* fileSize;
    NSError* error;
    if([url getResourceValue:&fileSize forKey:NSURLFileSizeKey error:&error] ){
        if([fileSize isEqualToNumber:@(0)]) {
            return; // skip zero byte files
        }
        
        NSMutableArray* x;
        if((x = [_filesBySize objectForKey:fileSize])) {
            [x addObject:[[FileWithHash alloc] initWithFile:url size:fileSize]];
            
            NSArray* xcopy = x.copy;
//            NSLog(@"multiple files with same size: %@", xcopy);
            dispatch_async(_verifierQueue, ^{
                [self verifyFiles:xcopy];
            });
        } else {
            x = NSMutableArray.new;
            [_filesBySize setObject:x forKey:fileSize];
            [x addObject:[[FileWithHash alloc] initWithFile:url size:fileSize]];
        }
    }
}


@end
