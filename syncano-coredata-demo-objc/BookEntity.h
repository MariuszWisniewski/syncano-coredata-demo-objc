//
//  BookEntity.h
//  syncano-coredata-demo-objc
//
//  Created by Mariusz Wisniewski on 9/29/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Book.h"
#import <MagicalRecord/MagicalRecord.h>

@class AuthorEntity;

@interface BookEntity : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * bookId;
@property (nonatomic, retain) NSNumber * numberOfPages;
@property (nonatomic, retain) AuthorEntity *author;

@end

@interface BookEntity (Syncano)

+ (BookEntity *)createOrUpdateWithBook:(Book *)book inContext:(NSManagedObjectContext *)context;
+ (BookEntity *)bookWithId:(NSNumber *)bookId inContext:(NSManagedObjectContext *) context;

@end
