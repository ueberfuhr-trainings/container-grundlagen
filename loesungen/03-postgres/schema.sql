-- Create the "helloworld" table
CREATE TABLE helloworld
(
  id      SERIAL PRIMARY KEY,
  message TEXT NOT NULL
);

-- Insert some sample "Hello, World!" messages
INSERT INTO helloworld (message)
VALUES ('Hello, World!'),
       ('Hola, Mundo!'),
       ('Bonjour, le monde!'),
       ('Hallo, Welt!'),
       ('こんにちは世界'),
       ('Привет, мир!'),
       ('Ciao, mondo!');
