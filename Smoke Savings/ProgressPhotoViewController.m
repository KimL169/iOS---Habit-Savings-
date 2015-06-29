//
//  ProgressPhotoViewController.m
//  GymRegime
//
//  Created by Kim on 29/05/14.
//  Copyright (c) 2014 Kim. All rights reserved.
//

#import "ProgressPhotoViewController.h"

@interface ProgressPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *selectPhotoButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *removePhotoButton;

@end

@implementation ProgressPhotoViewController

@synthesize addPhotoItem;


- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(UIButton *)sender {

    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)removePhoto:(UIButton *)sender {
    self.addPhotoItem.imageOfItem = nil;
    [self saveManagedObjectContext];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (IBAction)save:(UIBarButtonItem *)sender {
    
    NSData *imageData = UIImagePNGRepresentation(self.imageView.image);
    self.addPhotoItem.imageOfItem = imageData;
    
//    [self saveManagedObjectContext];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showImage {
    
    if (self.addPhotoItem.imageOfItem) {

        UIImage *image = [UIImage imageWithData:self.addPhotoItem.imageOfItem];
        self.imageView.image = image;

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //if the user has already set an image, show it.
    [self showImage];
    
    if (self.addPhotoItem.imageOfItem == nil) {
        _removePhotoButton.userInteractionEnabled = NO;
        _removePhotoButton.tintColor = [UIColor lightGrayColor];
    }
    
    //check if the user's device has a camera, if not, disable the takePicture button.
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        //disable the takePhoto button so a crash won't occur.
        self.takePhotoButton.userInteractionEnabled = NO;
        self.takePhotoButton.tintColor = [UIColor lightGrayColor];
    }
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
