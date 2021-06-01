CREATE TRIGGER after_insert_zaposlenik 
    AFTER INSERT ON zaposlenik
    FOR EACH ROW 
 INSERT INTO log
 SET akcija = 'dodan',
     ime = NEW.ime,
     prezime = NEW.prezime,
     datum = NOW();
     
     
     
SHOW TRIGGERS;