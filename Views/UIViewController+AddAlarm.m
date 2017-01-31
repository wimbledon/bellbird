//
//  UIViewController+AddAlarm.m
//  Bellbird
//
//  Created by David Liu on 1/31/17.
//  Copyright © 2017 Handshake. All rights reserved.
//

#import "UIViewController+AddAlarm.h"
#import "SCLAlertView.h"
#import "BFExecutor.h"
#import "BBHttpClient.h"
#import "TWMessageBarManager.h"
#import "BBUtility.h"

@implementation UIViewController (AddAlarm)

- (void)presentAddAlarmViewWithCompletedBlock:(void (^)(BOOL isCompleted))completedBlock
{
    SCLAlertView *alert = [[SCLAlertView alloc] init];
    UIColor *tc = [BBUtility mainColor];
    
    UITextField *bodyField = [alert addTextField:NSLocalizedString(@"Enter Alarm Message", nil)];
    bodyField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    bodyField.tintColor = tc;
    
    [alert addButton:NSLocalizedString(@"Confirm",nil)
     validationBlock:^BOOL{
         bodyField.text = [bodyField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
         
         if (!bodyField.text.length)
         {
             [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Whoops!",nil)
                                         message:NSLocalizedString(@"You forgot to enter the alarm message.", nil)
                                        delegate:nil
                               cancelButtonTitle:NSLocalizedString(@"OK",nil)
                               otherButtonTitles:nil] show];
             [bodyField becomeFirstResponder];
             return NO;
         }
                  return YES;
     } actionBlock:^{
         BBHttpClient *client = [BBHttpClient sharedClient];
         [[client createAlarmWithBody:bodyField.text votes:0] continueWithExecutor:[BFExecutor mainThreadExecutor] withBlock:^id _Nullable(BFTask * _Nonnull t) {
             if (t.error) {
                 [[TWMessageBarManager sharedInstance] showMessageWithTitle:NSLocalizedString(@"Add Alarm Failed",nil)
                                                                description:@"Please try to add alarm again later."
                                                                       type:TWMessageBarMessageTypeError];
                 if (completedBlock) {
                     completedBlock(NO);
                 }
             }
             else {
                 [[TWMessageBarManager sharedInstance] showMessageWithTitle:NSLocalizedString(@"Add Alarm Successful",nil)
                                                                description:@"All users will be notified."
                                                                       type:TWMessageBarMessageTypeSuccess];
                 if (completedBlock) {
                     completedBlock(YES);
                 }
             }
             return nil;
         }];
     }];
    
    [alert showCustom:self
                image:[UIImage imageNamed:@"alarmIcon"]
                color:tc
                title:NSLocalizedString(@"Add Alarm", nil)
             subTitle:NSLocalizedString(@"All users will be notified with your alarm message.", nil)
     closeButtonTitle:NSLocalizedString(@"Cancel", nil)
             duration:0.0f];
}

@end
