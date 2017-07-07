//
//  CzyRollerCoasterView.h
//  czyRollerCoasterDemo
//
//  Created by macOfEthan on 17/7/6.
//  Copyright © 2017年 macOfEthan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CzyRollerCoasterView : UIView

//开始云朵动画
- (void)addCloudAnimation;
//开始小黄车动画
- (void)addYellowCarAnimation;
//开始小绿车动画
- (void)addGreenCarAnimation;
//移除
- (void)removeCloudAnimation;
- (void)removeYellowCarAnimation;
- (void)removeGreenCarAnimation;

@end
