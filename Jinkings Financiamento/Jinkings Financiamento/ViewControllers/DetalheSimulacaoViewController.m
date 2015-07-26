//
//  DetalheSimulacaoViewController.m
//  Jinkings Soluciona
//
//  Created by Guilherme Augusto on 23/07/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "DetalheSimulacaoViewController.h"
#import "CategoriaProfissional.h"
#import "CategoriaDocumento.h"

@interface DetalheSimulacaoViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *tabela;

@end

@implementation DetalheSimulacaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *documentos = [self getCategoriaDocumentos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CategoriaProfissional*) userCategoria{
    PFUser *user = [PFUser currentUser];
    return user[@"categoriaProfissional"];
}

-(NSMutableArray*) getCategoriaDocumentos{
    PFQuery *query = [PFQuery queryWithClassName:@"CategoriaDocumento"];
    [query whereKey:@"categoria" equalTo:[self userCategoria]];
    
    return [NSMutableArray arrayWithArray:[query findObjects]];
}

//NSData *imageData = UIImagePNGRepresentation(image);
//PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
//
//PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
//userPhoto[@"imageName"] = @"My trip to Hawaii!";
//userPhoto[@"imageFile"] = imageFile;
//[userPhoto saveInBackground];

@end
