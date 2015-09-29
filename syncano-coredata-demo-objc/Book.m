//
//  Book.m
//  syncano-coredata-demo-objc
//
//  Created by Mariusz Wisniewski on 9/29/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

#import "Book.h"

@implementation Book

//use to change iOS variable name to something else than used on Syncano
//in this case we're changing number_of_pages defined in a Book class
//on Syncano, to numberOfPages which is more iOS style

+ (NSDictionary *)extendedPropertiesMapping {
    return @{
             @"numberOfPages":@"number_of_pages"
             };
}

@end
