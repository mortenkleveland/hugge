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
#import "Tonality.h"
#import "Feel.h"

@interface ViewController ()

@end

bool tempoLocked = false;
bool timeSignatureLocked = false;
bool tonalityLocked = false;
bool genreLocked = false;
bool feelLocked = false;
NSMutableSet *tempos;
NSMutableSet *genres;
NSMutableSet *timeSignatures;
NSMutableSet *tonalities;
NSMutableSet *feels;
Suggestion *suggestion;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tempos = [[NSMutableSet alloc]init];
    genres = [[NSMutableSet alloc]init];
    timeSignatures = [[NSMutableSet alloc]init];
    tonalities = [[NSMutableSet alloc]init];
    feels = [[NSMutableSet alloc]init];
    
    [self parseJSON];
    suggestion = [self generateRandomSuggestion];
    [self updateLabels];
}

- (Suggestion*)generateRandomSuggestion {
    Suggestion *suggestion = [[Suggestion alloc]init];
    if (!tempoLocked) [suggestion setTempo:[[tempos allObjects] objectAtIndex:arc4random_uniform((unsigned)tempos.count)]];
    if (!timeSignatureLocked) [suggestion setTimeSignature:[[timeSignatures allObjects] objectAtIndex:arc4random_uniform((unsigned)timeSignatures.count)]];
    if (!tonalityLocked) [suggestion setTonality:[[tonalities allObjects] objectAtIndex:arc4random_uniform((unsigned)tonalities.count)]];
    if (!genreLocked) [suggestion setGenre:[[genres allObjects] objectAtIndex:arc4random_uniform((unsigned)genres.count)]];
    if (!feelLocked) [suggestion setFeel:[[feels allObjects] objectAtIndex:arc4random_uniform((unsigned)feels.count)]];
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
    [[self tonalityLabel] setText:[[[suggestion tonality] tonality] capitalizedString]];
    [[self feelLabel] setText:[[[suggestion feel] feelTitle] capitalizedString]];
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
    
    NSArray* jsonFeels = [allKeys objectForKey:@"feel"];
    for (id arr in jsonFeels) {
        Feel *f = [[Feel alloc]initWithTitle: [arr objectAtIndex:0] andDescription:[arr objectAtIndex:1]];
        [feels addObject:f];
    }
    
    NSArray* jsonTonalities = [allKeys objectForKey:@"tonality"];
    for (id arr in jsonTonalities) {
        Tonality *t = [[Tonality alloc]initWithTonality:[arr objectAtIndex:0] andDescription:[arr objectAtIndex:1]];
        [tonalities addObject:t];
    }
}

- (void)randomizeSuggestion {
    suggestion = [self generateRandomSuggestion];
    [self updateLabels];
}

#pragma mark - UIResponder

- (void)motionEnded: (UIEventSubtype)motion withEvent:(UIEvent*)event {
    if (motion == UIEventSubtypeMotionShake) {
        [self randomizeSuggestion];
    }
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (IBAction)swipeRegistered:(id)sender {
    NSLog(@"%@", [sender view]);
    for (UIView *subview in self.view.subviews) {
        NSLog(@"%@", subview);
    }
}

@end
