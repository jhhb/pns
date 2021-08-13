.PHONY: c test lint lintf

c:
	bundle exec bin/console

test:
	bundle exec rspec

lint:
	bundle exec rubocop

lintf:
	bundle exec rubocop -a

cloze:
	./anki_cloze_cards.rb "~/code/writing/greek-text-vocab.json"

vocab:
	mkdir -p out/anki_cloze_cards
	make cloze | tail -n +3 > out/anki_cloze_cards/vocab-words.txt



