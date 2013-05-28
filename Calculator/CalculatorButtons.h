//
//  CalculatorButtons.h
//  Calculator
//
//  Created by Nick Johnson on 5/28/13.
//  Copyright (c) 2013 Nick Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorButtons : NSObject
@property (strong, nonatomic)UIView *calculatorView;

- (UIButton *)numberButtonFromNumber:(NSUInteger)number;
- (UIButton *)operationButtonFromOperation:(NSString *)operation; // like x, ÷, +, -.

- (UIButton *)dotButton;
- (UIButton *)equalsButton;
- (UIButton *)plusMinusButton;
- (UIButton *)clearButton;

- (UIButton *)memClearButton;
- (UIButton *)memOperationButtonFromOperation:(NSString *)operation; // m+ or m-
- (UIButton *)memRecallButton;

@end
