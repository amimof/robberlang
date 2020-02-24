package main

import (
	"testing"
)

func TestUsageText(t *testing.T) {
	expected := "Usage:\n  robberlang [-d] <string>\n\n"
	if usage() != expected {
		t.Fatalf("Usage text mismatch, got %s expected %s", usage(), expected)
	}
}