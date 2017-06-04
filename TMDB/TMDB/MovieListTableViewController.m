//
//  MovieListTableViewController.m
//  TMDB
//
//  Created by Treinamento on 29/05/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import "MovieListTableViewController.h"
#import "Reachability.h"
#import "Utils.h"
#import "MovieViewController.h"
#import "MovieViewController.h"


#define DESCRIPTION_LABEL_TAG       101
#define GENRE_VALUE_LABEL_TAG       103
#define RELEASE_DATE_LABEL_TAG      105
#define BACKDROP_IMAGE_TAG          106



@interface MovieListTableViewController ()

@property (nonatomic, retain) NSDictionary       *selectedMovieDict;

@end

@implementation MovieListTableViewController


@synthesize movieList;
@synthesize genreList;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMovieList];
    
}

-(void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = [UIColor groupTableViewBackgroundColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([self.movieList count] > 0){
        return 1;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.movieList count] > 0){
        return [self.movieList count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Configure Cell
    static NSString* cellID = @"MovieDefaultCell";
    UITableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [Utils cellFromNibNamed:cellID];
        if (cell == nil)
            return nil;
    }
    
    cell.autoresizesSubviews = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Configure Tags
    UILabel* descriptionLabel       = (UILabel*)[cell viewWithTag:DESCRIPTION_LABEL_TAG];
    UILabel* genereLabel            = (UILabel*)[cell viewWithTag:GENRE_VALUE_LABEL_TAG];
    UILabel* releaseDateLabel       = (UILabel*)[cell viewWithTag:RELEASE_DATE_LABEL_TAG];
    UIImageView* bannerImageView    = (UIImageView*)[cell viewWithTag:BACKDROP_IMAGE_TAG];
    
    genereLabel.adjustsFontSizeToFitWidth = YES;
    
    //Current Value
    NSDictionary* movieDict = [self.movieList objectAtIndex:indexPath.row];

    //Description
    descriptionLabel.text   = [movieDict objectForKey: @"title"];
    //Genres
    genereLabel.text        = [self genresDescriptionInList:[movieDict objectForKey: @"genre_ids"]];
    //Release Date
    releaseDateLabel.text   = [movieDict objectForKey: @"release_date"];
    
    //GetImage
    bannerImageView.image = [Utils downloadImageWithPath:[movieDict objectForKey: @"backdrop_path"]];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedMovieDict = [self.movieList objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"moveView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MovieViewController *vcToPushTo = segue.destinationViewController;
    vcToPushTo.movieDict            = self.selectedMovieDict;
}


#pragma mark Functions

-(void)loadMovieList{
    
    //Search Json for movie list
    NSError *error;
    NSString *url_string    = [NSString stringWithFormat: MOVIE_URL];
    NSData *data            = [NSData dataWithContentsOfURL: [NSURL URLWithString:url_string]];
    
    NSDictionary *jsonDict  = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    self.movieList = [jsonDict objectForKey:@"results"];
    
    if (jsonDict == nil){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                                 message:@"No movie found"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    
    //Search Json for Genre name
    NSString *url_genreString   = [NSString stringWithFormat:GENRE_URL];
    NSData *genreData           = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_genreString]];
    
    // Json Dict to get Genre ids and Names
    NSDictionary *jsonGenreDict  = [NSJSONSerialization JSONObjectWithData:genreData options:kNilOptions error:&error];
    
    self.genreList = [jsonGenreDict objectForKey:@"genres"];
}

-(NSString*) genresDescriptionInList:(NSArray*)_genreIdList {
    
    NSMutableString* genreListDescription = [[NSMutableString alloc] initWithString:@""];
    
    for (int i=0; i < [_genreIdList count]; i++) {
        NSNumber* genreId = [_genreIdList objectAtIndex:i];
        
        for (int j=0; j < [self.genreList count]; j++) {
            
            if (genreId == [[self.genreList objectAtIndex:j] objectForKey:@"id"]) {
                if (i == 0)
                    [genreListDescription appendString:[[self.genreList objectAtIndex:j] objectForKey:@"name"]];
                else
                    [genreListDescription appendFormat:@" / %@", [[self.genreList objectAtIndex:j] objectForKey:@"name"]];
            }
            
        }

    }
    
    return genreListDescription;   
}

@end
