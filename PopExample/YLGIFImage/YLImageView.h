//
//  YLImageView.h
//  YLGIFImage
//
//  Created by Yong Li on 14-3-2.
//  Copyright (c) 2014年 Yong Li. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLGIFImage;
@interface YLImageView : UIImageView

@property (nonatomic, copy) NSString *runLoopMode;
- (void)stopAnimating;
@property (nonatomic, strong) YLGIFImage *animatedImage;
@property (nonatomic) NSUInteger loopCountdown;
@end
