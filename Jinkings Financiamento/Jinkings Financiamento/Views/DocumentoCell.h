//
//  DocumentoCell.h
//  Jinkings Soluciona
//
//  Created by Guilherme Augusto on 25/07/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DocumentoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblDocumentoNome;
@property (strong, nonatomic) IBOutlet UILabel *lblDocumentoDescricao;
@property (strong, nonatomic) IBOutlet UIImageView *imageDocumento;

@end
