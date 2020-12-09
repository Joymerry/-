//
//  NSArray+PLVMASShorthandAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 22/07/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "NSArray+PLVMASAdditions.h"

#ifdef MAS_SHORTHAND

/**
 *	Shorthand array additions without the 'mas_' prefixes,
 *  only enabled if MAS_SHORTHAND is defined
 */
@interface NSArray (PLVMASShorthandAdditions)

//- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *make))block;
//- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *make))block;
//- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *make))block;

@end

@implementation NSArray (PLVMASShorthandAdditions)

//- (NSArray *)makeConstraints:(void(^)(MASConstraintMaker *))block {
//    return [self plv_makeConstraints:block];
//}
//
//- (NSArray *)updateConstraints:(void(^)(MASConstraintMaker *))block {
//    return [self plv_updateConstraints:block];
//}
//
//- (NSArray *)remakeConstraints:(void(^)(MASConstraintMaker *))block {
//    return [self plv_remakeConstraints:block];
//}

@end

#endif
