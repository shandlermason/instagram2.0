//
//  TimelineTableViewController.m
//  Instagram 2.0
//
//  Created by samason1 on 7/9/19.
//  Copyright © 2019 samason1. All rights reserved.
//

#import "TimelineTableViewController.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "PhotoViewController.h"
#import "PostCellTableViewCell.h"

@interface TimelineTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *postArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TimelineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
     [self fetchTimeLine];
    
}
-(void)fetchTimeLine{
    // Get timeline
  
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            NSLog(@"Query did work");
             self.postArray = posts;
            [self.tableView reloadData];
        }
        else {
            // handle error
//            NSLog(@"Query did not work", error.localizedDescription);
        }
    }];
}

- (IBAction)logout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
         [self performSegueWithIdentifier:@"logOut" sender:nil];
    }];
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PostCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCellTableViewCell" forIndexPath:indexPath];
    Post *post = self.postArray[indexPath.row];
    PFFileObject *imageFile = post.image;
    
    [imageFile getDataInBackgroundWithBlock:^(NSData * data, NSError * error) {
        if (!error)
        {
            NSLog(@"Get data in Background with block");
            UIImage *image = [UIImage imageWithData:data];
            [cell.picture setImage:image];
        }
        
    } ];
  
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
