
#import <FirebaseMLCommon/FIRModelManager.h>
#import <FirebaseMLNLTranslate/FIRTranslateLanguage.h>


@class FIRApp;
@class FIRModelDownloadConditions;
@class FIRTranslateRemoteModel;

NS_ASSUME_NONNULL_BEGIN

/**
 * Extensions to `ModelManager` for Translate-specific functionality.
 */
@interface FIRModelManager (Translate)

/**
 * Deletes the downloaded translate remote model.
 *
 * @discussion Translator instances need models for both languages involved in the translation.
 *     Deleting a language will make all Translator instances having that language as a source or
 *     target inoperable (unless the instance has already been used for translation, in which case
 *     it will keep working until process exit).
 * @discussion Deleting built-in models (currently only English) does nothing and completes
 *     successfully.
 *
 * @param remoteModel Which model to delete locally.
 * @param completion Called back on success (error is nil) or failure.
 */
- (void)deleteDownloadedTranslateModel:(FIRTranslateRemoteModel *)remoteModel
                            completion:(void (^)(NSError *_Nullable error))completion
    NS_SWIFT_NAME(deleteDownloadedTranslateModel(_:completion:));

/**
 * Retrieves a set of already-downloaded translate models (including built-in models, currently
 * only English) for the given Firebase app. These models can be then deleted through
 * `deleteDownloadedTranslateModel:completion:` API to manage disk space.
 *
 * @param app The Firebase app.
 * @return a set of all currently available language models.
 */
- (NSSet<FIRTranslateRemoteModel *> *)availableTranslateModelsWithApp:(FIRApp *)app
    NS_SWIFT_NAME(availableTranslateModels(app:));

@end

NS_ASSUME_NONNULL_END
