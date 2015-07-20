//
//  CondicaoImovel.m
//  Jinkings Soluciona
//
//  Created by Guilherme Augusto on 19/07/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "CondicaoImovel.h"

@implementation CondicaoImovel

+(void)load{
    [self registerSubclass];
}

+(NSString * __nonnull)parseClassName{
    return @"CondicaoImovel";
}

@end
