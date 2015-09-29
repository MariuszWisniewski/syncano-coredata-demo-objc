//
//  AuthorEntity.m
//  syncano-coredata-demo-objc
//
//  Created by Mariusz Wisniewski on 9/29/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

#import "AuthorEntity.h"

@implementation AuthorEntity

@dynamic firstName;
@dynamic lastName;
@dynamic authorId;
@dynamic books;

@end

@implementation AuthorEntity (Syncano)

+ (AuthorEntity *)createOrUpdateWithAuthor:(Author *)author inContext:(NSManagedObjectContext *)context {
    AuthorEntity *authorEntity = [self authorWithId:author.objectId inContext:context];
    if (authorEntity == nil) {
        authorEntity = [AuthorEntity MR_createEntityInContext:context];
    }
    authorEntity.firstName = author.firstName;
    authorEntity.lastName = author.lastName;
    authorEntity.authorId = author.objectId;
    return authorEntity;
}

+ (AuthorEntity *)authorWithId:(NSNumber *)authorId inContext:(NSManagedObjectContext *)context {
    AuthorEntity *authorEntity = [AuthorEntity MR_findFirstByAttribute:@"authorId" withValue:authorId inContext: context];
    return authorEntity;
}

@end
