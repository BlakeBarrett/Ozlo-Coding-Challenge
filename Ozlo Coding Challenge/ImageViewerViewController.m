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
    
    [self.heroImageView setImage:image];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setHeroImageUrlString:(NSString *)urlString {
    NSURL *imageURL = [NSURL URLWithString:urlString];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
    image = [UIImage imageWithData:imageData];
}

@end
