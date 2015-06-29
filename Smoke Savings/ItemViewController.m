//
//  ItemViewController.m
//  IreneSmokeCounter
//
//  Created by Kim on 28/06/15.
//  Copyright (c) 2015 Kim. All rights reserved.
//

#import "ItemViewController.h"
#import "ItemTableViewCell.h"
#import "NSDate+Helper.h"
#import "Item.h"

@interface ItemViewController ()

@end

@implementation ItemViewController

#define CELL_HEIGHT 80

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    Item *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[super managedObjectContext]];
    newItem.name = @"hello";
    newItem.date = [NSDate date];
    
    [self saveManagedObjectContext];
    
    [self performFetch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(ItemTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Item *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.nameLabel.text = item.name;
    cell.priceLabel.text = [NSString stringWithFormat:@"€%.2f", [item.price floatValue]];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",[item.date returnFormattedDateString]];
    if (item.imageOfItem) {
        cell.imageView.image = [UIImage imageWithData:item.imageOfItem];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
