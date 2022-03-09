module DatePickers

using Stipple
using StippleUI

@reactive mutable struct DatePickerModel <: ReactiveModel
  date::R{Date} = today() + Day(30)
  dates::R{Vector{Date}} = Date[today()+Day(10), today()+Day(20), today()+Day(30)]
  daterange::R{DateRange} = DateRange(today(), (today()+Day(3)))
  dateranges::R{Vector{DateRange}} = [DateRange(today(), (today()+Day(3))),
                                      DateRange(today()+Day(7), (today() + Day(10))),
                                      DateRange(today()+Day(14), (today() + Day(17)))]
  proxydate::R{Date} = today()
  inputdate::R{Date} = today()
end

function ui(datepicker_model)
  page(
    datepicker_model,
    title = "DatePicker Components",
    class = "container",
    [
      datepicker(:date),
      datepicker(:dates, multiple = true),
      datepicker(:dateranges, range = true, multiple = true),
      datepicker(:proxydate, content = [
        Html.div( class="row items-center justify-end q-gutter-sm", [
          btn(label="Cancel", color="primary", flat=true, vclosepopup=true)
          btn(label="OK", color="primary", flat=true, vclosepopup=true)
        ])
      ]),
      datepicker(:inputdate, content = [
        Html.div(class="row items-center justify-end", [
          btn(vclosepopup=true, label="Close", color="primary", flat=true)
        ])
      ])
    ],
  )
end

function factory()
  datepicker_model = DatePickerModel |> init
  datepicker_model
end

end