//
//  GlobalCommon.h
//  PathPlanningPanel
//
//  Created by User on 15/1/12.
//  Copyright (c) 2015年 weng zilin. All rights reserved.
//

#ifndef PathPlanningPanel_GlobalCommon_h
#define PathPlanningPanel_GlobalCommon_h

#define kSystemStatusBarHeight      20
#define kSystemToolbarHeight        44

/* 设备的尺寸，与UI无关，与ios版本无关 */
#define KDeviceAbsoluteHeight       [UIScreen mainScreen] currentMode].size.height
#define kDeviceAbsoluteWidth        [[UIScreen mainScreen] currentMode].size.width

/* 当前设备的屏幕尺寸，含状态栏，例如320x480，也即分辨率,ios8以下不随设备方向而变化，ios8及以上是实时尺寸 */
#define kDeviceWindowSize           [[UIScreen mainScreen] bounds].size
#define kDeviceWindowWidth          [[UIScreen mainScreen] bounds].size.width
#define kDeviceWindowHeight         [[UIScreen mainScreen] bounds].size.height

/* 当前设备的app尺寸，在任何版本都是不含状态栏，例如320x460，  一般用以下几个宏 */
#define kDeviceAppNoStatusSize      [[UIScreen mainScreen] applicationFrame].size
#define kDeviceAppNoStatusWidth     [[UIScreen mainScreen] applicationFrame].size.width
#define kDeviceAppNoStatusHeight    [[UIScreen mainScreen] applicationFrame].size.height


#define Interface_Flag              (int)[UIDevice getDeviceOrientation]  //横竖屏方向
/* 判断设备是否横屏 */
#define kIsDeviceLandscape          (Interface_Flag == 1)
/* 判断设备是否竖屏 */
#define kIsDevicePortrait           (Interface_Flag == 0)

/* iOS设备类型 */
typedef enum {
    DeviceTypePhone = 1 << 0,
    DeviceTypePad = 1 << 1
} DeviceType;

/* 判断iOS设备类型 */
#define CurrentDeviceType() \
(isiPhone ? \
DeviceTypePhone : DeviceTypePad)

/* 4英寸屏幕 */
#define Device4Inch iPhone5

/* 3.5英寸屏幕 */
#define Device35Inch iPhone4
/* 高清屏幕 */
#define DeviceRetinaDisplay ISRETINA
/* 系统软件版本 */
#define DeviceOSVersion IOS_VERSION

/* 适配IOS7 */
#define IsIOS7orAbove IOS_7
#define IsIOS8orAbove  (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)
#define CGRECT_NO_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?20:0)), (w), (h))
#define CGRECT_HAVE_NAV(x,y,w,h) CGRectMake((x), (y+(IsIOS7?64:0)), (w), (h))

#define kRGBA(r, g, b, a) (RGBACOLOR(r,g,b,a))

#define kColorPatterImage(imageName) (IMAGECOLOR(imageName,IMAGEPATH_TYPE_1))
#define kImageNamed(x) (IMAGE(x,IMAGEPATH_TYPE_1))

#define kImageContentFileNamed(x)  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(x) ofType:@"png"]]
#define WLocalizedString(myString) NSLocalizedString(myString, nil)

#endif
