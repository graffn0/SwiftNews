# SwiftNews
To run, open up SwiftNews.xcworkspace using Xcode, then press play on an emulator.

Further Considerations:
There is quiet a lot of changes that need to be made sense I had only had a short time to work on this.
I had a bug that said "Expected to decode Array<Any> but found a dictionary instead."
By using checkpoints, commenting out code, and print, I located the issue.
I used StackOverFlow To understand what is happening and how to fix the issue.
I added the appropriate Codables and the issue was fixed.

Most of my limitations that I can't fix was the api:
I would have all of the context displayed
I would download a block of results and download more when the user scrolls down
Have a search bar working

For the code itself:
I would have the observable be created in the view controller and have it flow to the manager
I would and a dependancy manager and reachablilty checks
Add the third party software moya to help manage the api calls
Add a text bar that is filtered and throttled for data efficancy
