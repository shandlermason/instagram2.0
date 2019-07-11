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
#import "AppDelegate.h"
#import "DateTools.h"


@interface TimelineTableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *postArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TimelineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
     [self fetchTimeLine];
    
    //adjust size to show picture and caption on timeline
    self.tableView.rowHeight=400.0;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
        //change color of refresh controller to light blue
    [self.refreshControl setTintColor:[UIColor colorWithRed:102.0/255.0 green:204.0/255.0 blue:255.0/255.0 alpha:1.0]];
    
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
        }
        [self.refreshControl endRefreshing];
      
    }];
}

// Makes a query request to get updated data, Updates the tableView with the new data, Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    //[self fetchTimeLine];
    
    
    PFQuery *postQuery2 = [Post query];
    [postQuery2 orderByDescending:@"createdAt"];
    [postQuery2 includeKey:@"author"];
    postQuery2.limit = 20;
    
    // fetch data asynchronously
    [postQuery2 findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            // do something with the data fetched
            NSLog(@"Query did work");
            self.postArray = posts;
           // NSLog(@"reload data 1");
           [self.tableView reloadData];
            [self.refreshControl endRefreshing];
            NSLog(@"refresh control works");
        }
        else {
            // handle error
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
    
    //post caption with picture onto TimeLine
     cell.pictureTLcaption.text=post.caption;
    
    NSDate *time = post.createdAt;
    cell.timeStamp.text=time.timeAgoSinceNow;
  
    
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
