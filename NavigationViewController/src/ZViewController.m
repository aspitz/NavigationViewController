//
//  ZViewController.m
//  NavigationViewController
//
//  Created by Ayal Spitz on 3/26/13.
//  Copyright (c) 2013 Ayal Spitz. All rights reserved.
//

#import "ZViewController.h"
#import "ZTableViewController.h"

@implementation ZViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    ZTableViewController *tabViewController = [[ZTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self setRootViewController:[[ZTableViewController alloc]init] andTabViewController:tabViewController];
}

@end
