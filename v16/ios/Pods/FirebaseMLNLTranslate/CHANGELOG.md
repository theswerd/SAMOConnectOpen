# 2019-07-09 -- v0.16.3
- Reduced application binary size: Changed Google Toolbox for Mac and Protobuf
  to CocoaPod dependencies instead of bundling
- Improvements to error telemetry for Translate model downloading

# 2019-06-04 -- v0.16.2
- Internal improvements and refactored code.

# 2019-05-21 -- v0.16.1
- Fixed possible out-of-memory error: Updated `Translator` to release memory for the
  instance once all references have been removed.
- Renamed Swift values of `TranslateLanguage` from uppercase to lowercase, e.g
  from `TranslateLanguage.EN` to `TranslateLanguage.en`.

# 2019-05-07 -- v0.16.0
- Initial release of Translate SDK.
