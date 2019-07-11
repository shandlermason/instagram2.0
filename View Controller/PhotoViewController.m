//
//  PhotoViewController.m
//  Instagram 2.0
//
//  Created by samason1 on 7/10/19.
//  Copyright © 2019 samason1. All rights reserved.
//

#import "PhotoViewController.h"
#import "Post.h"


@interface PhotoViewController () <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *writeCaption;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PhotoViewController

- (IBAction)shareButton:(id)sender {
    UIImagePickerController *shareDelegate;
    NSDictionary *infoDelegate;
    
    [self imagePickerController:(shareDelegate) didFinishPickingMediaWithInfo:(infoDelegate)];
    
    UIImage *chosenImage = infoDelegate[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    NSLog(@"Share button did work");
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Access the camera when the camera button is pressed
    NSLog(@"Camera button was pressed");
   
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        //access the photo library when the camera is not available
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
   
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Do something with the images (based on your use case)
    
    //Post* myPost = [[Post alloc] init]; //First, we create an instance of post
    
    [Post postUserImage:originalImage withCaption:self.writeCaption withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
        NSLog(@"postUserImage method works");
        
    }];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


//resize photo function
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
