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
#import "Suggestion.h"

@interface ViewController ()

@end

NSMutableSet *tempos;
NSMutableSet *genres;
NSMutableSet *timeSignatures;
Suggestion *suggestion;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tempos = [[NSMutableSet alloc]init];
    genres = [[NSMutableSet alloc]init];
    timeSignatures = [[NSMutableSet alloc]init];
    
    [self parseJSON];
    suggestion = [self generateRandomSuggestion];
    [self updateLabels];
}

- (Suggestion*)generateRandomSuggestion {
    Suggestion *suggestion = [[Suggestion alloc]init];
    [suggestion setTempo:[[tempos allObjects] objectAtIndex:arc4random_uniform((unsigned)tempos.count)]];
    [suggestion setTimeSignature:[[timeSignatures allObjects] objectAtIndex:arc4random_uniform((unsigned)timeSignatures.count)]];
    [suggestion setGenre:[[genres allObjects] objectAtIndex:arc4random_uniform((unsigned)genres.count)]];
    return suggestion;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLabels {
    [[self tempoLabel] setText:[[suggestion tempo] tempo]];
    [[self genreLabel] setText:[[suggestion genre] genreTitle]];
    [[self timeSignatureLabel] setText:[[suggestion timeSignature] timeSignature]];
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
