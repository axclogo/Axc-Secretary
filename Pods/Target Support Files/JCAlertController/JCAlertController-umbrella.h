#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "JCAlertView.h"
#import "JCAlertButtonItem.h"
#import "NSAttributedString+JCCalculateSize.h"
#import "UIColor+JCHightlightedColor.h"
#import "UIImage+JCColor2Image.h"
#import "UIWindow+JCBlur.h"
#import "JCAlertController.h"
#import "JCPresentController.h"
#import "UIViewController+JCPresentQueue.h"
#import "JCAlertStyle.h"

FOUNDATION_EXPORT double JCAlertControllerVersionNumber;
FOUNDATION_EXPORT const unsigned char JCAlertControllerVersionString[];

