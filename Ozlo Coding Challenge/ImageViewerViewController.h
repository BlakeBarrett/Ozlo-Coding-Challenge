//
//  ImaveViewerViewController.h
//  Ozlo Coding Challenge
//
//  Created by Blake Barrett on 6/11/16.
//  Copyright © 2016 Blake Barrett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *heroImageView;

-(void)setHeroImageUrlString:(NSString *)urlString;

@end
