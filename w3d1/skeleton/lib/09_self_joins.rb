# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: routes
#
#  num         :string       not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop_id     :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
  select
    count(*)
  from
    stops
  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
    select
      id
    from
      stops
    where
      name = 'Craiglockhart'
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
    select
      stops.id, stops.name
    from
      stops
      join routes
      on stops.id = routes.stop_id

    where
      routes.num = '4' and routes.company = 'LRT'
  SQL
end

def connecting_routes
  # Consider the following query:
  #
  # SELECT
  #   company,
  #   num,
  #   COUNT(*)
  # FROM
  #   routes
  # WHERE
  #   stop_id = 149 OR stop_id = 53
  # GROUP BY
  #   company, num
  #
  # The query gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have a count of 2. Add a HAVING clause to restrict
  # the output to these two routes.
  execute(<<-SQL)
  SELECT
    company,
    num,
    COUNT(*)
  FROM
    routes
  WHERE
    stop_id = 149 OR stop_id = 53
  GROUP BY
    company, num
  having
    count(*) > 1
  SQL
end

def cl_to_lr
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   a.stop_id,
  #   b.stop_id
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # WHERE
  #   a.stop_id = 53
  #
  # Observe that b.stop_id gives all the places you can get to from
  # Craiglockhart, without changing routes. Change the query so that it
  # shows the services from Craiglockhart to London Road.
  execute(<<-SQL)
  SELECT
    a.company,
    a.num,
    a.stop_id,
    b.stop_id
  FROM
    routes a
  JOIN
    routes b ON (a.company = b.company AND a.num = b.num)
  WHERE
    a.stop_id = 53 and b.stop_id = 149
  SQL
end

def cl_to_lr_by_name
  # Consider the query:
  #
  # SELECT
  #   a.company,
  #   a.num,
  #   stopa.name,
  #   stopb.name
  # FROM
  #   routes a
  # JOIN
  #   routes b ON (a.company = b.company AND a.num = b.num)
  # JOIN
  #   stops stopa ON (a.stop_id = stopa.id)
  # JOIN
  #   stops stopb ON (b.stop_id = stopb.id)
  # WHERE
  #   stopa.name = 'Craiglockhart'
  #
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown.
  execute(<<-SQL)
   SELECT
     a.company,
     a.num,
     stopa.name,
     stopb.name
   FROM
     routes a
   JOIN
     routes b ON (a.company = b.company AND a.num = b.num)
   JOIN
     stops stopa ON (a.stop_id = stopa.id)
   JOIN
     stops stopb ON (b.stop_id = stopb.id)
   WHERE
     stopa.name = 'Craiglockhart' and stopb.name = 'London Road'
  SQL
end

def haymarket_and_leith
  # Give the company and num of the services that connect stops
  # 115 and 137 ('Haymarket' and 'Leith')
  execute(<<-SQL)
  select distinct
    a.company,
    b.num
  from
    routes as  a
    join routes as b
    on a.company = b.company and a.num = b.num
    join stops as stopa
    on stopa.id = a.stop_id
    join stops as stopb
    on stopb.id = b.stop_id
  where
    stopa.name = 'Haymarket' and stopb.name = 'Leith'
  SQL
end

def craiglockhart_and_tollcross
  # Give the company and num of the services that connect stops
  # 'Craiglockhart' and 'Tollcross'
  execute(<<-SQL)
  select
    a.company,
    a.num
  from
    routes a
    join routes b
    on a.company = b.company and b.num = a.num
    join stops stopa
    on stopa.id = a.stop_id
    join stops stopb
    on stopb.id = b.stop_id
  where
    stopa.name = 'Craiglockhart' and stopb.name = 'Tollcross'
  SQL
end

def start_at_craiglockhart
  # Give a distinct list of the stops that can be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the stop name,
  # as well as the company and bus no. of the relevant service.
  execute(<<-SQL)
    select
      stopb.name,
      a.company,
      a.num
    from
      routes a
      join routes b
      on a.company = b.company and a.num = b.num
      join stops stopa
      on stopa.id = a.stop_id
      join stops stopb
      on stopb.id = b.stop_id
    where
      stopa.name = 'Craiglockhart'
  SQL
end

def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  execute(<<-SQL)
    select distinct
      stopc.a_num,
      stopc.a_comp,
      stopc.name,
      d.num,
      d.company
    from
      (select
        stopb.name as name, stopb.id as id, a.num as a_num, a.company as a_comp
      from
        routes a
      join routes b
      on a.company = b.company and a.num = b.num
      join stops stopa
      on stopa.id = a.stop_id
      join stops stopb
      on stopb.id = b.stop_id
    where
      stopa.name = 'Craiglockhart'
    ) as stopc

      join routes c
      on  c.stop_id = stopc.id
      join routes d
      on c.company = d.company and c.num = d.num
      join stops stopd
      on stopd.id = d.stop_id
    where
      stopd.name = 'Sighthill'
  SQL
end
