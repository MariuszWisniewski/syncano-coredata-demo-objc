//
//  Book.h
//  syncano-coredata-demo-objc
//
//  Created by Mariusz Wisniewski on 9/29/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

#import <Syncano.h>
#import "Author.h"

@interface Book : SCDataObject

@property (strong) NSString *title;
@property (strong) NSNumber *numberOfPages;
@property (strong) Author *author;

@end
