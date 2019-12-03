//
//  UDTextField.m
//  TestPwd
//
//  Created by uDoctor on 2019/12/2.
//  Copyright © 2019 UD. All rights reserved.
//

#import "UDTextField.h"

@interface UDTextField()
@property (nonatomic, assign) NSInteger pointCount;
@property (nonatomic, strong) NSMutableArray *shapeLayers;
@property (nonatomic, strong) CAShapeLayer *contextLayer;
@end


@implementation UDTextField

- (void)dealloc {
    [self.shapeLayers removeAllObjects];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setTextFieldType:(UDTextFieldType)textFieldType {
    _textFieldType = textFieldType;
    if (textFieldType == UDTextFieldType_PWD) {
        [self setupData];
        [self setupViews];
    }
    self.keyboardType = UIKeyboardTypeNumberPad;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChangesd:) name:UITextFieldTextDidChangeNotification object:nil];
}


#pragma mark - private
- (void)setupData {
    self.tintColor = [UIColor clearColor];
    self.textColor = [UIColor clearColor];
    self.shapeLayers = [NSMutableArray new];
    self.pointCount = 0;
    self.passwordCount = 6;
}

- (void)setupViews {
    CGFloat space = self.bounds.size.width/self.passwordCount;
    CGFloat hhh = self.bounds.size.height;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:5];
    for (int i = 0; i < (self.passwordCount-1); i ++) {
        CGFloat x = space*(i +1);
        [path moveToPoint:CGPointMake(x, 0)];
        [path addLineToPoint:CGPointMake(x, hhh)];
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    //线宽和颜色
    shapeLayer.lineWidth = 1;
    shapeLayer.strokeColor = [UIColor colorWithRed:211/255.f green:211/255.f blue:212/255.f alpha:1].CGColor;
    
    shapeLayer.fillColor = [UIColor colorWithRed:247/255.f green:248/255.f blue:249/255.f alpha:1].CGColor;
    shapeLayer.path = path.CGPath;
    self.contextLayer = shapeLayer;
    [self.layer addSublayer:self.contextLayer];
}


- (void)textChangesd:(NSNotification *)noti {
    switch (self.textFieldType) {
        case UDTextFieldType_PWD:
            [self dealWithPWD];
            break;
        case UDTextFieldType_Separate:
            [self dealWithSeparete];
            break;
        default:
            break;
    }
}


- (void)dealWithPWD {
    if (self.text.length <= self.passwordCount) {
        CGFloat space = self.bounds.size.width/self.passwordCount;
        [self setRoundPoint:CGPointMake( space*self.text.length- space/2.f, self.bounds.size.height/2.f) pointCount:self.text.length];
    }
    
    if (self.text.length >= self.passwordCount) {
        self.text = [self.text substringToIndex:(self.passwordCount)];
        __weak UDTextField *weakSelf = self;
        if (self.textFieldCompleted) {
            self.textFieldCompleted(weakSelf);
        }
    }
}

- (void)dealWithSeparete {
    if (self.separatedArray.count == 0) {
        return;
    }
    NSString *originString = self.text;
    CGFloat SeparatedDistance = 8;
    NSArray * separatedArr = self.separatedArray;
    NSMutableAttributedString * string =[[NSMutableAttributedString alloc]initWithString:originString];
    NSInteger arrayIndex = 0;
    for (int i = 1; i < originString.length; i ++) {
        NSRange range = NSMakeRange(arrayIndex, separatedArr.count-arrayIndex);
        NSInteger separatedValue = [[[separatedArr subarrayWithRange:range] firstObject] integerValue];
        if (separatedValue != 0) {
            if (i % separatedValue == 0) {
                [string addAttribute:NSKernAttributeName value:[NSNumber numberWithFloat:SeparatedDistance] range:NSMakeRange(i-1, 1)];
                arrayIndex ++ ;
                if (arrayIndex > separatedArr.count-1) {
                    arrayIndex = separatedArr.count - 1;
                }
            }
        }
    }
    self.attributedText = string;
}

- (void)setRoundPoint:(CGPoint)center pointCount:(NSInteger)count {
    
    if (self.pointCount == count) {
        return;
    }
    if (self.pointCount > count) {
        CAShapeLayer *sp = self.shapeLayers.lastObject;
        [self.shapeLayers removeLastObject];
        [sp removeFromSuperlayer];
        self.pointCount = count;
        return;
    }
    self.pointCount = count;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:center radius:5 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    //线宽和颜色
    shapeLayer.lineWidth = 1;
    UIColor *color = [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1];
    shapeLayer.strokeColor = color.CGColor;
    
    shapeLayer.fillColor = color.CGColor;
    shapeLayer.path = path.CGPath;
    
    [self.layer addSublayer:shapeLayer];
    [self.shapeLayers addObject:shapeLayer];
}

#pragma mark - setter&getter
- (void)setPasswordCount:(NSInteger)passwordCount {
    _passwordCount = passwordCount;
    [self.contextLayer removeFromSuperlayer];
    [self setupViews];
}

@end

