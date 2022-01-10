//
//  ProductIDToISBNConverter.h
//  ISBN-Convert
//
//  Created by Joshua Endter on 1/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ISBNConverter : NSObject

/// Convert Product ID to ISBN
+ (nullable NSString *)isbnFromProductID:(NSString *)productID;

@end

NS_ASSUME_NONNULL_END
