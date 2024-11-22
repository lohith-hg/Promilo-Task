# promilo_task

## Task Overview

This Flutter app embeds a YouTube video and ensures that:
1. Videos play inside the app when clicked.
2. Related (recommended) videos are displayed after a video finishes.
3. Clicking on a recommended video loads it within the app instead of redirecting to the YouTube app or browser.

### Approach

   - Used the `webview_flutter` package to embed YouTube videos with custom HTML.
   - The `WebView` intercepts navigation requests using the `onNavigationRequest` callback.
   - Navigation requests to YouTube URLs are intercepted.
   - A Dart function extracts the `videoId` from the intercepted URL.
   - The video ID is extracted, and the WebView content is updated to play the new video inside the app.
   - Default navigation is prevented, keeping the user within the app.
   - The `rel=1` parameter in the YouTube embed URL ensures related videos are shown at the end of playback.

### Technologies Used

- **Flutter**: 3.24.3
- **Dart**: 3.5.3
- **Package**: `webview_flutter`

### How to Run

1. Install Flutter 3.24.3 and Dart 3.5.3.
2. Add `webview_flutter` to `pubspec.yaml`:
   ```yaml
   dependencies:
     webview_flutter: ^4.0.0
   ```
3. Run `flutter pub get`.
4. Use `flutter run` to start the app.
