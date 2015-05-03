//
//  AppHelper.m
//  Beautify
//
//  Created by Guilherme Augusto on 11/04/15.
//  Copyright (c) 2015 Cousins Corp. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper

+ (NSManagedObjectContext *)mainManagedObjectContext {
    return [((AppDelegate *)[[UIApplication sharedApplication] delegate]) managedObjectContext];
}

@end
