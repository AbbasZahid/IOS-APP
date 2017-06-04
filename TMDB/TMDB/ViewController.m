//
//  ViewController.m
//  TMDB
//
//  Created by Treinamento on 29/05/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loadMoviesButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [[self.loadMoviesButton layer] setBorderWidth:2.0f];
    [[self.loadMoviesButton layer] setBorderColor:[UIColor greenColor].CGColor];
    
    self.loadMoviesButton.layer.cornerRadius = 10; // this value vary as per your desire
    self.loadMoviesButton.clipsToBounds = YES;
    
}

-(void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor darkTextColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
