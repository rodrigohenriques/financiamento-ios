//
//  TipoImovel.m
//  Jinkings Soluciona
//
//  Created by Guilherme Augusto on 19/07/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "TipoImovel.h"

@implementation TipoImovel

+(void)load{
    [self registerSubclass];
}

+(NSString * __nonnull)parseClassName{
    return @"TipoImovel";
}

@end
