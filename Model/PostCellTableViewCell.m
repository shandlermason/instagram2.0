//
//  PostCellTableViewCell.m
//  Instagram 2.0
//
//  Created by samason1 on 7/10/19.
//  Copyright © 2019 samason1. All rights reserved.
//

#import "PostCellTableViewCell.h"
#import "Post.h"
@implementation PostCellTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //[self setPost:self.picture];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
- (void)setPost:(Post *)post {
    self.post = post;
    NSLog(@"Trying to set a post");
    self.photoImageView.file = post[@"image"];
    [self.photoImageView loadInBackground];
}
*/

@end
