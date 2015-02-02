## Testing iOS Apps in 2015

Content for the talk "Testing iOS apps in 2015"


"This talk will start with an intro to testing iOS apps and cover basic topics
like what to test and available tools. Next, we'll dive into writing testable
code, techniques for testing UI logic, testing async code, and adding tests to a
legacy codebase. Then, we'll walk through adding regression tests to a 'legacy'
iPhone app with Apple's testing framework, XCTest, and end with a Q&A session."

I plan to push slides/notes post talks.

I'm going to talk about adding tests to an untested app. I needed a codebase
quick to explain but complex enough to demonstrate testing a "real" app.

### HotSpots

HotSpots is a moderately realistic *enterprisy* location based iPhone app. It
fetches locations from Google maps and then displays them.

It computes a hotness score for the location, which is animated in as the
long running computation is finished.

I implemented this app to be as close to a real "legacy" app that was designed
without considering testability, and without creating a *total* trainwreck.

Pull requests for difficult to test features or methods are welcome. I plan to
add tests for any features and will push the tests to this repo talk.

It requires CocoaPods to install dependencies and a Google Places API token.

