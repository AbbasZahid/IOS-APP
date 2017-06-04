//
//  MovieViewController.m
//  TMDB
//
//  Created by Treinamento on 02/06/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import "MovieViewController.h"
#import "Utils.h"

@interface MovieViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (weak, nonatomic) IBOutlet UITextView *overViewText;
@property (weak, nonatomic) IBOutlet UITextView *releaseDateTextView;

@end

@implementation MovieViewController

@synthesize movieDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = [self.movieDict objectForKey:@"title"];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    self.bannerImageView.image = [Utils downloadImageWithPath:[movieDict objectForKey: @"backdrop_path"]];
    
    self.overViewText.text = [self.movieDict objectForKey:@"overview"];
    
    self.releaseDateTextView.text = [NSString stringWithFormat: @"Release Date: %@" , [self.movieDict objectForKey:@"release_date"]];
}

-(void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = self.view.backgroundColor;
}

- (void)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
