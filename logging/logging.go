package logging

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"path/filepath"

	"github.com/samwho/streamdeck"
)

func directory() string {
	ex, err := os.Executable()
	if err != nil {
		log.Fatalf("error getting directory: %v", err)
	}
	return filepath.Base(filepath.Dir(ex))
}

// Enable turns logging on for the StreamDeck API client as well as the global
// log object. It sends both to a temp file that contains <project_directory>.log.
func Enable() {
	d := directory()
	f, err := ioutil.TempFile("", fmt.Sprintf("%s.log", d))
	if err != nil {
		log.Fatalf("error creating temp file: %v", err)
	}
	streamdeck.Log().SetOutput(f)
	log.SetPrefix(fmt.Sprintf("%s ", d))
	log.SetOutput(f)
}
