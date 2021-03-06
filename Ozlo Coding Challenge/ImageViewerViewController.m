//
//  ImaveViewerViewController.m
//  Ozlo Coding Challenge
//
//  Created by Blake Barrett on 6/11/16.
//  Copyright © 2016 Blake Barrett. All rights reserved.
//

#import "ImageViewerViewController.h"

@interface ImageViewerViewController ()

@end

@implementation ImageViewerViewController

UIImage *image;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0ul), ^{
        [self.heroImageView setImage:image];
    });
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    singleTap.numberOfTapsRequired = 1;
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:singleTap];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setHeroImageUrlString:(NSString *)urlString {
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    image = [UIImage imageWithData:imageData];
}

-(void)onTap{
    self.heroImageView.image = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
