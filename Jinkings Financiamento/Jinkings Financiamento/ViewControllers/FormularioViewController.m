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
#import <TSMessages/TSMessage.h>

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
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtCondicaoImovel;

@property (nonatomic, strong) UIActionSheet *actionSheetTipoImovel;
@property (nonatomic, strong) UIActionSheet *actionSheetImovelMunicipioFinanciamento;
@property (nonatomic, strong) UIActionSheet *actionSheetImovelMunicipioReside;
@property (nonatomic, strong) UIActionSheet *actionSheetPossuiFinanciamento;
@property (nonatomic, strong) UIActionSheet *actionSheetECorrentista;
@property (nonatomic, strong) UIActionSheet *actionSheetCondicaoImovel;

@end

@implementation FormularioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_scrollView setContentSize:CGSizeMake(self.view.bounds.size.width, 1270)];
    
    [self setupTextFields];
    
    _actionSheetImovelMunicipioFinanciamento = [[UIActionSheet alloc] initWithTitle:@"Possui imóvel no município do financiamento?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Sim", @"Não", nil];
    
    _actionSheetECorrentista = [[UIActionSheet alloc] initWithTitle:@"É correntista no Banco do Brasil?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Sim", @"Não", nil];
    
    _actionSheetImovelMunicipioReside = [[UIActionSheet alloc] initWithTitle:@"Possui imóvel no município onde reside?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Sim", @"Não", nil];
    
    _actionSheetPossuiFinanciamento = [[UIActionSheet alloc] initWithTitle:@"Possui financiamento imobiliário?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Sim", @"Não", nil];
    
    _actionSheetTipoImovel = [[UIActionSheet alloc] initWithTitle:@"Tipo do imóvel" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Comercial", @"Residencial", nil];
    
    _actionSheetCondicaoImovel = [[UIActionSheet alloc] initWithTitle:@"Condição do imóvel" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Novo", @"Usado", @"Em construção", nil];
    
    self.navigationItem.title = @"Simulação";
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnPesquisarCepClick:(id)sender {
    if (_edtCep.text.length > 0) {
        
        [_edtCep resignFirstResponder];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.labelText = @"Consultando";
        
        NSString *strUrlCep = [NSString stringWithFormat:@"http://cep.correiocontrol.com.br/%@.json", [[_edtCep.text stringByReplacingOccurrencesOfString:@"." withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""]];
        
        [self limparCamposEndereco];
        
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
    _edtMunicipio.text  = @"";
    _edtLogradouro.text = @"";
    _edtUF.text         = @"";
}

-(void) preencherEndereco:(NSDictionary*) dicEndereco{
    _edtBairro.text = [dicEndereco objectForKey:@"bairro"];
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
    
    _edtCondicaoImovel.delegate = self;
    _edtCondicaoImovel.backgroundColor = [UIColor clearColor];
    _edtCondicaoImovel.floatingLabelActiveTextColor = [UIColor colorWithRed:0.278 green:0.314 blue:0.349 alpha:1];
    _edtCondicaoImovel.floatingLabelInactiveTextColor = [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1];
    
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
    
    _edtCondicaoImovel.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Condição do imóvel" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
    _edtValorImovel.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Valor aproximado do imóvel" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.518 green:0.58 blue:0.651 alpha:1]}];
    
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
- (IBAction)actionSheetCondicaoImovel:(id)sender {
    [_actionSheetCondicaoImovel showInView:self.view];
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
        
        if ([actionSheet isEqual:_actionSheetCondicaoImovel]) {
            _edtCondicaoImovel.text = [actionSheet buttonTitleAtIndex:buttonIndex];
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    if ([textField isEqual:_edtCep]) {
        
        if (textField.text.length >= 10) {
            return NO;
        }
        
        if (textField.text.length == 2) {
            textField.text = [NSString stringWithFormat:@"%@.",textField.text];
        }
        
        if (textField.text.length == 6) {
            textField.text = [NSString stringWithFormat:@"%@-",textField.text];
        }
    }
    
    if ([textField isEqual:_edtDataNascimentoComprador]) {
        if (textField.text.length >= 10) {
            return NO;
        }
        
        if (textField.text.length == 2 || textField.text.length == 5) {
            textField.text = [NSString stringWithFormat:@"%@/",textField.text];
        }
    }
    
    if ([textField isEqual:_edtValorFinanciamento] || [textField isEqual:_edtValorImovel]) {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setMaximumFractionDigits:2];
        [numberFormatter setMinimumFractionDigits:2];
        
        NSString *stringMaybeChanged = [NSString stringWithString:string];
        if (stringMaybeChanged.length > 1)
        {
            NSMutableString *stringPasted = [NSMutableString stringWithString:stringMaybeChanged];
            [stringPasted replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                          withString:@""
                                             options:NSLiteralSearch
                                               range:NSMakeRange(0, [stringPasted length])];
            
            NSDecimalNumber *numberPasted = [NSDecimalNumber decimalNumberWithString:stringPasted];
            stringMaybeChanged = [numberFormatter stringFromNumber:numberPasted];
        }
        
        UITextRange *selectedRange = [textField selectedTextRange];
        UITextPosition *start = textField.beginningOfDocument;
        NSInteger cursorOffset = [textField offsetFromPosition:start toPosition:selectedRange.start];
        NSMutableString *textFieldTextStr = [NSMutableString stringWithString:textField.text];
        NSUInteger textFieldTextStrLength = textFieldTextStr.length;
        
        [textFieldTextStr replaceCharactersInRange:range withString:stringMaybeChanged];
        
        [textFieldTextStr replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                          withString:@""
                                             options:NSLiteralSearch
                                               range:NSMakeRange(0, [textFieldTextStr length])];
        
        [textFieldTextStr replaceOccurrencesOfString:numberFormatter.decimalSeparator
                                          withString:@""
                                             options:NSLiteralSearch
                                               range:NSMakeRange(0, [textFieldTextStr length])];
        
        if (textFieldTextStr.length <= 12)
        {
            NSDecimalNumber *textFieldTextNum = [NSDecimalNumber decimalNumberWithString:textFieldTextStr];
            NSDecimalNumber *divideByNum = [[[NSDecimalNumber alloc] initWithInt:10] decimalNumberByRaisingToPower:numberFormatter.maximumFractionDigits];
            NSDecimalNumber *textFieldTextNewNum = [textFieldTextNum decimalNumberByDividingBy:divideByNum];
            NSString *textFieldTextNewStr = [numberFormatter stringFromNumber:textFieldTextNewNum];
            
            textField.text = textFieldTextNewStr;
            
            if (cursorOffset != textFieldTextStrLength)
            {
                NSInteger lengthDelta = textFieldTextNewStr.length - textFieldTextStrLength;
                NSInteger newCursorOffset = MAX(0, MIN(textFieldTextNewStr.length, cursorOffset + lengthDelta));
                UITextPosition* newPosition = [textField positionFromPosition:textField.beginningOfDocument offset:newCursorOffset];
                UITextRange* newRange = [textField textRangeFromPosition:newPosition toPosition:newPosition];
                [textField setSelectedTextRange:newRange];
            }
        }
        
        return NO;
    }
    
    return YES;
}

-(BOOL) validarCampos{
    
    if (_edtCep.text.length <= 0) {
        [self exibeMensagem:@"Preencha o campo CEP"];
        return NO;
    }
    
    if (_edtBairro.text.length <= 0) {
        [self exibeMensagem:@"Preencha o campo BAIRRO"];
        return NO;
    }
    
    if (_edtLogradouro.text.length <= 0) {
        [self exibeMensagem:@"Preencha o campo LOGRADOURO"];
        return NO;
    }
    
    if (_edtUF.text.length <= 0) {
        [self exibeMensagem:@"Preencha o campo UF"];
        return NO;
    }
    
    if (_edtMunicipio.text.length <= 0) {
        [self exibeMensagem:@"Preencha o campo MUNICÍPIO"];
        return NO;
    }
    
    if (_edtTipoImovel.text.length <= 0) {
        [self exibeMensagem:@"Selecione o tipo do imóvel"];
        return NO;
    }
    
    if (_edtCondicaoImovel.text.length <= 0) {
        [self exibeMensagem:@"Selecione a condição do imóvel"];
        return NO;
    }
    
    if (_edtValorImovel.text.length <= 0) {
        [self exibeMensagem:@"Informe o valor aproximado do imóvel"];
        return NO;
    }
    
    if (_edtPossuiFinanciamento.text.length <= 0) {
        [self exibeMensagem:@"Informe se você possui financiamento"];
        return NO;
    }
    
    if (_edtValorFinanciamento.text.length <= 0) {
        [self exibeMensagem:@"Informe o valor do financiamento desejado"];
        return NO;
    }
    
    if (_edtPrazoDesejado.text.length <= 0) {
        [self exibeMensagem:@"Informe o prazo desejado para o financiamento"];
        return NO;
    }
    
    if (_edtImovelMunicipioFinanciamento.text.length <= 0) {
        [self exibeMensagem:@"Informe se você possui imóvel no município do financiamento"];
        return NO;
    }
    
    if (_edtImovelMunicipioReside.text.length <= 0) {
        [self exibeMensagem:@"Informe se você possui imóvel no município onde reside"];
        return NO;
    }
    
    if (_edtDataNascimentoComprador.text.length <= 0) {
        [self exibeMensagem:@"Informe a data de nascimento do comprador mais velho"];
        return NO;
    }
    
    if (_edtECorrentista.text.length <= 0) {
        [self exibeMensagem:@"Informe se você é correntista do Banco do Brasil"];
        return NO;
    } else if ([_edtECorrentista.text isEqualToString:@"Sim"]){
        if (_edtAgencia.text.length <= 0 || _edtConta.text.length <= 0) {
            [self exibeMensagem:@"Informe sua agência e conta"];
            return NO;
        }
    }
 
    return YES;
}

-(void) exibeMensagem:(NSString*) mensagem{
    [TSMessage showNotificationWithTitle:@"Atenção"
                                subtitle:mensagem
                                    type:TSMessageNotificationTypeError];
}

- (IBAction)btnEnviarClick:(id)sender {
    
    if (![self validarCampos]) {
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = @"Enviando";
    
    [hud show:YES];
    
    PFObject *user = [PFUser currentUser];
    
    PFObject *simulacao = [PFObject objectWithClassName:@"Simulacao"];
    
    simulacao[@"cep"] = _edtCep.text;
    simulacao[@"bairro"] = _edtBairro.text;
    simulacao[@"logradouro"] = _edtLogradouro.text;
    simulacao[@"uf"] = _edtUF.text;
    simulacao[@"municipio"] = _edtMunicipio.text;
    simulacao[@"tipoImovel"] = _edtTipoImovel.text;
    simulacao[@"condicaoImovel"] = _edtCondicaoImovel.text;
    simulacao[@"valorImovel"] = _edtValorImovel.text;
    
    simulacao[@"possuiFinanciamento"] = [_edtPossuiFinanciamento.text isEqualToString:@"Sim"] ? [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO];
    
    simulacao[@"valorFinanciamento"] = _edtValorFinanciamento.text;
    
    simulacao[@"prazoDesejado"] = [NSNumber numberWithInt:[_edtPrazoDesejado.text intValue]];
    
    simulacao[@"imovelMunicipioFinanciamento"] = [_edtImovelMunicipioFinanciamento.text isEqualToString:@"Sim"] ? [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO];
    
    simulacao[@"imovelMunicipioReside"] = [_edtImovelMunicipioReside.text isEqualToString:@"Sim"] ? [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO];

    simulacao[@"dataNascimento"] = _edtDataNascimentoComprador.text;
    
    simulacao[@"correntista"] = [_edtECorrentista.text isEqualToString:@"Sim"] ? [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO];
    
    simulacao[@"agencia"] = _edtAgencia.text;
    simulacao[@"conta"] = _edtConta.text;
    
    simulacao[@"user"] = user;
    
    simulacao[@"status"] = @"Em análise";
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    simulacao[@"dataEnvio"] = [dateFormatter stringFromDate:[NSDate date]];
    
    [simulacao saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [[[UIAlertView alloc] initWithTitle:@"Sucesso" message:@"Sua simulação de financiamento foi enviada com sucesso. Nossa equipe entrará em contato com você para informar os próximos passos. Obrigado por escolher a Soluciona!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
            [self limparCampos];
        } else {
            [self exibeMensagem:@"Não foi possível enviar a sua simulação. Por favor, tente novamente mais tarde."];
        }
        
        [hud hide:YES];
    }];
}

-(void) limparCampos{
    _edtCep.text = @"";
    _edtBairro.text = @"";
    _edtLogradouro.text = @"";
    _edtUF.text = @"";
    _edtMunicipio.text = @"";
    _edtTipoImovel.text = @"";
    _edtValorImovel.text = @"";
    _edtPossuiFinanciamento.text = @"";
    _edtValorFinanciamento.text = @"";
    _edtPrazoDesejado.text = @"";
    _edtImovelMunicipioFinanciamento.text = @"";
    _edtImovelMunicipioReside.text = @"";
    _edtDataNascimentoComprador.text = @"";
    _edtECorrentista.text = @"";
    _edtAgencia.text = @"";
    _edtConta.text = @"";
    _edtCondicaoImovel.text = @"";
}


@end
