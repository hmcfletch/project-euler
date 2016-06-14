# You are given the following information, but you may prefer to do some research for yourself.
#
# - 1 Jan 1900 was a Monday.
# - Thirty days has September,
#   April, June and November.
#   All the rest have thirty-one,
#   Saving February alone,
#   Which has twenty-eight, rain or shine.
#   And on leap years, twenty-nine.
# - A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
#
# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

require 'date'

MONTH_DAYS = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ]

def is_leap_year?(year)
  (year % 4 == 0 && !(year % 100 == 0)) || year % 400 == 0
end

def should_count?(year, month, day)
  year >= 1901 && year <= 2000
end

def max_month_days(year, month)
  if month == 2 && is_leap_year?(year)
    29
  else
    MONTH_DAYS[month - 1]
  end
end

def next_date(year, month, day)
  max_days = max_month_days(year, month)

  if day < max_days
    day += 1
  else
    month += 1
    day = 1
  end

  if month > 12
    year += 1
    month = 1
  end

  return [year, month, day]
end

year = 1900
month = 1
day = 1

day_num = 0

count = 0

while year <= 2000
  if should_count?(year, month, day) && day_num % 7 == 6 && day == 1
    count += 1
  end

  year, month, day = next_date(year, month, day)
  day_num += 1
end

puts count
