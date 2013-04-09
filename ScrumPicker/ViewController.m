//
//  ViewController.m
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
//
//  Copyright 2013 Earljon Hidalgo
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */

#import "ViewController.h"
#import "NSMutableArray+Shuffle.h"

#define FONT_BEBAS(s) [UIFont fontWithName:@"BebasNeue" size:s]
#define BG_BLUE [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue_bg"]]

@interface ViewController ()
{
    NSArray *people;
    NSMutableArray *completed;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.navTitle.text = @"Scrum Tester";
    self.navTitle.font = FONT_BEBAS(20.0);

    [self initData];
    completed = [[NSMutableArray alloc] init];
    
    self.theTableView.backgroundColor = [UIColor clearColor];
    self.theTableView.backgroundColor = BG_BLUE;
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initData {
    NSArray *arrayTeam = @[@"Vhal", @"Daryl", @"Earljon", @"Lindz", @"Mike", @"Jason", @"Abbie", @"Happy", @"Pippay", @"Joan", @"Anthony", @"Miggy", @"Jun", @"Richard", @"Janina", @"Francis", @"Lance", @"Chris", @"Cherry"];
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:arrayTeam];
    [items shuffle];
    
    people = [[NSArray alloc] initWithArray:items];
}

- (IBAction)randomize:(id)sender {
    [completed removeAllObjects];
    
    [self initData];
    
    // magic starts
    [self.theTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [people count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.contentView.backgroundColor = BG_BLUE;
        cell.textLabel.font = FONT_BEBAS(30.0);
    }
    
    if ([completed containsObject:indexPath]) {
        cell.textLabel.textAlignment = NSTextAlignmentRight;
        cell.textLabel.textColor = [UIColor colorWithRed:214.0/255 green:218.0/255 blue:221.0/255 alpha:1.0];
    }
    else {
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;    
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%i. %@", indexPath.row + 1, [people objectAtIndex:indexPath.row] ];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([completed containsObject:indexPath]) {
        [self.theTableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
    
    [completed addObject:indexPath];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    
    
}

@end
