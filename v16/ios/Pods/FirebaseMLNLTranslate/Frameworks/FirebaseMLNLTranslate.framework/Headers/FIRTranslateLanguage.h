#import <Foundation/Foundation.h>

#if defined __cplusplus
extern "C" {
#endif  // __cplusplus

NS_ASSUME_NONNULL_BEGIN

/**
 * This enum specifies the languages that are supported by `Translator`.
 *
 * Note that if and when languages are added / removed, we would like to keep the existing
 * enum values - hence specifying exactly even if they match defaults.
 *
 * Next available enum = 59.
 */
typedef NS_ENUM(NSUInteger, FIRTranslateLanguage) {
  /* Afrikaans. */ FIRTranslateLanguageAF NS_SWIFT_NAME(af) = 0,
  /* Arabic. */ FIRTranslateLanguageAR NS_SWIFT_NAME(ar) = 1,
  /* Belarusian. */ FIRTranslateLanguageBE NS_SWIFT_NAME(be) = 2,
  /* Bulgarian. */ FIRTranslateLanguageBG NS_SWIFT_NAME(bg) = 3,
  /* Bengali. */ FIRTranslateLanguageBN NS_SWIFT_NAME(bn) = 4,
  /* Catalan. */ FIRTranslateLanguageCA NS_SWIFT_NAME(ca) = 5,
  /* Czech. */ FIRTranslateLanguageCS NS_SWIFT_NAME(cs) = 6,
  /* Welsh. */ FIRTranslateLanguageCY NS_SWIFT_NAME(cy) = 7,
  /* Danish. */ FIRTranslateLanguageDA NS_SWIFT_NAME(da) = 8,
  /* German. */ FIRTranslateLanguageDE NS_SWIFT_NAME(de) = 9,
  /* Greek. */ FIRTranslateLanguageEL NS_SWIFT_NAME(el) = 10,
  /* English. */ FIRTranslateLanguageEN NS_SWIFT_NAME(en) = 11,
  /* Esperanto. */ FIRTranslateLanguageEO NS_SWIFT_NAME(eo) = 12,
  /* Spanish. */ FIRTranslateLanguageES NS_SWIFT_NAME(es) = 13,
  /* Estonian. */ FIRTranslateLanguageET NS_SWIFT_NAME(et) = 14,
  /* Persian. */ FIRTranslateLanguageFA NS_SWIFT_NAME(fa) = 15,
  /* Finnish. */ FIRTranslateLanguageFI NS_SWIFT_NAME(fi) = 16,
  /* French. */ FIRTranslateLanguageFR NS_SWIFT_NAME(fr) = 17,
  /* Irish. */ FIRTranslateLanguageGA NS_SWIFT_NAME(ga) = 18,
  /* Galician. */ FIRTranslateLanguageGL NS_SWIFT_NAME(gl) = 19,
  /* Gujarati. */ FIRTranslateLanguageGU NS_SWIFT_NAME(gu) = 20,
  /* Hebrew. */ FIRTranslateLanguageHE NS_SWIFT_NAME(he) = 21,
  /* Hindi. */ FIRTranslateLanguageHI NS_SWIFT_NAME(hi) = 22,
  /* Croatian. */ FIRTranslateLanguageHR NS_SWIFT_NAME(hr) = 23,
  /* Haitian. */ FIRTranslateLanguageHT NS_SWIFT_NAME(ht) = 24,
  /* Hungarian. */ FIRTranslateLanguageHU NS_SWIFT_NAME(hu) = 25,
  /* Indonesian. */ FIRTranslateLanguageID NS_SWIFT_NAME(id) = 26,
  /* Icelandic. */ FIRTranslateLanguageIS NS_SWIFT_NAME(is) = 27,
  /* Italian. */ FIRTranslateLanguageIT NS_SWIFT_NAME(it) = 28,
  /* Japanese. */ FIRTranslateLanguageJA NS_SWIFT_NAME(ja) = 29,
  /* Georgian. */ FIRTranslateLanguageKA NS_SWIFT_NAME(ka) = 30,
  /* Kannada. */ FIRTranslateLanguageKN NS_SWIFT_NAME(kn) = 31,
  /* Korean. */ FIRTranslateLanguageKO NS_SWIFT_NAME(ko) = 32,
  /* Lithuanian. */ FIRTranslateLanguageLT NS_SWIFT_NAME(lt) = 33,
  /* Latvian. */ FIRTranslateLanguageLV NS_SWIFT_NAME(lv) = 34,
  /* Macedonian. */ FIRTranslateLanguageMK NS_SWIFT_NAME(mk) = 35,
  /* Marathi. */ FIRTranslateLanguageMR NS_SWIFT_NAME(mr) = 36,
  /* Malay. */ FIRTranslateLanguageMS NS_SWIFT_NAME(ms) = 37,
  /* Maltese. */ FIRTranslateLanguageMT NS_SWIFT_NAME(mt) = 38,
  /* Dutch. */ FIRTranslateLanguageNL NS_SWIFT_NAME(nl) = 39,
  /* Norwegian. */ FIRTranslateLanguageNO NS_SWIFT_NAME(no) = 40,
  /* Polish. */ FIRTranslateLanguagePL NS_SWIFT_NAME(pl) = 41,
  /* Portuguese. */ FIRTranslateLanguagePT NS_SWIFT_NAME(pt) = 42,
  /* Romanian. */ FIRTranslateLanguageRO NS_SWIFT_NAME(ro) = 43,
  /* Russian. */ FIRTranslateLanguageRU NS_SWIFT_NAME(ru) = 44,
  /* Slovak. */ FIRTranslateLanguageSK NS_SWIFT_NAME(sk) = 45,
  /* Slovenian. */ FIRTranslateLanguageSL NS_SWIFT_NAME(sl) = 46,
  /* Albanian. */ FIRTranslateLanguageSQ NS_SWIFT_NAME(sq) = 47,
  /* Swedish. */ FIRTranslateLanguageSV NS_SWIFT_NAME(sv) = 48,
  /* Swahili. */ FIRTranslateLanguageSW NS_SWIFT_NAME(sw) = 49,
  /* Tamil. */ FIRTranslateLanguageTA NS_SWIFT_NAME(ta) = 50,
  /* Telugu. */ FIRTranslateLanguageTE NS_SWIFT_NAME(te) = 51,
  /* Thai. */ FIRTranslateLanguageTH NS_SWIFT_NAME(th) = 52,
  /* Tagalog. */ FIRTranslateLanguageTL NS_SWIFT_NAME(tl) = 53,
  /* Turkish. */ FIRTranslateLanguageTR NS_SWIFT_NAME(tr) = 54,
  /* Ukranian. */ FIRTranslateLanguageUK NS_SWIFT_NAME(uk) = 55,
  /* Urdu. */ FIRTranslateLanguageUR NS_SWIFT_NAME(ur) = 56,
  /* Vietnamese. */ FIRTranslateLanguageVI NS_SWIFT_NAME(vi) = 57,
  /* Chinese. */ FIRTranslateLanguageZH NS_SWIFT_NAME(zh) = 58,
  /* Unsupported or invalid language */ FIRTranslateLanguageInvalid = 0xffff,
} NS_SWIFT_NAME(TranslateLanguage);

/** Returns the BCP-47 language code for the given `TranslateLanguage`. */
NSString* FIRTranslateLanguageCodeForLanguage(FIRTranslateLanguage language)
    NS_SWIFT_NAME(TranslateLanguage.toLanguageCode(self:));

/**
 * Returns the `TranslateLanguage` for a given BCP-47 language code, or
 * `TranslateLanguage.Invalid` if the language code is invalid or not supported
 * by the Translate API.
 */
FIRTranslateLanguage FIRTranslateLanguageForLanguageCode(NSString* languageCode)
    NS_SWIFT_NAME(TranslateLanguage.fromLanguageCode(_:));

/**
 * Returns a set that contains `TranslateLanguage` codes of all languages supported by the
 * translate API.
 */
NSSet<NSNumber*>* FIRTranslateAllLanguages(void) NS_SWIFT_NAME(TranslateLanguage.allLanguages());

NS_ASSUME_NONNULL_END

#if defined __cplusplus
}
#endif  // __cplusplus
