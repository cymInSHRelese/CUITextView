//
//  UITextview+view.h
//  JpushTest
//
//  Created by 常永梅 on 2020/11/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CtextViewDelegate <NSObject>

-(void)CtextViewTextChange:(NSString *)changeText;
@end


@interface UITextview_view : UIView<UITextViewDelegate>
/*文本*/
@property (nonatomic, assign)NSString *strTitle; // 标题

@property (nonatomic, assign)NSInteger intTextNumber; // 字符总数量

@property (nonatomic, assign)NSString *strPlaceHolder; // 输入框默认文字

/** 控件 **/
@property (nonatomic, strong)UILabel *labRemark; //标题控件

@property (nonatomic, strong)UILabel *placeHolderLabel; // 输入框默认文字控件

@property (nonatomic, strong)UITextView *tvRemark; // 可输入框

@property (nonatomic, strong)UILabel *labNumber; // 文本数量变化

@property (nonatomic, strong)UILabel *labNormal; // 默认提示文本

@property (nonatomic, strong)UILabel *labTag;

/*delegate*/
@property (nonatomic,assign)id <CtextViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
