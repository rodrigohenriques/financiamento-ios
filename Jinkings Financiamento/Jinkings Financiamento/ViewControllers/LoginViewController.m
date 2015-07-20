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

-(void) getStatusObjects{
    PFQuery *query = [PFQuery queryWithClassName:@"StatusSimulacao"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (StatusSimulacao *statusSimulacao in objects) {
                [statusSimulacao pinInBackground];
            }
        }
    }];
}

-(void) getTipoImovelObjects{
    PFQuery *query = [PFQuery queryWithClassName:@"TipoImovel"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (TipoImovel *tipoImovel in objects) {
                [tipoImovel pinInBackground];
            }
        }
    }];
}

-(void) getCondicaoImovelObjects{
    PFQuery *query = [PFQuery queryWithClassName:@"CondicaoImovel"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (CondicaoImovel *condicaoImovel in objects) {
                [condicaoImovel pinInBackground];
            }
        }
    }];
}

- (IBAction)btnEntrarClick:(id)sender {
    
    if ([self validarCampos]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"Entrando";
        
        [hud show:YES];
        
        [PFUser logInWithUsernameInBackground:_edtEmail.text password:_edtSenha.text
                                        block:^(PFUser *user, NSError *error) {
                                            [hud hide:YES];
                                            if (user) {
                                                [self getTipoImovelObjects];
                                                [self getCondicaoImovelObjects];
                                                [self getStatusObjects];
                                                
                                                [self performSegueWithIdentifier:@"sgPrincipal" sender:nil];
                                            } else {
                                                [self exibeMensagem:@"Usuário ou senha inválido(a)"];
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
