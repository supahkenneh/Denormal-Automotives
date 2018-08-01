DROP USER IF EXISTS normal_user;
DROP DATABASE IF EXISTS normal_cars;

CREATE USER normal_user;
CREATE DATABASE normal_cars OWNER normal_user;

\c normal_cars;
\i scripts/denormal_data.sql;

CREATE TABLE makes_table (
  id serial NOT NULL primary key,
  make_code varchar(125) NOT NULL,
  make_title varchar(125) NOT NULL
);

CREATE TABLE models_table (
  id serial NOT NULL primary key,
  model_code varchar(125) NOT NULL,
  model_title varchar(125) NOT NULL,
  make_id integer REFERENCES makes_table(id),
  year integer NOT NULL
);

INSERT INTO makes_table (make_code, make_title)
  SELECT DISTINCT make_code, make_title
  FROM car_models;

INSERT INTO models_table (model_code, model_title, year, make_id)
  SELECT DISTINCT model_code, model_title, year, id AS make_id
  FROM car_models
  INNER JOIN makes_table 
  ON car_models.make_title = makes_table.make_title;

  SELECT DISTINCT make_title FROM car_models;

  SELECT DISTINCT model_title FROM car_models WHERE make_code = 'VOLKS';

  SELECT DISTINCT make_code, model_code, model_title, year
  FROM car_models
  WHERE make_code = 'LAM';

  SELECT DISTINCT *
  FROM car_models
  WHERE year BETWEEN 2010 and 2015;