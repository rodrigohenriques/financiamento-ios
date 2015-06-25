//
//  CadastroViewController.h
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 03/05/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RPFloatingPlaceholders/RPFloatingPlaceholderTextField.h>
#import "BaseViewController.h"

@interface CadastroViewController : BaseViewController <UITextFieldDelegate, UIAlertViewDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtNome;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtEmail;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtTelefone;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtCelular;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtSenha;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtConfirmarSenha;

@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtCPF;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtCategoriaProfissional;

@end
