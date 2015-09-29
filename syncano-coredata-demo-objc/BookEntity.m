//
//  BookEntity.m
//  syncano-coredata-demo-objc
//
//  Created by Mariusz Wisniewski on 9/29/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

#import "BookEntity.h"
#import "AuthorEntity.h"

@implementation BookEntity

@dynamic title;
@dynamic bookId;
@dynamic numberOfPages;
@dynamic author;

@end

@implementation BookEntity (Syncano)

+ (BookEntity *)createOrUpdateWithBook:(Book *)book inContext:(NSManagedObjectContext *)context {
    BookEntity* bookEntity = [self bookWithId:book.objectId inContext:context];
    if (bookEntity == nil) {
        bookEntity = [BookEntity MR_createEntityInContext:context];
    }
    bookEntity.title = book.title;
    bookEntity.numberOfPages = book.numberOfPages;
    bookEntity.bookId = book.objectId;
    NSNumber *authorId = book.author.objectId;
    if (authorId != nil) {
        AuthorEntity* authorEntity = [AuthorEntity authorWithId:authorId inContext:context];
        if (authorEntity == nil) {
            authorEntity = [AuthorEntity createOrUpdateWithAuthor:book.author inContext:context];
        }
        bookEntity.author = authorEntity;
    }
    return bookEntity;
}

+ (BookEntity *)bookWithId:(NSNumber *)bookId inContext:(NSManagedObjectContext *) context {
    BookEntity *bookEntity = [BookEntity MR_findFirstByAttribute:@"bookId" withValue:bookId inContext: context];
    return bookEntity;
}

@end
