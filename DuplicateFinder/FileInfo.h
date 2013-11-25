//
//  FileInfo.h
//  DuplicateFinder
//
//  Created by Orion Edwards on 25/11/13.
//  Copyright (c) 2013 Orion Edwards. All rights reserved.
//

#ifndef __DuplicateFinder__FileInfo__
#define __DuplicateFinder__FileInfo__

#include <iostream>

class MyFileInfo {
    const std::string m_path;
public:
    MyFileInfo(const std::string& path);
    virtual ~MyFileInfo();
    
    int getLength();
};

#endif /* defined(__DuplicateFinder__FileInfo__) */
