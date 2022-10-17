require 'net/http'
require 'json'
class StaticPagesController < ApplicationController
    def index
        response = HTTParty.get('http://www.vrbo.com/icalendar/6a52d4a5eea744f59e45b2c4bd8929c4.ics')
        @body = response.body  
        @ical = Selene.parse(@body)["vcalendar"][0]["vevent"][0]["dtend"][0]
        
        #puts JSON.pretty_generate(@ical)
    end
end
