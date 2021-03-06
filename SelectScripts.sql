--Find the number of games available per Store
SELECT st.STORE_NAME, st.STORE_ID, i.GAME_ID, i.GAME_ID_COUNT as GAMES_AVAILABLE 
from STORE_INFORMATION st, GAME_INVENTORY i
where st.STORE_ID = i.STORE_ID;


--Member Rental Status
SELECT mr.MEMBER_ID,mr.STORE_ID,mr.GAME_ID,g.GAME_NAME, mr.RENTAL_STATUS, COUNT(*),
mr.RENTAL_RETURN_DATE
from MEMBER_RENTALS mr, GAMES g
where mr.GAME_ID = g.GAME_ID
group by mr.MEMBER_ID,mr.STORE_ID,mr.GAME_ID, mr.RENTAL_STATUS,g.GAME_NAME;



--Members per Store
SELECT st.STORE_NAME, st.STORE_LOCATION, st.STORE_ID, i.MEMBER_NAME, i.MEMBER_PHONE_NUMBER, MEMBER_EIRCODE 
from STORE_INFORMATION st, MEMBER_DETAILS i
where st.STORE_ID = i.STORE_ID;


--Number of Rentals per Member with total and returned count
SELECT mr.MEMBER_ID, md.MEMBER_NAME, g.GAME_NAME, mr.GAME_ID, 
COUNT(mr.MEMBER_ID) AS TOTAL_RENTALS, COUNT(mr.RENTAL_RETURN_DATE) as RETURNED_RENTALS
FROM MEMBER_RENTALS mr, MEMBER_DETAILS md, GAMES g
WHERE mr.MEMBER_ID = md.MEMBER_ID
AND mr.GAME_ID = g.GAME_ID
GROUP BY mr.MEMBER_ID, g.GAME_NAME, mr.GAME_ID, 
md.MEMBER_NAME;


--Members who have rented more than one game
SELECT mr.MEMBER_ID, md.MEMBER_NAME, g.GAME_NAME, mr.GAME_ID, 
COUNT(mr.MEMBER_ID) AS TOTAL_RENTALS
FROM MEMBER_RENTALS mr, MEMBER_DETAILS md, GAMES g
WHERE mr.MEMBER_ID = md.MEMBER_ID
AND mr.GAME_ID = g.GAME_ID
GROUP BY mr.MEMBER_ID, g.GAME_NAME, mr.GAME_ID, 
md.MEMBER_NAME

HAVING  COUNT(mr.MEMBER_ID) >1;

--Euro value of rentals per store by game
SELECT st.STORE_NAME, st.STORE_LOCATION, st.STORE_ID, mr.GAME_ID, SUM(g.RENTAL_PRICE) as GROSS_PROFIT, COUNT(mr.MEMBER_ID) AS TOTAL_RENTALS
FROM STORE_INFORMATION st, MEMBER_RENTALS mr, MEMBER_DETAILS md, GAMES g
WHERE mr.MEMBER_ID = md.MEMBER_ID
AND mr.GAME_ID = g.GAME_ID
AND st.STORE_ID = md.STORE_ID
GROUP BY  st.STORE_NAME, st.STORE_LOCATION, st.STORE_ID, mr.GAME_ID;

--Euro value of all rentals per store
SELECT st.STORE_NAME, st.STORE_ID, SUM(g.RENTAL_PRICE) as EUR_GROSS_PROFIT, COUNT(mr.MEMBER_ID) AS TOTAL_RENTALS
FROM STORE_INFORMATION st, MEMBER_RENTALS mr, MEMBER_DETAILS md, GAMES g
WHERE mr.MEMBER_ID = md.MEMBER_ID
AND mr.GAME_ID = g.GAME_ID
AND st.STORE_ID = md.STORE_ID
GROUP BY  st.STORE_NAME, st.STORE_ID;