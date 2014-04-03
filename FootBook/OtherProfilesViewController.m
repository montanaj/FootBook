//
//  OtherProfilesViewController.m
//  FootBook
//
//  Created by Claire Jencks on 4/2/14.
//  Copyright (c) 2014 Claire Jencks. All rights reserved.
//

#import "OtherProfilesViewController.h"
#import "Profile.h"
#import "DetailViewController.h"

@interface OtherProfilesViewController ()

@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@property NSArray* namesArray;


@end

@implementation OtherProfilesViewController
//NEED TO SAVE CORE DATA
//NEED TO LOAD CORE DATA


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:67/255.0f green:97/255.0f blue:114/255.0f alpha:1.0f];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    
    [self loadAllProfiles];
    
}

#pragma mark SAVE CORE DATA upon tablecell being tapped
// Tap on table Row
- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    Profile* profile = [NSEntityDescription insertNewObjectForEntityForName:@"Profile" inManagedObjectContext:self.managedObjectContext];
    profile.name = self.namesArray[indexPath.row];
    //    character.actorName = self.actorNameTextField.text;
    //    character.gender = self.genderTextField.text;
    
    [self.managedObjectContext save:nil];
    [self loadAllProfiles];
}
// Tap on row accessory
- (void) tableView: (UITableView *) tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *) indexPath
{
//    Profile* profile = [NSEntityDescription insertNewObjectForEntityForName:@"Profile" inManagedObjectContext:self.managedObjectContext];
//    profile.name = self.namesArray[indexPath.row];
//    //    character.actorName = self.actorNameTextField.text;
//    //    character.gender = self.genderTextField.text;
//    
//    [self.managedObjectContext save:nil];
//    [self loadAllProfiles];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UITableViewCell*)sender
{
    //segueing TO the Destination
    OtherProfilesViewController *vc = segue.destinationViewController;
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:sender];
    vc.detailItem = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
}



//#pragma mark FILTER & LOADING INTO TABLEVIEW CELLS (FOR SORTING)
//
//-(void)load
//{
//    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Profile"];
//    //checking to see if it needs to prepopulate the list - not the best way but a good way to use a search bar or filter - just need to make one in story board
//    request.predicate = [NSPredicate predicateWithFormat:@"name contains %@", @""];
//    NSSortDescriptor* sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//    NSArray* sortDescriptorsArray = [NSArray arrayWithObjects:sortDescriptor1, nil];
//    request.sortDescriptors = sortDescriptorsArray;
//    
//    self.namesArray = [self.managedObjectContext executeFetchRequest:request error:nil];
//    
//    //BOOL isFirstRunCoreDataEmpty = self.charactersArray.count == 0;
//    BOOL isFirstRunCoreDataEmpty = ![[NSUserDefaults standardUserDefaults] boolForKey:@"hasRunOnce"];
//    
//    if (isFirstRunCoreDataEmpty)
//    {
//        //this returns a user defaults object
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        [userDefaults setBool:YES forKey:@"hasRunOnce"];
//        
//        [userDefaults synchronize];
//        
//        // get back an array of dictionaries that represent lost characters
//        NSURL *url = [NSURL URLWithString:@"http://s3.amazonaws.com/mobile-makers-assets/app/public/ckeditor_assets/attachments/4/friends.json"];
//        self.namesArray = [NSArray arrayWithContentsOfURL:url];
//        
//        // we will put the Character objects in here
//        NSMutableArray *mutableArray = [NSMutableArray new];
//        
//                    [mutableArray addObject:profile];
//        };
//        self.profilesArray = mutableArray;
//    }
//    [self.myTableView reloadData];
//}
//



#pragma mark THE STUFF BELOW WORKS



-(void)loadAllProfiles
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
        [self loadAllProfiles];
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
