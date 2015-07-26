//
//  CategoriaDocumento.m
//  Jinkings Soluciona
//
//  Created by Guilherme Augusto on 25/07/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "CategoriaDocumento.h"

@implementation CategoriaDocumento

+(void)load{
    [self registerSubclass];
}

+(NSString * __nonnull)parseClassName{
    return @"CategoriaDocumento";
}

@end
