//
//  UITextview+view.m
//  JpushTest
//
//  Created by 常永梅 on 2020/11/26.
//

#import "UITextview+view.h"

@implementation UITextview_view

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initView:frame];
    }
    return self;
}

#pragma mark - init
-(void)initView:(CGRect)frame{
    self.backgroundColor = [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:1];
    /**标题**/
    _labRemark = [[UILabel alloc] init];
    _labRemark.font = [UIFont systemFontOfSize:15];
    _labRemark.textColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1];
    [self addSubview:_labRemark];
    
    _labTag = [[UILabel alloc] init];
    _labTag.textColor = [UIColor colorWithRed:221.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1];
    _labTag.text = @"*";
    [self addSubview:_labTag];
    
    /**可输入内容**/
    self.tvRemark = [[UITextView alloc] init];
    self.tvRemark.font = [UIFont systemFontOfSize:13];
    self.tvRemark.delegate = self;
    self.tvRemark.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.tvRemark];
    self.tvRemark.layer.masksToBounds = YES;
    self.tvRemark.layer.cornerRadius = 4;
    self.tvRemark.layer.borderColor = [UIColor colorWithRed:181.0f/255.0f green:181.0f/255.0f blue:181.0f/255.0f alpha:1].CGColor;
    self.tvRemark.layer.borderWidth = 1;
    
    // _placeholderLabel
    self.placeHolderLabel = [[UILabel alloc] init];
    self.placeHolderLabel.numberOfLines = 0;
    self.placeHolderLabel.textColor = [UIColor lightGrayColor];
    [self.placeHolderLabel sizeToFit];
    self.placeHolderLabel.font = [UIFont systemFontOfSize:13.0f];
    [self.tvRemark addSubview:self.placeHolderLabel];
    [self.tvRemark setValue:self.placeHolderLabel forKey:@"_placeholderLabel"];
    
    /**文字数量变化**/
    self.labNumber = [[UILabel alloc] init];
    self.labNumber.textColor = [UIColor colorWithRed:172.0f/255.0f green:172.0f/255.0f blue:172.0f/255.0f alpha:1];
    self.labNumber.font = [UIFont systemFontOfSize:13];
    self.labNumber.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.labNumber];
}

#pragma mark - update
-(void)updateFrameDate{
    _labRemark.frame = CGRectMake(15, 8, 70, 20);
    [self addSubview:_labRemark];
    
    _labTag.frame = CGRectMake(_labRemark.frame.size.width+_labRemark.frame.origin.x+5, 8, 10, 20);
    [self addSubview:_labTag];
    
    self.tvRemark.frame = CGRectMake(15, self.labRemark.frame.size.height+self.labRemark.frame.origin.y+8, self.frame.size.width-30, self.frame.size.height-70);
    [self addSubview:self.tvRemark];
    
    self.labNumber.frame = CGRectMake(15, self.tvRemark.frame.origin.y+self.tvRemark.frame.size.height+8, self.frame.size.width-30, 20);
    [self addSubview:self.labNumber];
    
}

#pragma mark - set
-(void)setStrPlaceHolder:(NSString *)strPlaceHolder{
    self.placeHolderLabel.text = [NSString stringWithFormat:@"%@",strPlaceHolder];
    [self updateFrameDate];
}
-(void)setStrTitle:(NSString *)strTitle{
    self.labRemark.text = [NSString stringWithFormat:@"%@",strTitle];
    [self updateFrameDate];
}

-(void)setIntTextNumber:(NSInteger)intTextNumber{
    self.labNumber.text = [NSString stringWithFormat:@"0/%ld",(long)intTextNumber];
    [self updateFrameDate];
}


#pragma mark - delegate
-(void)textViewDidChange:(UITextView *)textView{
    NSString *lang = textView.textInputMode.primaryLanguage;//键盘输入模式

        if ([lang isEqualToString:@"zh-Hans"]){

            UITextRange *selectedRange = [textView markedTextRange];

            if (!selectedRange) {//已经标记的文本

                if (textView.text.length>200) {
                    self.tvRemark.text = [textView.text substringToIndex:200];
                }
            }
        }else{

            if (textView.text.length>200) {
                self.tvRemark.text = [textView.text substringToIndex:200];
            }
        }
            
    self.labNumber.text = [NSString stringWithFormat:@"%lu/200",(unsigned long)self.tvRemark.text.length];
            
    if (_delegate && [_delegate respondsToSelector:@selector(CtextViewTextChange:)]) {
         [self.delegate CtextViewTextChange:self.tvRemark.text];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self.tvRemark resignFirstResponder];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
 
    return YES;
}

@end
