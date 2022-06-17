//
//  TrailerViewController.m
//  Flixtr
//
//  Created by Shreeya Indap on 6/17/22.
//

#import "TrailerViewController.h"

@interface TrailerViewController ()

@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *getURL = [NSURL URLWithString:[NSString stringWithFormat: @"https://api.themoviedb.org/3/movie/%@/videos?api_key=9596ade9fec9e21640df2dd903535372&language=en-US", self.detailDict[@"id"]]];
    
   // NSLog(@"%@", getURL);
    
    NSURLRequest *request = [NSURLRequest requestWithURL:getURL cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               NSDictionary *dataResult = dataDictionary[@"results"][0];
               
               NSLog(@"%@", dataResult);
               
               NSString *urlString = [@"https://www.youtube.com/watch?v=" stringByAppendingString: dataResult[@"key"]];
               
               NSURL *url = [NSURL URLWithString: urlString];
               
               NSLog(@"%@", url);
            
               NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
                      
               [self.webkitView loadRequest:request];
               
           }
    }];
    [task resume];
    
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
