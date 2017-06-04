//
//  Utils.m
//  TMDB
//
//  Created by Treinamento on 02/06/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

#import "Utils.h"
#import "Reachability.h"

@implementation Utils


//Load Cell
+(UITableViewCell*)cellFromNibNamed:(NSString*)nibName{
    
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:NULL];
    NSEnumerator *nibEnumerator = [nibContents objectEnumerator];
    NSObject* nibItem = nil;
    
    while ((nibItem = [nibEnumerator nextObject]) != nil) {
        if ([nibItem isKindOfClass:[UITableViewCell class]]) {
            return (UITableViewCell *)nibItem;
        }
    }
    
    NSLog(@"Can't load cellFromNibNamed");
    return nil;
}

+(UIImage*)downloadImageWithPath:(NSString*)_imagePath{
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    
    if (networkStatus == NotReachable)
        return nil;
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@", IMAGE_URL, _imagePath];
    NSURL  *url     = [NSURL URLWithString:urlStr];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    if ( urlData ){
        
        UIImage* image = [UIImage imageWithData:urlData];
        
        if (image != nil)
            return [UIImage imageWithData:urlData];
        
    }
    
    return nil;
}


@end
