package main

import (
	"context"
	"log"
	"os"

	"github.com/samwho/streamdeck"
)

func main() {
	// logging.Enable()

	params, err := streamdeck.ParseRegistrationParams(os.Args)
	if err != nil {
		log.Fatalf("error parsing registration params: %v", err)
	}

	sd := streamdeck.NewClient(context.Background(), params)
	defer sd.Close()

	if err := sd.Run(); err != nil {
		log.Fatalf("error running streamdeck client: %v\n", err)
	}
}
