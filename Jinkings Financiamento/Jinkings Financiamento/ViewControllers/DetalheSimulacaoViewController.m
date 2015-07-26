//
//  DetalheSimulacaoViewController.m
//  Jinkings Soluciona
//
//  Created by Guilherme Augusto on 25/07/15.
//  Copyright (c) 2015 Jinkings. All rights reserved.
//

#import "DetalheSimulacaoViewController.h"
#import <Parse/Parse.h>
#import "CategoriaDocumento.h"
#import "DocumentoSimulacao.h"
#import "CategoriaProfissional.h"
#import "DocumentoCell.h"

@interface DetalheSimulacaoViewController ()

@property (nonatomic, strong) NSMutableArray *documentos;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DetalheSimulacaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.documentos = [self getCategoriaDocumentos];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self setTitle:@"Documentos"];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.documentos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DocumentoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DocumentoCell" forIndexPath:indexPath];
    
    CategoriaDocumento *documento = [self.documentos objectAtIndex:indexPath.row];
    
    cell.textLabel.text = documento[@"nome"];
    cell.detailTextLabel.text = documento[@"descricao"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
