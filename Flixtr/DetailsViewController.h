//
//  DetailsViewController.h
//  Flixtr
//
//  Created by Shreeya Indap on 6/16/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *dateDetail;
@property (weak, nonatomic) IBOutlet UILabel *titleDetail;
@property (weak, nonatomic) IBOutlet UILabel *synopsisDetail;
@property (weak, nonatomic) IBOutlet UIImageView *posterDetail;
@property (nonatomic, strong) NSDictionary *detailDict;
@end

NS_ASSUME_NONNULL_END
