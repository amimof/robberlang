# robberlang
[![Build Status](https://travis-ci.org/amimof/robberlang.svg?branch=master)](https://travis-ci.org/amimof/robberlang)

---

A command line tool for translating text into [The Robber Language](https://en.wikipedia.org/wiki/R%C3%B6varspr%C3%A5ket) (Rövarspråket)

## Installing
Binaries for the most common platforms are available under [Releases](). Download and place in your `$PATH`. 
```bash
curl -Ls https://github.com/amimof/robberlang/releases/latest/download/robberlang-darwin-amd64 -o robberlang && chmod +x robberlang && sudo mv robberlang /usr/local/bin/robberlang
```

## Usage
Pass any string to the `robberlang` command and it will translate it into The Robber Language. As an example, the following command
```
$ robberlang "vi ses i nangijala"
```
will render
```
vovi sosesos i nonanongogijojalola
```

## Contributing
All help in any form is highly appreciated and your are welcome participate in developing together. To contribute submit a Pull Request. If you want to provide feedback, open up a Github Issue.