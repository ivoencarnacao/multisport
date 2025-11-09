INSERT INTO sports (sport_name, sport_description)
VALUES
  ('Swimming', NULL),
  ('Cycling', NULL),
  ('Running', NULL),
  ('Triathlon', NULL),
  ('Walking', NULL),
  ('Duathlon', NULL),
  ('Aquathlon', NULL),
  ('Aquabike', NULL);

INSERT INTO race_categories (
  sport_id,
  race_category_name,
  race_category_description
)
VALUES
  ((SELECT sport_id FROM sports WHERE sport_name = 'Running'), '5K', NULL),
  ((SELECT sport_id FROM sports WHERE sport_name = 'Running'), '10K', NULL),
  ((SELECT sport_id FROM sports WHERE sport_name = 'Running'), 'Half Marathon', NULL),
  ((SELECT sport_id FROM sports WHERE sport_name = 'Running'), 'Marathon', NULL),
  ((SELECT sport_id FROM sports WHERE sport_name = 'Running'), 'Ultra', NULL),
  ((SELECT sport_id FROM sports WHERE sport_name = 'Running'), 'Trail', NULL),
  ((SELECT sport_id FROM sports WHERE sport_name = 'Swimming'), 'Open Water 5K', NULL),
  ((SELECT sport_id FROM sports WHERE sport_name = 'Cycling'), 'Granfondo', NULL),
  ((SELECT sport_id FROM sports WHERE sport_name = 'Cycling'), 'Gravel race', NULL),
  ((SELECT sport_id FROM sports WHERE sport_name = 'Triathlon'), 'Sprint Triathlon', NULL);

INSERT INTO organizers (
  organizer_name, 
  organizer_email, 
  organizer_phone, 
  organizer_mobile_phone,
  organizer_website 
)
VALUES
  ('HMS Sports Consulting, Lda', 'suporte@hmssports.pt', '+351 214 574 405', '+351 926 695 128', 'https://www.hmssports.pt'),
  ('Runporto', NULL, NULL, NULL, 'https://www.runporto.com');

INSERT INTO events (
  event_edition,
  event_name,
  event_date,
  event_website,
  event_has_expo
)
VALUES
  (18, 'LIDL São Silvestre de Lisboa', '2025-12-27 21:30:00+00', 'https://www.saosilvestredelisboa.com', FALSE),
  (31, 'Lidl S. Silvestre Cidade do Porto', '2025-12-28 18:00:00+00', 'https://www.runporto.com/eventos/sao-silvestre-do-porto/sao-silvestre-do-porto-2025', FALSE),
  (3, 'São Silvestre de Lagoa', '2025-12-29 18:00:00+00', 'https://www.aaalgarve.org', FALSE);

INSERT INTO races (
  race_name, 
  race_distance,
)
VALUES
  ('LIDL São Silvestre de Lisboa - Corrida de São Silvestre', 10000),
  ('Lidl S. Silvestre Cidade do Porto - Corrida de S. Silvestre', 10000),
  ('Lidl S. Silvestre Cidade do Porto - Caminhada de S. Silvestre', 5000);

INSERT INTO blocks (
  block_name, 
  block_description, 
  block_target_time, 
  block_access_criteria
)
VALUES
  ('Elite B', 'athletes with a time less than or equal to 37:30 minutes', '00:37:30', 'it is mandatory to present a time record that respects the time requirement of each starting block performed in a 10K event in the last two years'),
  ('Sub 45', 'athletes with a time less than or equal to 45:00 minutes', '00:45:00', 'it is mandatory to present a time record that respects the time requirement of each starting block performed in a 10K event in the last two years'),
  ('Sub 50', 'athletes with a time less than or equal to 50:00 minutes', '00:50:00', 'it is mandatory to present a time record that respects the time requirement of each starting block performed in a 10K event in the last two years'),
  ('Sub 60', 'athletes with a time less than or equal to 60:00 minutes', '00:60:00', 'it is mandatory to present a time record that respects the time requirement of each starting block performed in a 10K event in the last two years'),
  ('Sub 1h15', 'athletes with a time less than or equal to 1h15 minutes', '01:15:00', 'The sub 1h15 block does not require proof of time. To access it, you can simply make a request to change your starting block'),
  ('+1h15', 'athletes with a time greater than 1h15 minutes', '02:00:00', null);

INSERT INTO pacers (
  pacer_name,
  pacer_goal,
  pacer_target_time
)
VALUES
  ('4 min/km', 'racing time of 40 minutes or less', '00:40:00'),
  ('4:30 min/km', 'racing time of 45 minutes or less', '00:45:00'),
  ('5 min/km', 'racing time of 50 minutes or less', '00:50:00'),
  ('5:30 min/km', 'racing time of 55 minutes or less', '00:55:00'),
  ('6 min/km', 'racing time of 60 minutes or less', '01:00:00');


INSERT INTO age_groups (
  age_group_name,
  age_group_description,
  age_group_min_age, 
  age_group_max_age
)
VALUES
  ('Juniores', 'Masculinos e femininos nascidos entre 2006 e 2007', 18, 24),
  ('Seniores', 'Masculinos e femininos nascidos entre 1991 e 2005', 25, 34),
  ('V35', 'Masculinos e femininos dos 35 aos 39 anos', 35, 39),
  ('V40', 'Masculinos e femininos dos 40 aos 44 anos', 40, 44),
  ('V45', 'Masculinos e femininos dos 45 aos 49 anos', 45, 49),
  ('V50', 'Masculinos e femininos dos 50 aos 54 anos', 50, 54),
  ('V55', 'Masculinos e femininos dos 55 aos 59 anos', 55, 59),
  ('V60', 'Masculinos e femininos dos 60 aos 64 anos', 60, 64),
  ('V65', 'Masculinos e femininos dos 65 aos 69 anos', 65, 69),
  ('V70', 'Masculinos e femininos dos 70 aos 74 anos', 70, 74),
  ('V75', 'Masculinos e femininos dos 75 aos 79 anos', 75, 79),
  ('V80', 'Masculinos e femininos dos 80 aos 84 anos', 80, 84),
  ('V85', 'Masculinos e femininos dos 85 aos 89 anos', 85, 89),
  ('V90', 'Masculinos e femininos dos 90 anos em diante', 90, 94);

INSERT INTO locations (
  location_address,
  location_city,
  location_municipality, 
  location_district,
  location_country
)
VALUES
  ('Avenida da Liberdade', 'Lisboa', 'Lisboa', 'Lisboa', 'Portugal'),
  ('Avenida dos Aliados', 'Porto', 'Porto', 'Porto', 'Portugal');

-- Events
INSERT INTO event_organizers (
  event_id,
  organizer_id,
  event_organizer_role
)
VALUES
  (
    (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa'), 
    (SELECT organizer_id FROM organizers WHERE organizer_name = 'HMS Sports Consulting, Lda'),
    'Technical Organizer'
  ),
  (
    (SELECT event_id FROM events WHERE event_name = 'LIDL S. Silvestre Cidade do Porto'), 
    (SELECT organizer_id FROM organizers WHERE organizer_name = 'Runporto'),
    'Technical Organizer'
  );

-- Races
INSERT INTO event_races (
  event_id, 
  race_id,
  event_race_start_time,
  event_race_entry_fee,
  event_race_start_location,
  event_race_finish_location,
  event_race_cutoff_time,
  event_race_entry_limits,
  event_race_has_finisher_medal,
  event_race_has_age_group_awards,
  event_race_has_certificate,
  event_race_registration_open_date,
  event_race_registration_close_date,
  event_race_registration_status)
VALUES
  (
    (SELECT event_id FROM events WHERE event_name = 'LIDL S. Silvestre Cidade do Porto'), 
    (SELECT race_id FROM races WHERE race_name = 'Lidl S. Silvestre Cidade do Porto - Caminhada de S. Silvestre'),
    '2025-12-28 18:00:00+00',
    20,
    'Rua Dr. Magalhães Lemos',
    'Avenida dos Aliados',
    '02:00:00',
    NULL,
    FALSE,
    FALSE,
    TRUE,
    NULL,
    '2025-12-27 23:59:00+00',
    'sold out'
  ),
  (
    (SELECT event_id FROM events WHERE event_name = 'Lidl S. Silvestre Cidade do Porto'), 
    (SELECT race_id FROM races WHERE race_name = 'Lidl S. Silvestre Cidade do Porto - Corrida de S. Silvestre'),
    '2025-12-28 18:00:00+00',
    25,
    'Avenida dos Aliados',
    'Avenida dos Aliados',
    '02:00:00',
    NULL,
    FALSE,
    FALSE,
    TRUE,
    NULL,
    '2025-12-27 23:59:00+00',
    'sold out'
  ),
  (
    (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa'), 
    (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre'),
    '2025-12-27 21:30:00+00',
    42,
    'Avenida da Liberdade',
    'Avenida da Liberdade',
    '02:00:00',
    12000,
    TRUE,
    FALSE,
    TRUE,
    NULL,
    '2025-12-27 23:59:00+00',
    'open'
  );

-- Starting Waves
INSERT INTO event_race_waves (event_race_id, wave_name, wave_start_time)
VALUES
  (
    (SELECT event_race_id 
    FROM event_races 
    WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    '1ª vaga',
    '2025-12-27 21:30:00+00'
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    '2ª vaga',
    '2025-12-27 21:30:00+00'
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    '3ª vaga',
    '2025-12-27 21:30:00+00'
  );


INSERT INTO event_race_wave_blocks (event_race_wave_id, block_id)
VALUES
  (
    (SELECT event_race_wave_id 
    FROM event_race_waves 
    WHERE event_race_id = (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre'))),
    (SELECT block_id FROM blocks WHERE block_name = 'Elite B')
  );

-- Pacers
INSERT INTO event_race_pacers (event_race_id, pacer_id)
VALUES
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT pacer_id FROM pacers WHERE pacer_name = '4 min/km')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT pacer_id FROM pacers WHERE pacer_name = '4:30 min/km')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT pacer_id FROM pacers WHERE pacer_name = '5 min/km')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT pacer_id FROM pacers WHERE pacer_name = '5:30 min/km')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT pacer_id FROM pacers WHERE pacer_name = '6 min/km')
  );

-- Age Groups
INSERT INTO event_race_age_groups (event_race_id, age_group_id)
VALUES
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'Juniores')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'Seniores')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'V35')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'V40')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'V45')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'V50')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'V55')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'V60')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'V65')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'V70')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'V75')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'V80')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'V85')
  ),
  (
    (SELECT event_race_id FROM event_races WHERE event_id = (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa') AND race_id = (SELECT race_id FROM races WHERE race_name = 'LIDL São Silvestre de Lisboa - Corrida de São Silvestre')),
    (SELECT age_group_id FROM age_groups WHERE age_group_name = 'V90')
  );

INSERT INTO event_locations (event_id, location_id)
VALUES
  (
    (SELECT event_id FROM events WHERE event_name = 'LIDL São Silvestre de Lisboa'), 
    (SELECT location_id 
      FROM locations 
      WHERE location_parish = 'Lisboa'
        AND location_municipality = 'Lisboa'
        AND location_district = 'Lisboa'
        AND location_country = 'Portugal'
    )
  );

