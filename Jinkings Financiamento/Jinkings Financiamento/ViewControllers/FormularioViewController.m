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
#import <MBProgressHUD/MBProgressHUD.h>

@interface FormularioViewController ()

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtCep;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtBairro;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtLogradouro;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtUF;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtMunicipio;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtTipoImovel;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtValorImovel;

@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtImovelMunicipioFinanciamento;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtImovelMunicipioReside;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtPossuiFinanciamento;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtValorFinanciamento;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtPrazoDesejado;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtDataNascimentoComprador;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtECorrentista;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtAgencia;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtConta;

@property (nonatomic, strong) UIActionSheet *actionSheetTipoImovel;
@property (nonatomic, strong) UIActionSheet *actionSheetImovelMunicipioFinanciamento;
@property (nonatomic, strong) UIActionSheet *actionSheetImovelMunicipioReside;
@property (nonatomic, strong) UIActionSheet *actionSheetPossuiFinanciamento;
@property (nonatomic, strong) UIActionSheet *actionSheetECorrentista;

@end

@implementation FormularioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.bounds.size.width, 1024)];
    
    [self setupTextFields];
    
    _actionSheetImovelMunicipioFinanciamento = [[UIActionSheet alloc] initWithTitle:@"Possui imóvel no município do financiamento?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Sim", @"Não", nil];
    
    _actionSheetECorrentista = [[UIActionSheet alloc] initWithTitle:@"É correntista no Banco do Brasil?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Sim", @"Não", nil];
    
    _actionSheetImovelMunicipioReside = [[UIActionSheet alloc] initWithTitle:@"Possui imóvel no município onde reside?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Sim", @"Não", nil];
    
    _actionSheetPossuiFinanciamento = [[UIActionSheet alloc] initWithTitle:@"Possui financiamento imobiliário?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Sim", @"Não", nil];
    
    _actionSheetTipoImovel = [[UIActionSheet alloc] initWithTitle:@"Tipo do imóvel" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Comercial Novo", @"Comercial Usado", @"Residencial Novo", @"Residencial Usado", nil];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnPesquisarCepClick:(id)sender {
    if (_edtCep.text.length > 0) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.labelText = @"Consultando";
        
        [self limparCamposEndereco];
        
        NSString *strUrlCep = [NSString stringWithFormat:@"http://cep.correiocontrol.com.br/%@.json", _edtCep.text];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        [manager GET:strUrlCep parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *retorno = (NSDictionary*) responseObject;
            
            [self preencherEndereco:retorno];
            
            [hud hide:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[[UIAlertView alloc] initWithTitle:@"CEP não encontrado" message:@"Preencha o endereço manualmente" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
            
            [hud hide:YES];
        }];
    }
}

-(void) limparCamposEndereco{
    _edtBairro.text     = @"";
    _edtCep.text        = @"";
    _edtMunicipio.text  = @"";
    _edtLogradouro.text = @"";
    _edtUF.text         = @"";
}

-(void) preencherEndereco:(NSDictionary*) dicEndereco{
    _edtBairro.text = [dicEndereco objectForKey:@"bairro"];
    _edtCep.text    = [dicEndereco objectForKey:@"cep"];
    _edtMunicipio.text    = [dicEndereco objectForKey:@"localidade"];
    _edtLogradouro.text    = [dicEndereco objectForKey:@"logradouro"];
    _edtUF.text    = [dicEndereco objectForKey:@"uf"];
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
    
    _edtImovelMunicipioFinanciamento.delegate = self;
    _edtImovelMunicipioFinanciamento.backgroundColor = [UIColor clearColor];
    _edtImovelMunicipioFinanciamento.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtImovelMunicipioFinanciamento.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtImovelMunicipioReside.delegate = self;
    _edtImovelMunicipioReside.backgroundColor = [UIColor clearColor];
    _edtImovelMunicipioReside.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtImovelMunicipioReside.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtPossuiFinanciamento.delegate = self;
    _edtPossuiFinanciamento.backgroundColor = [UIColor clearColor];
    _edtPossuiFinanciamento.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtPossuiFinanciamento.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtValorFinanciamento.delegate = self;
    _edtValorFinanciamento.backgroundColor = [UIColor clearColor];
    _edtValorFinanciamento.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtValorFinanciamento.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtPrazoDesejado.delegate = self;
    _edtPrazoDesejado.backgroundColor = [UIColor clearColor];
    _edtPrazoDesejado.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtPrazoDesejado.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtDataNascimentoComprador.delegate = self;
    _edtDataNascimentoComprador.backgroundColor = [UIColor clearColor];
    _edtDataNascimentoComprador.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtDataNascimentoComprador.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtECorrentista.delegate = self;
    _edtECorrentista.backgroundColor = [UIColor clearColor];
    _edtECorrentista.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtECorrentista.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtAgencia.delegate = self;
    _edtAgencia.backgroundColor = [UIColor clearColor];
    _edtAgencia.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtAgencia.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
    _edtConta.delegate = self;
    _edtConta.backgroundColor = [UIColor clearColor];
    _edtConta.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtConta.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
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
    
    _edtImovelMunicipioFinanciamento.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Possui imóvel no município do financiamento?" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtImovelMunicipioReside.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Possui imóvel no município onde reside?" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtPossuiFinanciamento.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Possui financiamento imobiliário?" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtValorFinanciamento.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Valor a ser financiado" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtPrazoDesejado.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Prazo desejado (até 360 meses)" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtDataNascimentoComprador.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Data de nascimento do comprador" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtECorrentista.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"É correntista no Banco do Brasil?" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtAgencia.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Agência" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtConta.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Conta" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
}

- (IBAction)actionSheetECorrentista:(id)sender {
    [_actionSheetECorrentista showInView:self.view];
}

- (IBAction)actionSheetTipoImovel:(id)sender{
    [_actionSheetTipoImovel showInView:self.view];
}

- (IBAction)actionSheetMunicipioReside:(id)sender {
    [_actionSheetImovelMunicipioReside showInView:self.view];
}

- (IBAction)actionSheetMunicipioFinanciamento:(id)sender {
    [_actionSheetImovelMunicipioFinanciamento showInView:self.view];
}

- (IBAction)actionSheetPossuiFinanciamento:(id)sender {
    [_actionSheetPossuiFinanciamento showInView:self.view];
}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (![[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Cancelar"]) {
        if ([actionSheet isEqual:_actionSheetTipoImovel]) {
            _edtTipoImovel.text = [actionSheet buttonTitleAtIndex:buttonIndex];
        }
        
        if ([actionSheet isEqual:_actionSheetECorrentista]) {
            _edtECorrentista.text = [actionSheet buttonTitleAtIndex:buttonIndex];
        }
        
        if ([actionSheet isEqual:_actionSheetImovelMunicipioFinanciamento]) {
            _edtImovelMunicipioFinanciamento.text = [actionSheet buttonTitleAtIndex:buttonIndex];
        }
        
        if ([actionSheet isEqual:_actionSheetImovelMunicipioReside]) {
            _edtImovelMunicipioReside.text = [actionSheet buttonTitleAtIndex:buttonIndex];
        }
        
        if ([actionSheet isEqual:_actionSheetPossuiFinanciamento]) {
            _edtPossuiFinanciamento.text = [actionSheet buttonTitleAtIndex:buttonIndex];
        }
    }
}


@end
