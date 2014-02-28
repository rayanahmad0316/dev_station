#!/usr/bin/env python

import datetime
import getpass

import requests

ONE_DAY = datetime.timedelta(days=1)

HIRE_DATE = datetime.date(2014, 1, 20)

EXPECTED_HOURS_PER_DAY = 8

DATE_FORMAT_HARVEST_ENTRIES = "%Y%m%d"

WEEKDAY_NUMS = range(5)

now = datetime.datetime.now()
today = now.date()

response = requests.get("http://wandrsmith.harvestapp.com/projects/4871664"
    "/entries?from={from_date}&to={to_date}".format(
    from_date=HIRE_DATE.strftime(DATE_FORMAT_HARVEST_ENTRIES),
    to_date=today.strftime(DATE_FORMAT_HARVEST_ENTRIES)),
    auth=('warren@wandrsmith.net', getpass.getpass()), headers={
        "Accept":"application/json",
        "Content-Type":"application/json",
    })

data = response.json()

actual_time_dict = {}
for entry_date, hours in ((
        datetime.datetime.strptime(item["day_entry"]["spent_at"], "%Y-%m-%d"),
        item["day_entry"]["hours"],
        ) for item in data):
    month_key = datetime.date(entry_date.year, entry_date.month, 1)

    actual_time_dict[month_key] = actual_time_dict.get(month_key, 0) + hours

expected_time_dict = {}
cur_date = HIRE_DATE
while cur_date < today:
    if cur_date.weekday() in WEEKDAY_NUMS:
        month_key = datetime.date(cur_date.year, cur_date.month, 1)
        expected_time_dict[month_key] = expected_time_dict.get(month_key, 0
            ) + EXPECTED_HOURS_PER_DAY
    cur_date += ONE_DAY

total_actual_hours = 0
total_expected_hours = 0

for month_key, expected_hours in expected_time_dict.iteritems():
    actual_hours = actual_time_dict.get(month_key, 0)
    month_diff = actual_hours - expected_hours

    total_actual_hours += actual_hours
    total_expected_hours += expected_hours
    total_diff = total_actual_hours - total_expected_hours

    print
    print "{:%Y, %B}:".format(month_key)
    print "         Expected: {expected_hours:>7.2f}".format(
        expected_hours=expected_hours)
    print "           Actual: {actual_hours:>7.2f}".format(
        actual_hours=actual_hours)
    print "       Difference: {month_diff:>7.2f}".format(month_diff=month_diff)

print
print "   Total Expected: {total_expected_hours:>7.2f}".format(
    total_expected_hours=total_expected_hours)
print "     Total Actual: {total_actual_hours:>7.2f}".format(
    total_actual_hours=total_actual_hours)
print " Total Difference: {total_diff:>7.2f}".format(total_diff=total_diff)
