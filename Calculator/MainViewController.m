//
//  MainViewController.m
//  Calculator
//
//  Created by Nick Johnson on 5/28/13.
//  Copyright (c) 2013 Nick Johnson. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, OperatorType){
    OperatorTypeAdd = 0,
    OperatorTypeSubtract,
    OperatorTypeDivide,
    OperatorTypeMultiply
};

@interface MainViewController ()
@property (nonatomic, strong) NSMutableString *leftOperand;
@property (nonatomic, strong) NSMutableString *rightOperand;
@property (nonatomic, assign) BOOL hasOperator;
@property (weak, nonatomic) IBOutlet UILabel *outputTextField;
@property (nonatomic, assign) OperatorType currentOperator;
@property (nonatomic, assign) BOOL hasTappedEqualButton;
@property (nonatomic, assign) NSInteger memoryValue;
@property (nonatomic, assign) BOOL hasNumberButtonTapped;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self clearTapped:nil];
    self.outputTextField.layer.cornerRadius=6.0;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}
- (IBAction)clearTapped:(id)sender {
    self.outputTextField.text = @"0";
    self.hasOperator = NO;
    self.leftOperand = [NSMutableString new];
    self.rightOperand = [NSMutableString new];

}
-(void)appendValue:(NSInteger)value{
    NSString *stringValue = [NSString stringWithFormat:@"%i", value];
    if (self.hasOperator) {
        [self.rightOperand appendString:stringValue];
        self.outputTextField.text=self.rightOperand;
    } else {
        [self.leftOperand appendString:stringValue];
        self.outputTextField.text=self.leftOperand;
    }
    
}
- (IBAction)numberButtonTapped:(UIButton *)sender {
    [self appendValue:sender.tag];
    self.hasNumberButtonTapped = YES;
}


- (IBAction)equalButton:(id)sender {
    NSLog(@"=");
    NSInteger leftNumber = [self.leftOperand integerValue];
    NSInteger rightNumber = [self.rightOperand integerValue];
    NSInteger total = 0;
    NSLog(@"left number is %i", leftNumber);
    NSLog(@"right number is %i", rightNumber);
    
    switch (self.currentOperator) {
        case OperatorTypeAdd:
            total = leftNumber + rightNumber;
            break;
        case OperatorTypeSubtract:
            total = leftNumber - rightNumber;
            break;
        case OperatorTypeDivide:
            if (rightNumber!=0) {
               total = leftNumber / rightNumber;
            } else {
                self.outputTextField.text = @"Error";
            }
            break;
        case OperatorTypeMultiply:
            total = leftNumber * rightNumber;
            if (rightNumber == 0) {
                total = leftNumber * leftNumber;
            }
            break;
    }
    
    self.outputTextField.text = [NSString stringWithFormat:@"%i", total];
    self.leftOperand = [NSMutableString stringWithString:self.outputTextField.text];
}

- (void)configureOperator:(OperatorType)operatorType {
    self.hasOperator = YES;
    self.currentOperator = operatorType;
    self.rightOperand = [NSMutableString new];
}

- (IBAction)plusButton:(id)sender {
     NSLog(@"+");
     [self configureOperator:OperatorTypeAdd];
}


- (IBAction)subtractButton:(id)sender {
    NSLog(@"-");
    [self configureOperator:OperatorTypeSubtract];
}

- (IBAction)multiplybutton:(id)sender {
     NSLog(@"X" );
     [self configureOperator:OperatorTypeMultiply];
}

- (IBAction)divideButton:(id)sender {
     NSLog(@"/");
     [self configureOperator:OperatorTypeDivide];
}

- (IBAction)plusMinusButton:(id)sender {
     NSLog(@"+-");
     NSInteger textNumber = [self.outputTextField.text integerValue];
     textNumber = textNumber * -1;
     self.outputTextField.text = [NSString stringWithFormat:@"%i",textNumber];
     self.leftOperand = [self.outputTextField.text mutableCopy];
}

- (IBAction)pointButton:(id)sender {
     NSLog(@".");
}



- (IBAction)memoryClearButton:(id)sender {
     NSLog(@"mc");
     self.memoryValue = 0;
     self.leftOperand = [NSMutableString new];
     self.rightOperand = [NSMutableString new];

}

- (IBAction)addMemoryButton:(id)sender {
     NSLog(@"m+");
     self.memoryValue += [self.outputTextField.text integerValue];
     self.leftOperand = [NSMutableString new];
     self.rightOperand = [NSMutableString new];


}
 
- (IBAction)subtractMemoryButton:(id)sender {
     NSLog(@"m-");
     if (self.memoryValue != 0){
         self.memoryValue -= [self.outputTextField.text integerValue];
 
     }
     self.leftOperand = [NSMutableString new];
     self.rightOperand = [NSMutableString new];
}

- (IBAction)recallMemoryButton:(id)sender {
     NSLog(@"mr");
     self.outputTextField.text = [NSString stringWithFormat:@"%i",self.memoryValue];
     if (self.hasOperator ) {
        self.rightOperand = [[NSString stringWithFormat:@"%i",self.memoryValue] mutableCopy];
     }else {
         self.leftOperand = [[NSString stringWithFormat:@"%i",self.memoryValue] mutableCopy];
     }
    if (self.hasNumberButtonTapped == YES){
        self.leftOperand = [NSMutableString new];
        self.rightOperand = [NSMutableString new];
    }
        
        
}
@end
