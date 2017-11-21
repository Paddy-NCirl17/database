
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