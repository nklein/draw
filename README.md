DRAW
====

I started work on a package to create [Sudoku diagrams](https://github.com/nklein/sudoku-diagrams).
I know that sometimes I want them in a printable version and other times I want them
in a format that is easily displayed on the web.

This package attempts to distill the common parts of `CL-PDF`, `Vecto`, and maybe someday `CL-SVG`
into one interface where I can swap out the back-end to generate the type of file that I need
at a given time.

To render the Sudoku diagrams as PDFs, I used these functions from `CL-PDF`:
`bounds`, `circle`, `close-and-fill`,
`close-and-stroke`, `close-fill-and-stroke`, `draw-text`,
`get-char-size`, `get-font`, `get-font-descender`,
`get-kerning`, `in-text-mode`, `line-to`,
`move-text`, `move-to`, `rectangle`,
`set-font`, `set-line-width`, `set-rgb-fill`,
`set-rgb-stroke`, `translate`, `with-document`,
`with-page`, `with-saved-state`, `write-document`

With the exception of the `with-page` macro, these all seem very do-able
with `Vecto` (with some help from `ZPB-TTF`).
These are probably all very do-able in `CL-SVG`, as well, (though maybe not
with the font queries).
At the moment, I am torn about making this an almost drop-in replacement
(different package but same function names) for `CL-PDF`.
Some of the names above though are awkward for something generic.
Calling `write-document` for `Vecto` seems a bit odd.

Below is a test image as rendered by the `Vecto` backend.
You can download the same image [rendered by the `CL-PDF` backend](./images/draw-test.pdf).

![sample image from Vecto](./images/draw-test.png)

BACKEND STATUS
--------------

| Method                  | PDF   | Vecto |
|-------------------------| :---: | :---: |
| `circle`                | ✓     | ✓     |
| `close-and-fill`        | ✓     | ✓     |
| `close-and-stroke`      | ✓     | ✓     |
| `close-fill-and-stroke` | ✓     | ✓     |
| `close-path`            | ✓     | ✓     |
| `draw-text`             | ✓     | ✓     |
| `get-char-size`         |       |       |
| `get-font`              | ✓     | ✓     |
| `get-font-descender`    |       |       |
| `get-kerning`           |       |       |
| `in-text-mode`          | ✓     | ✓     |
| `line-to`               | ✓     | ✓     |
| `load-ttf-font`         | ✓     | ✓     |
| `move-text`             | ✓     | ✓     |
| `move-to`               | ✓     | ✓     |
| `rectangle`             | ✓     | ✓     |
| `rotate`                | ✓     | ✓     |
| `scale`                 | ✓     | ✓     |
| `set-font`              | ✓     | ✓     |
| `set-line-width`        | ✓     | ✓     |
| `set-rgb-fill`          | ✓     | ✓     |
| `set-rgb-stroke`        | ✓     | ✓     |
| `translate`             | ✓     | ✓     |
| `with-document`         | ✓     | ✓     |
| `with-page`             | ✓     | ✓     |
| `with-saved-state`      | ✓     | ✓     |
| `write-document`        | ✓     | ✓     |


PDF BACKEND
-----------

The `DRAW-PDF` backend exports the `PDF-RENDERER` class which can be used like:

    (draw:with-renderer (draw-pdf:pdf-renderer)
      (draw:load-ttf-font font-name handle)
      (draw:with-document (:width width :height height)
        (draw:with-page ()
          ...)
        (draw:write-document output-filename)))

The PDF backend can take advantage of these keyword arguments passed to `WITH-DOCUMENT`:

    :author string
    :title string
    :subject string
    :keywords string

Additionally, if you provide `WITH-DOCUMENT` both `WIDTH` and `HEIGHT`, then in the
dynamic scope of the document, the default page size is `WIDTH` and `HEIGHT`.

You can override the page boundary using the keyword `:BOUNDS` to the `WITH-PAGE` macro
and giving it a vector. However, if you do this, you will lose compatibility with the
`VECTO` backend which cannot change page sizes within a document. The most portable
option is to use the `WIDTH` and `HEIGHT` keywords for `WITH-DOCUMENT`.


VECTO BACKEND
-------------

The `DRAW-VECTO` backend exports the `VECTO-RENDERER` class which can be used like:

    (draw:with-renderer (draw-vecto:vecto-renderer :dpi 150 :page-color '(1.0 1.0 1.0 1.0))
      (draw:load-ttf-font font-name handle)
      (draw:with-document (:width width :height height)
        (draw:with-page ()
          ...)
        (draw:save-png output-filename)))

The `WITH-RENDERER` can take the following arguments:

    :dpi number
    :page-color list

The `DPI` is the number of dots per inch. This specifies how many pixels there are in
every inch (every 72-points) of document page.

The `PAGE-COLOR` is a list of either three or four numbers between 0 and 1. They are
used to set the background color for each page. If you wish the image to be transparent,
you can specify a zero four the fourth element of that list.

The Vecto backend can take advantage of these keyword arguments passed to `WITH-DOCUMENT`:

    :width number
    :height number

The `WIDTH` and `HEIGHT` are expected to be in points. The `DPI` is used to determine
the pixel width and height to use for the output image.


MINIMUM DIFFERENCE
------------------

At the moment, if you wanted to render with either `CL-PDF` or `VECTO` you could write
almost all of your document in one place something like this:

    (defun common-parts (output-filename width height)
      (draw:with-document (:width width :height height ...)
        (draw:load-ttf-font #P"/some/dir/myfont.ttf" "myfont")
        (draw:with-page ()
          (draw:in-text-mode
            (draw:set-font (draw:get-font "myfont"))
            (draw:text "My Common Document"))
          ...)
        (draw:write-document output-filename)))

Then, you can write short functions to render with `CL-PDF` or `VECTO`:

    (defun render-with-draw-pdf (output-filename width height)
      (draw:with-renderer (draw-pdf:pdf-renderer)
        (common-parts output-filename width height)))

    (defun render-with-draw-vecto (output-filename width height dpi)
      (draw:with-renderer (draw-vecto:vecto-renderer :dpi dpi)
        (common-parts output-filename width height)))
