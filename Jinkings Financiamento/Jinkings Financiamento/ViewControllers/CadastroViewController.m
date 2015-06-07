//
//  CadastroViewController.m
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 03/05/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "CadastroViewController.h"

@interface CadastroViewController ()

@end

@implementation CadastroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _edtNome.delegate = self;
    _edtNome.dismissKeyboardWhenClearingTextField = @YES;
    _edtNome.backgroundColor = [UIColor clearColor];
    
    _edtEmail.delegate = self;
    _edtEmail.dismissKeyboardWhenClearingTextField = @YES;
    _edtEmail.backgroundColor = [UIColor clearColor];
    
    _edtTelefone.delegate = self;
    _edtTelefone.dismissKeyboardWhenClearingTextField = @YES;
    _edtTelefone.backgroundColor = [UIColor clearColor];
    
    _edtCelular.delegate = self;
    _edtCelular.dismissKeyboardWhenClearingTextField = @YES;
    _edtCelular.backgroundColor = [UIColor clearColor];
    
    _edtSenha.secureTextEntry = YES;
    _edtSenha.delegate = self;
    _edtSenha.dismissKeyboardWhenClearingTextField = @YES;
    _edtSenha.backgroundColor = [UIColor clearColor];
    
    _edtConfirmarSenha.secureTextEntry = YES;
    _edtConfirmarSenha.delegate = self;
    _edtConfirmarSenha.dismissKeyboardWhenClearingTextField = @YES;
    _edtConfirmarSenha.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnConfirmarClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnCancelarClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
