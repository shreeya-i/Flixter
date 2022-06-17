//
//  MovieViewController.m
//  Flixtr
//
//  Created by Shreeya Indap on 6/16/22.
//

#import "MovieViewController.h"
#import "MovieTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "DetailsViewController.h"

@interface MovieViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *MovieTableView;
@property (nonatomic, strong) NSArray *myArray;
@property (strong, nonatomic) NSArray *filteredData;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBarController.tabBar setBarTintColor: [UIColor blackColor]];
    
    [self.activityIndicator startAnimating];
    
    self.MovieTableView.delegate = self;
    self.MovieTableView.dataSource = self;
    self.MovieTableView.rowHeight = 300;
    
    self.searchBar.delegate = self;
    self.searchBar.barTintColor = [UIColor blackColor];
    self.searchBar.searchTextField.textColor = [UIColor whiteColor];
    
    [self fetchMovies];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.MovieTableView insertSubview:self.refreshControl atIndex:0];
    
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=9596ade9fec9e21640df2dd903535372"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
               UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies"
                                              message:@"The Internet connection appears to be offline."
                                              preferredStyle:UIAlertControllerStyleAlert];
                
               UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault
                  handler:^(UIAlertAction * action) {}];
               [alert addAction:defaultAction];
               [self presentViewController:alert animated:YES completion:nil];
               [self.activityIndicator stopAnimating];
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

               NSLog(@"%@", dataDictionary);
               
               // TODO: Get the array of movies
               // TODO: Store the movies in a property to use elsewhere
               // TODO: Reload your table view data
               
               
               self.myArray = dataDictionary[@"results"];
               
               self.filteredData = self.myArray;
               
//               for (int i=0; i < sizeof(self.myArray); i++){
//                   NSLog(@"%@",self.myArray[i][@"title"]);
//               }
               
               [self.activityIndicator stopAnimating];
               [self.MovieTableView reloadData];
               
           }
        [self.refreshControl endRefreshing];
       }];
    [task resume];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    if (searchText.length != 0) {

        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSDictionary *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject[@"title"] containsString:searchText];
        }];
        self.filteredData = [self.myArray filteredArrayUsingPredicate:predicate];

    }
    else {
        self.filteredData = self.myArray;
    }

    [self.MovieTableView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.filteredData.count;
}

- (UITableViewCell *)tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieTableViewCell"];
    cell.titleLabel.text = self.filteredData[indexPath.row][@"title"];
    cell.synopsisLabel.text = self.filteredData[indexPath.row][@"overview"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", "https://image.tmdb.org/t/p/w500", self.filteredData[indexPath.row][@"poster_path"]]];
    [cell.posterImage setImageWithURL:url];
    
    return cell;
}



//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *myIndexPath = [self.MovieTableView indexPathForCell:sender];
    NSDictionary *dataToPass = self.filteredData[myIndexPath.row];
    DetailsViewController *detailVC = [segue destinationViewController];
    detailVC.detailDict = dataToPass;
}


@end
