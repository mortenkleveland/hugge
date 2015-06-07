//
//  ViewController.m
//  Hügge
//
//  Created by Morten Kleveland on 07.06.15.
//  Copyright (c) 2015 Morten G. Kleveland. All rights reserved.
//

#import "ViewController.h"
#import "Tempo.h"
#import "Genre.h"
#import "TimeSignature.h"

@interface ViewController ()

@end

NSMutableSet *tempos;
NSMutableSet *genres;
NSMutableSet *timeSignatures;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tempos = [[NSMutableSet alloc]init];
    genres = [[NSMutableSet alloc]init];
    timeSignatures = [[NSMutableSet alloc]init];
    
    [self parseJSON];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)parseJSON {
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"suggestions" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError;
    id allKeys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    
    NSArray* jsonTempos = [allKeys objectForKey:@"tempo"];
    for (id arr in jsonTempos) {
        Tempo *t = [[Tempo alloc]initWithTempo:[arr objectAtIndex:0] andDescription:[arr objectAtIndex:1]];
        [tempos addObject:t];
    }
    
    NSArray* jsonGenres = [allKeys objectForKey:@"genre"];
    for (id arr in jsonGenres) {
        Genre *g = [[Genre alloc]initWithTitle:[arr objectAtIndex:0] andDescription:[arr objectAtIndex:1]];
        [genres addObject:g];
    }
    
    NSArray* jsonTimeSignatures = [allKeys objectForKey:@"time_signature"];
    for (id arr in jsonTimeSignatures) {
        TimeSignature *t = [[TimeSignature alloc]initWithTimeSignature:[arr objectAtIndex:0] andDescription:[arr objectAtIndex:1]];
        [timeSignatures addObject:t];
    }
}

@end
