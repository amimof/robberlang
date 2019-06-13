package robber

import (
	"testing"
)

func TestEncode(t *testing.T) {
	str := "Ibland måste man göra saker man inte vågar, annars är man ingen människa utan bara en liten lort"
	expected := "iboblolanondod momåsostote momanon gogörora sosakokeror momanon inontote vovågogaror, anonnonarorsos äror momanon inongogenon momänonnonisoskoka utotanon bobarora enon lolitotenon lolorortot"
	encoded := Encode(str)
	if encoded != expected {
		t.Fatalf("Expected '%s' but got '%s'", expected, encoded)
	}
}

func TestDecode(t *testing.T) {
	encoded := "hohejoj jojagog hohetoteror amomiror"
	expected := "hej jag heter amir"
	decoded := Decode(encoded)
	if decoded != expected {
		t.Fatalf("Expected '%s' but got '%s'", expected, decoded)
	}
}

func TestReverse(t *testing.T) {
	s := "this string should be reversed"
	expected := "desrever eb dluohs gnirts siht"
	result := Reverse(s)
	if expected != result {
		t.Fatalf("Expeced '%s' but got '%s'", expected, result)
	}
}
