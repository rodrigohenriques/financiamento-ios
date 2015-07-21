//
//  BaseViewController.m
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 13/06/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "BaseViewController.h"
#import <Parse/Parse.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "TipoImovel.h"
#import "CondicaoImovel.h"
#import "StatusSimulacao.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *btnTeste = [[UIBarButtonItem alloc] initWithTitle:@"Sair" style:UIBarButtonItemStyleDone target:self action:@selector(logoff)];
    
    self.tabBarController.navigationItem.leftBarButtonItem = btnTeste;
    
    [self setNeedsStatusBarAppearanceUpdate];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

-(void) logoff{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Saindo";
    
    [hud show:YES];
    
    [PFUser logOutInBackgroundWithBlock:^(NSError *error) {
        [self deleteLocalDataStore];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [hud hide:YES];
    }];
}

-(NSMutableArray*) getObjectsFromLocalDataStoreClass:(NSString*) class{
    NSMutableArray *retorno = [NSMutableArray new];
    PFQuery *query = [PFQuery queryWithClassName:class];
    [query fromLocalDatastore];
    
    [retorno addObjectsFromArray:[query findObjects]];
    
    return retorno;
}

-(void) deleteLocalDataStore{
    NSMutableArray *tipoImovel = [self getObjectsFromLocalDataStoreClass:@"TipoImovel"];
    NSMutableArray *condicaoImovel = [self getObjectsFromLocalDataStoreClass:@"CondicaoImovel"];
    NSMutableArray *statusSimulacao = [self getObjectsFromLocalDataStoreClass:@"StatusSimulacao"];
    
    for (TipoImovel *tipo in tipoImovel) {
        [tipo unpin];
    }
    
    for (CondicaoImovel *condicao in condicaoImovel) {
        [condicao unpin];
    }
    
    for (StatusSimulacao *status in statusSimulacao) {
        [status unpin];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
