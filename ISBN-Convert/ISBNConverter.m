//
//  ProductToISBNConverter.m
//  ISBN-Convert
//
//  Created by Joshua Endter on 1/9/22.
//

#import "ISBNConverter.h"

@implementation ISBNConverter

// Possible improvements:
// - Returning the error if a validation has failed (eg. Swift enums conforming to Error / NSError objects)
+ (nullable NSString *)isbnFromProductID:(NSString *)productID;
{
    // product ids must be 12 digits
    if (productID.length != 12) {
        return nil;
    }
    
    // only numbers allowed
    NSCharacterSet* digitsOnly = [NSCharacterSet decimalDigitCharacterSet];
    if ([productID rangeOfCharacterFromSet:[digitsOnly invertedSet]].location != NSNotFound) {
        return nil;
    }
    
    NSString *baseISBN = [productID substringFromIndex:3];
    NSString *errorDetectionDigit = [self errorDetectionDigitFor: baseISBN];
    NSString *isbn = [baseISBN stringByAppendingString:errorDetectionDigit];
    return isbn;
}

+ (NSString *)errorDetectionDigitFor:(nonnull NSString *)baseISBN;
{
    int total = 0;
    for (int i = 0; i < baseISBN.length; i++) {
        NSString *substringAtIndex = [baseISBN substringWithRange:NSMakeRange(i, 1)];
        total += [substringAtIndex intValue] * (10 - i);
    }
    
    int errorControl = 11 - (total % 11);
    switch (errorControl) {
        case 11:
            return @"0";
            break;
        case 10:
            return @"x";
            break;
        default:
            return [NSString stringWithFormat:@"%d", errorControl];
            break;
    }
}

@end
