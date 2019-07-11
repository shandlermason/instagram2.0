//
//  PostCellTableViewCell.h
//  Instagram 2.0
//
//  Created by samason1 on 7/10/19.
//  Copyright © 2019 samason1. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UITextView *pictureCaption;


@end

NS_ASSUME_NONNULL_END
