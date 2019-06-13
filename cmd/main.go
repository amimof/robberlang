package main

import (
	"flag"
	"fmt"
	"github.com/amimof/robberlang/pkg"
	"os"
)

var (
	// VERSION is generated during compile as is never to be set here
	VERSION string
	// COMMIT is the Git commit hash and is generated during compile as is never to be set here
	COMMIT string
	// BRANCH is the Git branch name and is generated during compile as is never to be set here
	BRANCH string
	// GOVERSION is the Go version used to compile and is generated during compile as is never to be set here
	GOVERSION string
	host      string
	port      int
	decode    bool
	reverse		bool
)

func init() {
	flag.BoolVar(&decode, "d", false, "Treat string as encoded and try to decode it instead")
	flag.BoolVar(&reverse, "r", false, "Return the text in reverse")
}

func usage() {
	fmt.Fprint(os.Stderr, "Usage:\n")
	fmt.Fprint(os.Stderr, "  robberlang <string> [-d]\n\n")
}

func main() {

	// Parse cmd flags
	flag.Parse()

	// Print usage if no string to encode/decode provided
	if flag.Arg(0) == "" {
		usage()
		return
	}

	// Read first arg on cmd as the string
	str := flag.Arg(0)

	// Encode/decode
	if decode {
		if reverse {
			fmt.Println(robber.Reverse(robber.Decode(str)))
		} else {
			fmt.Println(robber.Decode(str))
		}
	} else {
		if reverse {
			fmt.Println(robber.Reverse(robber.Encode(str)))
		} else {
			fmt.Println(robber.Encode(str))
		}
	}

}
