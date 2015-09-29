//
//  ViewController.m
//  syncano-coredata-demo-objc
//
//  Created by Mariusz Wisniewski on 9/29/15.
//  Copyright (c) 2015 Mariusz Wisniewski. All rights reserved.
//

#import "ViewController.h"
#import <Syncano.h>

#import "AuthorEntity.h"
#import "BookEntity.h"

@interface ViewController ()
@property (strong, nonatomic) Syncano *syncano;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@interface ViewController (Syncano)
- (void)downloadBooks;
- (void)downloadAuthors;
- (void)saveBooksToDatabase:(NSArray *)books;
- (void)saveAuthorsToDatabase:(NSArray *)authors;
@end

@interface ViewController (UI)
@end

@implementation ViewController

- (Syncano *)syncano {
    if (_syncano == nil) {
        _syncano = [Syncano sharedInstanceWithApiKey:@"3d1f307cbe1f65c1f9cea9e796fb2b9ec2e8284b" instanceName:@"syncano-demo"];
    }
    return _syncano;
}

- (void)initSynano {
    [self syncano];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initSynano];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addToTextView:(NSString *)text {
    self.textView.text = [self.textView.text stringByAppendingFormat:@"%@\n\n",text];
    NSLog(@"text = %@",text);
    NSInteger length = self.textView.text.length;
    if (length > 0) {
        NSRange bottom = NSMakeRange(length - 1, 1);
        [self.textView scrollRangeToVisible:bottom];
    }
}

@end

@implementation ViewController (UI)

- (IBAction)downloadBooksPressed:(UIButton *)sender {
    [self downloadBooks];
}

- (IBAction)downloadAuthorsPressed:(UIButton *)sender {
    [self downloadAuthors];
}

- (IBAction)displayFromDatabasePressed:(UIButton *)sender {
    NSArray *authorEntities = [AuthorEntity MR_findAll];
    NSArray *bookEntities = [BookEntity MR_findAll];
    [self addToTextView:@"\n\n------"];
    for (AuthorEntity *author in authorEntities) {
        [self addToTextView:[NSString stringWithFormat:@"Author: %@ %@", author.firstName, author.lastName]];
    }
    for (BookEntity *book in bookEntities) {
        [self addToTextView:[NSString stringWithFormat:@"Book: %@ by %@ %@",book.title, book.author.firstName, book.author.lastName]];
    }
}

@end

@implementation ViewController (Syncano)

- (void)downloadBooks {
    [self addToTextView:@"Downloading books..."];
    [[Book please] giveMeDataObjectsWithCompletion:^(NSArray *books, NSError *error) {
        [self addToTextView:@"Downloaded books. Saving..."];
        [self saveBooksToDatabase:books];
    }];
}

- (void)downloadAuthors {
    [self addToTextView:@"Downloading authors..."];
    [[Author please] giveMeDataObjectsWithCompletion:^(NSArray *authors, NSError *error) {
        [self addToTextView:@"Downloaded authors. Saving..."];
        [self saveAuthorsToDatabase:authors];
        
    }];
}

- (void)saveBooksToDatabase:(NSArray *)books {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        for (Book *book in books) {
            [BookEntity createOrUpdateWithBook:book inContext:localContext];
        }
    } completion:^(BOOL contextDidSave, NSError *error) {
        [self addToTextView:@"Downloaded and saved Books."];
    }];
}

- (void)saveAuthorsToDatabase:(NSArray *)authors {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        for (Author *author in authors) {
            [AuthorEntity createOrUpdateWithAuthor:author inContext:localContext];
        }
    } completion:^(BOOL contextDidSave, NSError *error) {
        [self addToTextView:@"Downloaded and saved Authors."];
    }];
}

@end
