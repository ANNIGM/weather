//
//  IndexDetailViewController.m
//  weather
//
//  Created by IndusGoo on 2016/11/30.
//  Copyright © 2016年 Annie. All rights reserved.
//

#import "IndexDetailViewController.h"

@interface IndexDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation IndexDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ANColor(154, 186, 189);
    self.detailLabel.text = self.indexMode.details;
    self.imageView.image = [UIImage imageNamed:self.indexMode.code];
    // Do any additional setup after loading the view from its nib.
//    self.view.backgroundColor = [UIColor clearColor];
}

- (void)setIndexMode:(IndexMode *)indexMode
{
    _indexMode = indexMode;
}
- (IBAction)cancelButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
