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
    
    self.tempoView = [[DetailView alloc]init];
    self.timeSignatureView = [[DetailView alloc]init];
    self.feelView = [[DetailView alloc]init];
    self.tonalityView = [[DetailView alloc]init];
    self.genreView = [[DetailView alloc]init];
    
    [self parseJSON];
    //suggestion = [self generateRandomSuggestion];
    [self updateLabels];
    
    [self animateViews]; // Animating all labels, since some of them can be larger than their superviews
}

- (void)animateViews {
    [self animateView:self.tempoBackgroundLabel fromPosition:-self.tempoBackgroundLabel.frame.size.width withDuration:1.0];
    [self animateView:self.timeSignatureBackgroundLabel fromPosition:self.timeSignatureBackgroundLabel.frame.size.width withDuration:1.5];
    [self animateView:self.feelBackgroundLabel fromPosition:self.feelBackgroundLabel.frame.size.width withDuration:1.0];
    [self animateView:self.tonalityBackgroundLabel fromPosition:-self.tonalityBackgroundLabel.frame.size.width withDuration:1.0];
    [self animateView:self.genreBackgroundLabel fromPosition:self.genreBackgroundLabel.frame.size.width withDuration:1.0];
}

- (void)animateView:(UIView*)view fromPosition:(CGFloat)position withDuration:(double)duration {
    [UIView animateWithDuration: duration
                     animations: ^{
                         CGRect frame = view.frame;
                         frame.origin.x = position;
                         view.frame = frame;
                     } completion:^(BOOL finished) {
                         suggestion = [self generateRandomSuggestion];
                         [self updateLabels];
                     }];
}

- (void)shakeAnimation:(UILabel*)label {
    int randomRepeatCount = arc4random_uniform(2) + 3;
    int randomOffset = arc4random_uniform(3) + 2;
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.07];
    [shake setRepeatCount:randomRepeatCount];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint: CGPointMake(label.center.x - randomOffset, label.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint: CGPointMake(label.center.x + randomOffset, label.center.y)]];
    [label.layer addAnimation:shake forKey:@"position"];
}

- (Suggestion*)generateRandomSuggestion {
    Suggestion *suggestion = [[Suggestion alloc]init];
    if (!tempoLocked) {
        [suggestion setTempo:[[tempos allObjects] objectAtIndex:arc4random_uniform((unsigned)tempos.count)]];
        [self shakeAnimation:self.tempoBackgroundLabel];
    }
    if (!timeSignatureLocked) {
        [suggestion setTimeSignature:[[timeSignatures allObjects] objectAtIndex:arc4random_uniform((unsigned)timeSignatures.count)]];
        [self shakeAnimation:self.timeSignatureBackgroundLabel];
    }
    if (!tonalityLocked) {
        [suggestion setTonality:[[tonalities allObjects] objectAtIndex:arc4random_uniform((unsigned)tonalities.count)]];
        [self shakeAnimation:self.feelBackgroundLabel];
    }
    if (!genreLocked) {
        [suggestion setGenre:[[genres allObjects] objectAtIndex:arc4random_uniform((unsigned)genres.count)]];
        [self shakeAnimation:self.tonalityBackgroundLabel];
    }
    if (!feelLocked) {
        [suggestion setFeel:[[feels allObjects] objectAtIndex:arc4random_uniform((unsigned)feels.count)]];
        [self shakeAnimation:self.genreBackgroundLabel];
    }
    return suggestion;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
