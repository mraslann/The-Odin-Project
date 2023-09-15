require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

def clean_zipcode(zipcode)
    zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_numbers(phone_number)
    actual_number = ""
    phone_number.split('').each do |digit|
        if digit >= '0' && digit <= '9'
            actual_number += digit
        end
    end
    if actual_number.length == 10
        actual_number
    elsif actual_number.length == 11 && actual_number[0] == '1'
        actual_number[1..10]
    else
        "Wrong number!"
    end
end

def legislators_by_zipcode(zipcode)
    civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
    civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
    begin
        legislators = civic_info.representative_info_by_address(
            address: zipcode, 
            levels: 'country', 
            roles: ['legislatorUpperBody', 'legislatorLowerBody']).officials
    rescue
        'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
    end
end

def save_thank_you_letter(id, form_letter)
    Dir.mkdir('output') unless Dir.exist?('output')
    filename = "output/thanks_#{id}.html"
    File.open(filename, 'w') do |file|
        file.puts form_letter
    end
end

def most_common_time(time, most_common)
    if most_common[time].nil?
        most_common[time] = 1
    else
        most_common[time] += 1
    end
end

puts 'Event Manager Initialized!'
most_common_hour = Hash.new(0)
most_common_day = Hash.new(0)
days = {0 => "Sunday", 1 => "Monday", 2 => "Tuesday", 3 => "Wednesday", 4 => "Thursday", 5 => "Friday", 6 => "Saturday"}
template_letter = File.read("form_letter.erb")
erb_template = ERB.new template_letter
contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)
contents.each do |row|
    id = row[0]
    name = row[:first_name]
    zipcode = row[:zipcode]
    phone_number = row[:homephone]
    registration_date = row[:regdate]
    registration_date = DateTime.strptime(registration_date, "%m/%d/%Y %H:%M")
    hour = registration_date.hour
    day = registration_date.wday
    most_common_time(hour, most_common_hour)
    most_common_time(day, most_common_day)
    phone_number = clean_phone_numbers(phone_number)
    zipcode = clean_zipcode(zipcode)
    legislators = legislators_by_zipcode(zipcode)
    form_letter = erb_template.result(binding)
    save_thank_you_letter(id, form_letter)
end
max_hour = most_common_hour.max_by {|key, value| value}
max_day = most_common_day.max_by {|key, value| value}
puts "The most common hour is #{max_hour[0]}"
puts "The most common day is #{days[max_day[0]]}"