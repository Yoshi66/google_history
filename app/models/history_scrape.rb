require 'selenium-webdriver'
require 'time'

def self.check(string)
  string = string.gsub("Searched for ","")
  preposition = [" to "," out "," a "," is "," an "," and "," on "," I "," i "," with "," the "," in "," of ","for","View additional Web & App Activity","|","&"]
  time = ["pm","am"]
  preposition.each do |i|
    if string.include? i
      string = string.gsub(i, " ")
    end
  end
  time.each do |t|
    if string.include? t
      string = string.gsub(string[string.index(t)-5..string.index(t)+1],"")
    end
  end
  return string
end


#日本語削除
#928pmを削除

strings = String.new
result_time = String.new

driver =Selenium::WebDriver.for :firefox
driver.navigate.to "http://history.google.com"

element = driver.find_element(:name, "Email")
element.send_keys('yoshiki.mc@gmail.com')
element = driver.find_element(:name, "Passwd")
element.send_keys('Yoshi0412')


driver.find_element(:name, 'signIn').click

sleep(2)


div = driver.find_element(:name, 'edit').find_elements(:xpath, './div')
1.upto(div.length - 1){|i|
      text = div[i].text
      result = check(text)
      result1 = result.gsub!(/[^0-9a-z ]/i, ' ')
      if result1.nil?
        strings.concat(result)
      else
        strings.concat(result1)
      end
    }
driver.find_elements(:class, 'kd-buttonbar')[2].find_element(:xpath, './a').click


while result_time != "Yesterday" do
#5.times{
    sleep(2)
    div = driver.find_element(:name, 'edit').find_elements(:xpath, './div')
    1.upto(div.length - 1){|i|
      text = div[i].text
      result = check(text)
      result1 = result.gsub!(/[^0-9a-z ]/i, ' ')
      p result1
      if result1.nil?
        if result == "Yesterday"
          result_time = result
        else
        strings.concat(result)
        end
      else
        strings.concat(result1)
      end
    }
    p '////////////////////'
    driver.find_elements(:class, 'kd-buttonbar')[2].find_elements(:xpath, './a')[1].click
end
#}
words = strings.split(' ')
frequency = Hash.new(0)
words.each { |word| frequency[word.downcase] += 1 }
puts "Total Search Number: #{frequency.count}"
Hash[frequency.sort_by{|key,value| value}.reverse.to_a[1..50]].each do |key,value|
 puts "#{key}:#{value}"
end


# current_time = Time.new.to_s[11..15].gsub(":","").to_i
# p current_time
# time = result[result.length-7, result.length-1].gsub(" ","")
#         if time[time.length-2..time.length-1] == "pm"
#           search_time = DateTime.parse("#{time}").strftime("%H:%M").gsub(":","").to_i
#           p current_time - search_time
#         end
