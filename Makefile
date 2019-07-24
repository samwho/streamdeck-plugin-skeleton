GO = go
GOFLAGS =
NAME = yourpluginname
MAKEFILEDIR := $(notdir $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST))))))
INSTALLDIR = "$(APPDATA)\Elgato\StreamDeck\Plugins\$(NAME).sdPlugin"
BUILDDIR = build
RELEASEDIR = release
SDPLUGINDIR = "$(BUILDDIR)\$(NAME).sdPlugin"

.PHONY: test install build logs

build:
	$(GO) build $(GOFLAGS)

test:
	$(GO) run $(GOFLAGS) main.go -port 12345 -pluginUUID 213 -registerEvent test -info "{\"application\":{\"language\":\"en\",\"platform\":\"windows\",\"version\":\"10\"},\"plugin\":{\"version\":\"1.1\"},\"devicePixelRatio\":2,\"devices\":[{\"id\":\"55F16B35884A859CCE4FFA1FC8D3DE5B\",\"name\":\"Device Name\",\"size\":{\"columns\":5,\"rows\":3},\"type\":0},{\"id\":\"B8F04425B95855CF417199BCB97CD2BB\",\"name\":\"Another Device\",\"size\":{\"columns\":3,\"rows\":2},\"type\":1}]}"

sdplugin: build
	rm -rf $(SDPLUGINDIR)
	mkdir -p $(SDPLUGINDIR)
	cp *.json $(SDPLUGINDIR)
	cp *.exe $(SDPLUGINDIR)
	cp *.html $(SDPLUGINDIR)
	cp -r images $(SDPLUGINDIR)

install: uninstall sdplugin
	mv $(SDPLUGINDIR) $(INSTALLDIR)

uninstall:
	rm -rf $(INSTALLDIR)

logs:
	tail -f "$(TMP)"/$(MAKEFILEDIR).log*

release: sdplugin
	rm -rf $(RELEASEDIR)
	mkdir $(RELEASEDIR)
	DistributionTool -b -i $(SDPLUGINDIR) -o $(RELEASEDIR)