//
//  SecondViewController.m
//  TestPwd
//
//  Created by uDoctor on 2019/12/2.
//  Copyright © 2019 UD. All rights reserved.
//

#import "SecondViewController.h"
#import "UDTextField.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    UDTextField *tf = [[UDTextField alloc] initWithFrame:CGRectMake(30, 100, self.view.bounds.size.width - 60, 40)];
    tf.textFieldType = UDTextFieldType_PWD;
    tf.textFieldCompleted = ^(UDTextField * _Nonnull textField) {
        NSLog(@"text= [%@]",textField.text);
    };
    [self.view addSubview:tf];
    
    
    //
    UDTextField *tf1 = [[UDTextField alloc] initWithFrame:CGRectMake(30, 200, self.view.bounds.size.width - 60, 40)];
    tf1.placeholder = @"输入手机号";
    tf1.borderStyle = UITextBorderStyleRoundedRect;
    tf1.textFieldType = UDTextFieldType_Separate;
    tf1.separatedArray = @[@(3),@(7)];
    [self.view addSubview:tf1];


}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
