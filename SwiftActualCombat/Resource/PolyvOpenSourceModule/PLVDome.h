//
//  PLVDome.h
//  SwiftActualCombat
//
//  Created by 王俊杰的Mac mini on 2020/11/10.
//  Copyright © 2020 王俊杰的Mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLVVodSkinPlayerController.h"
NS_ASSUME_NONNULL_BEGIN

@interface PLVDome : NSObject
@property (nonatomic,strong) PLVVodSkinPlayerController * player;
- (void)polyvInit;
- (PLVVodSkinPlayerController *)play;
@end

NS_ASSUME_NONNULL_END
