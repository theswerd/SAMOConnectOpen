#import <Foundation/Foundation.h>


#import <FirebaseMLNLTranslate/FIRTranslateLanguage.h>


NS_ASSUME_NONNULL_BEGIN

/** Options for `Translator`. */
NS_SWIFT_NAME(TranslatorOptions)
@interface FIRTranslatorOptions : NSObject

/** The source language of the input. */
@property(nonatomic, readonly) FIRTranslateLanguage sourceLanguage;

/** The target language to translate the input into. */
@property(nonatomic, readonly) FIRTranslateLanguage targetLanguage;

/**
 * Creates a new instance of translator options with the given source and target languages.
 *
 * @param sourceLanguage The source language for the translator.
 * @param targetLanguage The target language for the translator.
 * @return A new instance of `TranslatorOptions` with the given source and target language.
 */
- (instancetype)initWithSourceLanguage:(FIRTranslateLanguage)sourceLanguage
                        targetLanguage:(FIRTranslateLanguage)targetLanguage
    NS_DESIGNATED_INITIALIZER;

/** UNAVAILABLE */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
