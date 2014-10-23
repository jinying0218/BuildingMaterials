//
//  VendorMacro.h
//  ProInspection
//
//  Created by Aries on 14-7-8.
//  Copyright (c) 2014年 Sagitar. All rights reserved.
//

#ifndef ProInspection_VendorMacro_h
#define ProInspection_VendorMacro_h

#define IOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)
#define CurrentVersion ([[[UIDevice currentDevice] systemVersion] floatValue])
#define CurrentSystem ([[UIDevice currentDevice] localizedModel])
#define CurrentModel ([[UIDevice currentDevice] model])
#define GetUUIDCODE (CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, CFUUIDCreate(kCFAllocatorDefault))))

#define STATUS_BAR_HEGHT (IOS7 ? 20.0f : 0.0f)
#define KnaviBarHeight 44
#define KbottomBarHeight 49

#define KscreenW  [UIScreen mainScreen].bounds.size.width    // 屏幕的宽度
#define KscreenH  [UIScreen mainScreen].bounds.size.height // 屏幕的高度

#endif
