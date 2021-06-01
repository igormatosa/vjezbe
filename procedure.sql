USE `vjezba_mwa`;
DROP procedure IF EXISTS `GetActiveUsers`;

DELIMITER $$
USE `vjezba_mwa`$$
CREATE PROCEDURE `GetActiveUsers` ()
BEGIN
	SELECT z.ID, z.ime, z.prezime, z.datumRodenja, z.adresa, g.naziv AS grad, zu.naziv AS zupanija, z.OIB, z.email, z.brojMobitela, ss.naziv AS StrucnaSprema
	FROM zaposlenik z
	LEFT JOIN grad g ON g.ID=z.grad_ID
	LEFT JOIN strucnasprema ss ON ss.ID=z.strucnaSprema_ID
	LEFT JOIN zupanija zu ON zu.ID=g.zupanija_ID
	WHERE z.aktivan = 1;
END$$

DELIMITER ;