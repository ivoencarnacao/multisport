-- Extensions
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
CREATE EXTENSION IF NOT EXISTS "postgis";

CREATE TYPE IF NOT EXISTS registration_status AS ENUM (
  'open',
  'closed',
  'sold-out'
);

CREATE TABLE IF NOT EXISTS sports (
  sport_id UUID DEFAULT gen_random_uuid(),
  sport_name VARCHAR(255) NOT NULL,
  sport_description TEXT,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_sports PRIMARY KEY (sport_id),
  CONSTRAINT uq_sport_name UNIQUE (sport_name)
);

-- TODO: isTableRedundant🤔
CREATE TABLE IF NOT EXISTS race_categories (
  race_category_id UUID DEFAULT gen_random_uuid(),
  sport_id UUID NOT NULL,
  race_category_name VARCHAR(255) NOT NULL,
  race_category_description TEXT,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_race_categories PRIMARY KEY (race_category_id),
  CONSTRAINT fk_race_categories_sports FOREIGN KEY (sport_id) REFERENCES sports (sport_id) ON DELETE CASCADE,
  CONSTRAINT uq_race_category_sport_name UNIQUE (sport_id, race_category_name)
);

-- TODO: Create contacts table
CREATE TABLE IF NOT EXISTS organizers (
  organizer_id UUID DEFAULT gen_random_uuid(),
  organizer_name VARCHAR(255) NOT NULL,
  organizer_email VARCHAR(255),
  organizer_phone VARCHAR(255),
  organizer_mobile_phone VARCHAR(255),
  organizer_website VARCHAR(255),
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_organizers PRIMARY KEY (organizer_id),
  CONSTRAINT uq_organizer_name UNIQUE (organizer_name)
);

CREATE TABLE IF NOT EXISTS events (
  event_id UUID DEFAULT gen_random_uuid(),
  event_edition INTEGER,
  event_name VARCHAR(255) NOT NULL,
  event_date TIMESTAMPTZ NOT NULL,
  event_website VARCHAR(255),
  event_has_expo BOOLEAN,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_events PRIMARY KEY (event_id),
  CONSTRAINT uq_event_name_date UNIQUE (event_name, event_date),
  CONSTRAINT chk_event_edition_positive CHECK (event_edition > 0)
);

CREATE TABLE IF NOT EXISTS races (
  race_id UUID DEFAULT gen_random_uuid(),
  --sport_id UUID NOT NULL,
  race_name VARCHAR(255) NOT NULL,
  race_distance INTEGER NOT NULL,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_races PRIMARY KEY (race_id),
  --CONSTRAINT fk_races_sport FOREIGN KEY (sport_id) REFERENCES sports, (sport_id) ON DELETE CASCADE
  --CONSTRAINT uq_races_sport_race_name UNIQUE (sport_id, race_name),
  CONSTRAINT chk_race_distance_positive CHECK (race_distance > 0)
);

CREATE TABLE IF NOT EXISTS blocks (
  block_id UUID DEFAULT gen_random_uuid(),
  block_name VARCHAR(255) NOT NULL,
  block_description TEXT,
  block_target_time INTERVAL NOT NULL,
  block_access_criteria TEXT,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_blocks PRIMARY KEY (block_id),
  CONSTRAINT uq_block_name UNIQUE (block_name)
);

CREATE TABLE IF NOT EXISTS pacers (
  pacer_id UUID DEFAULT gen_random_uuid(),
  pacer_name VARCHAR(255) NOT NULL,
  pacer_goal VARCHAR(255),
  pacer_target_time INTERVAL NOT NULL,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_pacers PRIMARY KEY (pacer_id)
);

CREATE TABLE IF NOT EXISTS age_groups (
  age_group_id UUID DEFAULT gen_random_uuid(),
  age_group_name VARCHAR(255) NOT NULL,
  age_group_description VARCHAR(255),
  age_group_min_age INTEGER NOT NULL,
  age_group_max_age INTEGER NOT NULL,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_age_groups PRIMARY KEY (age_group_id)
);

CREATE TABLE IF NOT EXISTS locations (
  location_id UUID DEFAULT gen_random_uuid(),
  location_parish VARCHAR(255),
  location_municipality VARCHAR(255),
  location_district VARCHAR(255),
  location_country VARCHAR(255) NOT NULL,
  location_geography GEOGRAPHY(POINT, 4326),
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_locations PRIMARY KEY (location_id)
);

-- Events
CREATE TABLE IF NOT EXISTS event_organizers (
  event_organizer_id UUID DEFAULT gen_random_uuid(),
  event_id UUID NOT NULL,
  organizer_id UUID NOT NULL,
  event_organizer_role VARCHAR(255),
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_event_organizers PRIMARY KEY (event_organizer_id),
  CONSTRAINT fk_event_organizers_events FOREIGN KEY (event_id) REFERENCES events (event_id) ON DELETE CASCADE,
  CONSTRAINT fk_event_organizers_organizers FOREIGN KEY (organizer_id) REFERENCES organizers (organizer_id) ON DELETE CASCADE,
  CONSTRAINT uq_event_organizers UNIQUE (event_id, organizer_id)
);

-- Races
CREATE TABLE IF NOT EXISTS event_races (
  event_race_id UUID DEFAULT gen_random_uuid(),
  event_id UUID NOT NULL,
  race_id UUID NOT NULL,
  event_race_start_time TIMESTAMPTZ NOT NULL,
  event_race_entry_fee NUMERIC(10,2),
  event_race_start_location VARCHAR(255),
  event_race_finish_location VARCHAR(255), 
  event_race_cutoff_time INTERVAL,
  event_race_entry_limits INTEGER,
  event_race_has_finisher_medal BOOLEAN DEFAULT TRUE,
  event_race_has_age_group_awards BOOLEAN DEFAULT FALSE,
  event_race_has_certificate BOOLEAN DEFAULT TRUE,
  event_race_registration_open_date TIMESTAMPTZ,
  event_race_registration_close_date TIMESTAMPTZ,
  event_race_registration_status registration_status DEFAULT 'open',
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_event_races PRIMARY KEY (event_race_id),
  CONSTRAINT fk_event_races_events FOREIGN KEY (event_id) REFERENCES events (event_id) ON DELETE CASCADE,
  CONSTRAINT fk_event_races_races FOREIGN KEY (race_id) REFERENCES races (race_id) ON DELETE CASCADE,
  CONSTRAINT uq_event_races UNIQUE (event_id, race_id)
);

-- Starting Waves
CREATE TABLE IF NOT EXISTS event_race_waves (
  event_race_wave_id UUID DEFAULT gen_random_uuid(),
  event_race_id UUID NOT NULL,
  wave_name VARCHAR(255) NOT NULL,
  wave_start_time TIMESTAMPTZ NOT NULL,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_event_race_waves PRIMARY KEY (event_race_wave_id),
  CONSTRAINT fk_event_race_wave_event_races FOREIGN KEY (event_race_id) REFERENCES event_races (event_race_id) ON DELETE CASCADE
);

-- Starting Blocks
CREATE TABLE IF NOT EXISTS event_race_wave_blocks (
  event_race_wave_block_id UUID DEFAULT gen_random_uuid(),
  event_race_wave_id UUID NOT NULL,
  block_id UUID NOT NULL,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_event_race_wave_blocks PRIMARY KEY (event_race_wave_block_id),
  CONSTRAINT fk_event_race_wave_blocks_waves FOREIGN KEY (event_race_wave_id) REFERENCES event_race_waves (event_race_wave_id) ON DELETE CASCADE,
  CONSTRAINT fk_event_race_wave_blocks_blocks FOREIGN KEY (block_id) REFERENCES blocks (block_id) ON DELETE CASCADE,
  CONSTRAINT uq_event_race_wave_blocks UNIQUE (event_race_wave_id, block_id)
);

-- Pacers
CREATE TABLE IF NOT EXISTS event_race_pacers (
  event_pacer_id UUID DEFAULT gen_random_uuid(),
  event_race_id UUID NOT NULL,
  pacer_id UUID NOT NULL,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_event_race_pacers PRIMARY KEY (event_pacer_id),
  CONSTRAINT fk_event_race_pacers_event_races FOREIGN KEY (event_race_id) REFERENCES event_races (event_race_id) ON DELETE CASCADE,
  CONSTRAINT fk_event_race_pacers_pacers FOREIGN KEY (pacer_id) REFERENCES pacers (pacer_id) ON DELETE CASCADE,
  CONSTRAINT uq_event_race_pacers UNIQUE (event_race_id, pacer_id)
);

-- Age Groups
CREATE TABLE IF NOT EXISTS event_race_age_groups (
  event_race_age_group_id UUID DEFAULT gen_random_uuid(),
  event_race_id UUID NOT NULL,
  age_group_id UUID NOT NULL,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_event_age_groups PRIMARY KEY (event_race_age_group_id),
  CONSTRAINT fk_event_age_groups_event_races FOREIGN KEY (event_race_id) REFERENCES event_races (event_race_id) ON DELETE CASCADE,
  CONSTRAINT fk_event_age_groups_age_groups FOREIGN KEY (age_group_id) REFERENCES age_groups (age_group_id) ON DELETE CASCADE,
  CONSTRAINT uq_event_race_age_groups UNIQUE (event_race_id, age_group_id)
);

-- Locations
CREATE TABLE IF NOT EXISTS event_locations (
  event_location_id UUID DEFAULT gen_random_uuid(),
  event_id UUID NOT NULL,
  location_id UUID NOT NULL,
  created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_event_locations PRIMARY KEY (event_location_id),
  CONSTRAINT fk_event_locations_events FOREIGN KEY (event_id) REFERENCES events (event_id) ON DELETE CASCADE,
  CONSTRAINT fk_event_locations_locations FOREIGN KEY (location_id) REFERENCES locations (location_id) ON DELETE CASCADE,
  CONSTRAINT uq_event_locations UNIQUE (event_id, location_id)
);

