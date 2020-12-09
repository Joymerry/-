//
//  UIViewController+PLVMASAdditions.m
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "ViewController+PLVMASAdditions.h"

#ifdef MAS_VIEW_CONTROLLER

@implementation MAS_VIEW_CONTROLLER (PLVMASAdditions)

- (PLVMASViewAttribute *)plv_topLayoutGuide {
    return [[PLVMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (PLVMASViewAttribute *)plv_topLayoutGuideTop {
    return [[PLVMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (PLVMASViewAttribute *)plv_topLayoutGuideBottom {
    return [[PLVMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (PLVMASViewAttribute *)plv_bottomLayoutGuide {
    return [[PLVMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (PLVMASViewAttribute *)plv_bottomLayoutGuideTop {
    return [[PLVMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (PLVMASViewAttribute *)plv_bottomLayoutGuideBottom {
    return [[PLVMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}



@end

#endif
