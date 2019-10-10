#import <Foundation/Foundation.h>

@class FIRModelDownloadConditions;

NS_ASSUME_NONNULL_BEGIN

/**
 * A block to invoke after ensuring that translate model files are downloaded.
 *
 * @param error The error or `nil`.
 */
typedef void (^FIRTranslatorDownloadModelIfNeededCallback)(NSError *_Nullable error)
    NS_SWIFT_NAME(TranslatorDownloadModelIfNeededCallback);

/**
 * A block containing the translation result or `nil` if there's an error.
 *
 * @param result A translation result for the text or `nil` if there's an error.
 * @param error The error or `nil`.
 */
typedef void (^FIRTranslatorCallback)(NSString *_Nullable result, NSError *_Nullable error)
    NS_SWIFT_NAME(TranslatorCallback);

/** A class that translates the given input text. */
NS_SWIFT_NAME(Translator)
@interface FIRTranslator : NSObject

/** Unavailable. */
- (instancetype)init NS_UNAVAILABLE;

/**
 * Translates the given text from the source language into the target language.
 *
 * @discussion This method will return an error if the model files have not been downloaded.
 *
 * @param text A string in the source language.
 * @param completion Handler to call back on the main queue with the translation result or error.
 */
- (void)translateText:(NSString *)text
           completion:(FIRTranslatorCallback)completion NS_SWIFT_NAME(translate(_:completion:));

/**
 * Downloads the model files required for translation, if they are not already downloaded.
 *
 * @param completion Handler to call back on the main queue with an error, if any.
 */
- (void)downloadModelIfNeededWithCompletion:(FIRTranslatorDownloadModelIfNeededCallback)completion;

/**
 * Downloads the model files required for translation when the given conditions are met. If model
 * has already been downloaded, completes without additional work.
 *
 * @param conditions The downloading conditions for the translate model.
 * @param completion Handler to call back on the main queue with an error, if any.
 */
- (void)downloadModelIfNeededWithConditions:(FIRModelDownloadConditions *)conditions
                                 completion:(FIRTranslatorDownloadModelIfNeededCallback)completion;

@end

NS_ASSUME_NONNULL_END
