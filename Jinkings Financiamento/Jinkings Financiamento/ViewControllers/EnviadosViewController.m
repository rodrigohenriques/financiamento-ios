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

@interface EnviadosViewController ()

@property (nonatomic, strong) NSMutableArray *simulacoes;
@property (strong, nonatomic) IBOutlet UITableView *tabela;

@end

@implementation EnviadosViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.labelText = @"Carregando...";
    
    [hud show:YES];
    
    self.simulacoes = [NSMutableArray new];
    
    _tabela.delegate = self;
    _tabela.dataSource = self;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Simulacao"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (Simulacao *simulacao in objects) {
                [self.simulacoes addObject:simulacao];
            }
            
            [_tabela reloadData];
            
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
        [hud hide:YES];
    }];
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
    
    cell.lblTitle.text = [NSString stringWithFormat:@"R$%@ - %@", simulacao[@"valorFinanciamento"], simulacao[@"dataEnvio"]];
    cell.lblImovel.text = [NSString stringWithFormat:@"%@ - %@", simulacao[@"tipoImovel"], simulacao[@"logradouro"]];

    NSString *status = simulacao[@"status"];
    
    if ([status isEqualToString:@"Em análise"]) {
        [cell.lblStatus setTextColor:[UIColor colorWithRed:0.882 green:0.773 blue:0.067 alpha:1]];
    } else if ([status isEqualToString:@"Cancelada"]){
        [cell.lblStatus setTextColor:[UIColor redColor]];
    } else if ([status isEqualToString:@"Aprovada"]){
        [cell.lblStatus setTextColor:[UIColor colorWithRed:0.302 green:0.851 blue:0.063 alpha:1]];
    } else if ([status isEqualToString:@"Aguardando documentação"]){
        [cell.lblStatus setTextColor:[UIColor colorWithRed:0.106 green:0.243 blue:0.576 alpha:1]];
    }
    
    cell.lblStatus.text = status;

    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.simulacoes count];
}

@end
