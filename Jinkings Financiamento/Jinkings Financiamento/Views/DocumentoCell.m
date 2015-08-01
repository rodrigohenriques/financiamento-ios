//
//  DocumentoCell.m
//  Jinkings Soluciona
//
//  Created by Guilherme Augusto on 25/07/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "DocumentoCell.h"

@implementation DocumentoCell

- (void)awakeFromNib {
    self.imageDocumento.layer.cornerRadius = 5;
    self.imageDocumento.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:NO animated:animated];

    // Configure the view for the selected state
}

@end
