//
//  ViewController.m
//  czyRollerCoasterDemo
//
//  Created by macOfEthan on 17/7/6.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#define kCzyWidth [UIScreen mainScreen].bounds.size.width
#define kCzyHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "CzyRollerCoasterView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    CzyRollerCoasterView *_rollerCoasterView;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _rollerCoasterView = [[CzyRollerCoasterView alloc] initWithFrame:CGRectMake(0, -150, kCzyWidth, 150)];
    
    [self.view addSubview:_rollerCoasterView];
    
    [self initTableView];
}

- (void)initTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kCzyWidth, kCzyHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake(-150, 0, 0, 0);
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    _tableView.tableHeaderView = _rollerCoasterView;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    
    NSLog(@"offset = %f", offset);
    
//    _rollerCoasterView.frame = CGRectMake(0, -150-offset, kCzyWidth, 150);
    
    if (offset < 0) {
        
        [_rollerCoasterView addCloudAnimation];
        [_rollerCoasterView addGreenCarAnimation];
        [_rollerCoasterView addYellowCarAnimation];
        
        [UIView animateWithDuration:0.5 animations:^{
            _tableView.contentInset = UIEdgeInsetsZero;
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [UIView animateWithDuration:0.5 animations:^{
                _tableView.contentInset = UIEdgeInsetsMake(-150, 0, 0, 0);
            }];
            
            [_rollerCoasterView removeCloudAnimation];
            [_rollerCoasterView removeGreenCarAnimation];
            [_rollerCoasterView removeYellowCarAnimation];
        });
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reused = @"reused";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reused];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reused];
    }
    
    cell.textLabel.text = @"1111";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
