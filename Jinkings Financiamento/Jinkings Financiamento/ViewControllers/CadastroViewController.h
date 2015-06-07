//
//  CadastroViewController.h
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 03/05/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIFloatLabelTextField/UIFloatLabelTextField.h>

@interface CadastroViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *edtNome;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *edtEmail;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *edtTelefone;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *edtCelular;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *edtSenha;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *edtConfirmarSenha;

@end
