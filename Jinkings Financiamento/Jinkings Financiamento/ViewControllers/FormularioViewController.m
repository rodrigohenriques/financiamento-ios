//
//  FormularioViewController.m
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 03/05/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "FormularioViewController.h"
#import <Parse/Parse.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <RPFloatingPlaceholders/RPFloatingPlaceholderTextField.h>

@interface FormularioViewController ()
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtCep;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtBairro;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtLogradouro;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtUF;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtMunicipio;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtTipoImovel;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtValorImovel;

@end

@implementation FormularioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTextFields];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnPesquisarCepClick:(id)sender {
    if (_edtCep.text.length > 0) {
        
        NSString *strUrlCep = [NSString stringWithFormat:@"http://cep.correiocontrol.com.br/%@.json", _edtCep.text];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager GET:strUrlCep parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

-(void) setupTextFields{
    _edtCep.delegate = self;
    _edtCep.backgroundColor = [UIColor clearColor];
    _edtCep.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtCep.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtBairro.delegate = self;
    _edtBairro.backgroundColor = [UIColor clearColor];
    _edtBairro.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtBairro.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtLogradouro.delegate = self;
    _edtLogradouro.backgroundColor = [UIColor clearColor];
    _edtLogradouro.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtLogradouro.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtUF.delegate = self;
    _edtUF.backgroundColor = [UIColor clearColor];
    _edtUF.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtUF.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtMunicipio.delegate = self;
    _edtMunicipio.backgroundColor = [UIColor clearColor];
    _edtMunicipio.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtMunicipio.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtTipoImovel.delegate = self;
    _edtTipoImovel.backgroundColor = [UIColor clearColor];
    _edtTipoImovel.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtTipoImovel.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtValorImovel.delegate = self;
    _edtValorImovel.backgroundColor = [UIColor clearColor];
    _edtValorImovel.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtValorImovel.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    [self setupFloatLabel];
    
}

-(void) setupFloatLabel{
    _edtCep.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"CEP" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtBairro.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Bairro" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtLogradouro.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Logradouro" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtUF.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"UF" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtMunicipio.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Município" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtTipoImovel.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Tipo do imóvel" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtValorImovel.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Valor do imóvel" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
}

@end
