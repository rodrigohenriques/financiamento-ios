//
//  EnviadosViewController.m
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 03/05/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "EnviadosViewController.h"
#import <Parse/Parse.h>
#import "SimulacaoCell.h"
#import "Simulacao.h"
#import <MBProgressHUD/MBProgressHUD.h>

#import "TipoImovel.h"
#import "CondicaoImovel.h"
#import "StatusSimulacao.h"

@interface EnviadosViewController ()

@property (nonatomic, strong) NSMutableArray *simulacoes;
@property (strong, nonatomic) IBOutlet UITableView *tabela;

@end

@implementation EnviadosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.simulacoes = [NSMutableArray new];
    
    _tabela.delegate = self;
    _tabela.dataSource = self;

}

-(void)viewWillAppear:(BOOL)animated{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Carregando...";
    
    [hud show:YES];
    
    [self.simulacoes removeAllObjects];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Simulacao"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    [self.simulacoes addObjectsFromArray:[query findObjects]];
    
    [self.tabela reloadData];
    
    [hud hide:YES];
    
    [self.tabBarController setTitle:@"Enviadas"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - uitableviewdelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simulacaoCell = @"SimulacaoCell";
    
    SimulacaoCell *cell = (SimulacaoCell *)[_tabela dequeueReusableCellWithIdentifier:simulacaoCell];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simulacaoCell owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Simulacao *simulacao = [self.simulacoes objectAtIndex:indexPath.row];
    
    TipoImovel *tipoImovel = simulacao[@"tipoImovel"];
    CondicaoImovel *condicaoImovel = simulacao[@"condicaoImovel"];
    
    cell.lblTitle.text = [NSString stringWithFormat:@"R$%@ - %@", simulacao[@"valorFinanciamento"], simulacao[@"dataEnvio"]];
    cell.lblImovel.text = [NSString stringWithFormat:@"%@ %@ - %@", tipoImovel[@"descricao"], condicaoImovel[@"descricao"], simulacao[@"logradouro"]];

    StatusSimulacao *status = simulacao[@"Status"];
    
    [cell.lblStatus setTextColor:[self colorFromHexString:status[@"hexCor"]]];
    
    cell.lblStatus.text = status[@"descricao"];

    return cell;
}

-(UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.simulacoes count];
}

@end
