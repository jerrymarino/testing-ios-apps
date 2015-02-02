## Testing iOS Apps in 2015

Content for the talk "Testing iOS apps in 2015"

I plan to push slides/notes post talks.

### HotSpots

HotSpots is a moderately realistic *enterprisy* location based iPhone app. It
fetches locations from Google maps and then displays them.

It computes a hotness score for the location, which is animated in as the
long running computation is finished.

I implemented this app to be as close to a real "legacy" app that was designed
without considering testability, and without creating a *total* trainwreck.

Pull requests for difficult to test features are welcome. I plan to add tests
for any features and will push the tests to this repo talk.

It requires CocoaPods to install dependencies and a Google Places API token.

