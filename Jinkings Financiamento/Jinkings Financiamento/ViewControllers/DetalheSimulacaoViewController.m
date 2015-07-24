//
//  DetalheSimulacaoViewController.m
//  Jinkings Soluciona
//
//  Created by Guilherme Augusto on 23/07/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "DetalheSimulacaoViewController.h"

@interface DetalheSimulacaoViewController ()

@property (strong, nonatomic) NSMutableArray *arrayDocAssalariado;
@property (strong, nonatomic) NSMutableArray *arrayDocEmpresario;
@property (strong, nonatomic) NSMutableArray *arrayDocAutonomo;
@property (strong, nonatomic) NSMutableArray *arrayDocLiberal;
@property (strong, nonatomic) NSMutableArray *arrayDocAposentado;

@property (strong, nonatomic) IBOutlet UICollectionView *tabela;

@end

@implementation DetalheSimulacaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayDocAssalariado = [NSMutableArray new];
    [self.arrayDocAssalariado addObject:@"Carteira de identidade"];
    [self.arrayDocAssalariado addObject:@"CPF"];
    [self.arrayDocAssalariado addObject:@"Comprovante de estado civil"];
    [self.arrayDocAssalariado addObject:@"Comprovante de residência atualizado"];
    [self.arrayDocAssalariado addObject:@"Comprovante de renda (D.I.R.P.F. ou contra cheque dos últimos 3 meses)."];
    
    self.arrayDocEmpresario = [NSMutableArray new];
    [self.arrayDocEmpresario addObject:@"Carteira de identidade"];
    [self.arrayDocEmpresario addObject:@"CPF"];
    [self.arrayDocEmpresario addObject:@"Comprovante de estado civil"];
    [self.arrayDocEmpresario addObject:@"Comprovante de residência atualizado"];
    [self.arrayDocEmpresario addObject:@"Comprovante de renda (D.I.R.P.F. últimos 3 anos juntamente com o contrato social e faturamento dos últimos 12 meses)"];

    self.arrayDocAutonomo = [NSMutableArray new];
    [self.arrayDocAutonomo addObject:@"Carteira de identidade"];
    [self.arrayDocAutonomo addObject:@"CPF"];
    [self.arrayDocAutonomo addObject:@"Comprovante de estado civil"];
    [self.arrayDocAutonomo addObject:@"Comprovante de residência atualizado"];
    [self.arrayDocAutonomo addObject:@"Comprovante de renda (D.I.R.P.F. ou DECORE dos últimos 6 meses com recolhimento das DARF’s."];
    
    self.arrayDocLiberal = [NSMutableArray new];
    [self.arrayDocLiberal addObject:@"Carteira da ordem de classe (CRM, CRN, OAB, etc)"];
    [self.arrayDocLiberal addObject:@"Comprovante de estado civil"];
    [self.arrayDocLiberal addObject:@"Comprovante de residência atualizado"];
    [self.arrayDocLiberal addObject:@"Comprovante de renda (D.I.R.P.F. , DECORE dos últimos 6 meses com recolhimento das DARF’S). Também será aceito contrato de prestação de serviços com no mínimo 1 ano já contrato com mais 1 ano de renovação."];
    
    self.arrayDocAposentado = [NSMutableArray new];
    [self.arrayDocAposentado addObject:@"Carteira de identidade"];
    [self.arrayDocAposentado addObject:@"CPF"];
    [self.arrayDocAposentado addObject:@"Comprovante de estado civil"];
    [self.arrayDocAposentado addObject:@"Comprovante de residência atualizado"];
    [self.arrayDocAposentado addObject:@"Comprovante de renda (D.I.R.P.F. ou extrato INSS atualizado ou DECORE dos últimos 6 meses com recolhimento das DARF’S."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//NSData *imageData = UIImagePNGRepresentation(image);
//PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
//
//PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
//userPhoto[@"imageName"] = @"My trip to Hawaii!";
//userPhoto[@"imageFile"] = imageFile;
//[userPhoto saveInBackground];

@end
