.PHONY: build index serve dev clean

build:
	hugo --gc --minify
	npx --yes pagefind --site public

index:
	hugo --gc --minify
	npx --yes pagefind --site public --output-path static/pagefind

serve:
	hugo server -D --disableFastRender

dev: index
	hugo server -D --disableFastRender

clean:
	rm -rf public resources/_gen static/pagefind
