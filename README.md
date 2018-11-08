# Identicon-ex

**Identicon implementation with elixir**

## Description

Implementation of an [identicon](https://en.wikipedia.org/wiki/Identicon) in elixir.
Inspired by [this course](https://www.udemy.com/the-complete-elixir-and-phoenix-bootcamp-and-tutorial).


## Usage

It needs [egd](http://erlang.org/documentation/doc-7.0/lib/percept-0.8.11/doc/html/egd.html) which can be installed by calling `mix deps.get`.

## Example

```elixir
$ iex -S mix
iex(1)> Identicon.main("asdf")
```

which will create this

![asdf](/asdf.png?raw=true)