//
//  OtherProfilesViewController.m
//  FootBook
//
//  Created by Claire Jencks on 4/2/14.
//  Copyright (c) 2014 Claire Jencks. All rights reserved.
//

#import "OtherProfilesViewController.h"
#import "Profile.h"


@interface OtherProfilesViewController ()

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property NSArray* namesArray;


@end

@implementation OtherProfilesViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67/255.0f green:97/255.0f blue:114/255.0f alpha:1.0f];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    [self load];
    
}

-(void)loadsduhiu
{
    
    //    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Profile"];
    //    //checking to see if it needs to prepopulate the list
    //    request.predicate = [NSPredicate predicateWithFormat:@"name contains %@", @""];
    //
    //    NSSortDescriptor* sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
}

-(void)load
{
    // get back an array of names
    NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/4/friends.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError *error;
        
        self.namesArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"names %@", self.namesArray);
        [self.myTableView reloadData];
    }];
    
}

#pragma mark CELL POPULATING/DELEGATE METHODS

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.namesArray.count;
    //return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellReuseID"];
    cell.textLabel.text = self.namesArray[indexPath.row];
    
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
        [self load];
    }
}
//change the title of the delete confirmation button
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"U.R.NT.MY.FRND";
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
