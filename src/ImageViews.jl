module ImageViews

using Genie, Stipple, StippleUI, StippleUI.API
import Genie.Renderer.Html: HTMLString, normal_element, register_normal_element

export imageview

register_normal_element("q__img", context = @__MODULE__)

"""
      imageview(args...; kwargs...)

The `imageview` component makes working with images (any picture format) easy and also adds a nice loading effect to it along with many other features (example: the ability to set an aspect ratio).

----------
### Examples
----------

### Model

```julia-repl
julia> @vars Model begin
          url::R{String} = "https://placeimg.com/500/300/nature"
       end
```

### View

```julia-repl
julia> imageview(src = :url, spinnercolor = "white", style = "height: 140px; max-width: 150px" )
julia> imageview(src = :url, style = "height: 140px; max-width: 150px", [
          template("", "v-slot:loading", [spinner(:gears, color = "white", wrap = StippleUI.NO_WRAPPER)]),
       ])
```

-----------
### Arguments
-----------

1. Behaviour
       * `transition::String` - One of [embedded transitions](https://v1.quasar.dev/options/transitions) ex. `fade` `slide-down`
       * `nativecontextmenu::Bool` - Enable the native context menu of the image
2. Content
       * `ratio::Union{String, Int}` - Force the component to maintain an aspect ratio ex. `ratio!="4/3"` `(Number format) ratio!="16/9"` `(String format) ratio="1"`
       * `alt::String` - Specifies an alternate text for the image, if the image cannot be displayed ex. `Two cats`
       * `basic::Bool` - Do not use transitions; faster render
       * `contain::Bool` - Make sure that the image getting displayed is fully contained, regardless if additional blank space besides the image is needed on horizontal or vertical
3. Model
       * `src::String` - Path to image ex. `(public folder) src="img/something.png"` `(assets folder) src="~assets/my-img.gif"` `(URL) src="https://placeimg.com/500/300/nature"`
       * `srcset::String` - Same syntax as <img> srcset attribute. ex. `elva-fairy-320w.jpg 320w, elva-fairy-480w.jpg 480w`
       * `sizes::String` - Same syntax as <img> sizes attribute. ex. `(max-width: 320px) 280px, (max-width: 480px) 440px, 800px`
       * `width::String` - Forces image width; Must also include the unit (px or %) ex. `280px` `70%`
       * `height::String` - Forces image height; Must also include the unit (px or %) ex. `280px` `70%`
       * `placeholdersrc::String` - While waiting for your image to load, you can use a placeholder image ex. `(public folder) src="img/something.png"` `(assets folder) src="~assets/my-img.gif"` `(URL) src="https://placeimg.com/500/300/nature"`
4. Style
      * `color::String` - Color name for component from the [Color Palette](https://quasar.dev/style/color-palette) eg. `primary` `teal-10`
      * `imgclass::Union{Vector, String, Dict}` - Class definitions to be attributed to the container of image; Does not apply to the caption ex. `my-special-class` `imgclass!="{ 'my-special-class': <condition> }"`
      * `imgstyle::Dict` - Apply CSS to the container of the image; Does not apply to the caption ex. `imgstyle!="{ transform: 'rotate(45deg)' }"`
      * `spinnercolor::String` - Color name for default Spinner (unless using a 'loading' slot) `primary` `teal-10`
      * `spinnersize::String` - Size in CSS units, including unit name, for default Spinner (unless using a 'loading' slot) ex. `16px` `2rem`
"""
function imageview(args...; kwargs...)
  q__img(args...; kw(kwargs)...)
end

end
