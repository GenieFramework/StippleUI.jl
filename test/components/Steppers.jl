module Steppers

using Stipple
using StippleUI

@reactive mutable struct StepperModel <: ReactiveModel
  mystep::R{Int} = 1
end

function ui(stepper_model)
  page(
    stepper_model,
    title = "Stepper Components",
    class = "container",
    Html.div(class="q-pa-md", [
      stepper(:mystep, ref="stepper", color="primary", animated=true, [
        step("For each ad campaign that you create, you can control how much you're willing to
        spend on clicks and conversions, which networks and geographical locations you want
        your ads to show on, and more.",
        name! = "1", title="Select campaign settings", icon="settings", done! = "step > 1"),

        step("An ad group contains one or more ads which target a shared set of keywords.",
        name! = "2", title="Create an ad group", caption="Optional", icon="create_new_folder", done! = "step > 2"),

        step("This step won't show up because it is disabled.",
        name! = "3", title="Ad template", icon="assignment", disable=true),

        step("Try out different ad text to see what brings in the most customers, and learn how to
        enhance your ads using features like ad extensions. If you run into any problems with
        your ads, find out how to tell if they're running and how to resolve approval issues.",
        name! = "4", title="Create an ad", icon="add_comment"),

        template("", "v-slot:navigation", [
          steppernavigation([
            btn(@click("\$refs.stepper.next()"), color="primary", label! = "step === 4 ? 'Finish' : 'Continue'"),
            btn(flat=true, color="primary", @click("\$refs.stepper.previous()"), label="Back", class="q-ml-sm", @iif("step > 1"))
          ])
        ])
      ])
    ])
  )
end

function factory()
  stepper_model = StepperModel |> init
  stepper_model
end

end