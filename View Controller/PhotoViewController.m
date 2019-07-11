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
@property (strong, nonatomic) UIImage *originalImage ;
@property (strong, nonatomic)NSString *captionText;

@end

@implementation PhotoViewController

- (IBAction)shareButton:(id)sender {
    [Post postUserImage:self.originalImage withCaption: self.captionWrite.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(succeeded){
            NSLog(@"Share Button was a success");
        }
        else{
            NSLog(@"Share button failed");
        }
    }];
        [self dismissViewControllerAnimated:YES completion:nil];
   
    
  /*  UIImagePickerController *shareDelegate;
    NSDictionary *infoDelegate;
    
    [self imagePickerController:(shareDelegate) didFinishPickingMediaWithInfo:(infoDelegate)];
    
    UIImage *chosenImage = infoDelegate[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    // [self setImageView:chosenImage];

    NSLog(@"Share button did work");
    // construct PFQuery
   /* PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            NSLog(@"Query did work");
            
        }
        else {
            // handle error
            NSLog(@"Query did not work");
        }
    }];
    
    // Do something with the images (based on your use case)
    //try to resize image
   
    

    
    //Allows you to write a caption before sharing
    self.captionText = self.captionWrite.text;
    PFObject *addValues= [PFObject objectWithClassName:@"Post"];
    [addValues setObject: captionText forKey:@"caption"];
    [addValues saveInBackground];
    
    [Post postUserImage:self.originalImage withCaption:self.writeCaption withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
        NSLog(@"postUserImage method works");
        
    }];
    
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];*/
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
   self.originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    [self resizeImage:self.originalImage withSize:CGSizeMake(50.0, 50.0)];
    
    //sets image chosen into smaller image view so you can write a caption then share
    self.imageView.image=self.originalImage;
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
