select activity_date as day,
       count(distinct(user_id)) as active_users 
from Activity
where '2019-07-27'::date >= activity_date and activity_date > '2019-07-27'::date - 30 and
      activity_type in ('open_session', 'end_session', 'scroll_down', 'send_message')
group by activity_date
