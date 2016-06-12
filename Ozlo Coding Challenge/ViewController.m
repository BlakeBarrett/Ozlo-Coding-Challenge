//
//  ViewController.m
//  Ozlo Coding Challenge
//
//  Created by Blake Barrett on 6/11/16.
//  Copyright © 2016 Blake Barrett. All rights reserved.
//

#import "ViewController.h"
#import "ImageViewerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

static NSString * const reuseIdentifier = @"ozloImageCellReuseIdentifier";

NSArray *imageUrlStrings;
NSMutableArray *images;
// the lie we tell the collection view to fake an "inifinite" data set.
NSInteger numItems;

- (id) init {
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    images = [NSMutableArray new];
    imageUrlStrings = [[NSArray alloc] initWithObjects: @"https://images.njck.co/img?q=jack://i/ios-challenge/img.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img1.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img2.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img4.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img5.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img6.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img7.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img8.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img9.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img10.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img11.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img12.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img13.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img14.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img15.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img16.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img17.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img18.jpeg",
              @"https://images.njck.co/img?q=jack://i/ios-challenge/img19.jpeg", nil];
    
    numItems = imageUrlStrings.count;
    
    [self.imagesCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.imagesCollectionView.delegate = self;
    self.imagesCollectionView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [images removeAllObjects];
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
     return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark load and cache image

- (NSInteger) wrappedIndexForIndexPath:(NSIndexPath *)indexPath {
    return indexPath.row % imageUrlStrings.count;
}

- (UIImageView *)imageViewForIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [self wrappedIndexForIndexPath:indexPath];
    
    UIImageView *imageView;
    if (index >= images.count) {
        NSString *imageURLString = imageUrlStrings[index];
        NSURL *imageURL = [NSURL URLWithString:imageURLString];
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        
        imageView = [[UIImageView alloc] initWithImage:image];
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        images[index] = imageView;
    } else {
        imageView = images[index];
    }

    return imageView;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return imageUrlStrings.count;
    return numItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImageView *imageView = [self imageViewForIndexPath:indexPath];
    cell.backgroundView = imageView;
    
    return cell;
}

#pragma mark <UICollectionViewFlowDelegate>

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *) collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIImageView *imageView = [self imageViewForIndexPath:indexPath];
    
    float aspectRatio = imageView.image.size.width / imageView.image.size.height;
    
    CGFloat width = (collectionView.frame.size.width / 2.1);
    CGFloat height = width / aspectRatio;
    
    CGSize size = CGSizeMake(width, height);
    return size;
}


#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ImageViewerViewController *imageViewerViewController = (ImageViewerViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ImageViewerScene"];
    
    NSString *urlString = imageUrlStrings[[self wrappedIndexForIndexPath:indexPath]];
    [imageViewerViewController setHeroImageUrlString:urlString];
    
    [self presentViewController:imageViewerViewController animated:YES completion:nil];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    float maxContentOffsetHeight = ceil(scrollView.contentSize.height - self.imagesCollectionView.frame.size.height);
    float currentY = scrollView.contentOffset.y;
    
    if (currentY >= maxContentOffsetHeight) {
        numItems += imageUrlStrings.count;
        [self.imagesCollectionView reloadData];
    }
}

// Logic based on example here:
//  https://adoptioncurve.net/archives/2013/07/building-a-circular-gallery-with-a-uicollectionview/
// I don't really like it, but it "works".
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    float maxContentOffsetHeight = ceil(scrollView.contentSize.height - self.imagesCollectionView.frame.size.height);
//    float currentY = scrollView.contentOffset.y;
//    
//    NSIndexPath *newIndexPath;
//    UICollectionViewScrollPosition position;
//    
//    if (currentY >= maxContentOffsetHeight) {
//        newIndexPath = [NSIndexPath indexPathForItem:1 inSection:0];
//        position = UICollectionViewScrollPositionTop;
//    } else if (scrollView.contentOffset.y == 0)  {
//        
//        newIndexPath = [NSIndexPath indexPathForItem:(imageUrlStrings.count -2) inSection:0];
//        position = UICollectionViewScrollPositionBottom;
//    }
//    
//    [self.imagesCollectionView scrollToItemAtIndexPath:newIndexPath atScrollPosition:position animated:NO];
//}

@end
