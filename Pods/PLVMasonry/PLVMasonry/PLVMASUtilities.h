//
//  PLVMASUtilities.h
//  Masonry
//
//  Created by Jonas Budelmann on 19/08/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import <Foundation/Foundation.h>



#if TARGET_OS_IPHONE || TARGET_OS_TV

    #import <UIKit/UIKit.h>
    #define MAS_VIEW UIView
    #define MAS_VIEW_CONTROLLER UIViewController
    #define MASEdgeInsets UIEdgeInsets

    typedef UILayoutPriority PLVMASLayoutPriority;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityRequired = UILayoutPriorityRequired;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityDefaultHigh = UILayoutPriorityDefaultHigh;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityDefaultMedium = 500;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityDefaultLow = UILayoutPriorityDefaultLow;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityFittingSizeLevel = UILayoutPriorityFittingSizeLevel;

#elif TARGET_OS_MAC

    #import <AppKit/AppKit.h>
    #define MAS_VIEW NSView
    #define MASEdgeInsets NSEdgeInsets

    typedef NSLayoutPriority PLVMASLayoutPriority;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityRequired = NSLayoutPriorityRequired;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityDefaultHigh = NSLayoutPriorityDefaultHigh;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityDragThatCanResizeWindow = NSLayoutPriorityDragThatCanResizeWindow;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityDefaultMedium = 501;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityWindowSizeStayPut = NSLayoutPriorityWindowSizeStayPut;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityDragThatCannotResizeWindow = NSLayoutPriorityDragThatCannotResizeWindow;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityDefaultLow = NSLayoutPriorityDefaultLow;
    static const PLVMASLayoutPriority PLVMASLayoutPriorityFittingSizeCompression = NSLayoutPriorityFittingSizeCompression;

#endif

/**
 *	Allows you to attach keys to objects matching the variable names passed.
 *
 *  view1.plv_key = @"view1", view2.plv_key = @"view2";
 *
 *  is equivalent to:
 *
 *  PLVMASAttachKeys(view1, view2);
 */
#define PLVMASAttachKeys(...)                                                        \
    {                                                                             \
        NSDictionary *keyPairs = NSDictionaryOfVariableBindings(__VA_ARGS__);     \
        for (id key in keyPairs.allKeys) {                                        \
            id obj = keyPairs[key];                                               \
            NSAssert([obj respondsToSelector:@selector(setMas_key:)],             \
                     @"Cannot attach plv_key to %@", obj);                        \
            [obj setMas_key:key];                                                 \
        }                                                                         \
    }

/**
 *  Used to create object hashes
 *  Based on http://www.mikeash.com/pyblog/friday-qa-2010-06-18-implementing-equality-and-hashing.html
 */
#define PLVMAS_NSUINT_BIT (CHAR_BIT * sizeof(NSUInteger))
#define PLVMAS_NSUINTROTATE(val, howmuch) ((((NSUInteger)val) << howmuch) | (((NSUInteger)val) >> (PLVMAS_NSUINT_BIT - howmuch)))

/**
 *  Given a scalar or struct value, wraps it in NSValue
 *  Based on EXPObjectify: https://github.com/specta/expecta
 */
static inline id _PLVMASBoxValue(const char *type, ...) {
    va_list v;
    va_start(v, type);
    id obj = nil;
    if (strcmp(type, @encode(id)) == 0) {
        id actual = va_arg(v, id);
        obj = actual;
    } else if (strcmp(type, @encode(CGPoint)) == 0) {
        CGPoint actual = (CGPoint)va_arg(v, CGPoint);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(CGSize)) == 0) {
        CGSize actual = (CGSize)va_arg(v, CGSize);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(MASEdgeInsets)) == 0) {
        MASEdgeInsets actual = (MASEdgeInsets)va_arg(v, MASEdgeInsets);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(double)) == 0) {
        double actual = (double)va_arg(v, double);
        obj = [NSNumber numberWithDouble:actual];
    } else if (strcmp(type, @encode(float)) == 0) {
        float actual = (float)va_arg(v, double);
        obj = [NSNumber numberWithFloat:actual];
    } else if (strcmp(type, @encode(int)) == 0) {
        int actual = (int)va_arg(v, int);
        obj = [NSNumber numberWithInt:actual];
    } else if (strcmp(type, @encode(long)) == 0) {
        long actual = (long)va_arg(v, long);
        obj = [NSNumber numberWithLong:actual];
    } else if (strcmp(type, @encode(long long)) == 0) {
        long long actual = (long long)va_arg(v, long long);
        obj = [NSNumber numberWithLongLong:actual];
    } else if (strcmp(type, @encode(short)) == 0) {
        short actual = (short)va_arg(v, int);
        obj = [NSNumber numberWithShort:actual];
    } else if (strcmp(type, @encode(char)) == 0) {
        char actual = (char)va_arg(v, int);
        obj = [NSNumber numberWithChar:actual];
    } else if (strcmp(type, @encode(bool)) == 0) {
        bool actual = (bool)va_arg(v, int);
        obj = [NSNumber numberWithBool:actual];
    } else if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char actual = (unsigned char)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedChar:actual];
    } else if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int actual = (unsigned int)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedInt:actual];
    } else if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long actual = (unsigned long)va_arg(v, unsigned long);
        obj = [NSNumber numberWithUnsignedLong:actual];
    } else if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long actual = (unsigned long long)va_arg(v, unsigned long long);
        obj = [NSNumber numberWithUnsignedLongLong:actual];
    } else if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short actual = (unsigned short)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedShort:actual];
    }
    va_end(v);
    return obj;
}

#define PLVMASBoxValue(value) _PLVMASBoxValue(@encode(__typeof__((value))), (value))
