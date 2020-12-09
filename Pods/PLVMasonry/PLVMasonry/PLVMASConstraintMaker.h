//
//  MASConstraintMaker.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "PLVMASConstraint.h"
#import "PLVMASUtilities.h"

typedef NS_OPTIONS(NSInteger, PLVMASAttribute) {
    PLVMASAttributeLeft = 1 << NSLayoutAttributeLeft,
    PLVMASAttributeRight = 1 << NSLayoutAttributeRight,
    PLVMASAttributeTop = 1 << NSLayoutAttributeTop,
    PLVMASAttributeBottom = 1 << NSLayoutAttributeBottom,
    PLVMASAttributeLeading = 1 << NSLayoutAttributeLeading,
    PLVMASAttributeTrailing = 1 << NSLayoutAttributeTrailing,
    PLVMASAttributeWidth = 1 << NSLayoutAttributeWidth,
    PLVMASAttributeHeight = 1 << NSLayoutAttributeHeight,
    PLVMASAttributeCenterX = 1 << NSLayoutAttributeCenterX,
    PLVMASAttributeCenterY = 1 << NSLayoutAttributeCenterY,
    PLVMASAttributeBaseline = 1 << NSLayoutAttributeBaseline,
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)
    
    PLVMASAttributeFirstBaseline = 1 << NSLayoutAttributeFirstBaseline,
    PLVMASAttributeLastBaseline = 1 << NSLayoutAttributeLastBaseline,
    
#endif
    
#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)
    
    PLVMASAttributeLeftMargin = 1 << NSLayoutAttributeLeftMargin,
    PLVMASAttributeRightMargin = 1 << NSLayoutAttributeRightMargin,
    PLVMASAttributeTopMargin = 1 << NSLayoutAttributeTopMargin,
    PLVMASAttributeBottomMargin = 1 << NSLayoutAttributeBottomMargin,
    PLVMASAttributeLeadingMargin = 1 << NSLayoutAttributeLeadingMargin,
    PLVMASAttributeTrailingMargin = 1 << NSLayoutAttributeTrailingMargin,
    PLVMASAttributeCenterXWithinMargins = 1 << NSLayoutAttributeCenterXWithinMargins,
    PLVMASAttributeCenterYWithinMargins = 1 << NSLayoutAttributeCenterYWithinMargins,

#endif
    
};

/**
 *  Provides factory methods for creating MASConstraints.
 *  Constraints are collected until they are ready to be installed
 *
 */
@interface PLVMASConstraintMaker : NSObject

/**
 *	The following properties return a new MASViewConstraint
 *  with the first item set to the makers associated view and the appropriate MASViewAttribute
 */
@property (nonatomic, strong, readonly) PLVMASConstraint *left;
@property (nonatomic, strong, readonly) PLVMASConstraint *top;
@property (nonatomic, strong, readonly) PLVMASConstraint *right;
@property (nonatomic, strong, readonly) PLVMASConstraint *bottom;
@property (nonatomic, strong, readonly) PLVMASConstraint *leading;
@property (nonatomic, strong, readonly) PLVMASConstraint *trailing;
@property (nonatomic, strong, readonly) PLVMASConstraint *width;
@property (nonatomic, strong, readonly) PLVMASConstraint *height;
@property (nonatomic, strong, readonly) PLVMASConstraint *centerX;
@property (nonatomic, strong, readonly) PLVMASConstraint *centerY;
@property (nonatomic, strong, readonly) PLVMASConstraint *baseline;

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) PLVMASConstraint *firstBaseline;
@property (nonatomic, strong, readonly) PLVMASConstraint *lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) PLVMASConstraint *leftMargin;
@property (nonatomic, strong, readonly) PLVMASConstraint *rightMargin;
@property (nonatomic, strong, readonly) PLVMASConstraint *topMargin;
@property (nonatomic, strong, readonly) PLVMASConstraint *bottomMargin;
@property (nonatomic, strong, readonly) PLVMASConstraint *leadingMargin;
@property (nonatomic, strong, readonly) PLVMASConstraint *trailingMargin;
@property (nonatomic, strong, readonly) PLVMASConstraint *centerXWithinMargins;
@property (nonatomic, strong, readonly) PLVMASConstraint *centerYWithinMargins;

#endif

/**
 *  Returns a block which creates a new MASCompositeConstraint with the first item set
 *  to the makers associated view and children corresponding to the set bits in the
 *  PLVMASAttribute parameter. Combine multiple attributes via binary-or.
 */
@property (nonatomic, strong, readonly) PLVMASConstraint *(^attributes)(PLVMASAttribute attrs);

/**
 *	Creates a MASCompositeConstraint with type MASCompositeConstraintTypeEdges
 *  which generates the appropriate MASViewConstraint children (top, left, bottom, right)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) PLVMASConstraint *edges;

/**
 *	Creates a MASCompositeConstraint with type MASCompositeConstraintTypeSize
 *  which generates the appropriate MASViewConstraint children (width, height)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) PLVMASConstraint *size;

/**
 *	Creates a MASCompositeConstraint with type MASCompositeConstraintTypeCenter
 *  which generates the appropriate MASViewConstraint children (centerX, centerY)
 *  with the first item set to the makers associated view
 */
@property (nonatomic, strong, readonly) PLVMASConstraint *center;

/**
 *  Whether or not to check for an existing constraint instead of adding constraint
 */
@property (nonatomic, assign) BOOL updateExisting;

/**
 *  Whether or not to remove existing constraints prior to installing
 */
@property (nonatomic, assign) BOOL removeExisting;

/**
 *	initialises the maker with a default view
 *
 *	@param	view	any MASConstraint are created with this view as the first item
 *
 *	@return	a new MASConstraintMaker
 */
- (id)initWithView:(MAS_VIEW *)view;

/**
 *	Calls install method on any MASConstraints which have been created by this maker
 *
 *	@return	an array of all the installed MASConstraints
 */
- (NSArray *)install;

- (PLVMASConstraint * (^)(dispatch_block_t))group;

@end
