# StreamDeck plugin skeleton

This is a skeleton project for getting started making StreamDeck plugins using the [Golang client library][1].

## Usage

Clone this repo and copy the directory to somewhere appropriate in your `GOPATH`. From there, most things are done
using the supplied Makefile.

Build:

    make build

This outputs a build binary in to the project directory but doesn't do much else. To test out the plugin with your
StreamDeck, you need to do a local install.

Install:

    make install

This builds an `.sdPlugin` directory under the `build` directory and then copies it over to the StreamDeck plugin
directory. **Note: you'll need to close the StreamDeck software before doing this. If you don't, you'll get a device
or resource busy error.**

View logs:

    make logs

If you've enabled logging, logs will get dumped in to a temporary file. This make command tails all log files and needs to
be run after you've fired up the StreamDeck software, as the temporary file won't have been created before then.

Build for release:

    make release

To distribute your StreamDeck plugin, you need to use Elgato's [DistributionTool][2]. Download it, put it somewhere on your
path, and then `make release` should work. If you have any problems in your `manifest.json`, this tool will ask you to fix
them before it outputs a release-ready plugin.

[1]: https://github.com/samwho/streamdeck
[2]: https://developer.elgato.com/documentation/stream-deck/sdk/exporting-your-plugin/