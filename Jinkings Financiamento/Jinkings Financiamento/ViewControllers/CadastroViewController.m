//
//  CadastroViewController.m
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 03/05/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "CadastroViewController.h"
#import <Parse/Parse.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <TSMessages/TSMessage.h>

@interface CadastroViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation CadastroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.bounds.size.width, 600)];
    
    _edtNome.delegate = self;
    _edtNome.backgroundColor = [UIColor clearColor];
    _edtNome.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtNome.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtCPF.delegate = self;
    _edtCPF.backgroundColor = [UIColor clearColor];
    _edtCPF.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtCPF.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtEmail.delegate = self;
    _edtEmail.backgroundColor = [UIColor clearColor];
    _edtEmail.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtEmail.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtTelefone.delegate = self;
    _edtTelefone.backgroundColor = [UIColor clearColor];
    _edtTelefone.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtTelefone.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtCelular.delegate = self;
    _edtCelular.backgroundColor = [UIColor clearColor];
    _edtCelular.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtCelular.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtCategoriaProfissional.delegate = self;
    _edtCategoriaProfissional.backgroundColor = [UIColor clearColor];
    _edtCategoriaProfissional.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtCategoriaProfissional.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtSenha.secureTextEntry = YES;
    _edtSenha.delegate = self;
    _edtSenha.backgroundColor = [UIColor clearColor];
    _edtSenha.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtSenha.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtConfirmarSenha.secureTextEntry = YES;
    _edtConfirmarSenha.delegate = self;
    _edtConfirmarSenha.backgroundColor = [UIColor clearColor];
    _edtConfirmarSenha.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtConfirmarSenha.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
}

-(void)viewDidAppear:(BOOL)animated{
    [self setupFloatLabel];
}

-(void) setupFloatLabel{
    _edtNome.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Nome Completo" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtCPF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"CPF" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtTelefone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Telefone Residencial" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtCelular.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Celular" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtCategoriaProfissional.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Categoria Profissional" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtSenha.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Senha" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtConfirmarSenha.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Confirmar Senha" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) exibeMensagem:(NSString*) mensagem{
    [TSMessage showNotificationWithTitle:@"Atenção"
                                subtitle:mensagem
                                    type:TSMessageNotificationTypeError];
}

-(BOOL) validarCampos{
    
    if (!_edtNome.text.length > 0) {
        [self exibeMensagem:@"Informe o seu nome completo"];
        return NO;
    }
    
    if (!_edtCPF.text.length > 0) {
        [self exibeMensagem:@"Informe o seu CPF"];
        return NO;
    }
    
    if (!_edtEmail.text.length > 0) {
        [self exibeMensagem:@"Informe o seu e-mail"];
        return NO;
    }
    
    if (!_edtTelefone.text.length > 0) {
        [self exibeMensagem:@"Informe o seu telefone residencial"];
        return NO;
    }
    
    if (!_edtCelular.text.length > 0) {
        [self exibeMensagem:@"Informe o seu celular"];
        return NO;
    }
    
    if (!_edtCategoriaProfissional.text.length > 0) {
        [self exibeMensagem:@"Informe sua categoria profissional"];
        return NO;
    }
    
    if (!_edtSenha.text.length > 0) {
        [self exibeMensagem:@"Digite a sua senha"];
        return NO;
    }
    
    if (!_edtConfirmarSenha.text.length > 0) {
        [self exibeMensagem:@"Confirme a sua senha"];
        return NO;
    }
    
    if (![_edtConfirmarSenha.text isEqualToString:_edtSenha.text]) {
        [self exibeMensagem:@"Senhas não conferem!"];
        return NO;
    }
    
    return YES;
}

- (IBAction)btnConfirmarClick:(id)sender {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Efetuando cadastro";
    
    [hud show:YES];
    
    if ([self validarCampos]) {
        
        PFUser *user = [PFUser user];
        
        user.username = _edtEmail.text;
        user.password = _edtSenha.text;
        user.email = _edtEmail.text;
        
        user[@"nome"] = _edtNome.text;
        user[@"telefone"] = _edtTelefone.text;
        user[@"celular"]  = _edtCelular.text;
        user[@"cpf"] = _edtCPF.text;
        user[@"categoriaProfissional"] = _edtCategoriaProfissional.text;
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {   // Hooray! Let them use the app now.
                [[[UIAlertView alloc] initWithTitle:@"Cadastro" message:@"Cadastro efetuado com sucesso!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil] show];
            } else {
                [self exibeMensagem:@"Erro ao efetuar cadastro"];
            }
            [hud hide:YES];
        }];
        
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnCategoriaProfissionalClick:(id)sender {
    
}


@end
