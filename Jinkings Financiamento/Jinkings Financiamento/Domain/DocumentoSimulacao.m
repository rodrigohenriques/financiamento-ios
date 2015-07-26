//
//  DocumentoSimulacao.m
//  Jinkings Soluciona
//
//  Created by Guilherme Augusto on 26/07/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "DocumentoSimulacao.h"

@implementation DocumentoSimulacao

+(void)load{
    [self registerSubclass];
}

+(NSString * __nonnull)parseClassName{
    return @"DocumentoSimulacao";
}

@end
