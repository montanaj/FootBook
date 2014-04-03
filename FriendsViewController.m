//
//  FriendsViewController.m
//  FootBook
//
//  Created by Claire Jencks on 4/2/14.
//  Copyright (c) 2014 Claire Jencks. All rights reserved.
//

#import "FriendsViewController.h"
#import "Profile.h"
#import "OtherProfilesViewController.h"


@interface FriendsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property NSArray* namesArray;

@end

@implementation FriendsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67/255.0f green:97/255.0f blue:114/255.0f alpha:1.0f];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    //self.navigationController.navigationItem.backBarButtonItem.tintColor = [UIColor whiteColor];
}

#pragma mark CELL POPULATING/DELEGATE METHODS

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return self.namesArray.count;
    return 2;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsCellReuseID"];
    
    return cell;
    
}

#pragma MARK  SWIPE TO DELETE

//allow the standard swipe to delete functionality
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.managedObjectContext deleteObject:self.namesArray[indexPath.row]];
        [self.managedObjectContext save:nil];
        //[self loadAllProfiles];
    }
}
//change the title of the delete confirmation button
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"U.R.NT.MY.FRND";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
{
    //segueing TO the Destination (which is detailViewController)
    OtherProfilesViewController *vc = segue.destinationViewController;
    vc.managedObjectContext = self.managedObjectContext;
    
}


@end
