//
//  MainTableViewController.m
//  CostReport
//
//  Created by 周 贇 on 13/01/18.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import "MainTableViewController.h"

#import "CommonUtilsHeader.h"
#import "MainMenu.h"
#import "InsertViewController.h"
#import "CostsTodayViewController.h"
#import "CostTypeViewController.h"

@interface MainTableViewController ()

@property (nonatomic) MainMenu *manager;

@end

@implementation MainTableViewController

#define MainTableViewTitle              @"記録"
#define MainTableViewCellIdentifier     @"MainTableViewCellIdentifier"

@synthesize manager;

- (id)initWithStyle:(UITableViewStyle)style
{
    DebugLogFunc();
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DebugLogFunc();
    
    [self setTitle:MainTableViewTitle];
    
    if (!manager) {
        manager = [MainMenu sharedManager];
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    DebugLogFunc();
    
    manager = nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[manager getSectionHeaders] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[manager getRowTitlesBySection:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainTableViewCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MainTableViewCellIdentifier];
    }
    
    cell.imageView.image = [[manager getRowImagesBySection:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = [[manager getRowTitlesBySection:indexPath.section] objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[manager getSectionHeaders] objectAtIndex:section];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DebugLogFunc();
    
    UIViewController *viewController;
    Class class;
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            class = [InsertViewController class];
        } else if (indexPath.row == 1) {
            class = [CostsTodayViewController class];
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            class = [CostTypeViewController class];
        }
    } else {
        class = [InsertViewController class];
    }
    
    viewController = [[class alloc] initWithNibName:NSStringFromClass(class) bundle:nil];
    [viewController setTitle:[[manager getRowTitlesBySection:indexPath.section] objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
