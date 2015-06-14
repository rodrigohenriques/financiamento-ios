//
//  LoginViewController.m
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 03/05/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <CRToast/CRToast.h>
#import <MBProgressHUD/MBProgressHUD.h>

#define placeHolderColor [UIColor whiteColor]

@interface LoginViewController ()

@property (nonatomic, strong) NSDictionary *options;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _edtEmail.delegate = self;
    _edtEmail.backgroundColor = [UIColor clearColor];
    _edtEmail.floatingLabelActiveTextColor = [UIColor whiteColor];
    
    _edtSenha.secureTextEntry = YES;
    _edtSenha.delegate = self;
    _edtSenha.backgroundColor = [UIColor clearColor];
    _edtSenha.floatingLabelActiveTextColor = [UIColor whiteColor];
    
    _options = @{
                 kCRToastNotificationTypeKey : @(CRToastTypeNavigationBar),
                 kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                 kCRToastBackgroundColorKey : [UIColor redColor],
                 kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                 kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                 kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionLeft),
                 kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionRight),
                 };
    
    PFUser *user = [PFUser currentUser];
    
    if (user) {
        [self performSegueWithIdentifier:@"sgPrincipal" sender:nil];
    }
    
    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCadastroClick:(id)sender {
    [self performSegueWithIdentifier:@"sgCadastro" sender:nil];
}

-(BOOL) validarCampos{
    if (!_edtEmail.text.length > 0) {
        [CRToastManager showNotificationWithMessage:@"Informe o e-mail" completionBlock:nil];
        return NO;
    }
    
    if (!_edtSenha.text.length > 0) {
        [CRToastManager showNotificationWithMessage:@"Informe a senha" completionBlock:nil];
        return NO;
    }
    
    return YES;
}

- (IBAction)btnEntrarClick:(id)sender {
    
    [CRToastManager setDefaultOptions:_options];
    
    if ([self validarCampos]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.labelText = @"Entrando";

        [hud show:YES];
        
        [PFUser logInWithUsernameInBackground:_edtEmail.text password:_edtSenha.text
                                        block:^(PFUser *user, NSError *error) {
                                            [hud hide:YES];
                                            if (user) {
                                                [self performSegueWithIdentifier:@"sgPrincipal" sender:nil];
                                            } else {
                                                [CRToastManager showNotificationWithMessage:@"Usuário ou senha inválido(a)" completionBlock:nil];
                                            }
                                        }];
    }
}

#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(![touch.view isMemberOfClass:[UITextField class]]) {
        [touch.view endEditing:YES];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
