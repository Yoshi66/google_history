require 'selenium-webdriver'

driver =Selenium::WebDriver.for :firefox
driver.navigate.to "http://history.google.com"

element = driver.find_element(:name, "Email")
element.send_keys('yoshiki.mc@gmail.com')
element = driver.find_element(:name, "Passwd")
element.send_keys('Yoshi0412')

driver.find_element(:name, 'signIn').click

sleep(2)

div1 = driver.find_element(:xpath, '//*[@class="result"]/tbody/tr/td[2]/span[2]')
puts div1.text

# div = driver.find_element(:name, 'edit').find_elements(:xpath, './div')
# 1.upto(div.length - 1){|i|
#     p div[i].find_element(:class, 'result')
#     # text = div[i].text
#     # puts text
#     # p div[i]
#     # p div[i].find_element(:class,'result')
#     #   text = div[i].text
#     #   puts text
#     }

