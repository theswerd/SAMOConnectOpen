#import <Foundation/Foundation.h>

@class FIRApp;

NS_ASSUME_NONNULL_BEGIN

/**
 * A Firebase service that supports natural language APIs.
 */
NS_SWIFT_NAME(NaturalLanguage)
@interface FIRNaturalLanguage : NSObject

/**
 * Whether stats collection for the ML Kit Natural Language module is enabled. The stats include API
 * call counts, errors, API call durations, etc. No personally identifiable information is logged.
 * The default value is `true`.
 *
 * <p>The setting is per `FirebaseApp` and per `NaturalLanguage` instance, and is persistent across
 * launches of the app. If the user uninstalls the app or clears the app data, the setting will be
 * reset to `true`. The best practice is to set the flag for each `NaturalLanguage` instance.
 */
@property(nonatomic, getter=isStatsCollectionEnabled) BOOL statsCollectionEnabled;

/**
 * Gets an instance of Firebase `NaturalLanguage` service for the default Firebase app.  This method
 * is thread safe.  The default Firebase app instance must be configured before calling this method;
 * otherwise raises `FIRAppNotConfigured` exception.
 *
 * @return A Firebase `NaturalLanguage` service instance, initialized with the default Firebase app.
 */
+ (instancetype)naturalLanguage NS_SWIFT_NAME(naturalLanguage());

/**
 * Gets an instance of Firebase `NaturalLanguage` service for the custom Firebase app.  This method
 * is thread safe.
 *
 * @param app The custom Firebase app used for initialization.  Raises `FIRAppInvalid` exception if
 *     `app` is nil.
 * @return A Firebase `NaturalLanguage` service instance, initialized with the custom Firebase app.
 */
+ (instancetype)naturalLanguageForApp:(FIRApp *)app NS_SWIFT_NAME(naturalLanguage(app:));

/**
 * Not available. Please use the factory method instead, `NaturalLanguage.naturalLanguage()`.
 */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
