select 
case 
    when p is Null then concat(n, ' Root' )
    when n in (select distinct(p) from bst) then concat(n, ' Inner')
    else concat(n, ' Leaf')
end as output
from bst order by n;
