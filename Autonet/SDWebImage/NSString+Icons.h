//
//  NSString+Icons.h
//  FlatUIKitExample
//
//  Created by Jamie Matthews on 12/24/14.
//
//
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, FlatUIIcon) {
    FUITriangleUp,
    FUITraingleDown,
    FUITriangleUpSmall,
    FUITriangleDownSmall,
    FUITriangleLeftLarge,
    FUITriangleRightLarge,
    FUIArrowLeft,
    FUIArrowRight,
    FUIPlus,
    FUICross,
    FUICheck,
    FUIRadioUnchecked,
    FUIRadioChecked,
    FUICheckboxUnchecked,
    FUICheckboxChecked,
    FUIInfoCircle,
    FUIAlertCircle,
    FUIQuestionCirlce,
    FUICheckCircle,
    FUICrossCircle,
    FUIPlusCircle,
    FUIPause,
    FUIPlay,
    FUIVolume,
    FUIMute,
    FUIResize,
    FUIList,
    FUIListThumbnailed,
    FUIListSmallThumbails,
    FUIListLargeThumnails,
    FUIListNumbered,
    FUIListColumned,
    FUIListBulleted,
    FUIWindow,
    FUIWindows,
    FUILoop,
    FUICMD,
    FUIMic,
    FUIHeart,
    FUILocation,
    FUINew,
    FUIVideo,
    FUIPhoto,
    FUITime,
    FUIEye,
    FUIChat,
    FUIHome,
    FUIUpload,
    FUISearch,
    FUIUser,
    FUIMail,
    FUILock,
    FUIPower,
    FUICalendar,
    FUIGear,
    FUIBookmark,
    FUIExit,
    FUITrash,
    FUIFolder,
    FUIBubble,
    FUIExport,
    FUICalendarSolid,
    FUIStar,
    FUIStar2,
    FUICreditCard,
    FUIClip,
    FUILink,
    FUITag,
    FUIDocument,
    FUIImage,
    FUIFacebook,
    FUIYoutube,
    FUIVimeo,
    FUITwitter,
    FUISpotify,
    FUISkype,
    FUIPintrest,
    FUIPath,
    FUILinkedin,
    FUIGooglePlus,
    FUIDribble,
    FUIBehance,
    FUIStumbleUpon,
    FUIYelp,
    FUIWordpress,
    FUIWindows8,
    FUIVine,
    FUITumblr,
    FUIPaypal,
    FUILastFM,
    FUIInstagram,
    FUIHtml5,
    FUIGithub,
    FUIFourSquare,
    FUIDropBox,
    FUIAndroid,
    FUIApple,
};
static NSString *const kFlatUIFontFamilyName = @"flat-ui-pro-icons";
@interface NSString (Icons)
+ (NSString*)iconStringForEnum:(FlatUIIcon)value;
+ (NSArray *)iconUnicodeStrings;
@end