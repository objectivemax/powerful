//
//  CommonTypes.h
//  FireBaseTEST
//
//  Created by Maxim Ohrimenko on 8/15/19.
//  Copyright © 2019 Maxim Ohrimenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^MOValueBlock)(id value);
typedef void (^MOVoidBlock)(void);
typedef void (^MOBoolBlock)(BOOL result);
typedef void (^MOSelectionBlock)(NSInteger selection);
typedef void (^MOCompletionBlock)(id response, NSError *error);

typedef void (^MOCompletionBlockTest)(NSData *data, NSURLResponse *response, NSError *error);


typedef void (^SelectItemBlock)(NSInteger);
typedef void (^SelectStringItemBlock)(NSString *);
typedef void (^ActionBlock)(void);
typedef void (^ActionDateBlock)(void);
typedef void (^ShowPhotoBlock)(UIImageView * imageView);
typedef void (^ShowMediaBlock)(UIView * view);
typedef void (^ShowUserProfileBlock)(NSInteger row);
typedef void (^LoadUserProfileBlock)(NSInteger row);

typedef NS_ENUM(NSInteger, TagCellType) {
    TagCellTypeSkill,
    TagCellTypeInterest,
    TagCellTypeTag,
    TagCellTypeFile,
    TagCellTypeLocation,
};

typedef NS_ENUM(NSInteger, StatusCellType) {
    StatusCellTypeActivate,
    StatusCellTypeProductAvailable,
    StatusCellTypeServiceAvailable,
};

typedef NS_ENUM(NSInteger, EditUserState) {
    EditUserStateDefault,
};

typedef NS_ENUM(NSInteger, MediaType) {
    MediaTypeImage = 1,
    MediaTypeFile,
    MediaTypeLink,
};

typedef NS_ENUM(NSInteger, CategoryCellType) {
    CTypeCellCategory,
};

typedef NS_ENUM(NSInteger, MLocationType) {
    MLocationTypeSingle,
};

typedef NS_ENUM(NSInteger, SuccessInfoViewType) {
    SuccessInfoViewTypeConfirmation,
    SuccessInfoViewTypeRegistration,
    SuccessInfoViewTypeContactUs,
    SuccessInfoViewTypeReportInappropriate,
    SuccessInfoViewTypeRequest
};

typedef void (^SetTextToModelBlock)(NSString *);
typedef void (^SetTextToWithConditionBlock)(NSString * text, BOOL condition);
typedef void (^GetIndexPathBlock)(NSIndexPath *);

typedef NS_ENUM(NSInteger, EUCellType) {
    EUCellTypeDefault,
    EUCellTypeJob,
    EUCellTypeJobDate,
    EUCellTypeDate,
    EUCellTypePhone
};

typedef NS_ENUM(NSInteger, CommentItemType) {
    CommentItemTypeItem,
    CommentItemTypeCommunity,
    CommentItemTypeUsers
};

typedef NS_ENUM(NSUInteger, MOAction) {
    MActionUnknown,
    MActionDefault,
    MActionSelectAllPressed,
    
    MActionUserShowAvatar,
    MActionUserShowSettings,
    MActionUserShowInfo,
    MActionUserShowGroups,
    MActionUserShowMedia,
    MActionUserShowSubscriptionsList,
    MActionUserShowMessenger,
    
    MActionShowProfileWithMessagesUserID,
    MActionShowMessageAttachment,
    MActionRemoveAttachment,
    
    MActionUpdateCell,
    
    MActionLike,
    MActionShowProfile,
    MActionShowMediaView,
    MActionShowComments,
    MActionShowMenu,
};

@protocol MOActionDelegate <NSObject>

@optional
- (void)control:(id)control didSendAction:(MOAction)action withMessage:(id)message;

@end

@protocol MActionProtocol <NSObject>

@required
@property (nonatomic, weak) id<MOActionDelegate> actionDelegate;

- (void)sendAction:(MOAction)action;
- (void)sendAction:(MOAction)action withMessage:(id)message;

@end

@class EUAddTagView, MJobModel, MItemModel, HomePageTableViewController, ODRefreshControl, MPostEnvelop, MBaseEditVC;


@protocol MEditUserDelegate <NSObject>

- (void)showDatePicker:(NSDate *)date;
- (void)showAlertWithMessage:(NSString *)message;
- (void)showCameraWithConfigurator:(MOValueBlock)configurator;
- (void)showCoverCamera;
- (void)hidePickers;

@end

@protocol MRemoveMediaProtocol <NSObject>

- (void)removeMediaWithIndexPath:(NSIndexPath *)indexPath;
- (void)makeCoverWithIndexPath:(NSIndexPath *)indexPath;

@end

@protocol GetCellHeightProtocol <NSObject>

@optional

- (double)getCellHeightByString:(NSString *)data;

@end

@protocol MOEditItemProtocol <NSObject>

- (void)itemDidChanged:(MItemModel *)item;
- (void)itemDidCreated:(MItemModel *)item;
- (void)itemDidDeleted:(MItemModel *)item;
- (void)updateData;
- (void)reloadTable;

@end

@class SearchFilterModel;
@protocol MOQuestionPageDelegate <NSObject, UITableViewDelegate, UITableViewDataSource>

@required
- (instancetype)initWithVC:(MBaseEditVC *)questionVC;
- (void)getDataForPage:(NSInteger)page;
- (void)setRefreshControls;

@optional
- (void)refreshData:(ODRefreshControl *)refreshControl_;
- (void)itemDidChanged:(id)item;
- (void)itemDidCreated:(id)item;
- (void)itemDidDeleted:(id)item;


@end

