

#import <FirebaseMLNaturalLanguage/FirebaseMLNaturalLanguage.h>



@class FIRLanguageIdentification;
@class FIRLanguageIdentificationOptions;

NS_ASSUME_NONNULL_BEGIN

/** A category for `NaturalLanguage` that contains `LanguageIdentification` APIs. */
@interface FIRNaturalLanguage (LanguageID)

/**
 * Gets a language identification instance with the default options.
 *
 * @return A new instance of `LanguageIdentification` with the default options.
 */
- (FIRLanguageIdentification *)languageIdentification;

/**
 * Gets a language identification instance with the given options.
 *
 * @param options The options used for language identification.
 * @return A new instance of `LanguageIdentification` with the given options.
 */
- (FIRLanguageIdentification *)languageIdentificationWithOptions:
    (FIRLanguageIdentificationOptions *)options NS_SWIFT_NAME(languageIdentification(options:));

@end

NS_ASSUME_NONNULL_END
