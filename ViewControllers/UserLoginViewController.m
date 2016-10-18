//
//  UserLoginViewController.m
//  EVNTouchIDDemo
//
//  Created by developer on 2016/10/17.
//  Copyright © 2016年 仁伯安. All rights reserved.
//

#import "UserLoginViewController.h"
#import "EVNHelper.h"

@interface UserLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation UserLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    UIBarButtonItem *lefttem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
    self.navigationItem.leftBarButtonItem = lefttem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backBtnAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)loginBtnAction:(UIButton *)sender
{

    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"loginState"];

    EVNHelper *helper = [EVNHelper shareHelper];
    helper.isAppCurrentLoginState = YES;

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登录成功！" message:@"是否启用指纹登录" preferredStyle:UIAlertControllerStyleAlert];

    __weak typeof (self) weakSelf = self;

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"稍后" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:NO] forKey:@"startAutoLoginState"];
        weakSelf.transLoginStateBlock(); // 回传
        [self dismissViewControllerAnimated:YES completion:nil];
    }];

    UIAlertAction *startUseAction = [UIAlertAction actionWithTitle:@"启用" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {

        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"startAutoLoginState"];
        weakSelf.transLoginStateBlock(); // 回传
        [self dismissViewControllerAnimated:YES completion:nil];

    }];
    [alertController addAction:cancelAction];
    [alertController addAction:startUseAction];

    [self presentViewController:alertController animated:YES completion:nil];

}


@end
