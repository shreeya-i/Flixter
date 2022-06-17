//
//  DetailsViewController.m
//  Flixtr
//
//  Created by Shreeya Indap on 6/16/22.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleDetail.text = self.detailDict[@"title"];
    self.synopsisDetail.text = self.detailDict[@"overview"];
    self.dateDetail.text = self.detailDict[@"release_date"];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%s/%@", "https://image.tmdb.org/t/p/w500", self.detailDict[@"poster_path"]]];
    [self.posterDetail setImageWithURL:url];
    
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _posterDetail.frame.size.width, _posterDetail.frame.size.height)];
    [overlay setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    [_posterDetail addSubview:overlay];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
