//
//  UIView+PLVMASAdditions.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "View+PLVMASAdditions.h"
#import <objc/runtime.h>

@implementation MAS_VIEW (PLVMASAdditions)

- (NSArray *)plv_makeConstraints:(void(^)(PLVMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    PLVMASConstraintMaker *constraintMaker = [[PLVMASConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)plv_updateConstraints:(void(^)(PLVMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    PLVMASConstraintMaker *constraintMaker = [[PLVMASConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)plv_remakeConstraints:(void(^)(PLVMASConstraintMaker *make))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    PLVMASConstraintMaker *constraintMaker = [[PLVMASConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (PLVMASViewAttribute *)plv_left {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (PLVMASViewAttribute *)plv_top {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (PLVMASViewAttribute *)plv_right {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (PLVMASViewAttribute *)plv_bottom {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (PLVMASViewAttribute *)plv_leading {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}

- (PLVMASViewAttribute *)plv_trailing {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (PLVMASViewAttribute *)plv_width {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (PLVMASViewAttribute *)plv_height {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (PLVMASViewAttribute *)plv_centerX {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (PLVMASViewAttribute *)plv_centerY {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (PLVMASViewAttribute *)plv_baseline {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}

- (PLVMASViewAttribute *(^)(NSLayoutAttribute))plv_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:attr];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (PLVMASViewAttribute *)plv_firstBaseline {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeFirstBaseline];
}
- (PLVMASViewAttribute *)plv_lastBaseline {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (PLVMASViewAttribute *)plv_leftMargin {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (PLVMASViewAttribute *)plv_rightMargin {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
}

- (PLVMASViewAttribute *)plv_topMargin {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
}

- (PLVMASViewAttribute *)plv_bottomMargin {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (PLVMASViewAttribute *)plv_leadingMargin {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (PLVMASViewAttribute *)plv_trailingMargin {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (PLVMASViewAttribute *)plv_centerXWithinMargins {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (PLVMASViewAttribute *)plv_centerYWithinMargins {
    return [[PLVMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

- (PLVMASViewAttribute *)plv_safeAreaLayoutGuide {
    return [[PLVMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (PLVMASViewAttribute *)plv_safeAreaLayoutGuideTop {
    return [[PLVMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (PLVMASViewAttribute *)plv_safeAreaLayoutGuideBottom {
    return [[PLVMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (PLVMASViewAttribute *)plv_safeAreaLayoutGuideLeft {
    return [[PLVMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeLeft];
}
- (PLVMASViewAttribute *)plv_safeAreaLayoutGuideRight {
    return [[PLVMASViewAttribute alloc] initWithView:self item:self.safeAreaLayoutGuide layoutAttribute:NSLayoutAttributeRight];
}

#endif

#pragma mark - associated properties

- (id)plv_key {
    return objc_getAssociatedObject(self, @selector(plv_key));
}

- (void)setPlv_key:(id)plv_key {
    objc_setAssociatedObject(self, @selector(plv_key), plv_key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (instancetype)plv_closestCommonSuperview:(MAS_VIEW *)view {
    MAS_VIEW *closestCommonSuperview = nil;

    MAS_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        MAS_VIEW *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
