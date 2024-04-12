using GenieFramework
@genietools

@app begin
    @in start_date = today()
    @out start_date_has_errors = false
    @in end_date = today() + Day(7)
    @out end_date_has_errors = false
    @in start_time = Dates.Time(now())

    @onchange start_date begin
      if start_date < today()
        notify(__model__, "Start date must be today or later", :negative)
        start_date_has_errors = true
        start_date = today()
        return
      end
      if start_date > end_date
        notify(__model__, "Start date must be before end date", :negative)
        start_date_has_errors = true
        start_date = today()
        return
      end
      if start_date >= today() && start_date <= end_date
        if start_date_has_errors
          start_date_has_errors = false
          return
        end

        notify(__model__, "Start date saved", :positive)
      end
    end

    @onchange end_date begin
      if end_date < today()
        notify(__model__, "End date must be today or later", :negative)
        end_date_has_errors = true
        end_date = today()
        return
      end
      if end_date < start_date
        notify(__model__, "End date must be after start date", :negative)
        end_date_has_errors = true
        end_date = start_date + Day(7)
        return
      end
      if end_date >= today() && end_date >= start_date
        if end_date_has_errors
          end_date_has_errors = false
          return
        end

        notify(__model__, "End date saved", :positive)
      end
    end

    @onchange start_time begin
      notify(__model__, "Start time saved", :positive)
    end
end

ui() = begin
  row(style="max-width: 400px") do
    cell() do; [
      row() do
        cell() do
          heading("Date range picker demo")
        end
      end
      row() do
        cell() do
          datefield("Start date", :start_date, datepicker_props = Dict(:todaybtn => true, :nounset => true), textfield_props = Dict(:bgcolor => "green-1"))
        end
      end
      row() do
        cell() do
          datefield("End date", :end_date, datepicker_props = Dict(:nounset => true), icon_props = Dict(:color => "red-10"), textfield_props = Dict(:dense => true, :square => true))
        end
      end
      row() do
        cell() do
          timefield("Start time", :start_time, timepicker_props = Dict(:nowbtn => true, :nounset => true, :format24h => true, :withseconds => true), textfield_props = Dict(:bgcolor => "blue-1"))
        end
      end
    ];end
  end
end

@page("/", ui)