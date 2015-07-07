//
//  ViewController.h
//  Hügge
//
//  Created by Morten Kleveland on 07.06.15.
//  Copyright (c) 2015 Morten G. Kleveland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *tempoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeSignatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *tonalityLabel;

@property (weak, nonatomic) IBOutlet UILabel *tempoBackgroundLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeSignatureBackgroundLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelBackgroundLabel;
@property (weak, nonatomic) IBOutlet UILabel *tonalityBackgroundLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreBackgroundLabel;

@property (strong, nonatomic) IBOutlet DetailView *tempoView;
@property (strong, nonatomic) IBOutlet DetailView *timeSignatureView;
@property (strong, nonatomic) IBOutlet DetailView *feelView;
@property (strong, nonatomic) IBOutlet DetailView *tonalityView;
@property (strong, nonatomic) IBOutlet DetailView *genreView;

- (IBAction)swipeRegistered:(id)sender;

@end

