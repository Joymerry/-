//
//  UIViewController+PLVMASAdditions.h
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "PLVMASUtilities.h"
#import "PLVMASConstraintMaker.h"
#import "PLVMASViewAttribute.h"

#ifdef MAS_VIEW_CONTROLLER

@interface MAS_VIEW_CONTROLLER (PLVMASAdditions)

/**
 *	following properties return a new MASViewAttribute with appropriate UILayoutGuide and NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_topLayoutGuide;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_bottomLayoutGuide;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_topLayoutGuideTop;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_topLayoutGuideBottom;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_bottomLayoutGuideTop;
@property (nonatomic, strong, readonly) PLVMASViewAttribute *plv_bottomLayoutGuideBottom;


@end

#endif
