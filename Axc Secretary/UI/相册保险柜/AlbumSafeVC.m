//
//  AlbumSafeVC.m
//  Axc Secretary
//
//  Created by AxcLogo on 2018/10/30.
//  Copyright © 2018 AxcLogo. All rights reserved.
//

#import "AlbumSafeVC.h"

#import <WebKit/WebKit.h>

@interface AlbumSafeVC ()
@property(nonatomic , strong)WKWebView *webView;
@end

@implementation AlbumSafeVC

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSString *path = [[NSBundle mainBundle] pathForResource:@"paipai" ofType:@"jpeg"];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"paipai" ofType:@"jpeg"];
    NSData *imageData=[NSData dataWithContentsOfFile:imagePath];//imagePath :沙盒图片路径
    if (!imageData) {
        imageData = UIImagePNGRepresentation([UIImage imageNamed:@"paipai.jpeg"]);
    }
    NSString *imageSource = [NSString stringWithFormat:@"data:image/png;base64,%@",[imageData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed]];
    
    [self.webView loadHTMLString:[NSString stringWithFormat:@"<img src = \"%@\" width=\"100%%\">",imageSource] baseURL:nil];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
}

- (WKWebView *)webView{
    if (!_webView) {
        _webView = [WKWebView new];
        [self.view addSubview:_webView];
    }
    return _webView;
}


@end
