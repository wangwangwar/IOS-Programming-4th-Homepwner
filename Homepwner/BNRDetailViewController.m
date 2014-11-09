//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by wangwangwar on 14/11/6.
//  Copyright (c) 2014年 wangwangwar. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *SerialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailViewController

#pragma mark - Basic

- (void)setItem:(BNRItem *)item {
    _item = item;
    self.navigationItem.title = item.itemName;
}

#pragma mark - View

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.nameField.text = self.item.itemName;
    self.SerialNumberField.text = self.item.serialName;
    self.valueField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
    
    // make NSDateFormatter `static` for time-saving
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
    
    // Get image
    UIImage *image = [[BNRImageStore sharedStore] imageForKey:self.item.itemKey];
    // Put the image on the screen
    self.imageView.image = image;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // Save changes to item
    self.item.itemName = self.nameField.text;
    self.item.serialName = self.SerialNumberField.text;
    self.item.valueInDollars = [self.valueField.text intValue];
}

#pragma mark - Image Picker Controller Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // Store the image in the BNRImageStore for this key
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    // Put that image onto the screen in our image view
    self.imageView.image = image;
    
    // Take image picker off the screen -
    // you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Actions

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    
    // If the device has a camera, take a picture, otherwise,
    // just pick from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    
    // Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

@end
