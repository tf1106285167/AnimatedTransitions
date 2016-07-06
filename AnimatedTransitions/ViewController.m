//
//  ViewController.m
//  转场动画
//
//  Created by 玉女峰峰主 on 15-11-25.
//  Copyright (c) 2015年 玉女峰峰主. All rights reserved.
//

#import "ViewController.h"

#define KSCreenWidth [UIScreen mainScreen].bounds.size.width
#define KSCreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@property(nonatomic,strong)NSMutableArray *images;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,assign)NSInteger index;

@property(nonatomic,copy)NSString *transitionType;
@property(nonatomic,copy)NSString *transitionSubtype;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, KSCreenWidth, KSCreenHeight)];
    [self.view addSubview:_imageView];
    
    _imageView.image = [UIImage imageNamed:@"1.jpg"];
    //添加向左轻扫手势
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeftAction)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;//黙认是向右轻扫
    [_imageView addGestureRecognizer:swipeLeft];
    //为imageView开启事件交互.
    //隐藏,透明度,userInteractionEnabled = no; 分发的时候,(uiview *)hitTest:
    _imageView.userInteractionEnabled = YES;
    _images = [NSMutableArray array];
    
    for (NSInteger index = 1; index<= 9; index ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",index]];
        [_images addObject:image];
    }
    _index = 0;
    
    //添加向右轻扫手势
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRightAction)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_imageView addGestureRecognizer:swipeRight];
    
    
    //添加向上轻扫手势
    UISwipeGestureRecognizer *swipeTop = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeTopAction)];
    swipeTop.direction = UISwipeGestureRecognizerDirectionUp;
    [_imageView addGestureRecognizer:swipeTop];
    
    
    //添加向下轻扫手势
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDownAction)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [_imageView addGestureRecognizer:swipeDown];
}

//向右轻扫
-(void)swipeRightAction{
    
    _index --;
    
    if (_index == -1) {
        _index = 8;
    }
    
    _transitionType = @"oglFlip";
    _transitionSubtype = @"fromLeft";
    
    [self transitionAction];
}

//向左轻扫
-(void)swipeLeftAction{
    
    _index++;
    if (_index == 9) {
        _index = 0;
    }
    
    _transitionType = @"cube";
    _transitionSubtype = @"fromRight";
    
    [self transitionAction];
}

//向上轻扫
-(void)swipeTopAction{
    
    _index++;
    if (_index == 9) {
        _index = 0;
    }
    
    _transitionType = @"pageCurl";
    _transitionSubtype = @"fromTop";
    
    [self transitionAction];
}

//向右轻扫
-(void)swipeDownAction{
    
    _index --;
    
    if (_index == -1) {
        _index = 8;
    }
    
    _transitionType = @"moveIn";
    _transitionSubtype = @"fromBottom";
    
    [self transitionAction];
}


//创建转厂动画
-(void)transitionAction{
    
    _imageView.image = _images[_index];
    
    CATransition *transition = [[CATransition alloc]init];
    //苹果官方提供：`fade', `moveIn', `push' and `reveal'. Defaults to `fade'； 其它是私有属性，若使用则不能上架（如：cube，oglFlip,suckEffect,rippleEffect,pageCurl,pageUncurl,camerIrisHollowOpen,camerIrisHollowClose）
    transition.type = _transitionType; //转场动画的类型
    //`fromLeft', `fromRight', `fromTop' and `fromBottom'
    transition.subtype = _transitionSubtype;
    transition.duration = .5;
    //将动画添加到图层
    [_imageView.layer addAnimation:transition forKey:@"transition"];
}

@end
