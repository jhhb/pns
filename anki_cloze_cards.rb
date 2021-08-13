#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

file = ARGV.first

unless file
  puts "Usage: ./anki_cloze_cards <path_to_file>"
  abort "Must provide a file path"
end

expanded = File.expand_path(file)
abort "Given file path: [#{file}] does not exist." unless File.exist?(expanded)

vocab_list = JSON.parse(File.read(expanded))

def make_card(word:, unit_number:)
  keys = %i[lemma rest added meaning deriv pdgm].map(&:to_s)
  l, r, added, meaning, deriv, pdgm = word.values_at(*keys)
  c1_contents = [l, r, added].compact.reject(&:empty?).join(", ")
  c2_contents = meaning.to_s
  extra_field = deriv.empty? ? "___leftblank___" : "mnemonic - #{deriv}"
  translation_field = "Translate:<br>{{c1::#{c1_contents}}}<br><br>{{c2::#{c2_contents}}}"
  tags_field = [
    "mastronarde",
    "ch#{unit_number}",
    pdgm.to_s,
    "added-by-script"
  ].join(" ")
  [
    translation_field,
    extra_field,
    tags_field
  ].join("\t")
end
unit = "8"
words_for_unit = vocab_list.select { |el| el["unit"] == unit }
formatted_card_strings = words_for_unit.map { |vocab| make_card(word: vocab, unit_number: unit) }
puts formatted_card_strings
