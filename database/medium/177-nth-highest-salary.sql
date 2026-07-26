CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (Salary INT) AS $$
BEGIN
  RETURN QUERY (
    -- Write your PostgreSQL query statement below.
    with sal as (
        select a.salary,
                dense_rank() over(order by a.salary desc) escala
        from Employee a
    )
    select max(sal.salary) Salary
    from sal
    where escala = N
  );
END;
$$ LANGUAGE plpgsql;
