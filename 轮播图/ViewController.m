//
//  ViewController.m
//  轮播图
//
//  Created by jiangwei18 on 17/6/10.
//  Copyright © 2017年 jiangwei18. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *mPageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int xOffset = self.mScrollView.contentOffset.x;
    xOffset = xOffset + 150;
    self.mPageControl.currentPage = xOffset/300;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    for (int i = 0;i < 5;i++) {
        UIImageView *iv = [UIImageView new];
        NSString* name = [NSString stringWithFormat:@"img_%02d",i+1];
        iv.frame = CGRectMake(i*300, 0, 300, 130);
        [iv setImage:[UIImage imageNamed:name]];
        [self.mScrollView addSubview:iv];
    }
    [self.mScrollView setContentSize:CGSizeMake(300*5, 0)];
    self.mScrollView.pagingEnabled = YES;
    self.mPageControl.numberOfPages = 5;
    self.mScrollView.delegate = self;
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    [loop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextPage {
    NSUInteger page = self.mPageControl.currentPage;
    if (page == 4) {
        [self.mScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else {
        [self.mScrollView setContentOffset:CGPointMake((page+1)*300, 0) animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
