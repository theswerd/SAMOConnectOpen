

#import <FirebaseMLNaturalLanguage/FirebaseMLNaturalLanguage.h>



@class FIRTranslateModelManager;
@class FIRTranslator;
@class FIRTranslatorOptions;

NS_ASSUME_NONNULL_BEGIN

@interface FIRNaturalLanguage (Translate)

/**
 * Gets a `Translator` instance for the specified options. This method is thread safe.
 *
 * @param options The options for the translator.
 * @return A `Translator` instance that provides translation with the given options.
 */
- (FIRTranslator *)translatorWithOptions:(FIRTranslatorOptions *)options
    NS_SWIFT_NAME(translator(options:));

@end

NS_ASSUME_NONNULL_END
