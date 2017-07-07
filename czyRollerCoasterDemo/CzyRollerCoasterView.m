//
//  CzyRollerCoasterView.m
//  czyRollerCoasterDemo
//
//  Created by macOfEthan on 17/7/6.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#define kSelfWidth self.bounds.size.width
#define kSelfHeight self.bounds.size.height

#import "CzyRollerCoasterView.h"

@interface CzyRollerCoasterView ()
{
    //黄色轨道
    CAShapeLayer *_yellowCarLayer;
    UIBezierPath *_yellowPathWayPath;
    //绿色轨道
    CAShapeLayer *_greenCarLayer;
    UIBezierPath *_greenPathWayPath;
    //云朵
    CALayer *_cloudLayer;
    UIBezierPath *_cloudPath;
}
@end

@implementation CzyRollerCoasterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initRollerCoasterView];
    }
    return self;
}

- (void)initRollerCoasterView
{
    //背景
    [self customInitBackgroundView];
    //初始化山脉
    [self mountainUIInit];
    //黄色轨道
    [self yellowPathWay];
    //云朵
    [self cloud];
    //绿色轨道
    [self greenPathWay];
    //草坪
    [self grassland];
    //大地
    [self earthUIInit];
    //树
    [self tree];
}


#pragma mark - 初始化背景
- (void)customInitBackgroundView
{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.frame = CGRectMake(0, 0, kSelfWidth, kSelfHeight);
    //创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = @[(id)[UIColor colorWithRed:178.0/255.0 green:226.0/255.0 blue:248.0/255.0 alpha:1.0].CGColor,(id)[UIColor colorWithRed:232.0/255.0 green:244.0/255.0 blue:193.0/255.0 alpha:1.0].CGColor];
    //  设置三种颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@(0.1f) ,@(0.4f)];
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    [self.layer addSublayer:gradientLayer];
}

#pragma mark - 初始化大地
- (void)earthUIInit
{
    CALayer *earthLayer = [CALayer layer];
    earthLayer.frame = CGRectMake(0, kSelfHeight-20, kSelfWidth, 20);
    earthLayer.backgroundColor = [UIColor colorWithDisplayP3Red:82.0/255.0 green:177.0/255.0 blue:44.0/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:earthLayer];
}

#pragma mark - 初始化山脉
- (void)mountainUIInit
{
    //第一座山
    //背景
    UIBezierPath *mountain1Path = [UIBezierPath bezierPath];
    [mountain1Path moveToPoint:CGPointMake(0, kSelfHeight-20)];
    [mountain1Path addLineToPoint:CGPointMake(50, kSelfHeight-120)];
    [mountain1Path addLineToPoint:CGPointMake(120, kSelfHeight-20)];
    
    CAShapeLayer *mountain1Layer = [CAShapeLayer layer];
    mountain1Layer.fillColor = [UIColor brownColor].CGColor;
    mountain1Layer.path = mountain1Path.CGPath;
    [self.layer addSublayer:mountain1Layer];
    
    //覆盖层
    UIBezierPath *mask1Path = [UIBezierPath bezierPath];
    CAShapeLayer *mask1Layer = [CAShapeLayer layer];

    //计算斜线上的点 slope代表斜率 b代表截距 slope=(y1-y2)/(x1-x2) b=y1-slope*x1
    CGFloat slope11 = (kSelfHeight-120-(kSelfHeight-20))/(50-0);
    CGFloat b11 = kSelfHeight-120-slope11*50;
    CGFloat slope12 = (kSelfHeight-20-(kSelfHeight-120))/(120-50);
    CGFloat b12 = kSelfHeight-20-slope12*120;

    [mask1Path moveToPoint:CGPointMake(35, (slope11*35)+b11)];
    [mask1Path addLineToPoint:CGPointMake(50, kSelfHeight-120)];
    [mask1Path addLineToPoint:CGPointMake(95, slope12*95+b12)];
    
    mask1Layer.path = mask1Path.CGPath;
    mask1Layer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:mask1Layer];
    
    
    //第二座山
    CAShapeLayer *mountain2Layer = [CAShapeLayer layer];
    UIBezierPath *mountain2Path = [UIBezierPath bezierPath];
    [mountain2Path moveToPoint:CGPointMake(50, kSelfHeight-20)];
    [mountain2Path addLineToPoint:CGPointMake(110, kSelfHeight-70)];
    [mountain2Path addLineToPoint:CGPointMake(150, kSelfHeight-20)];
    
    mountain2Layer.fillColor = [UIColor brownColor].CGColor;
    mountain2Layer.path = mountain2Path.CGPath;
    [self.layer addSublayer:mountain2Layer];
    
    CAShapeLayer *mask2Layer = [CAShapeLayer layer];
    UIBezierPath *mask2Path = [UIBezierPath bezierPath];
    
    CGFloat slope21 = (kSelfHeight-70-(kSelfHeight-20))/(110-50);
    CGFloat slope22 = (kSelfHeight-20-(kSelfHeight-70))/(150-110);
    CGFloat b21 = kSelfHeight-20-slope21*50;
    CGFloat b22 = kSelfHeight-70-slope22*110;
    
    [mask2Path moveToPoint:CGPointMake(85, 85*slope21+b21)];
    [mask2Path addLineToPoint:CGPointMake(110, kSelfHeight-70)];
    [mask2Path addLineToPoint:CGPointMake(150, 150*slope22+b22)];
    
    mask2Layer.path = mask2Path.CGPath;
    mask2Layer.fillColor = [UIColor whiteColor].CGColor;
    [self.layer addSublayer:mask2Layer];
}

#pragma mark - 云朵
- (void)cloud
{
    _cloudLayer = [CALayer layer];
    
    //设置layer内容
    _cloudLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"cloud"].CGImage);
    //设置云朵的起始位置和大小
    _cloudLayer.frame = CGRectMake(-20, -100, 60, 20);
    
    _cloudPath = [UIBezierPath bezierPath];
    [_cloudPath moveToPoint:CGPointMake(kSelfWidth+65, 40)];
    [_cloudPath addLineToPoint:CGPointMake(-65, 40)];
    
    [self.layer addSublayer:_cloudLayer];
}

#pragma mark - 草坪
- (void)grassland
{
    UIBezierPath *grassland1Path = [UIBezierPath bezierPath];
    [grassland1Path moveToPoint:CGPointMake(0, kSelfHeight-20)];
    [grassland1Path addLineToPoint:CGPointMake(0, kSelfHeight-50)];
    [grassland1Path addQuadCurveToPoint:CGPointMake(kSelfWidth/3, kSelfHeight-20) controlPoint:CGPointMake(30, kSelfHeight-55)];
    
    CAShapeLayer *grasslandLayer = [CAShapeLayer layer];
    grasslandLayer.path = grassland1Path.CGPath;
    grasslandLayer.fillColor = [UIColor colorWithDisplayP3Red:92.0/255.0 green:195.0/255.0 blue:52.0/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:grasslandLayer];
    
    
    UIBezierPath *grassland2Path = [UIBezierPath bezierPath];
    [grassland2Path moveToPoint:CGPointMake(0, kSelfHeight-20)];
    [grassland2Path addQuadCurveToPoint:CGPointMake(kSelfWidth, kSelfHeight-50) controlPoint:CGPointMake(kSelfWidth*2/3, kSelfHeight-55)];
    [grassland2Path addLineToPoint:CGPointMake(kSelfWidth, kSelfHeight-20)];
    [grassland2Path fill];
    
    CAShapeLayer *grassland2Layer = [CAShapeLayer layer];
    grassland2Layer.path = grassland2Path.CGPath;
    grassland2Layer.fillColor = [UIColor colorWithDisplayP3Red:82.0/255.0 green:177.0/255.0 blue:44.0/255.0 alpha:1.0].CGColor;
    [self.layer addSublayer:grassland2Layer];
}

#pragma mark - 土地上种树
- (void)tree
{
    NSArray *xArr = @[@25,@(kSelfWidth-50),@(kSelfWidth-80),@(kSelfWidth/2-30),@60,@87,@(kSelfWidth-30),@97,@124,@245,@139,@(kSelfWidth/2+10),@(kSelfWidth/2+23),@(kSelfWidth-90),@(kSelfWidth/2+23),@(kSelfWidth-90),@(kSelfWidth-30),@(kSelfWidth-10)];
    NSArray *yArr = @[@(kSelfHeight-10),@(kSelfHeight-5),@(kSelfHeight-8),@(kSelfHeight-12),@(kSelfHeight-14),@(kSelfHeight-20),@(kSelfHeight-20-3),@(kSelfHeight-20-2),@(kSelfHeight-20-3),@(kSelfHeight-5),@(kSelfHeight-8),@(kSelfHeight-20-1),@(kSelfHeight-20-2),@(kSelfHeight-20-4),@(kSelfHeight-5),@(kSelfHeight-8),@(kSelfHeight-20-4),@(kSelfHeight-5)];
    
    for (NSInteger i=0; i<MIN(xArr.count, yArr.count); i++) {
        
        CALayer *treeLayer = [CALayer layer];
        treeLayer.frame = CGRectMake([xArr[i] floatValue], [yArr[i] integerValue]-20, 20, 20);
        //树
        treeLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"tree"].CGImage);
        [self.layer addSublayer:treeLayer];
    }
}

#pragma mark - 黄色轨道
- (void)yellowPathWay
{
    _yellowPathWayPath = [UIBezierPath bezierPath];
    _yellowPathWayPath.lineCapStyle = kCGLineCapRound;
    _yellowPathWayPath.lineJoinStyle = kCGLineJoinRound;

    [_yellowPathWayPath moveToPoint:CGPointMake(0, kSelfHeight-50)];
    [_yellowPathWayPath addCurveToPoint:CGPointMake(kSelfWidth+10, kSelfHeight-120) controlPoint1:CGPointMake(kSelfWidth/4, kSelfHeight-80) controlPoint2:CGPointMake(kSelfWidth/2, kSelfHeight-30)];
    [_yellowPathWayPath addLineToPoint:CGPointMake(kSelfWidth, kSelfHeight-25)];
    [_yellowPathWayPath addLineToPoint:CGPointMake(0, kSelfHeight-25)];
    
    CAShapeLayer *curveLayer = [CAShapeLayer layer];
    curveLayer.lineWidth = 4;
//    curveLayer.fillRule = kCAFillRuleEvenOdd;
    curveLayer.lineCap = kCALineCapRound;
    curveLayer.fillColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow"]].CGColor;
    curveLayer.strokeColor = [UIColor colorWithRed:210.0/255.0 green:179.0/255.0 blue:54.0/255.0 alpha:1.0].CGColor;
    curveLayer.path = _yellowPathWayPath.CGPath;
    [self.layer addSublayer:curveLayer];
    
    
    //黄色小车动画
    _yellowCarLayer = [CAShapeLayer layer];
    _yellowCarLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"rollerCoasterCar"].CGImage);
    _yellowCarLayer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
    //设置小车的起始位置和大小
    _yellowCarLayer.frame = CGRectMake(-20, -20, 20, 10);
    [self.layer addSublayer:_yellowCarLayer];
    
    //镂空的虚线
    CAShapeLayer *trackLineLayer = [CAShapeLayer layer];
    trackLineLayer.lineCap = kCALineCapRound;
    // 第一个是 线条长度   第二个是间距    nil时为实线
    trackLineLayer.strokeColor = [UIColor whiteColor].CGColor;
    trackLineLayer.lineDashPattern = @[@10.0,@5];
    trackLineLayer.lineWidth = 2;
    trackLineLayer.fillColor = nil;
    trackLineLayer.path = _yellowPathWayPath.CGPath;
    [self.layer addSublayer:trackLineLayer];
}

#pragma mark - 绿色轨道
- (void)greenPathWay
{
    CAShapeLayer *greenLayer = [CAShapeLayer layer];
    greenLayer.fillColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]].CGColor;
    greenLayer.strokeColor = [UIColor brownColor].CGColor;
    greenLayer.fillRule = kCAFillRuleEvenOdd;
    greenLayer.lineWidth = 4;
    greenLayer.lineJoin = kCALineJoinRound;
    greenLayer.lineJoin = kCALineCapRound;
    
    _greenPathWayPath = [UIBezierPath bezierPath];
    [_greenPathWayPath moveToPoint:CGPointMake(kSelfWidth+10, kSelfHeight)];
    [_greenPathWayPath addLineToPoint:CGPointMake(kSelfWidth+10, kSelfHeight-70)];
    [_greenPathWayPath addQuadCurveToPoint:CGPointMake(kSelfWidth/2, kSelfHeight-40) controlPoint:CGPointMake(kSelfWidth/2*3, kSelfHeight-100)];
    [_greenPathWayPath addArcWithCenter:CGPointMake(kSelfWidth/2, kSelfHeight-80) radius:40 startAngle:0.5*M_PI endAngle:2.5*M_PI clockwise:YES];
    [_greenPathWayPath addQuadCurveToPoint:CGPointMake(-10, kSelfHeight-30) controlPoint:CGPointMake(kSelfWidth/6, kSelfHeight-40)];
    [_greenPathWayPath addLineToPoint:CGPointMake(-10, kSelfHeight)];
    [_greenPathWayPath fill];
    
    greenLayer.path = _greenPathWayPath.CGPath;
    [self.layer addSublayer:greenLayer];
    
    //绿色轨道小车
    _greenCarLayer = [CAShapeLayer layer];
    _greenCarLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"car_back"].CGImage);
    //设置小车的起始位置和大小
    _greenCarLayer.frame = CGRectMake(-20, -20, 20, 10);
    [self.layer addSublayer:_greenCarLayer];

    
    //添加镂空虚线
    CAShapeLayer *greenDashLayer = [CAShapeLayer layer];
    greenDashLayer.strokeColor = [UIColor whiteColor].CGColor;
    greenDashLayer.lineDashPattern = @[@10,@5];
    greenDashLayer.lineWidth = 2;
    greenDashLayer.fillColor = nil;
    greenDashLayer.path = _greenPathWayPath.CGPath;
    [self.layer addSublayer:greenDashLayer];
}

#pragma mark - 云朵动画
- (CAKeyframeAnimation *)customCreatCloudAnimation
{
    CAKeyframeAnimation *cloudAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    cloudAnimation.duration = 5.0;
    cloudAnimation.repeatCount = MAXFLOAT;
    cloudAnimation.autoreverses = false;
    cloudAnimation.calculationMode = kCAAnimationPaced;
    
    return cloudAnimation;
}

#pragma mark - 过山车动画
- (CAKeyframeAnimation *)rollerCoasterAnimation
{
    CAKeyframeAnimation *carAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    carAnimation.duration = 4.0;
    carAnimation.repeatCount = MAXFLOAT;
    carAnimation.autoreverses = false;
    carAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    carAnimation.calculationMode = kCAAnimationPaced;
    //转圈自动旋转
    carAnimation.rotationMode = kCAAnimationRotateAuto;
    
    return carAnimation;
}

#pragma mark - 开始动画
//开始云朵动画
- (void)addCloudAnimation
{
    CAKeyframeAnimation *cloudAnimation = [self customCreatCloudAnimation];
    //设置动画路径
    cloudAnimation.path = _cloudPath.CGPath;
    
    //添加动画到layer
    [_cloudLayer addAnimation:cloudAnimation forKey:@"cloud"];
}
//开始小黄车动画
- (void)addYellowCarAnimation
{
    CAKeyframeAnimation *carAnimation = [self rollerCoasterAnimation];
    carAnimation.path = _yellowPathWayPath.CGPath;
    
    [_yellowCarLayer addAnimation:carAnimation forKey:@"yellowCarAnimation"];
}
//开始小绿车动画
- (void)addGreenCarAnimation
{
    CAKeyframeAnimation *greenCarAnimation = [self rollerCoasterAnimation];
    greenCarAnimation.path = _greenPathWayPath.CGPath;
    [_greenCarLayer addAnimation:greenCarAnimation forKey:@"greenCarAnimation"];
}

#pragma mark - 移除动画
- (void)removeCloudAnimation
{
    [_cloudLayer removeAnimationForKey:@"cloud"];
}
- (void)removeYellowCarAnimation
{
    [_yellowCarLayer removeAnimationForKey:@"yellowCarAnimation"];
}
- (void)removeGreenCarAnimation
{
    [_greenCarLayer removeAnimationForKey:@"greenCarAnimation"];
}

@end












