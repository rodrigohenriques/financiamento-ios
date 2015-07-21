//
//  LoginViewController.m
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 03/05/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <TSMessages/TSMessage.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "TipoImovel.h"
#import "CondicaoImovel.h"
#import "StatusSimulacao.h"

#define placeHolderColor [UIColor whiteColor]

@interface LoginViewController ()

@property (nonatomic, strong) UIWindow *window;
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
    
    [self setNeedsStatusBarAppearanceUpdate];
    
}

-(void)viewDidAppear:(BOOL)animated{
    PFUser *user = [PFUser currentUser];
    
    if (user) {
        [self performSegueWithIdentifier:@"sgPrincipal" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCadastroClick:(id)sender {
    [self performSegueWithIdentifier:@"sgCadastro" sender:nil];
}

-(void) exibeMensagem:(NSString*) mensagem{
    [TSMessage showNotificationWithTitle:@"Atenção"
                                subtitle:mensagem
                                    type:TSMessageNotificationTypeError];
}

-(BOOL) validarCampos{
    if (!_edtEmail.text.length > 0) {
        [self exibeMensagem:@"Informe o e-mail"];
        return NO;
    }
    
    if (!_edtSenha.text.length > 0) {
        [self exibeMensagem:@"Informe a senha"];
        return NO;
    }
    
    return YES;
}

-(BOOL) getStatusObjects{
    BOOL retorno = NO;
    PFQuery *query = [PFQuery queryWithClassName:@"StatusSimulacao"];
    NSArray *arrayStatus = [query findObjects];
    for (StatusSimulacao *status in arrayStatus) {
        retorno = [status pin];
    }
    
    return retorno;
}

-(BOOL) getTipoImovelObjects{
    BOOL retorno = NO;
    PFQuery *query = [PFQuery queryWithClassName:@"TipoImovel"];
    NSArray *arrayTipos = [query findObjects];
    for (TipoImovel *tipo in arrayTipos) {
        retorno = [tipo pin];
    }
    
    return retorno;
}

-(BOOL) getCondicaoImovelObjects{
    BOOL retorno = NO;
    PFQuery *query = [PFQuery queryWithClassName:@"CondicaoImovel"];
    NSArray *arrayCondicao = [query findObjects];
    for (CondicaoImovel *condicao in arrayCondicao) {
        retorno = [condicao pin];
    }
    
    return retorno;
}

- (IBAction)btnEntrarClick:(id)sender {
    
    if ([self validarCampos]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Entrando";
        
        [hud show:YES];
        
        [PFUser logInWithUsernameInBackground:_edtEmail.text password:_edtSenha.text
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                if ([self getCondicaoImovelObjects] && [self getTipoImovelObjects] && [self getStatusObjects]) {
                                                    [self performSegueWithIdentifier:@"sgPrincipal" sender:nil];
                                                } else {
                                                    [self exibeMensagem:@"Falha ao carregar dados de login"];
                                                }
                                            } else {
                                                [self exibeMensagem:@"Usuário ou senha inválido(a)"];
                                            }
                                            [hud hide:YES];
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
