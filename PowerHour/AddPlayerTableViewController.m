//
//  AddPlayerTableViewController.m
//  PowerHour
//
//  Created by James Lubo on 4/4/14.
//  Copyright (c) 2014 SocialCrawl. All rights reserved.
//

#import "AddPlayerTableViewController.h"
#import "Player.h"
#import "PlayerTableViewCell.h"
#import "GameSettingsTableViewController.h"
#import "SocialCrawlAppDelegate.h"


#define kMaxPlayers 8

@interface AddPlayerTableViewController ()
@property (strong, nonatomic) NSMutableArray *players;
@property (strong, nonatomic) NSMutableSet *playerColors;
@end

@implementation AddPlayerTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.editing = YES;
    SocialCrawlAppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.players = delegate.players;
    [self filterAvailableColors];
    [self.tableView reloadData];
}

- (NSMutableSet *)playerColors
{
    if (!_playerColors) {
        _playerColors = [[NSMutableSet alloc] init];
        [_playerColors addObjectsFromArray:@[[UIColor lightGrayColor],
                                            [UIColor redColor],
                                            [UIColor greenColor],
                                            [UIColor blueColor],
                                            [UIColor orangeColor],
                                            [UIColor purpleColor],
                                             [UIColor brownColor],
                                             [UIColor cyanColor]]];
    }
    return _playerColors;
}

- (void)filterAvailableColors
{
    NSMutableSet *selectedColors = [[NSMutableSet alloc] init];
    for (Player *player in self.players) {
        [selectedColors addObject:[player color]];
    }
    [self.playerColors minusSet:selectedColors];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    CGRect footerRect = CGRectMake(0, 0, 320, 45);
    UIView *containerView = [[UIView alloc] initWithFrame:footerRect];
//    containerView.backgroundColor = [UIColor redColor];
    
//    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];


    CGRect labelRect = CGRectMake(40, 0, 320, 45);
    
    UIButton *newButton = [[UIButton alloc] initWithFrame:footerRect];
    [newButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [newButton setTitle:@"Add New Player..." forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(addPlayer:) forControlEvents:UIControlEventTouchUpInside];
    [newButton setBackgroundColor:[UIColor whiteColor]];

    UILabel *newLabel = [[UILabel alloc] initWithFrame:labelRect];
    newLabel.text = @"Add New Player...";
    newLabel.textColor = [UIColor blackColor];

    
    //    [containerView addSubview:newLabel];
    [containerView addSubview:newButton];

    return containerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.players count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playerCell" forIndexPath:indexPath];
    Player *currentPlayer = [self.players objectAtIndex:indexPath.row];
    cell.player = currentPlayer;
    cell.textField.text = currentPlayer.name;
    cell.imageView.image = [self imageWithColor:currentPlayer.color];
    return cell;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 43.0f, 43.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self removePlayer:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    Player *fromPlayer = self.players[fromIndexPath.row];
    [self.players removeObject:fromPlayer];
    [self.players insertObject:fromPlayer atIndex:toIndexPath.row];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [[self view] endEditing:YES];
    GameSettingsTableViewController *viewController = segue.destinationViewController;
    viewController.gameMode = self.gameMode;
}

- (void)removePlayer:(NSInteger)index {
    Player *player = self.players[index];
    [self.playerColors addObject:[player color]];
    [self.players removeObjectAtIndex:index];
}

- (IBAction)addPlayer:(id)sender
{
    if ([self.players count] == kMaxPlayers) {
        return;
    }
    NSString *playerName = [NSString stringWithFormat:@"Player %d", [self.players count]+1];
    UIColor *playerColor = [self.playerColors anyObject];
    [self.playerColors removeObject:playerColor];
    
    Player *newPlayer = [Player playerWithName:playerName color:playerColor];
    [self.players addObject:newPlayer];
    // insert with animation instead
    [self.tableView reloadData];
}

@end
