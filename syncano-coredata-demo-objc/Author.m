//
//  Author.m
//  syncano-coredata-demo-objc
//
//  Created by Mariusz Wisniewski on 9/29/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

#import "Author.h"

@implementation Author

//use to change iOS variable name to something else than used on Syncano
//in this case we're changing last_name and first_name defined in an Author class
//on Syncano, to lastName and firstName which is more iOS style

+ (NSDictionary *)extendedPropertiesMapping {
    return @{
            @"firstName":@"first_name",
            @"lastName":@"last_name"
            };
}

@end
