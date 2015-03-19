# empty-webapp
novice developer builds stack

make sure you have `node`, `npm` and `grunt`

then just
```npm install```

## directory structure

```
Gruntfile
app/ <- this is the webapp 
	lib/ <- these are your common js-style coffeescript files
	index.jade <- the main jade template
	main.coffee <- entry point for the webapp
```

`grunt` compiles `app/` to a neat bundle in `dist/` using coffeeify (browserify for coffeescript)

