//
//  ItemViewController.h
//  Smoke Savings
//
//  Created by Kim on 28/06/15.
//  Copyright (c) 2015 Kim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataViewController.h"

@interface ItemViewController : CoreDataViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end
