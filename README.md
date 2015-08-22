# NRGProfiler

NRGProfiler is the simple time profiling library based on MTU (Mach Time Units) in Objective-C. You can create a new profiler at any time and log any count of "safe spots" whenever you need until you stop it. You just need to keep a strong reference to created profiler until it stopped.

NRGProfiler uses standard `NSLog()` function to print your spots synchronously in a main thread to keep your logs actual at any time.

## Adding NRGProfiler to your project

### Cocoapods

[CocoaPods](http://cocoapods.org) is the recommended way to add NRGProfiler to your project.

1. Add a pod entry for NRGProfiler to your Podfile `pod 'NRGProfiler'`
2. Install the pod(s) by running `pod install`.
3. Include NRGProfiler wherever you need it with `#import "NRGProfiler.h"`.

### Source files

Alternatively you can directly add the `NRGProfiler.h` and `NRGProfiler.m` source files to your project.

1. Download the [latest code version](https://github.com/NRGRepo/NRGProfiler/archive/master.zip) or add the repository as a git submodule to your git-tracked project. 
2. Open your project in Xcode, then drag and drop `NRGProfiler.h` and `NRGProfiler.m` onto your project (use the "Product Navigator view"). Make sure to select Copy items when asked if you extracted the code archive outside of your project. 
3. Include NRGProfiler wherever you need it with `#import "NRGProfiler.h"`.

## Usage

When you want to start profiling some critical code, just start a new profiler by calling static method

```objective-c
NRGProfiler *profiler = [NRGProfiler startWithMessage:@"I'm profiling my special code!"];

// or use shorter version
NRGProfiler *profiler = [NRGProfiler start];
```

Note that you can use short method version without specifying an input message if you do not need it. Each method in the library has its detailed and short versions.

Now profiling is started. When you need to log a spot, just call this:

```objective-c
[profiler pointWithMessage:@"I've finished some kind of work!"];
```

If you save your point value (points stored as seconds with high precision transformed from nano seconds) - you can use it for further measurement. For example, in this case:

```objective-c
double p1 = [profiler point];
// some critical code block
// ...
double p2 = [profiler point];

NSLog(@"My critical code passed in %.3f", p2 - p1); // just subtract them
```

When you want to finish your measurement, stop a profiler by calling `stop`:

```objective-c
[profiler stopWithMessage:@"Some profiling finished!"];
```

After stopping you can create a new profiler by calling `start` as you see above, it's no necessary to keep a strong reference to a stopped profiler anymore. Also you can use `restart` or `restartWithMessage:` functions instead to renew your existing profiler and use it again.

You can create as many profilers as you need, just be sure that you keep strong references to them.

## Thread Safety

You are free in operating threads with NRGProfiler. NRGProfiler uses standard `NSLog()` function to print your logs and a system functions to measure time. You should keep in mind to use your profilers in a same thread in which you've created them.

## Utilities
`NRGProfiler` has its own `NSLog()` function wrapping macro called `NRGDLog()` which will be automatically disabled in production mode due to auto `DEBUG` preprocessor constant removal on a Release project scheme.

## Samples

You can find sample application in the `Samples` folder.

## License

Apache. See `LICENSE` for details.
