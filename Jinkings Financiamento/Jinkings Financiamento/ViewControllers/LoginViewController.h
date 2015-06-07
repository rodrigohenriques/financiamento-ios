//
//  LoginViewController.h
//  Jinkings Financiamento
//
//  Created by Guilherme Augusto on 03/05/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIFloatLabelTextField/UIFloatLabelTextField.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *edtEmail;
@property (strong, nonatomic) IBOutlet UIFloatLabelTextField *edtSenha;

@end
