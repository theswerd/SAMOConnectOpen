#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** An identified language for the given input text. */
NS_SWIFT_NAME(IdentifiedLanguage)
@interface FIRIdentifiedLanguage : NSObject

/** The BCP-47 language code for the language. */
@property(nonatomic, readonly, copy) NSString *languageCode;

/** The confidence score of the language. */
@property(nonatomic, readonly) float confidence;

/** Unavailable. */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
