//
//  PerfilViewController.m
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 13/06/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "PerfilViewController.h"
#import <Parse/Parse.h>

@interface PerfilViewController ()

@property (strong, nonatomic) IBOutlet UILabel *lblNome;
@property (strong, nonatomic) IBOutlet UILabel *lblCelular;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblCategoria;

@end

@implementation PerfilViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFObject *user = [PFUser currentUser];
    
    _lblNome.text = user[@"nome"];
    _lblCelular.text = user[@"celular"];
    _lblEmail.text = user[@"email"];
    _lblCategoria.text = user[@"categoriaProfissional"];
    
}

@end
