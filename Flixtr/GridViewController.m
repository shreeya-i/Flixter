//
//  GridViewController.m
//  Flixtr
//
//  Created by Shreeya Indap on 6/16/22.
//

#import "GridViewController.h"
#import "GridCollectionViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface GridViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *myArray;
@property (weak, nonatomic) IBOutlet UICollectionView *GridCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *GridCollectionViewFlowLayout;

@end

@implementation GridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.GridCollectionView.dataSource = self;
    self.GridCollectionView.delegate = self;
    
    [self fetchMovies];
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=9596ade9fec9e21640df2dd903535372"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               self.myArray = dataDictionary[@"results"];
               [self.GridCollectionView reloadData];
               
           }
       }];
    [task resume];
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridCollectionViewCell" forIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", "https://image.tmdb.org/t/p/w500", self.myArray[indexPath.row][@"poster_path"]]];
    [cell.posterImage setImageWithURL:url];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

//- (void)viewDidLayoutSubviews {
//   [super viewDidLayoutSubviews];
//    self.GridCollectionViewFlowLayout.minimumLineSpacing = 10;
//    self.GridCollectionViewFlowLayout.minimumInteritemSpacing = 10;
//    //self.GridCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 20);
//}


 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     NSIndexPath *myIndexPath = [self.GridCollectionView indexPathForCell:sender];
     NSDictionary *dataToPass = self.myArray[myIndexPath.row];
     DetailsViewController *detailVC = [segue destinationViewController];
     detailVC.detailDict = dataToPass;
 }

@end
