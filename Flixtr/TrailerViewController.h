//
//  TrailerViewController.h
//  Flixtr
//
//  Created by Shreeya Indap on 6/17/22.
//

#import <UIKit/UIKit.h>
#import "WebKit/WKWebView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrailerViewController : UIViewController
@property (weak, nonatomic) IBOutlet WKWebView *webkitView;
@property (nonatomic, strong) NSDictionary *detailDict;

@end

NS_ASSUME_NONNULL_END
