# PokeApp

PokeApp is an application to search a Pokemon by name or by ID.
You'll see the picture and the name, and if you want more detail, just tap on top right button.

If you liked the pokemon you searched for, click on the icon with a heart to save it as a favorite.

The app will save your poke in this webook:

webhookAddress: https://webhook.site/#!/9b896056-bede-43e8-b223-a5cffb7e9e8c/228cf4ae-c71a-4ade-9058-da6e917f59de/1

## Installation

Use Xcode to run the app.

```bash
All network calls within the app are done natively.
I mean...you do not have to install any library, just run the app.
```

## Usage
Please use the app in dark mode, it looks beautiful. But you have the option to use it in light mode too, the layout is adaptable. 

You can rotate the iPhone to landscape mode, the layout will adjust as well.

Some code spec here:

```swift
# returns the search by name
interactor?.getMainPoke(name: "bulbasaur", id: nil)

# returns the search by id
interactor?.getMainPoke(name: nil, id: 30)

```

## Design Pattern

The application is built like this: the ViewController where it receives and sends commands from the user and later displays some result or change. Our ViewController asks the Interactor for information, the work ahead is some API request, after the information arrives in the Interactor, we send it to the Presenter, and the Presenter, having a (weak) reference of the ViewController, sends the data to the ViewController to show.

If you wanna know more about this, please read: https://clean-swift.com

## License
[MIT](https://choosealicense.com/licenses/mit/)
