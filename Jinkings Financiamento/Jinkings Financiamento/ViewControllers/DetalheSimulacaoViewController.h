//
//  DetalheSimulacaoViewController.h
//  Jinkings Soluciona
//
//  Created by Guilherme Augusto on 25/07/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Simulacao.h"
#import "FotoViewController.h"

@interface DetalheSimulacaoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) Simulacao *simulacao;

@end
