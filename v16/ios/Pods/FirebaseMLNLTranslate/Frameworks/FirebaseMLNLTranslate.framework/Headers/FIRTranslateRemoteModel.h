#import <Foundation/Foundation.h>


#import <FirebaseMLCommon/FIRRemoteModel.h>
#import <FirebaseMLNLTranslate/FIRTranslateLanguage.h>


@class FIRApp;
NS_ASSUME_NONNULL_BEGIN

/** A translate model that is stored remotely on the server and downloaded on the device. */
NS_SWIFT_NAME(TranslateRemoteModel)
@interface FIRTranslateRemoteModel : FIRRemoteModel

/** The language associated with this model. */
@property(nonatomic, readonly) FIRTranslateLanguage language;

/**
 * Gets an instance of `TranslateRemoteModel` configured with the given language, the default
 * Firebase App and the default downloading conditions. This model can be used to trigger a download
 * by calling `download(_:)` API from `ModelManager`.
 *
 * @discussion `TranslateRemoteModel` uses `ModelManager` internally. When downloading
 * `TranslateRemoteModel`s, there will be a notification posted for an internal `RemoteModel`. When
 * listening to the notifications for a `TranslateRemoteModel` you need to check the model object is
 * a `TranslateRemoteModel` before using it. Otherwise you may try to use the internal RemoteModel
 * as a TranslateRemoteModel.
 *
 * @param language The given language.
 * @return A `TranslateRemoteModel` instance.
 */
+ (FIRTranslateRemoteModel *)translateRemoteModelWithLanguage:(FIRTranslateLanguage)language
    NS_SWIFT_NAME(translateRemoteModel(language:));

/**
 * Gets an instance of `TranslateRemoteModel` configured with the given language, the given Firebase
 * App and the given downloading conditions.
 *
 * @param app The Firebase app.
 * @param language The given language.
 * @param conditions The downloading conditions for the translate model.
 * @return A `TranslateRemoteModel` instance.
 */
+ (FIRTranslateRemoteModel *)translateRemoteModelForApp:(FIRApp *)app
                                               language:(FIRTranslateLanguage)language
                                             conditions:(FIRModelDownloadConditions *)conditions
    NS_SWIFT_NAME(translateRemoteModel(app:language:conditions:));

/** UNAVAILABLE */
- (instancetype)init NS_UNAVAILABLE;

/** UNAVAILABLE: TranslateRemoteModels cannot be initialized explicitly. */
- (instancetype)initWithName:(NSString *)name
          allowsModelUpdates:(BOOL)allowsModelUpdates
           initialConditions:(FIRModelDownloadConditions *)initialConditions
            updateConditions:(nullable FIRModelDownloadConditions *)updateConditions NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
