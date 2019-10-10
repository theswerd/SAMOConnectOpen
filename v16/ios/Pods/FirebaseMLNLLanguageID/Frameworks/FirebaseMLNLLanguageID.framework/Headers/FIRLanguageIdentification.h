#import <Foundation/Foundation.h>

@class FIRIdentifiedLanguage;

NS_ASSUME_NONNULL_BEGIN

/** The BCP 47 language code for an undetermined language. */
extern NSString *const FIRMLKitUndeterminedLanguageCode
    NS_SWIFT_NAME(MLKitUndeterminedLanguageCode);

/**
 * A block that handles a language identification result.
 *
 * @param languageCode The identified language code for the text, `FIRMLKitUndeterminedLanguageCode`
 *     if no language was identified or `nil` if there was an error.
 * @param error The error or `nil`.
 */
typedef void (^FIRIdentifyLanguageCallback)(NSString *_Nullable languageCode,
                                            NSError *_Nullable error)
    NS_SWIFT_NAME(IdentifyLanguageCallback);

/**
 * A block that handles the result of identifying possible languages.
 *
 * @param identifiedLanguages The list of identified languages for the text (which may be a list
 *     with a single element if no languages were identified: a language code
 *     `FIRMLKitUndeterminedLanguageCode` with confidence 1), or `nil` in case of an error.
 * @param error The error or `nil`.
 */
typedef void (^FIRIdentifyPossibleLanguagesCallback)(
    NSArray<FIRIdentifiedLanguage *> *_Nullable identifiedLanguages, NSError *_Nullable error)
    NS_SWIFT_NAME(IdentifyPossibleLanguagesCallback);

/**
 * The `LanguageIdentification` class that identifies the main language or possible languages for
 * the given text.
 */
NS_SWIFT_NAME(LanguageIdentification)
@interface FIRLanguageIdentification : NSObject

/**
 * Unavailable.
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 * Identifies the main language for the given text.
 *
 * @param text The input text to use for identifying the language. Inputs longer than 200 characters
 *     are truncated to 200 characters, as longer input does not improve the detection accuracy.
 * @param completion Handler to call back on the main queue with the identified language code or
 *     error.
 */
- (void)identifyLanguageForText:(NSString *)text
                     completion:(FIRIdentifyLanguageCallback)completion
    NS_SWIFT_NAME(identifyLanguage(for:completion:));

/**
 * Identifies possible languages for the given text.
 *
 * @param text The input text to use for identifying the language. Inputs longer than 200 characters
 *     are truncated to 200 characters, as longer input does not improve the detection accuracy.
 * @param completion Handler to call back on the main queue with identified languages or error.
 */
- (void)identifyPossibleLanguagesForText:(NSString *)text
                              completion:(FIRIdentifyPossibleLanguagesCallback)completion
    NS_SWIFT_NAME(identifyPossibleLanguages(for:completion:));

@end

NS_ASSUME_NONNULL_END
