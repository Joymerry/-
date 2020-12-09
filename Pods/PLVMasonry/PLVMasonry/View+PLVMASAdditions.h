//
//  UIView+PLVMASAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "PLVMASUtilities.h"
#import "PLVMASConstraintMaker.h"
#import "PLVMASViewAttribute.h"

/**
 *	Provides constraint maker block
 *  and convience methods for creating MASViewAttribute which are view + NSLayoutAttribute pairs
 */
@interface MAS_VIEW (PLVMASAdditions)

/**
 *	following properties return a new MASViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_left;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_top;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_right;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_bottom;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_leading;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_trailing;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_width;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_height;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_centerX;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_centerY;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_baseline;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *(^plv_attribute)(NSLayoutAttribute attr);

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000) || (__MAC_OS_X_VERSION_MIN_REQUIRED >= 101100)

@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_firstBaseline;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_lastBaseline;

#endif

#if (__IPHONE_OS_VERSION_MIN_REQUIRED >= 80000) || (__TV_OS_VERSION_MIN_REQUIRED >= 9000)

@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_leftMargin;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_rightMargin;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_topMargin;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_bottomMargin;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_leadingMargin;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_trailingMargin;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_centerXWithinMargins;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_centerYWithinMargins;

#endif

#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 110000) || (__TV_OS_VERSION_MAX_ALLOWED >= 110000)

@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_safeAreaLayoutGuide API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_safeAreaLayoutGuideTop API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_safeAreaLayoutGuideBottom API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_safeAreaLayoutGuideLeft API_AVAILABLE(ios(11.0),tvos(11.0));
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_safeAreaLayoutGuideRight API_AVAILABLE(ios(11.0),tvos(11.0));

#endif

/**
 *	a key to associate with this view
 */
@property (nonatomic, strong) id plv_key;

/**
 *	Finds the closest common superview between this view and another view
 *
 *	@param	view	other view
 *
 *	@return	returns nil if common superview could not be found
 */
- (instancetype)plv_closestCommonSuperview:(MAS_VIEW *)view;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created MASConstraints
 */
- (NSArray *)plv_makeConstraints:(void(NS_NOESCAPE ^)(PLVMASConstraintMaker *make))block;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)plv_updateConstraints:(void(NS_NOESCAPE ^)(PLVMASConstraintMaker *make))block;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)plv_remakeConstraints:(void(NS_NOESCAPE ^)(PLVMASConstraintMaker *make))block;

@end
