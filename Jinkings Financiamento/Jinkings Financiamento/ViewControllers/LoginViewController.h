//
//  LoginViewController.h
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 03/05/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RPFloatingPlaceholders/RPFloatingPlaceholderTextField.h>
#import "BaseViewController.h"

@interface LoginViewController : BaseViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtEmail;
@property (strong, nonatomic) IBOutlet RPFloatingPlaceholderTextField *edtSenha;

@end
