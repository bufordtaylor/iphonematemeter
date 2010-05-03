//
//  AddProfileForm.m
//  matemeter
//
//  Created by Buford Taylor on 5/1/10.
//  Copyright 2010 Buford Taylor. All rights reserved.
//

#import "AddProfileForm.h"
#import "Services.h"
#import "DataManager.h"
#import "ApiManager.h"
#import "LoadingView.h"

@implementation AddProfileForm

-(void) dealloc {	
	[dataFailurePopup release];
	[doneButton release];
	[loadingView release];
	[super dealloc];
}

-(void)showError:(NSString*)title msg:(NSString*)msg {
	[dataFailurePopup release];
	dataFailurePopup = [[UIAlertView alloc] initWithTitle:title 
												  message:msg 
												 delegate:self 
										cancelButtonTitle:nil 
										otherButtonTitles:@"OK", nil];
	[dataFailurePopup show];
}


- (void)viewDidLoad {
	
	// create custom button
	doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
	doneButton.tag = 99;
	doneButton.frame = CGRectMake(0, 163, 106, 53);
	doneButton.adjustsImageWhenHighlighted = NO;
	[doneButton setImage:[UIImage imageNamed:@"doneup.png"] forState:UIControlStateNormal];
	[doneButton setImage:[UIImage imageNamed:@"downdown.png"] forState:UIControlStateHighlighted];
	[doneButton addTarget:self action:@selector(tapDone) forControlEvents:UIControlEventTouchUpInside];
	[doneButton retain];
	
	nameInput.textAlignment = UITextAlignmentRight;
	nameInput.keyboardType = UIKeyboardTypeEmailAddress;
	nameInput.keyboardAppearance = UIKeyboardAppearanceDefault;
	nameInput.placeholder = @"name@example.com";
	nameInput.text = [[[Services services] dm] username];
	[nameInput setDelegate:self];
	
	pwInput.textAlignment = UITextAlignmentRight;
	pwInput.keyboardType = UIKeyboardTypeAlphabet;
	pwInput.keyboardAppearance = UIKeyboardAppearanceDefault;
	pwInput.secureTextEntry = YES;
	pwInput.placeholder = @"secret";
	pwInput.text = [[[Services services] dm] password];
	[pwInput setDelegate:self];
	
    [super viewDidLoad];
}

- (void)cancelInsert {
	[self dismissModalViewControllerAnimated:YES];
}

- (void)completeInsert {
	
	if ([[nameInput.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] <= 0) {
		[self showError:@"Missing Field" msg:@"Please Enter an Email"];
		return;
	}
	if ([[pwInput.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] <= 0) {
		[self showError:@"Missing Field" msg:@"Please Enter a Password"];
		return;
	}
	
	NSString* emailText = nameInput.text;
	NSString* pwText = pwInput.text;
	NSLog(@"uid = %@", [[[Services services] dm] uid]);
	[[[Services services] am] APIAddProfile:self username:emailText password:pwText uid:[[[Services services] dm] uid]];
	
	loadingView = [LoadingView loadingViewInView:[self.view.window.subviews objectAtIndex:0] withMsg:@"Verifying..."];
}


- (void)keyboardWillShow:(NSNotification *)notif
{
	UIWindow* tempWindow = [[[UIApplication sharedApplication] windows] objectAtIndex:1];
	for(int i=0; i<[tempWindow.subviews count]; i++) {
		if (doneButton.tag == 99) {
			[doneButton removeFromSuperview];
		}
	}

}

-(void) tapDone {
	[nameInput resignFirstResponder];
	[pwInput resignFirstResponder];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[pwInput resignFirstResponder];
	[nameInput resignFirstResponder];
	return YES;
	
}
- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification object:self.view.window]; 
}

- (void)viewWillDisappear:(BOOL)animated
{
	// unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil]; 
}

-(void) success {
	DataManager* dm = [[Services services] dm];
	[dm storeUser:nameInput.text pass:pwInput.text];
	[self dismissModalViewControllerAnimated:YES];
}

-(void) failure:(NSString*)msg {
	[loadingView performSelector:@selector(removeView) withObject:nil afterDelay:0.5];
	NSLog(@"Failed api call: %@", msg);
	UIAlertView* loginFailurePopup = [[UIAlertView alloc] initWithTitle:@"Could not save profile" 
												   message:msg 
												  delegate:self 
										 cancelButtonTitle:nil 
										 otherButtonTitles:@"OK", nil];
	[loginFailurePopup show];
	[loginFailurePopup release];
}


@end
