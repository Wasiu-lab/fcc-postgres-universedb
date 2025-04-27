-- Create galaxy table
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    age_in_billions_of_years NUMERIC(10, 2),
    galaxy_type TEXT NOT NULL,
    distance_from_earth_in_light_years INT,
    has_active_center BOOLEAN DEFAULT false,
    is_spiral BOOLEAN
);

-- Create star table
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    galaxy_id INT REFERENCES galaxy(galaxy_id) NOT NULL,
    temperature_in_kelvin INT,
    mass_solar_units NUMERIC(10, 2),
    is_binary BOOLEAN DEFAULT false,
    has_planets BOOLEAN,
    color TEXT
);

-- Create planet table
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    star_id INT REFERENCES star(star_id) NOT NULL,
    orbital_period_in_days INT,
    radius_km NUMERIC(10, 2),
    has_atmosphere BOOLEAN DEFAULT false,
    has_life BOOLEAN DEFAULT false,
    planet_type TEXT,
    distance_from_star_in_au NUMERIC(10, 2)
);

-- Create moon table
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    planet_id INT REFERENCES planet(planet_id) NOT NULL,
    radius_km INT,
    orbital_period_in_days NUMERIC(10, 2),
    is_spherical BOOLEAN,
    has_water BOOLEAN,
    surface_description TEXT
);

-- Create a fifth table for additional information
CREATE TABLE planetary_system (
    planetary_system_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    star_id INT REFERENCES star(star_id) NOT NULL,
    number_of_planets INT,
    has_asteroid_belt BOOLEAN,
    has_dwarf_planets BOOLEAN,
    description TEXT
);

-- Insert data into galaxy table
INSERT INTO galaxy (name, age_in_billions_of_years, galaxy_type, distance_from_earth_in_light_years, has_active_center, is_spiral)
VALUES 
('Milky Way', 13.61, 'Spiral', 0, true, true),
('Andromeda', 10.01, 'Spiral', 2537000, true, true),
('Triangulum', 9.85, 'Spiral', 3000000, false, true),
('Large Magellanic Cloud', 1.10, 'Irregular', 158200, false, false),
('Small Magellanic Cloud', 6.50, 'Irregular', 199000, false, false),
('Centaurus A', 13.27, 'Elliptical', 13700000, true, false);

-- Insert data into star table
INSERT INTO star (name, galaxy_id, temperature_in_kelvin, mass_solar_units, is_binary, has_planets, color)
VALUES 
('Sun', 1, 5778, 1.00, false, true, 'Yellow'),
('Proxima Centauri', 1, 3042, 0.12, false, true, 'Red'),
('Alpha Centauri A', 1, 5790, 1.10, true, true, 'Yellow'),
('Sirius', 1, 9940, 2.02, true, false, 'Blue-white'),
('Betelgeuse', 1, 3500, 11.60, false, false, 'Red'),
('Vega', 1, 9602, 2.10, false, true, 'Blue-white');

-- Insert data into planet table
INSERT INTO planet (name, star_id, orbital_period_in_days, radius_km, has_atmosphere, has_life, planet_type, distance_from_star_in_au)
VALUES 
('Mercury', 1, 88, 2439.70, false, false, 'Terrestrial', 0.39),
('Venus', 1, 225, 6051.80, true, false, 'Terrestrial', 0.72),
('Earth', 1, 365, 6371.00, true, true, 'Terrestrial', 1.00),
('Mars', 1, 687, 3389.50, true, false, 'Terrestrial', 1.52),
('Jupiter', 1, 4333, 69911.00, true, false, 'Gas Giant', 5.20),
('Saturn', 1, 10759, 58232.00, true, false, 'Gas Giant', 9.58),
('Uranus', 1, 30687, 25362.00, true, false, 'Ice Giant', 19.18),
('Neptune', 1, 60190, 24622.00, true, false, 'Ice Giant', 30.07),
('Proxima Centauri b', 2, 11, 7300.00, true, false, 'Terrestrial', 0.05),
('Proxima Centauri c', 2, 1928, 8400.00, false, false, 'Super-Earth', 1.49),
('Alpha Centauri Bb', 3, 3, 7150.00, false, false, 'Terrestrial', 0.04),
('Vega b', 6, 116, 25400.00, true, false, 'Gas Giant', 0.72);

-- Insert data into moon table
INSERT INTO moon (name, planet_id, radius_km, orbital_period_in_days, is_spherical, has_water, surface_description)
VALUES 
('Moon', 3, 1737, 27.32, true, true, 'Cratered'),
('Phobos', 4, 11, 0.32, false, false, 'Irregular and heavily cratered'),
('Deimos', 4, 6, 1.26, false, false, 'Small and lumpy'),
('Io', 5, 1821, 1.77, true, false, 'Volcanic and sulfurous'),
('Europa', 5, 1560, 3.55, true, true, 'Icy smooth surface with cracks'),
('Ganymede', 5, 2634, 7.15, true, true, 'Mixture of cratered and smooth terrain'),
('Callisto', 5, 2410, 16.69, true, true, 'Heavily cratered'),
('Amalthea', 5, 83, 0.50, false, false, 'Reddish and irregular'),
('Mimas', 6, 198, 0.94, true, false, 'Heavily cratered with large Herschel crater'),
('Enceladus', 6, 252, 1.37, true, true, 'Bright icy surface with geysers'),
('Tethys', 6, 531, 1.89, true, false, 'Heavily cratered with large Odysseus crater'),
('Dione', 6, 561, 2.74, true, false, 'Heavily cratered with bright streaks'),
('Rhea', 6, 763, 4.52, true, false, 'Cratered surface'),
('Titan', 6, 2575, 15.95, true, true, 'Thick atmosphere and liquid hydrocarbons'),
('Miranda', 7, 235, 1.41, true, false, 'Diverse terrain with canyons and cliffs'),
('Ariel', 7, 579, 2.52, true, true, 'Relatively smooth with few craters'),
('Umbriel', 7, 584, 4.14, true, false, 'Dark and heavily cratered'),
('Titania', 7, 788, 8.71, true, true, 'Many large impact basins'),
('Oberon', 7, 761, 13.46, true, false, 'Heavily cratered with ice patches'),
('Triton', 8, 1353, 5.88, true, true, 'Coldest known surface with nitrogen geysers');

-- Insert data into planetary_system table
INSERT INTO planetary_system (name, star_id, number_of_planets, has_asteroid_belt, has_dwarf_planets, description)
VALUES 
('Solar System', 1, 8, true, true, 'Our home planetary system with 8 major planets and numerous dwarf planets'),
('Proxima Centauri System', 2, 2, false, false, 'Closest exoplanetary system to Earth'),
('Alpha Centauri System', 3, 1, false, false, 'Binary star system with at least one confirmed planet'),
('Vega System', 6, 1, true, false, 'Young star system with debris disk similar to our Kuiper Belt');