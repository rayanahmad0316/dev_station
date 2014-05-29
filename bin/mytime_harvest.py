#!/usr/bin/env python

import datetime
import getpass
import json
import os
import sys

import requests

ONE_DAY = datetime.timedelta(days=1)

HIRE_DATE = datetime.date(2014, 1, 20)

EXPECTED_HOURS_PER_DAY = 8

DATE_FORMAT_HARVEST_ENTRIES = "%Y%m%d"

WEEKDAY_NUMS = range(5)

now = datetime.datetime.now()
today = now.date()

pto_filename = "{}_pto.json".format(os.path.splitext(os.path.realpath(
    sys.argv[0]))[0])
if os.path.exists(pto_filename):
    with open(pto_filename) as pto_file:
        raw_pto_dict = json.load(pto_file)
else:
    raw_pto_dict = {}

pto_dict = {}
pto_time_dict = {}
for pto_type in ("holiday", "sick", "vacation"):
    for raw_pto_date, raw_description in raw_pto_dict.get(pto_type, {}
            ).iteritems():
        pto_date = datetime.datetime.strptime(raw_pto_date, "%Y-%m-%d").date()
        if pto_date >= today:
            # We are only interested in time from days in the past
            continue

        pto_description = ": ".join(filter(None, (pto_type.title(),
            raw_description)))

        month_key = datetime.date(pto_date.year, pto_date.month, 1)

        pto_list = pto_dict.setdefault(month_key, [])
        pto_list.append((pto_date, pto_description, EXPECTED_HOURS_PER_DAY))

        pto_time_dict[month_key] = pto_time_dict.get(month_key, 0
            ) + EXPECTED_HOURS_PER_DAY

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

    if entry_date.date() >= today:
        # We are only interested in time from days in the past
        continue

    month_key = datetime.date(entry_date.year, entry_date.month, 1)

    actual_time_dict[month_key] = actual_time_dict.get(month_key, 0) + hours

expected_time_dict = {}
cur_date = HIRE_DATE
while cur_date < today: # Only calculate expected time for days in the past
    if cur_date.weekday() in WEEKDAY_NUMS:
        month_key = datetime.date(cur_date.year, cur_date.month, 1)
        expected_time_dict[month_key] = expected_time_dict.get(month_key, 0
            ) + EXPECTED_HOURS_PER_DAY
    cur_date += ONE_DAY

total_actual_hours = 0
total_pto_hours = 0
total_expected_hours = 0

for index, expected_time_item in enumerate(sorted(
        expected_time_dict.iteritems(), key=lambda x: x[0])):
    month_key, expected_hours = expected_time_item
    actual_hours = actual_time_dict.get(month_key, 0)
    pto_hours = pto_time_dict.get(month_key, 0)
    month_diff = (actual_hours + pto_hours) - expected_hours

    total_actual_hours += actual_hours
    total_pto_hours += pto_hours
    total_expected_hours += expected_hours
    total_diff = (total_actual_hours + total_pto_hours) - total_expected_hours

    print
    print "-" * 26
    print "{:%Y, %B}:".format(month_key)
    print "         Expected: {expected_hours:>7.2f}".format(
        expected_hours=expected_hours)
    print "           Actual: {actual_hours:>7.2f}".format(
        actual_hours=actual_hours)

    pto_items = sorted(pto_dict.get(month_key, []))
    if pto_items:
        print
        for pto_date, pto_description, pto_item_hours in pto_items:
            print "   {:14}: {:>7.2f} {}".format("{:%d, %A}".format(pto_date),
                pto_item_hours, pto_description)
        print "              PTO: {pto_hours:>7.2f}\n".format(
            pto_hours=pto_hours)

    print "       Difference: {month_diff:>7.2f}".format(month_diff=month_diff)

    if index > 0:
        print
        print "   Total Expected: {total_expected_hours:>7.2f}".format(
            total_expected_hours=total_expected_hours)
        print "     Total Actual: {total_actual_hours:>7.2f}".format(
            total_actual_hours=total_actual_hours)
        print "        Total PTO: {total_pto_hours:>7.2f}".format(
            total_pto_hours=total_pto_hours)
        print " Total Difference: {total_diff:>7.2f}".format(
            total_diff=total_diff)
