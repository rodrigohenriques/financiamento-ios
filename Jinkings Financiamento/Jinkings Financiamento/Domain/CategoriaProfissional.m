//
//  CategoriaProfissional.m
//  Jinkings Soluciona
//
//  Created by Guilherme Augusto on 25/07/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "CategoriaProfissional.h"

@implementation CategoriaProfissional

+(void)load{
    [self registerSubclass];
}

+(NSString * __nonnull)parseClassName{
    return @"CategoriaProfissional";
}

@end
