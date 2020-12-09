//
//  MASConstraintMaker.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "PLVMASConstraintMaker.h"
#import "PLVMASViewConstraint.h"
#import "PLVMASCompositeConstraint.h"
#import "PLVMASConstraint+Private.h"
#import "PLVMASViewAttribute.h"
#import "View+PLVMASAdditions.h"

@interface PLVMASConstraintMaker () <PLVMASConstraintDelegate>

@property (nonatomic, weak) MAS_VIEW *view;
@property (nonatomic, strong) NSMutableArray *constraints;

@end

@implementation PLVMASConstraintMaker

- (id)initWithView:(MAS_VIEW *)view {
    self = [super init];
    if (!self) return nil;
    
    self.view = view;
    self.constraints = NSMutableArray.new;
    
    return self;
}

- (NSArray *)install {
    if (self.removeExisting) {
        NSArray *installedConstraints = [PLVMASViewConstraint installedConstraintsForView:self.view];
        for (PLVMASConstraint *constraint in installedConstraints) {
            [constraint uninstall];
        }
    }
    NSArray *constraints = self.constraints.copy;
    for (PLVMASConstraint *constraint in constraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
    [self.constraints removeAllObjects];
    return constraints;
}

#pragma mark - PLVMASConstraintDelegate

- (void)constraint:(PLVMASConstraint *)constraint shouldBeReplacedWithConstraint:(PLVMASConstraint *)replacementConstraint {
    NSUInteger index = [self.constraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (PLVMASConstraint *)constraint:(PLVMASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    PLVMASViewAttribute *viewAttribute = [[PLVMASViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];
    PLVMASViewConstraint *newConstraint = [[PLVMASViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    if ([constraint isKindOfClass:PLVMASViewConstraint.class]) {
        //replace with composite constraint
        NSArray *children = @[constraint, newConstraint];
        PLVMASCompositeConstraint *compositeConstraint = [[PLVMASCompositeConstraint alloc] initWithChildren:children];
        compositeConstraint.delegate = self;
        [self constraint:constraint shouldBeReplacedWithConstraint:compositeConstraint];
        return compositeConstraint;
    }
    if (!constraint) {
        newConstraint.delegate = self;
        [self.constraints addObject:newConstraint];
    }
    return newConstraint;
}

- (PLVMASConstraint *)addConstraintWithAttributes:(PLVMASAttribute)attrs {
    __unused PLVMASAttribute anyAttribute = (PLVMASAttributeLeft | PLVMASAttributeRight | PLVMASAttributeTop | PLVMASAttributeBottom | PLVMASAttributeLeading
                                          | PLVMASAttributeTrailing | PLVMASAttributeWidth | PLVMASAttributeHeight | PLVMASAttributeCenterX
                                          | PLVMASAttributeCenterY | PLVMASAttributeBaseline
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
                                          | PLVMASAttributeFirstBaseline | PLVMASAttributeLastBaseline
#endif
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
                                          | PLVMASAttributeLeftMargin | PLVMASAttributeRightMargin | PLVMASAttributeTopMargin | PLVMASAttributeBottomMargin
                                          | PLVMASAttributeLeadingMargin | PLVMASAttributeTrailingMargin | PLVMASAttributeCenterXWithinMargins
                                          | PLVMASAttributeCenterYWithinMargins
#endif
                                          );
    
    NSAssert((attrs & anyAttribute) != 0, @"You didn't pass any attribute to make.attributes(...)");
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    if (attrs & PLVMASAttributeLeft) [attributes addObject:self.view.plv_left];
    if (attrs & PLVMASAttributeRight) [attributes addObject:self.view.plv_right];
    if (attrs & PLVMASAttributeTop) [attributes addObject:self.view.plv_top];
    if (attrs & PLVMASAttributeBottom) [attributes addObject:self.view.plv_bottom];
    if (attrs & PLVMASAttributeLeading) [attributes addObject:self.view.plv_leading];
    if (attrs & PLVMASAttributeTrailing) [attributes addObject:self.view.plv_trailing];
    if (attrs & PLVMASAttributeWidth) [attributes addObject:self.view.plv_width];
    if (attrs & PLVMASAttributeHeight) [attributes addObject:self.view.plv_height];
    if (attrs & PLVMASAttributeCenterX) [attributes addObject:self.view.plv_centerX];
    if (attrs & PLVMASAttributeCenterY) [attributes addObject:self.view.plv_centerY];
    if (attrs & PLVMASAttributeBaseline) [attributes addObject:self.view.plv_baseline];
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    if (attrs & PLVMASAttributeFirstBaseline) [attributes addObject:self.view.plv_firstBaseline];
    if (attrs & PLVMASAttributeLastBaseline) [attributes addObject:self.view.plv_lastBaseline];
    
#endif
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
    
    if (attrs & PLVMASAttributeLeftMargin) [attributes addObject:self.view.plv_leftMargin];
    if (attrs & PLVMASAttributeRightMargin) [attributes addObject:self.view.plv_rightMargin];
    if (attrs & PLVMASAttributeTopMargin) [attributes addObject:self.view.plv_topMargin];
    if (attrs & PLVMASAttributeBottomMargin) [attributes addObject:self.view.plv_bottomMargin];
    if (attrs & PLVMASAttributeLeadingMargin) [attributes addObject:self.view.plv_leadingMargin];
    if (attrs & PLVMASAttributeTrailingMargin) [attributes addObject:self.view.plv_trailingMargin];
    if (attrs & PLVMASAttributeCenterXWithinMargins) [attributes addObject:self.view.plv_centerXWithinMargins];
    if (attrs & PLVMASAttributeCenterYWithinMargins) [attributes addObject:self.view.plv_centerYWithinMargins];
    
#endif
    
    NSMutableArray *children = [NSMutableArray arrayWithCapacity:attributes.count];
    
    for (PLVMASViewAttribute *a in attributes) {
        [children addObject:[[PLVMASViewConstraint alloc] initWithFirstViewAttribute:a]];
    }
    
    PLVMASCompositeConstraint *constraint = [[PLVMASCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

#pragma mark - standard Attributes

- (PLVMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    return [self constraint:nil addConstraintWithLayoutAttribute:layoutAttribute];
}

- (PLVMASConstraint *)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (PLVMASConstraint *)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (PLVMASConstraint *)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (PLVMASConstraint *)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (PLVMASConstraint *)leading {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeading];
}

- (PLVMASConstraint *)trailing {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}

- (PLVMASConstraint *)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (PLVMASConstraint *)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (PLVMASConstraint *)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (PLVMASConstraint *)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (PLVMASConstraint *)baseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}

- (PLVMASConstraint *(^)(PLVMASAttribute))attributes {
    return ^(PLVMASAttribute attrs){
        return [self addConstraintWithAttributes:attrs];
    };
}

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

- (PLVMASConstraint *)firstBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeFirstBaseline];
}

- (PLVMASConstraint *)lastBaseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLastBaseline];
}

#endif


#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

- (PLVMASConstraint *)leftMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeftMargin];
}

- (PLVMASConstraint *)rightMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRightMargin];
}

- (PLVMASConstraint *)topMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTopMargin];
}

- (PLVMASConstraint *)bottomMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottomMargin];
}

- (PLVMASConstraint *)leadingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (PLVMASConstraint *)trailingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (PLVMASConstraint *)centerXWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (PLVMASConstraint *)centerYWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif


#pragma mark - composite Attributes

- (PLVMASConstraint *)edges {
    return [self addConstraintWithAttributes:PLVMASAttributeTop | PLVMASAttributeLeft | PLVMASAttributeRight | PLVMASAttributeBottom];
}

- (PLVMASConstraint *)size {
    return [self addConstraintWithAttributes:PLVMASAttributeWidth | PLVMASAttributeHeight];
}

- (PLVMASConstraint *)center {
    return [self addConstraintWithAttributes:PLVMASAttributeCenterX | PLVMASAttributeCenterY];
}

#pragma mark - grouping

- (PLVMASConstraint *(^)(dispatch_block_t group))group {
    return ^id(dispatch_block_t group) {
        NSInteger previousCount = self.constraints.count;
        group();

        NSArray *children = [self.constraints subarrayWithRange:NSMakeRange(previousCount, self.constraints.count - previousCount)];
        PLVMASCompositeConstraint *constraint = [[PLVMASCompositeConstraint alloc] initWithChildren:children];
        constraint.delegate = self;
        return constraint;
    };
}

@end
