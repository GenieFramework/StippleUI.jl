module Timelines

using Stipple
using StippleUI

@reactive mutable struct TimelineModel <: ReactiveModel
end

function ui(timeline_model)
  page(
    timeline_model,
    title = "Timeline Components",
    class = "container",
    Html.div(class="q-px-lg q-pb-md", [
      timeline(color="secondary", [
        timelineentry("Timeline Heading", heading=true),
        timelineentry(title="Event Title", subtitle="February 22, 1986", [
          Html.div("Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
            sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris 
            nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
            reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
            Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia 
            deserunt mollit anim id est laborum.")
        ]),
        timelineentry(title="Event Title", subtitle="February 21, 1986", icon="delete",[
          Html.div("Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
            sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris 
            nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
            reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
            Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia 
            deserunt mollit anim id est laborum.")
        ]),
        timelineentry(title="Event Title",
        subtitle="February 22, 1986",
        avatar="https://cdn.quasar.dev/img/avatar2.jpg", [
          Html.div("Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
            sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris 
            nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
            reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
            Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia 
            deserunt mollit anim id est laborum.")
        ])
      ])
    ])
  )
end

function factory()
  timeline_model = TimelineModel |> init
  timeline_model
end

end