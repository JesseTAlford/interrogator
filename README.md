# THE INTERROGATOR SUITE

A set of bash scripts for asking Cloud Controller _pointed questions._

You'll need to set the following environment variables for all of these:

- `CF_API`
- `CF_USERNAME`
- `CF_PASSWORD`

Individual tools may require additional setup.

These all require the excellent [jq](http://stedolan.github.io/jq/).

## `interroman`
_give me the manifest for this app!_

Of course, poor CC doesn't have the manifest for the app. `manifest.yml` is cf-ignored by default, and ccdb doesn't know or care about our puny mortal manifests. 

Which is why we have to beat it out of CC with `cf curl`.

`interroman` takes an app name, org and space as arguments (in that order).

### Limitations of `interroman`
It can only represent the first route in a manifest (and in fact, only one route is permissable in app manifests.) 
It doesn't currently handle env vars at all. 
It can only represent the fist bound service.

Eliminating these latter two are potential future features. The first one requires some thought; `interroman` _could_ insert multiple values for each of these things into the manifest without breaking it; the last value given would always "win," with others being clobbered. This might be confusing/terrible in the event that there were multiple routes, only some of which had hostnames. You might end up with a new, previously not-specified combination of hostname and domain. Ugly. **Anyway.** For now it doesn't do any of those things.

## interro-route
_where is the rebel base!?_ Um. Actually, more like _who is the owner of the app running with this hostname!?_ (But that's basically the same thing, right?)

CC knows. The `cf` cli doesn't want to ask it, but CC knows. 

We have ways of making CC talk. 

`interro-route` takes a hostname and returns the known associates of the first route it comes across that use that hostname. 

### Limitations of `interro-route`
- only handles first instance of a host name, of which there could be more than one on various domains
- can't find you domain-only routes
- doesn't list multiple apps bound, if more than one

Still, it leaves its files around for you to inspect in ~/tmp/interrogator. You can probably find out what you want to know with the .json files in there, the script's patterns, and `cf curl`.