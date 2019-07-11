//
//  DetailViewController.m
//  Instagram 2.0
//
//  Created by samason1 on 7/11/19.
//  Copyright © 2019 samason1. All rights reserved.
//

#import "DetailViewController.h"
#import "Post.h"
#import "PostCellTableViewCell.h"
#import "DateTools.h"


@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UILabel *detailCaption;
@property (weak, nonatomic) IBOutlet UILabel *detailTimeStamp;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    PFFileObject *imagee = self.posts.image;
    [imagee getDataInBackgroundWithBlock:^(NSData *  data, NSError * error) {
        UIImage *imageLoad = [UIImage imageWithData:data];
        [self.detailImage setImage:imageLoad];
    }];
    self.detailCaption.text=self.posts.caption;
    NSDate *time = self.posts.createdAt;
    self.detailTimeStamp.text=time.timeAgoSinceNow;
    //_posts.detailTimeStamp.text=time.timeIntervalSinceNow;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
