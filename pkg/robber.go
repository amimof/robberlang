package robber

import (
	"fmt"
	"strings"
)

var consonants = []rune{'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'x', 'z', 'w'}

func isInArr(s rune, a []rune) bool {
	for _, v := range a {
		if s == v {
			return true
		}
	}
	return false
}

// Encode translates a string into robber languange
func Encode(s string) string {
	var r string
	for _, v := range strings.ToLower(s) {
		if isInArr(v, consonants) {
			r = r + fmt.Sprintf("%co%c", v, v)
			continue
		}
		r = r + fmt.Sprintf("%c", v)
	}
	return r
}

// Decode translates tries to reverse robber languange into ordinary languange
func Decode(s string) string {
	for _, v := range consonants {
		s = strings.Replace(strings.ToLower(s), fmt.Sprintf("%co%c", v, v), string(v), -1)
	}
	return s
}

// Reverse will return s in reverse
func Reverse(s string) string {
	var r string
	for _, v := range s {
		r = fmt.Sprintf("%c%s", v, r)
	}
	return r
}
