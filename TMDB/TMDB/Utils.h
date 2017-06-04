//
//  Utils.h
//  TMDB
//
//  Created by Treinamento on 02/06/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IMAGE_URL                   @"https://image.tmdb.org/t/p/w500"

#define MOVIE_URL       @"https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=1f54bd990f1cdfb230adb312546d765d"

#define GENRE_URL       @"https://api.themoviedb.org/3/genre/movie/list?api_key=1f54bd990f1cdfb230adb312546d765d&language=en-US"

@interface Utils : NSObject

+(UITableViewCell*)cellFromNibNamed:(NSString*)nibName;
+(UIImage*)downloadImageWithPath:(NSString*)_imagePath;

@end
