//
//  UDTextField.h
//  TestPwd
//
//  Created by uDoctor on 2019/12/2.
//  Copyright © 2019 UD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UDTextFieldType_PWD,
    UDTextFieldType_Separate,
} UDTextFieldType;

@class UDTextField;
NS_ASSUME_NONNULL_BEGIN

typedef void(^TextFieldCompleted)(UDTextField * textField);

@interface UDTextField : UITextField

/**
 * 必须声明它的类型
 * textFieldType: 两种类型，UDTextFieldType_PWD 用于密码；
 * UDTextFieldType_Separate 用于手机号，身份证输入
 */
@property (nonatomic, assign) UDTextFieldType textFieldType;


/**
 * 当密码输入到第六位（passwordCount）的时候，会回调 textFieldCompleted
 */
@property (nonatomic, copy) TextFieldCompleted textFieldCompleted;


/**
 * 默认6位密码，当输入第六位的时候，会回调 textFieldCompleted
 */
@property (nonatomic, assign) NSInteger passwordCount;

/**
 * 给UITextField添加了一个设置分割数的属性
 * 使用时注意：等比分割和不等比分割 以下以 123456789 为例
 * separatedArray = @[@(3),@(7)],在第3，和第7位分割，123 4567 89
 */
@property (nonatomic, copy) NSArray *separatedArray;

@end


NS_ASSUME_NONNULL_END
