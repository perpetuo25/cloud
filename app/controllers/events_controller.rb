class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
    puts event_is_available
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:start, :end, :name)
    end

    def event_is_available
      response = HTTParty.get('http://www.vrbo.com/icalendar/6a52d4a5eea744f59e45b2c4bd8929c4.ics')
      @body = response.body  
      @events = Selene.parse(@body)["vcalendar"][0]["vevent"]
      @all_dates =  []
      @events.each do |ev|
        start = number_to_date(ev["dtstart"][0].to_s)
        dend  = number_to_date(ev["dtend"][0].to_s)
        @all_dates = @all_dates + getDateBtw(start, dend)
      end
      @all_Dates
    end

    def number_to_date(date_s)
      @date = Date.parse date_s
    end

    def getDateBtw(start, end_s)
      start = Date.parse start
      end_s = Date.parse end_s
      
    end
end
