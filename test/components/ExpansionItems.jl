module ExpansionItems

using Stipple
using StippleUI

@reactive mutable struct ExpansionModel <: ReactiveModel
  dummy::R{Bool} = true
end

function ui(expansion_model)
  page(
    expansion_model,
    title = "Expansion Items Components",
    class = "container",
    [
      list(bordered=true, class="rounded-borders", [
        expansionitem(expandseparator=true, icon="perm_identity", label="Account settings", caption="John Doe", [
          card([
            cardsection("Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
            commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
            eveniet doloribus ullam aliquid.")
          ])
        ]),
        expansionitem(expandseparator=true, icon="signal_wifi_off", label="Wifi settings", [
          card([
            cardsection("Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
            commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
            eveniet doloribus ullam aliquid.")
          ])
        ]),
        expansionitem(expandseparator=true, icon="drafts", label="Drafts", [
          card([
            cardsection("Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quidem, eius reprehenderit eos corrupti
            commodi magni quaerat ex numquam, dolorum officiis modi facere maiores architecto suscipit iste
            eveniet doloribus ullam aliquid.")
          ])
        ])
        
      ])
      
    ],
  )
end

function factory()
  expansion_model = ExpansionModel |> init
  expansion_model
end

end