//
//  Item.h
//  Smoke Savings
//
//  Created by Kim on 28/06/15.
//  Copyright (c) 2015 Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSData * image;

@end
