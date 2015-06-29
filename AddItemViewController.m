//
//  AddItemViewController.m
//  Smoke Savings
//
//  Created by Kim on 28/06/15.
//  Copyright (c) 2015 Kim. All rights reserved.
//

#import "AddItemViewController.h"
#import "ProgressPhotoViewController.h"
#import "Item.h"
#import "NSDate+Helper.h"

@interface AddItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UIButton *addImageButton;
@property (strong, nonatomic) NSDate *date;

@property (strong, nonatomic) UIAlertView *alertView;

@property (weak, nonatomic) Item *item;
@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _date = [NSDate date];
    _dateTextField.text = [NSString stringWithFormat:@"%@", [_date returnFormattedDateString]];
    
    _item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[super managedObjectContext]];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(touch:)];
    
    [self.view addGestureRecognizer:recognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_item.imageOfItem) {
        [_addImageButton setBackgroundImage:[UIImage imageWithData:_item.imageOfItem] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dateFieldDidBeginEditing:(UITextField *)sender {
    //initialize a datepicker to act as the keyboard view for the date field.
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //check if the dietplan already has a date, if so, set the datepicker to it.
    sender.inputView = datePicker;
    
    _dateTextField.text = [NSString stringWithFormat:@"%@", [datePicker.date returnFormattedDateString]];
    
    _date = datePicker.date;
}

- (void)touch:(UITapGestureRecognizer *)recognizer {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)datePickerValueChanged:(UIDatePicker *)sender {
    _date = sender.date;
    _dateTextField.text = [NSString stringWithFormat:@"%@",[_date returnFormattedDateString]];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    if ([_nameTextField.text isEqualToString:@""] || [_priceTextField.text isEqualToString:@""]) {
        //show alert to indicate that there should be a name and a price
        
        NSString *message = @"De item moet een prijs en een naam hebben schatje ;)";
        
        self.alertView = [[UIAlertView alloc]initWithTitle:@""
                                                   message:message
                                                  delegate:self
                                         cancelButtonTitle:@"Oke"
                                         otherButtonTitles:nil, nil];
        
        [self.alertView show];
        
    } else {
        _item.name = _nameTextField.text;
        _item.date = _date;
        _item.price = [NSNumber numberWithFloat:[_priceTextField.text floatValue]];
        
        [self saveManagedObjectContext];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)cancelButtonPressed:(id)sender {
    [[self managedObjectContext] rollback];
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"addPhoto"]) {
        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
    
        ProgressPhotoViewController*editPhotoVC = (ProgressPhotoViewController *)navController.topViewController;
        
        editPhotoVC.addPhotoItem = _item;
    }
}

@end
