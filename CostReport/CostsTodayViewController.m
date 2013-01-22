//
//  CostsTodayViewController.m
//  CostReport
//
//  Created by 周 贇 on 13/01/19.
//  Copyright (c) 2013年 周 贇. All rights reserved.
//

#import "CostsTodayViewController.h"

#import "CommonUtilsHeader.h"
#import "CostManager.h"
#import "CostType.h"

@interface CostsTodayViewController ()

@property (nonatomic) CostManager *manager;

@end

@implementation CostsTodayViewController

#define CostsTodayTableViewCellIdentifier @"CostsTodayTableViewCellIdentifier"

@synthesize manager;

- (id)initWithStyle:(UITableViewStyle)style
{
    DebugLogFunc();
    
    self = [super initWithStyle:style];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    DebugLogFunc();
    
    if (!manager) {
        manager = [CostManager sharedManager];
    }
    
    if ([[manager getCosts] count] <= 0) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"通知" message:@"記録数が0です" delegate:self cancelButtonTitle:@"戻る" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    DebugLogFunc();
    
    manager = nil;
}

#pragma mark - alert view

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[manager getCosts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CostsTodayTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CostsTodayTableViewCellIdentifier];
    }
    
    Cost *cost = (Cost *)[[manager getCosts] objectAtIndex:indexPath.row];
    NSString * costType = [cost getCostType];
    
    cell.imageView.image = [[CostType sharedManager] getImageByType:costType];
    cell.textLabel.text = [NSString stringWithFormat:@"%@円", [cost getCost]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:%@  %@", [cost getHourOfCost], [cost getMinuteOfCost], costType];
    
    return cell;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
