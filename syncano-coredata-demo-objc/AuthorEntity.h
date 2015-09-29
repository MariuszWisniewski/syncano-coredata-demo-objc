//
//  AuthorEntity.h
//  syncano-coredata-demo-objc
//
//  Created by Mariusz Wisniewski on 9/29/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import <MagicalRecord/MagicalRecord.h>

#import "Author.h"

@class NSManagedObject;

@interface AuthorEntity : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * authorId;
@property (nonatomic, retain) NSSet *books;
@end

@interface AuthorEntity (CoreDataGeneratedAccessors)

- (void)addBooksObject:(NSManagedObject *)value;
- (void)removeBooksObject:(NSManagedObject *)value;
- (void)addBooks:(NSSet *)values;
- (void)removeBooks:(NSSet *)values;

@end

@interface AuthorEntity (Syncano)

+ (AuthorEntity *)createOrUpdateWithAuthor:(Author *)author inContext:(NSManagedObjectContext *)context;
+ (AuthorEntity *)authorWithId:(NSNumber *)authorId inContext:(NSManagedObjectContext *)context;

@end
