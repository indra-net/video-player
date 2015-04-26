# video player

plays a video

takes a list of video-related events of the form:

```
events: {
    timeInVideoInSeconds: 'eventName'
}
```

`videoEvents.onEvent()` handles what happens when an event comes in

## development
this produces a static site. the build tools here are for compiling that static site.

make sure you have `node`, `npm` and `grunt`

then just
```npm install```

`grunt` compiles `app/` to a neat bundle in `built-app/` coffeeify (browserify for coffeescript)

for developing, you can `coffee server.coffee`
