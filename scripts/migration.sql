 -- Inserting data into the reservations table 

INSERT INTO "public"."reservations" 
("id", "guest_name", "check_in", "check_out", "room_id") VALUES 
(DEFAULT, 'james jani', '2024-01-02 09:04:25.422000', '2024-01-04 09:04:35.019000', 1),

-- Inserting data into the rooms table

INSERT INTO "public"."rooms" 
("id", "room_number") VALUES 
(DEFAULT, '1A'),
(DEFAULT, '1B')

SELECT room_number
FROM public.reservations re
LEFT JOIN public.rooms ro
ON re.room_id = ro.id;

