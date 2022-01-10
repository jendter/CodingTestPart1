//
//  ViewController.m
//  ISBN-Convert
//
//  Created by Joshua Endter on 1/9/22.
//

#import "ViewController.h"
#import "ISBNConverter.h"

@interface ViewController ()

@property (strong, nonatomic) UITextField *productIDTextField;
@property (strong, nonatomic) UILabel *isbnLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *container = [[UIView alloc] init];
    self.productIDTextField = [[UITextField alloc] init];
    self.productIDTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.productIDTextField.clearButtonMode =  UITextFieldViewModeWhileEditing;
    self.productIDTextField.placeholder = @"Product ID #";
    self.productIDTextField.delegate = self;
    self.isbnLabel = [[UILabel alloc] init];
    
    [self.view addSubview:container];
    [container addSubview:self.productIDTextField];
    [container addSubview:self.isbnLabel];
    
    container.translatesAutoresizingMaskIntoConstraints = NO;
    self.productIDTextField.translatesAutoresizingMaskIntoConstraints = NO;
    self.isbnLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:@[
        [container.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:16],
        [container.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16],
        [container.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16],
        
        [self.productIDTextField.topAnchor constraintEqualToAnchor:container.topAnchor],
        [self.productIDTextField.leadingAnchor constraintEqualToAnchor:container.leadingAnchor],
        [self.productIDTextField.trailingAnchor constraintEqualToAnchor:container.trailingAnchor],
        
        [self.isbnLabel.topAnchor constraintEqualToAnchor:self.productIDTextField.bottomAnchor constant:8],
        [self.isbnLabel.leadingAnchor constraintEqualToAnchor:container.leadingAnchor],
        [self.isbnLabel.trailingAnchor constraintEqualToAnchor:container.trailingAnchor],
        [self.isbnLabel.bottomAnchor constraintEqualToAnchor:container.bottomAnchor]
    ]];
    
    [self productIDUpdated:self.productIDTextField.text];
}

- (void)productIDUpdated:(NSString *)productID;
{    
    NSString *isbn = [ISBNConverter isbnFromProductID:productID];
    self.isbnLabel.text = [NSString stringWithFormat:@"ISBN: %@", isbn ? isbn : @""];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *productID = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    // Product IDs are 12 characters
    if (productID.length > 12) {
        return NO;
    }
    
    // Update UI
    dispatch_async(dispatch_get_main_queue(), ^{
        [self productIDUpdated:productID];
    });
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    // Update UI
    dispatch_async(dispatch_get_main_queue(), ^{
        [self productIDUpdated:@""];
    });
    
    return YES;
}

@end
