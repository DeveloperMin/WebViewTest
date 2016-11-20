//
//  ViewController.m
//  WebViewTest
//
//  Created by 李兴民 on 16/11/3.
//  Copyright © 2016年 李兴民. All rights reserved.
//

#import "ViewController.h"
#import "MGTemplateEngine.h"
#import "ICUTemplateMatcher.h"
#import "GRMustacheTemplate.h"

@interface ViewController ()<MGTemplateEngineDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test3];
}

- (void)test2 {
    GRMustacheTemplate *demoTemplate = [GRMustacheTemplate templateFromContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sample2" ofType:@"html"] error:nil];
    
    NSDictionary *objectToRender = @{@"name": @"Chris",
@"value": @10000,
                                     @"taxed_value": @ (10000 - (10000 * 0.4)),
                                     @"in_ca": @(true)
                                     };
    
    NSString *htmlString = [demoTemplate renderObject:objectToRender error:nil];
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

- (void)test1 {
    // 第二种MGTemplateEngine
    MGTemplateEngine *engine = [MGTemplateEngine templateEngine];
    [engine setDelegate:self];
    [engine setMatcher:[ICUTemplateMatcher matcherWithTemplateEngine:engine]];
    NSString *templatePath = [[NSBundle mainBundle] pathForResource:@"sample" ofType:@"html"];
    NSDictionary *variables = [NSDictionary dictionaryWithObjectsAndKeys:@"limmy", @"title",@"limmy", @"author", @"2016-10-11", @"date", @"你好limmy", @"content" ,@"icon.png",@"imagePath", nil];
    NSLog(@"%@", variables);
    // 第一种赋值方式
    //    [engine setObject:@"limmy" forKey:@"title"];
    //    [engine setObject:@"limmy" forKey:@"author"];
    //    [engine setObject:@"2016-10-11" forKey:@"date"];
    //    [engine setObject:@"你好limmy" forKey:@"content"];
    //    NSString *htmlString = [engine processTemplateInFileAtPath:templatePath withVariables:nil];
    
    // 第二种赋值方式
    // Process the template and display the results.
    NSString *htmlString = [engine processTemplateInFileAtPath:templatePath withVariables:variables];
    
    NSLog(@"Processed template:\r%@", htmlString);
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test3 {
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

@end
