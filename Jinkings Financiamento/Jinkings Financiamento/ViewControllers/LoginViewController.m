//
//  LoginViewController.m
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 03/05/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "LoginViewController.h"

#define placeHolderColor [UIColor whiteColor]

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIFloatLabelTextField appearance] setBackgroundColor:[UIColor whiteColor]];
    
    _edtEmail.delegate = self;
    _edtEmail.dismissKeyboardWhenClearingTextField = @YES;
    _edtEmail.backgroundColor = [UIColor clearColor];
    
    _edtSenha.secureTextEntry = YES;
    _edtSenha.delegate = self;
    _edtSenha.dismissKeyboardWhenClearingTextField = @YES;
    _edtSenha.backgroundColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnLoginClick:(id)sender {
    [self performSegueWithIdentifier:@"sgPrincipal" sender:nil];
}

- (IBAction)btnCadastroClick:(id)sender {
    [self performSegueWithIdentifier:@"sgCadastro" sender:nil];
}

#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if(![touch.view isMemberOfClass:[UITextField class]]) {
        [touch.view endEditing:YES];
    }
}

@end
