//
//  ViewController.h
//  Hügge
//
//  Created by Morten Kleveland on 07.06.15.
//  Copyright (c) 2015 Morten G. Kleveland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *tempoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeSignatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *feelLabel;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *tonalityLabel;

@end

