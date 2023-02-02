{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "45b94381",
   "metadata": {
    "papermill": {
     "duration": 0.004052,
     "end_time": "2023-02-02T08:27:06.621817",
     "exception": false,
     "start_time": "2023-02-02T08:27:06.617765",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  },
  {
   "cell_type": "markdown",
   "id": "294d2dcd",
   "metadata": {
    "papermill": {
     "duration": 0.00286,
     "end_time": "2023-02-02T08:27:06.627555",
     "exception": false,
     "start_time": "2023-02-02T08:27:06.624695",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Using R Code to Clean and Analyze Cyclistic Data\n",
    "\n",
    "Preparing for Cleaning"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "93d10826",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-02-02T08:27:06.637906Z",
     "iopub.status.busy": "2023-02-02T08:27:06.635157Z",
     "iopub.status.idle": "2023-02-02T08:27:59.765335Z",
     "shell.execute_reply": "2023-02-02T08:27:59.762666Z"
    },
    "papermill": {
     "duration": 53.138785,
     "end_time": "2023-02-02T08:27:59.768991",
     "exception": false,
     "start_time": "2023-02-02T08:27:06.630206",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.2 ──\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.4.0      \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 1.0.1 \n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.8      \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.10\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.2.1      \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.5.0 \n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.1.3      \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.2 \n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "Loading required package: timechange\n",
      "\n",
      "\n",
      "Attaching package: ‘lubridate’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:base’:\n",
      "\n",
      "    date, intersect, setdiff, union\n",
      "\n",
      "\n",
      "\n",
      "Attaching package: ‘chron’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:lubridate’:\n",
      "\n",
      "    days, hours, minutes, seconds, years\n",
      "\n",
      "\n",
      "\n",
      "Attaching package: ‘hms’\n",
      "\n",
      "\n",
      "The following object is masked from ‘package:lubridate’:\n",
      "\n",
      "    hms\n",
      "\n",
      "\n",
      "\n",
      "Attaching package: ‘data.table’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:lubridate’:\n",
      "\n",
      "    hour, isoweek, mday, minute, month, quarter, second, wday, week,\n",
      "    yday, year\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:dplyr’:\n",
      "\n",
      "    between, first, last\n",
      "\n",
      "\n",
      "The following object is masked from ‘package:purrr’:\n",
      "\n",
      "    transpose\n",
      "\n",
      "\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m103770\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m11\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (5): ride_id, rideable_type, started_at, ended_at, member_casual\n",
      "\u001b[32mdbl\u001b[39m  (1): day_of_week\n",
      "\u001b[34mdate\u001b[39m (2): start_date, end_date\n",
      "\u001b[34mtime\u001b[39m (3): start_time, end_time, ride_length\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m115609\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m11\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (5): ride_id, rideable_type, started_at, ended_at, member_casual\n",
      "\u001b[32mdbl\u001b[39m  (1): day_of_week\n",
      "\u001b[34mdate\u001b[39m (2): start_date, end_date\n",
      "\u001b[34mtime\u001b[39m (3): start_time, end_time, ride_length\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m284042\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m11\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (5): ride_id, rideable_type, started_at, ended_at, member_casual\n",
      "\u001b[32mdbl\u001b[39m  (1): day_of_week\n",
      "\u001b[34mdate\u001b[39m (2): start_date, end_date\n",
      "\u001b[34mtime\u001b[39m (3): start_time, end_time, ride_length\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m371249\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m11\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (5): ride_id, rideable_type, started_at, ended_at, member_casual\n",
      "\u001b[32mdbl\u001b[39m  (1): day_of_week\n",
      "\u001b[34mdate\u001b[39m (2): start_date, end_date\n",
      "\u001b[34mtime\u001b[39m (3): start_time, end_time, ride_length\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m634858\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m11\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (5): ride_id, rideable_type, started_at, ended_at, member_casual\n",
      "\u001b[32mdbl\u001b[39m  (1): day_of_week\n",
      "\u001b[34mdate\u001b[39m (2): start_date, end_date\n",
      "\u001b[34mtime\u001b[39m (3): start_time, end_time, ride_length\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m769204\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m11\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (5): ride_id, rideable_type, started_at, ended_at, member_casual\n",
      "\u001b[32mdbl\u001b[39m  (1): day_of_week\n",
      "\u001b[34mdate\u001b[39m (2): start_date, end_date\n",
      "\u001b[34mtime\u001b[39m (3): start_time, end_time, ride_length\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m823488\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m11\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, started_at, ended_at, member_casual, start...\n",
      "\u001b[32mdbl\u001b[39m  (1): day_of_week\n",
      "\u001b[34mtime\u001b[39m (3): start_time, end_time, ride_length\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m785932\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m11\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (5): ride_id, rideable_type, started_at, ended_at, member_casual\n",
      "\u001b[32mdbl\u001b[39m  (1): day_of_week\n",
      "\u001b[34mdate\u001b[39m (2): start_date, end_date\n",
      "\u001b[34mtime\u001b[39m (3): start_time, end_time, ride_length\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m701339\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m11\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (5): ride_id, rideable_type, started_at, ended_at, member_casual\n",
      "\u001b[32mdbl\u001b[39m  (1): day_of_week\n",
      "\u001b[34mdate\u001b[39m (2): start_date, end_date\n",
      "\u001b[34mtime\u001b[39m (3): start_time, end_time, ride_length\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m558685\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m11\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (5): ride_id, rideable_type, started_at, ended_at, member_casual\n",
      "\u001b[32mdbl\u001b[39m  (1): day_of_week\n",
      "\u001b[34mdate\u001b[39m (2): start_date, end_date\n",
      "\u001b[34mtime\u001b[39m (3): start_time, end_time, ride_length\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m337735\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m11\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (5): ride_id, rideable_type, started_at, ended_at, member_casual\n",
      "\u001b[32mdbl\u001b[39m  (1): day_of_week\n",
      "\u001b[34mdate\u001b[39m (2): start_date, end_date\n",
      "\u001b[34mtime\u001b[39m (3): start_time, end_time, ride_length\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n",
      "\u001b[1mRows: \u001b[22m\u001b[34m181806\u001b[39m \u001b[1mColumns: \u001b[22m\u001b[34m11\u001b[39m\n",
      "\u001b[36m──\u001b[39m \u001b[1mColumn specification\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (5): ride_id, rideable_type, started_at, ended_at, member_casual\n",
      "\u001b[32mdbl\u001b[39m  (1): day_of_week\n",
      "\u001b[34mdate\u001b[39m (2): start_date, end_date\n",
      "\u001b[34mtime\u001b[39m (3): start_time, end_time, ride_length\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use `spec()` to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set `show_col_types = FALSE` to quiet this message.\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 11</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>ride_id</th><th scope=col>rideable_type</th><th scope=col>started_at</th><th scope=col>ended_at</th><th scope=col>member_casual</th><th scope=col>start_date</th><th scope=col>start_time</th><th scope=col>end_date</th><th scope=col>end_time</th><th scope=col>ride_length</th><th scope=col>day_of_week</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;time&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;time&gt;</th><th scope=col>&lt;time&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>C2F7DD78E82EC875</td><td>electric_bike</td><td>13-01-2022 11:59</td><td>13-01-2022 12:02</td><td>casual</td><td>2022-01-13</td><td>11:59:47</td><td>2022-01-13</td><td>12:02:44</td><td>00:02:57</td><td>5</td></tr>\n",
       "\t<tr><td>A6CF8980A652D272</td><td>electric_bike</td><td>10-01-2022 08:41</td><td>10-01-2022 08:46</td><td>casual</td><td>2022-01-10</td><td>08:41:56</td><td>2022-01-10</td><td>08:46:17</td><td>00:04:21</td><td>2</td></tr>\n",
       "\t<tr><td>BD0F91DFF741C66D</td><td>classic_bike </td><td>25-01-2022 04:53</td><td>25-01-2022 04:58</td><td>member</td><td>2022-01-25</td><td>04:53:40</td><td>2022-01-25</td><td>04:58:01</td><td>00:04:21</td><td>3</td></tr>\n",
       "\t<tr><td>CBB80ED419105406</td><td>classic_bike </td><td>04-01-2022 00:18</td><td>04-01-2022 00:33</td><td>casual</td><td>2022-01-04</td><td>00:18:04</td><td>2022-01-04</td><td>00:33:00</td><td>00:14:56</td><td>3</td></tr>\n",
       "\t<tr><td>DDC963BFDDA51EEA</td><td>classic_bike </td><td>20-01-2022 01:31</td><td>20-01-2022 01:37</td><td>member</td><td>2022-01-20</td><td>01:31:10</td><td>2022-01-20</td><td>01:37:12</td><td>00:06:02</td><td>5</td></tr>\n",
       "\t<tr><td>A39C6F6CC0586C0B</td><td>classic_bike </td><td>11-01-2022 18:48</td><td>11-01-2022 18:51</td><td>member</td><td>2022-01-11</td><td>18:48:09</td><td>2022-01-11</td><td>18:51:31</td><td>00:03:22</td><td>3</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 11\n",
       "\\begin{tabular}{lllllllllll}\n",
       " ride\\_id & rideable\\_type & started\\_at & ended\\_at & member\\_casual & start\\_date & start\\_time & end\\_date & end\\_time & ride\\_length & day\\_of\\_week\\\\\n",
       " <chr> & <chr> & <chr> & <chr> & <chr> & <date> & <time> & <date> & <time> & <time> & <dbl>\\\\\n",
       "\\hline\n",
       "\t C2F7DD78E82EC875 & electric\\_bike & 13-01-2022 11:59 & 13-01-2022 12:02 & casual & 2022-01-13 & 11:59:47 & 2022-01-13 & 12:02:44 & 00:02:57 & 5\\\\\n",
       "\t A6CF8980A652D272 & electric\\_bike & 10-01-2022 08:41 & 10-01-2022 08:46 & casual & 2022-01-10 & 08:41:56 & 2022-01-10 & 08:46:17 & 00:04:21 & 2\\\\\n",
       "\t BD0F91DFF741C66D & classic\\_bike  & 25-01-2022 04:53 & 25-01-2022 04:58 & member & 2022-01-25 & 04:53:40 & 2022-01-25 & 04:58:01 & 00:04:21 & 3\\\\\n",
       "\t CBB80ED419105406 & classic\\_bike  & 04-01-2022 00:18 & 04-01-2022 00:33 & casual & 2022-01-04 & 00:18:04 & 2022-01-04 & 00:33:00 & 00:14:56 & 3\\\\\n",
       "\t DDC963BFDDA51EEA & classic\\_bike  & 20-01-2022 01:31 & 20-01-2022 01:37 & member & 2022-01-20 & 01:31:10 & 2022-01-20 & 01:37:12 & 00:06:02 & 5\\\\\n",
       "\t A39C6F6CC0586C0B & classic\\_bike  & 11-01-2022 18:48 & 11-01-2022 18:51 & member & 2022-01-11 & 18:48:09 & 2022-01-11 & 18:51:31 & 00:03:22 & 3\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 11\n",
       "\n",
       "| ride_id &lt;chr&gt; | rideable_type &lt;chr&gt; | started_at &lt;chr&gt; | ended_at &lt;chr&gt; | member_casual &lt;chr&gt; | start_date &lt;date&gt; | start_time &lt;time&gt; | end_date &lt;date&gt; | end_time &lt;time&gt; | ride_length &lt;time&gt; | day_of_week &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| C2F7DD78E82EC875 | electric_bike | 13-01-2022 11:59 | 13-01-2022 12:02 | casual | 2022-01-13 | 11:59:47 | 2022-01-13 | 12:02:44 | 00:02:57 | 5 |\n",
       "| A6CF8980A652D272 | electric_bike | 10-01-2022 08:41 | 10-01-2022 08:46 | casual | 2022-01-10 | 08:41:56 | 2022-01-10 | 08:46:17 | 00:04:21 | 2 |\n",
       "| BD0F91DFF741C66D | classic_bike  | 25-01-2022 04:53 | 25-01-2022 04:58 | member | 2022-01-25 | 04:53:40 | 2022-01-25 | 04:58:01 | 00:04:21 | 3 |\n",
       "| CBB80ED419105406 | classic_bike  | 04-01-2022 00:18 | 04-01-2022 00:33 | casual | 2022-01-04 | 00:18:04 | 2022-01-04 | 00:33:00 | 00:14:56 | 3 |\n",
       "| DDC963BFDDA51EEA | classic_bike  | 20-01-2022 01:31 | 20-01-2022 01:37 | member | 2022-01-20 | 01:31:10 | 2022-01-20 | 01:37:12 | 00:06:02 | 5 |\n",
       "| A39C6F6CC0586C0B | classic_bike  | 11-01-2022 18:48 | 11-01-2022 18:51 | member | 2022-01-11 | 18:48:09 | 2022-01-11 | 18:51:31 | 00:03:22 | 3 |\n",
       "\n"
      ],
      "text/plain": [
       "  ride_id          rideable_type started_at       ended_at        \n",
       "1 C2F7DD78E82EC875 electric_bike 13-01-2022 11:59 13-01-2022 12:02\n",
       "2 A6CF8980A652D272 electric_bike 10-01-2022 08:41 10-01-2022 08:46\n",
       "3 BD0F91DFF741C66D classic_bike  25-01-2022 04:53 25-01-2022 04:58\n",
       "4 CBB80ED419105406 classic_bike  04-01-2022 00:18 04-01-2022 00:33\n",
       "5 DDC963BFDDA51EEA classic_bike  20-01-2022 01:31 20-01-2022 01:37\n",
       "6 A39C6F6CC0586C0B classic_bike  11-01-2022 18:48 11-01-2022 18:51\n",
       "  member_casual start_date start_time end_date   end_time ride_length\n",
       "1 casual        2022-01-13 11:59:47   2022-01-13 12:02:44 00:02:57   \n",
       "2 casual        2022-01-10 08:41:56   2022-01-10 08:46:17 00:04:21   \n",
       "3 member        2022-01-25 04:53:40   2022-01-25 04:58:01 00:04:21   \n",
       "4 casual        2022-01-04 00:18:04   2022-01-04 00:33:00 00:14:56   \n",
       "5 member        2022-01-20 01:31:10   2022-01-20 01:37:12 00:06:02   \n",
       "6 member        2022-01-11 18:48:09   2022-01-11 18:51:31 00:03:22   \n",
       "  day_of_week\n",
       "1 5          \n",
       "2 2          \n",
       "3 3          \n",
       "4 3          \n",
       "5 5          \n",
       "6 3          "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#loading libraries\n",
    "library(tidyverse)\n",
    "\n",
    "library(lubridate)\n",
    "\n",
    "library(chron)\n",
    "\n",
    "library(hms)\n",
    "\n",
    "library(data.table)\n",
    "\n",
    "jan22 <- read_csv(\"/kaggle/input/cyclistic-data/202201.csv\")\n",
    "\n",
    "feb22 <- read_csv(\"/kaggle/input/cyclistic-data/202202.csv\")\n",
    "\n",
    "mar22 <- read_csv(\"/kaggle/input/cyclistic-data/202203.csv\")\n",
    "\n",
    "apr22 <- read_csv(\"/kaggle/input/cyclistic-data/202204.csv\")\n",
    "\n",
    "may22 <- read_csv(\"/kaggle/input/cyclistic-data/202205.csv\")\n",
    "\n",
    "jun22 <- read_csv(\"/kaggle/input/cyclistic-data/202206.csv\")\n",
    "\n",
    "jul22 <- read_csv(\"/kaggle/input/cyclistic-data/202207.csv\")\n",
    "\n",
    "aug22 <- read_csv(\"/kaggle/input/cyclistic-data/202208.csv\")\n",
    "\n",
    "sep22 <- read_csv(\"/kaggle/input/cyclistic-data/202209.csv\")\n",
    "\n",
    "oct22 <- read_csv(\"/kaggle/input/cyclistic-data/202210.csv\")\n",
    "\n",
    "nov22 <- read_csv(\"/kaggle/input/cyclistic-data/202211.csv\")\n",
    "\n",
    "dec22 <- read_csv(\"/kaggle/input/cyclistic-data/202212.csv\")\n",
    "\n",
    "#merge all dataframes into one year view using rbind\n",
    "cyclistic_df <- rbind(jan22,feb22,mar22,apr22,may22,jun22,jul22,aug22,sep22,oct22,nov22,dec22)\n",
    "\n",
    "#view first 6 rows of data set with column headings and data types\n",
    "head(cyclistic_df)\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "9d0dce0e",
   "metadata": {
    "papermill": {
     "duration": 0.006037,
     "end_time": "2023-02-02T08:27:59.783030",
     "exception": false,
     "start_time": "2023-02-02T08:27:59.776993",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Further Data Cleaning"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "4894a8f6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-02-02T08:27:59.826911Z",
     "iopub.status.busy": "2023-02-02T08:27:59.796981Z",
     "iopub.status.idle": "2023-02-02T08:28:08.924828Z",
     "shell.execute_reply": "2023-02-02T08:28:08.922927Z"
    },
    "papermill": {
     "duration": 9.138453,
     "end_time": "2023-02-02T08:28:08.927475",
     "exception": false,
     "start_time": "2023-02-02T08:27:59.789022",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#removing any NA's or duplicates, removing invalid data\n",
    "cyclistic_df <- na.omit(cyclistic_df) #remove rows with NA values\n",
    "cyclistic_df <- distinct(cyclistic_df) #remove duplicate rows\n",
    "cyclistic_df <- cyclistic_df[!(cyclistic_df$ride_length <= 0),] #remove rows where ride length is 0 or negative"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "80a7b830",
   "metadata": {
    "papermill": {
     "duration": 0.006292,
     "end_time": "2023-02-02T08:28:08.940144",
     "exception": false,
     "start_time": "2023-02-02T08:28:08.933852",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Adding new columns for Times of Day"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "3462fb11",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-02-02T08:28:08.956411Z",
     "iopub.status.busy": "2023-02-02T08:28:08.954666Z",
     "iopub.status.idle": "2023-02-02T08:28:28.625561Z",
     "shell.execute_reply": "2023-02-02T08:28:28.623724Z"
    },
    "papermill": {
     "duration": 19.68237,
     "end_time": "2023-02-02T08:28:28.628581",
     "exception": false,
     "start_time": "2023-02-02T08:28:08.946211",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "cyclistic_df$day_of_week <- format(as.Date(cyclistic_df$start_date),\"%A\") #modified day_of_week column with the day name\n",
    "#create a column for different times of the day\n",
    "h <- hour(cyclistic_df$start_time)\n",
    "cyclistic_df <- cyclistic_df %>% mutate(time_of_day = \n",
    "                                          case_when(h == \"0\" ~ \"Night\",\n",
    "                                                    h == \"1\" ~ \"Night\",\n",
    "                                                    h == \"2\" ~ \"Night\",\n",
    "                                                    h == \"3\" ~ \"Night\",\n",
    "                                                    h == \"4\" ~ \"Night\",\n",
    "                                                    h == \"5\" ~ \"Night\",\n",
    "                                                    h == \"6\" ~ \"Morning\",\n",
    "                                                    h == \"7\" ~ \"Morning\",\n",
    "                                                    h == \"8\" ~ \"Morning\",\n",
    "                                                    h == \"9\" ~ \"Morning\",\n",
    "                                                    h == \"10\" ~ \"Morning\",\n",
    "                                                    h == \"11\" ~ \"Morning\",\n",
    "                                                    h == \"12\" ~ \"Afternoon\",\n",
    "                                                    h == \"13\" ~ \"Afternoon\",\n",
    "                                                    h == \"14\" ~ \"Afternoon\",\n",
    "                                                    h == \"15\" ~ \"Afternoon\",\n",
    "                                                    h == \"16\" ~ \"Afternoon\",\n",
    "                                                    h == \"17\" ~ \"Afternoon\",\n",
    "                                                    h == \"18\" ~ \"Evening\",\n",
    "                                                    h == \"19\" ~ \"Evening\",\n",
    "                                                    h == \"20\" ~ \"Evening\",\n",
    "                                                    h == \"21\" ~ \"Evening\",\n",
    "                                                    h == \"22\" ~ \"Evening\",\n",
    "                                                    h == \"23\" ~ \"Evening\")\n",
    "                                        )"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "274a78e0",
   "metadata": {
    "papermill": {
     "duration": 0.006031,
     "end_time": "2023-02-02T08:28:28.640682",
     "exception": false,
     "start_time": "2023-02-02T08:28:28.634651",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Computing Statistics on the Data"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "714bfa81",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-02-02T08:28:28.655882Z",
     "iopub.status.busy": "2023-02-02T08:28:28.654355Z",
     "iopub.status.idle": "2023-02-02T08:28:34.855708Z",
     "shell.execute_reply": "2023-02-02T08:28:34.853989Z"
    },
    "papermill": {
     "duration": 6.211655,
     "end_time": "2023-02-02T08:28:34.858245",
     "exception": false,
     "start_time": "2023-02-02T08:28:28.646590",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 2 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>member_casual</th><th scope=col>max_ride_time</th><th scope=col>min_ride_time</th><th scope=col>mean_ride_time</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>1408.5</td><td>0.1</td><td>21.04443</td></tr>\n",
       "\t<tr><td>member</td><td>1165.8</td><td>0.1</td><td>12.22060</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 2 × 4\n",
       "\\begin{tabular}{llll}\n",
       " member\\_casual & max\\_ride\\_time & min\\_ride\\_time & mean\\_ride\\_time\\\\\n",
       " <chr> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 1408.5 & 0.1 & 21.04443\\\\\n",
       "\t member & 1165.8 & 0.1 & 12.22060\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 2 × 4\n",
       "\n",
       "| member_casual &lt;chr&gt; | max_ride_time &lt;dbl&gt; | min_ride_time &lt;dbl&gt; | mean_ride_time &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| casual | 1408.5 | 0.1 | 21.04443 |\n",
       "| member | 1165.8 | 0.1 | 12.22060 |\n",
       "\n"
      ],
      "text/plain": [
       "  member_casual max_ride_time min_ride_time mean_ride_time\n",
       "1 casual        1408.5        0.1           21.04443      \n",
       "2 member        1165.8        0.1           12.22060      "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>member_casual</th><th scope=col>n</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>2298798</td></tr>\n",
       "\t<tr><td>member</td><td>3328810</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " member\\_casual & n\\\\\n",
       " <chr> & <int>\\\\\n",
       "\\hline\n",
       "\t casual & 2298798\\\\\n",
       "\t member & 3328810\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 2 × 2\n",
       "\n",
       "| member_casual &lt;chr&gt; | n &lt;int&gt; |\n",
       "|---|---|\n",
       "| casual | 2298798 |\n",
       "| member | 3328810 |\n",
       "\n"
      ],
      "text/plain": [
       "  member_casual n      \n",
       "1 casual        2298798\n",
       "2 member        3328810"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\u001b[90m# A tibble: 5 × 3\u001b[39m\n",
      "\u001b[90m# Groups:   member_casual, rideable_type [5]\u001b[39m\n",
      "  member_casual rideable_type       n\n",
      "  \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m         \u001b[3m\u001b[90m<chr>\u001b[39m\u001b[23m           \u001b[3m\u001b[90m<int>\u001b[39m\u001b[23m\n",
      "\u001b[90m1\u001b[39m casual        classic_bike   \u001b[4m8\u001b[24m\u001b[4m8\u001b[24m\u001b[4m2\u001b[24m723\n",
      "\u001b[90m2\u001b[39m casual        docked_bike    \u001b[4m1\u001b[24m\u001b[4m7\u001b[24m\u001b[4m3\u001b[24m157\n",
      "\u001b[90m3\u001b[39m casual        electric_bike 1\u001b[4m2\u001b[24m\u001b[4m4\u001b[24m\u001b[4m2\u001b[24m918\n",
      "\u001b[90m4\u001b[39m member        classic_bike  1\u001b[4m7\u001b[24m\u001b[4m0\u001b[24m\u001b[4m1\u001b[24m551\n",
      "\u001b[90m5\u001b[39m member        electric_bike 1\u001b[4m6\u001b[24m\u001b[4m2\u001b[24m\u001b[4m7\u001b[24m259\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "5627608"
      ],
      "text/latex": [
       "5627608"
      ],
      "text/markdown": [
       "5627608"
      ],
      "text/plain": [
       "[1] 5627608"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>member_casual</th><th scope=col>mode_day_of_week</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>Saturday</td></tr>\n",
       "\t<tr><td>member</td><td>Thursday</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " member\\_casual & mode\\_day\\_of\\_week\\\\\n",
       " <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t casual & Saturday\\\\\n",
       "\t member & Thursday\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 2 × 2\n",
       "\n",
       "| member_casual &lt;chr&gt; | mode_day_of_week &lt;chr&gt; |\n",
       "|---|---|\n",
       "| casual | Saturday |\n",
       "| member | Thursday |\n",
       "\n"
      ],
      "text/plain": [
       "  member_casual mode_day_of_week\n",
       "1 casual        Saturday        \n",
       "2 member        Thursday        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 2 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>member_casual</th><th scope=col>mode_time</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;time&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>17:05:56</td></tr>\n",
       "\t<tr><td>member</td><td>17:04:12</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 2 × 2\n",
       "\\begin{tabular}{ll}\n",
       " member\\_casual & mode\\_time\\\\\n",
       " <chr> & <time>\\\\\n",
       "\\hline\n",
       "\t casual & 17:05:56\\\\\n",
       "\t member & 17:04:12\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 2 × 2\n",
       "\n",
       "| member_casual &lt;chr&gt; | mode_time &lt;time&gt; |\n",
       "|---|---|\n",
       "| casual | 17:05:56 |\n",
       "| member | 17:04:12 |\n",
       "\n"
      ],
      "text/plain": [
       "  member_casual mode_time\n",
       "1 casual        17:05:56 \n",
       "2 member        17:04:12 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#calculate ride length and convert to minutes\n",
    "\n",
    "cyclistic_df$ride_length <- as.numeric(difftime(cyclistic_df$end_time,cyclistic_df$start_time, units = \"mins\"))\n",
    "cyclistic_df$ride_length <- round(cyclistic_df$ride_length, digits = 1)\n",
    "\n",
    "#max, min and mean ride times\n",
    "\n",
    "cyclistic_df <- cyclistic_df[!(cyclistic_df$ride_length <= 0),] #remove rows where ride length is 0 or negative\n",
    "\n",
    "cyclistic_df %>% \n",
    "  group_by(member_casual) %>% \n",
    "  summarise(max_ride_time = max(ride_length),\n",
    "            min_ride_time = min(ride_length),\n",
    "            mean_ride_time = mean(ride_length))\n",
    "\n",
    "#compare membership types\n",
    "cyclistic_df %>% \n",
    "  group_by(member_casual) %>% \n",
    "  count(member_casual)\n",
    "\n",
    "#how many people use each type of bike\n",
    "rideable_share <- cyclistic_df %>% \n",
    "  group_by(member_casual, rideable_type) %>% \n",
    "  count(member_casual)\n",
    "print(rideable_share)\n",
    "\n",
    "#total number of rides\n",
    "nrow(cyclistic_df)\n",
    "\n",
    "#setting up Mode\n",
    "Mode <- function(x){\n",
    "  ux <- unique(x)\n",
    "  ux[which.max(tabulate(match(x, ux)))]\n",
    "}\n",
    "\n",
    "#find most frequent day of riding\n",
    "cyclistic_df %>%\n",
    "group_by(member_casual) %>%\n",
    "summarise(mode_day_of_week = Mode(day_of_week))\n",
    "\n",
    "#find the most frequent time of riding\n",
    "cyclistic_df %>%\n",
    "group_by(member_casual) %>%\n",
    "summarise(mode_time = Mode(start_time))\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "62e3dec3",
   "metadata": {
    "papermill": {
     "duration": 0.007182,
     "end_time": "2023-02-02T08:28:34.872682",
     "exception": false,
     "start_time": "2023-02-02T08:28:34.865500",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "Saving the new csv file"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "f97e511b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2023-02-02T08:28:34.889617Z",
     "iopub.status.busy": "2023-02-02T08:28:34.888144Z",
     "iopub.status.idle": "2023-02-02T08:28:37.925527Z",
     "shell.execute_reply": "2023-02-02T08:28:37.922526Z"
    },
    "papermill": {
     "duration": 3.050151,
     "end_time": "2023-02-02T08:28:37.929734",
     "exception": false,
     "start_time": "2023-02-02T08:28:34.879583",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#download the new data as .csv file\n",
    "fwrite(cyclistic_df,\"/kaggle/working/cyclistic_data.csv\")\n"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 95.19623,
   "end_time": "2023-02-02T08:28:38.261552",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2023-02-02T08:27:03.065322",
   "version": "2.4.0"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
