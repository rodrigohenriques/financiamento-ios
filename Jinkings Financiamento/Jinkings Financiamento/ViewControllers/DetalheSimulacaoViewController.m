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
#import <MBProgressHUD/MBProgressHUD.h>

@interface DetalheSimulacaoViewController ()

@property (nonatomic, strong) NSMutableArray *documentos;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) MBProgressHUD *hud;

@end

@implementation DetalheSimulacaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.documentos = [self getCategoriaDocumentos];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = @"Carregando...";
    [self.hud hide:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setTitle:@"Documentos"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FotoViewController *fotoVC = (FotoViewController*) segue.destinationViewController;
    fotoVC.imgDocumento = (UIImage*) sender;
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
    
    PFQuery *queryDocSimulacao = [PFQuery queryWithClassName:@"DocumentoSimulacao"];
    [queryDocSimulacao whereKey:@"categoriaDocumento" equalTo:documento];
    [queryDocSimulacao whereKey:@"simulacao" equalTo:self.simulacao];
    
    NSArray *resultado = [queryDocSimulacao findObjects];
    
    DocumentoSimulacao *docSimulacao = [DocumentoSimulacao alloc];
    
    cell.lblDocumentoNome.text = documento[@"nome"];
    cell.lblDocumentoDescricao.text = documento[@"descricao"];
    cell.imageDocumento.image = [UIImage imageNamed:@"placeholder"];
    
    if ([resultado count] > 0) {
        docSimulacao = [resultado objectAtIndex:0];
        PFFile *imageFile = docSimulacao[@"documento"];
        
        [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!data) {
                return NSLog(@"%@", error);
            }
            
            cell.imageDocumento.image = [UIImage imageWithData:data];
        }];
    }
    
    [cell setupWithDocumento: docSimulacao];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.selectedIndexPath = indexPath;
    
    UIAlertController *action = [UIAlertController alertControllerWithTitle:@"Selecione uma opção" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *visualizar = [UIAlertAction actionWithTitle:@"Visualizar documento" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.hud show:YES];
        
        CategoriaDocumento *documento = [self.documentos objectAtIndex:indexPath.row];
        
        PFQuery *queryDocSimulacao = [PFQuery queryWithClassName:@"DocumentoSimulacao"];
        [queryDocSimulacao whereKey:@"categoriaDocumento" equalTo:documento];
        [queryDocSimulacao whereKey:@"simulacao" equalTo:self.simulacao];
        
        NSArray *resultado = [queryDocSimulacao findObjects];
        
        DocumentoSimulacao *docSimulacao = [DocumentoSimulacao alloc];
        
        if ([resultado count] > 0) {
            docSimulacao = [resultado objectAtIndex:0];
            PFFile *imageFile = docSimulacao[@"documento"];
            
            [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                if (!data) {
                    return NSLog(@"%@", error);
                }
                
                UIImage *image = [UIImage imageWithData:data];
                [self performSegueWithIdentifier:@"segueFoto" sender:image];
                [self.hud hide:YES];
            }];
        }
    }];
    
    UIAlertAction *apagar = [UIAlertAction actionWithTitle:@"Apagar documento" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self.hud show:YES];
        
        CategoriaDocumento *documento = [self.documentos objectAtIndex:indexPath.row];
        
        PFQuery *queryDocSimulacao = [PFQuery queryWithClassName:@"DocumentoSimulacao"];
        [queryDocSimulacao whereKey:@"categoriaDocumento" equalTo:documento];
        [queryDocSimulacao whereKey:@"simulacao" equalTo:self.simulacao];
        
        NSArray *resultado = [queryDocSimulacao findObjects];
        DocumentoSimulacao *docSimulacao = [DocumentoSimulacao alloc];
        
        if ([resultado count] > 0) {
            docSimulacao = [resultado objectAtIndex:0];
            [docSimulacao delete];
            [self.tableView reloadData];
        }
        
        [self.hud hide:YES];
    }];
    
    UIAlertAction *capturar = [UIAlertAction actionWithTitle:@"Capturar imagem" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self abrirCamera];
    }];
    
    UIAlertAction *cancelar = [UIAlertAction actionWithTitle:@"Cancelar" style:UIAlertActionStyleDestructive handler:nil];
    
    [action addAction:visualizar];
    [action addAction:apagar];
    [action addAction:capturar];
    [action addAction:cancelar];
    
    [self presentViewController:action animated:YES completion:nil];
}

-(void) abrirCamera{
    @try
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.allowsEditing = NO;
        picker.showsCameraControls = YES;
        [self presentViewController:picker animated:YES completion:nil];
    }
    @catch (NSException *exception)
    {
        [[[UIAlertView alloc] initWithTitle:@"Sem Câmera" message:@"Câmera não disponível" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.3);
    
    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
    
    CategoriaDocumento *documento = [self.documentos objectAtIndex:self.selectedIndexPath.row];
    
    PFQuery *queryDocSimulacao = [PFQuery queryWithClassName:@"DocumentoSimulacao"];
    [queryDocSimulacao whereKey:@"categoriaDocumento" equalTo:documento];
    [queryDocSimulacao whereKey:@"simulacao" equalTo:self.simulacao];
    
    NSArray *resultado = [queryDocSimulacao findObjects];
    
    
    if ([resultado count] > 0) {
        DocumentoSimulacao *docSimulacao = [resultado objectAtIndex:0];
        docSimulacao[@"documento"] = imageFile;
        [docSimulacao save];
    } else {
        PFObject *docSimulacao = [PFObject objectWithClassName:@"DocumentoSimulacao"];
        docSimulacao[@"documento"] = imageFile;
        docSimulacao[@"categoriaDocumento"] = documento;
        docSimulacao[@"simulacao"] = self.simulacao;
        
        [docSimulacao save];
    }
    
    [self.tableView reloadData];
}

UIImage *squareCropImageToSideLength(UIImage *sourceImage,
                                     CGFloat sideLength)
{
    // input size comes from image
    CGSize inputSize = sourceImage.size;
    
    // round up side length to avoid fractional output size
    sideLength = ceilf(sideLength);
    
    // output size has sideLength for both dimensions
    CGSize outputSize = CGSizeMake(sideLength, sideLength);
    
    // calculate scale so that smaller dimension fits sideLength
    CGFloat scale = MAX(sideLength / inputSize.width,
                        sideLength / inputSize.height);
    
    // scaling the image with this scale results in this output size
    CGSize scaledInputSize = CGSizeMake(inputSize.width * scale,
                                        inputSize.height * scale);
    
    // determine point in center of "canvas"
    CGPoint center = CGPointMake(outputSize.width/2.0,
                                 outputSize.height/2.0);
    
    // calculate drawing rect relative to output Size
    CGRect outputRect = CGRectMake(center.x - scaledInputSize.width/2.0,
                                   center.y - scaledInputSize.height/2.0,
                                   scaledInputSize.width,
                                   scaledInputSize.height);
    
    // begin a new bitmap context, scale 0 takes display scale
    UIGraphicsBeginImageContextWithOptions(outputSize, YES, 0);
    
    // optional: set the interpolation quality.
    // For this you need to grab the underlying CGContext
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(ctx, kCGInterpolationHigh);
    
    // draw the source image into the calculated rect
    [sourceImage drawInRect:outputRect];
    
    // create new image from bitmap context
    UIImage *outImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // clean up
    UIGraphicsEndImageContext();
    
    // pass back new image
    return outImage;
}

@end
