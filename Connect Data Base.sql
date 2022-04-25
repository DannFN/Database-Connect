CREATE DATABASE CONNECT CHARACTER SET utf8 COLLATE utf8_general_ci;

USE CONNECT;

CREATE TABLE MInicioSesionUsuario(
  IdUsuario INT(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  CorreoElectronico VARCHAR(255) NOT NULL,
  PassUsuario CHAR(32) NOT NULL
);

CREATE TABLE CEstado(
  IdEstado TINYINT(2) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Estado VARCHAR(50) NOT NULL
);

CREATE TABLE CMunicipioDelegacion(
  IdMunicipioDelegacion SMALLINT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  MunicipioDelegacion VARCHAR(100) NOT NULL
);

CREATE TABLE DLocalidad(
  IdLocalidad SMALLINT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  IdEstado TINYINT(2) NOT NULL,
  IdMunicipioDelegacion SMALLINT(4) NOT NULL,
  FOREIGN KEY(IdEstado) REFERENCES CEstado(IdEstado) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(IdMunicipioDelegacion) REFERENCES CMunicipioDelegacion(IdMunicipioDelegacion) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CSexo(
  IdSexo TINYINT(1) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Sexo VARCHAR(15) NOT NULL
);

CREATE TABLE CUsuario(
  IdUsuario INT(8) NOT NULL,
  Nombre VARCHAR(40) NOT NULL, 
  ApellidoPaterno VARCHAR(24) NOT NULL, 
  ApellidoMaterno VARCHAR(24) NOT NULL,
  FotoPerfil BLOB NOT NULL,  
  NumeroTelefonico CHAR(10) NOT NULL, 
  FechaDeNacimiento DATE NOT NULL,
  IdSexo TINYINT(1) NOT NULL DEFAULT 1,
  IdLocalidad SMALLINT(4) NOT NULL DEFAULT 1,
  Hobbies TEXT(400) NOT NULL,
  FOREIGN KEY(IdUsuario) REFERENCES MInicioSesionUsuario(IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(IdSexo) REFERENCES CSexo(IdSexo) ON UPDATE CASCADE,
  FOREIGN KEY(IdLocalidad) REFERENCES DLocalidad(IdLocalidad) ON UPDATE CASCADE
);

CREATE TABLE CCategoria(
  IdCategoria TINYINT(2) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Categoria VARCHAR(255) NOT NULL,
  FotoCategoria VARCHAR(255) NOT NULL
);

CREATE TABLE CPerfilUsuario(
  IdPerfil INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  IdUsuario INT(8) NOT NULL,
  IdCategoria TINYINT(2) NOT NULL DEFAULT 1,
  PerfilProfesional TEXT(450) NOT NULL,
  FOREIGN KEY(IdUsuario) REFERENCES MInicioSesionUsuario(IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(IdCategoria) REFERENCES CCategoria(IdCategoria) ON UPDATE CASCADE
);

CREATE TABLE CCompetenciasProfesionales(
  IdCompetencia SMALLINT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Competencia VARCHAR(255) NOT NULL
);

CREATE TABLE DCompetenciasUsuario(
  IdUsuario INT(8) NOT NULL,
  IdCompetencia SMALLINT(3) NOT NULL,
  Dominio TINYINT(2),
  FOREIGN KEY(IdUsuario) REFERENCES MInicioSesionUsuario(IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(IdCompetencia) REFERENCES CCompetenciasProfesionales(IdCompetencia) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CIdioma(
  IdIdioma SMALLINT(3) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Idioma VARCHAR(255) NOT NULL
);

CREATE TABLE DIdiomaUsuario(
  IdUSuario INT(8) NOT NULL,
  IdIdioma SMALLINT(3) NOT NULL,
  Dominio TINYINT(2) NOT NULL,
  FOREIGN KEY(IdUsuario) REFERENCES MInicioSesionUsuario(IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(IdIdioma) REFERENCES CIdioma(IdIdioma) ON DELETE CASCADE ON UPDATE CASCADE 
);

CREATE TABLE CEscuela(
  IdEscuela SMALLINT(4) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  TipoEscuela CHAR(1) NOT NULL,
  Escuela VARCHAR(255) NOT NULL
);

CREATE TABLE CGrado(
  IdGrado TINYINT(1) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  Grado VARCHAR(15)
);

CREATE TABLE DEscuelaGradoTitulo(
  IdUsuario INT(8) NOT NULL,
  IdEscuela SMALLINT(4) NOT NULL,
  IdGrado TINYINT(1) NOT NULL DEFAULT 1, 
  Titulo VARCHAR(255) NOT NULL,
  FOREIGN KEY(IdUsuario) REFERENCES MInicioSesionUsuario(IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(IdEscuela) REFERENCES CEscuela(IdEscuela) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(Idgrado) REFERENCES CGrado(IdGrado) ON UPDATE CASCADE  
);

CREATE TABLE MInicioSesionOrganizacion(
  IdOrganizacion INT(8) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  CorreoElectronico VARCHAR(255) NOT NULL,
  PassOrganizacion CHAR NOT NULL
);

CREATE TABLE CCategoriaOrganizacion(
  IdCategoriaOrganizacion TINYINT(2) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  CategoriaOrganizacion VARCHAR(255) NOT NULL
);

CREATE TABLE COrganizacion(
  IdOrganizacion INT(8) NOT NULL,
  NombreOrganizacion VARCHAR(255) NOT NULL,
  FotoOrganizacion VARCHAR(255) NOT NULL,
  NumeroTelefonico CHAR(8) NOT NULL,
  IdLocalidad SMALLINT(4) NOT NULL DEFAULT 1,
  Direccion VARCHAR(255) NOT NULL,
  IdCategoriaOrganizacion TINYINT(2) NOT NULL DEFAULT 1,
  FOREIGN KEY(IdOrganizacion) REFERENCES MInicioSesionOrganizacion(IdOrganizacion) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(IdLocalidad) REFERENCES DLocalidad(IdLocalidad) ON UPDATE CASCADE,
  FOREIGN KEY(IdCategoriaOrganizacion) REFERENCES CCategoriaOrganizacion(IdCategoriaOrganizacion) ON UPDATE CASCADE
);

CREATE TABLE CPerfilOrganizacion(
  IdOrganizacion INT(8) NOT NULL,
  Eslogan VARCHAR(255) NOT NULL,
  Descripcion TEXT(400) NOT NULL,
  Mision VARCHAR(255) NOT NULL,
  Vision VARCHAR(255) NOT NULL,
  Valores TEXT(500) NOT NULL,
  FOREIGN KEY(IdOrganizacion) REFERENCES MInicioSesionOrganizacion(IdOrganizacion) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CRepresentanteOrganizacion(
  IdRepresentanteOrganizacion INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  IdOrganizacion INT(8) NOT NULL,
  Nombre VARCHAR(40) NOT NULL,
  ApellidoPaterno VARCHAR(24) NOT NULL,
  CorreoElectronico VARCHAR(255) NOT NULL,
  Cargo VARCHAR(255) NOT NULL,
  FotoRepresentante VARCHAR(255) NOT NULL,
  FOREIGN KEY(IdOrganizacion) REFERENCES MInicioSesionOrganizacion(idOrganizacion) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CPeriodoDePago(
  IdPeriodoDePago TINYINT(1) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  PeriodoDePago VARCHAR(10) NOT NULL
);

CREATE TABLE COferta(
  IdOferta INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  IdOrganizacion INT(8) NOT NULL,
  Titulo VARCHAR(40) NOT NULL,
  Descripcion VARCHAR(140) NOT NULL,
  IdCategoria TINYINT(2) NOT NULL DEFAULT 1, 
  Beneficios VARCHAR(255) NOT NULL,
  Pago DECIMAL(10, 8) NOT NULL,
  IdPeriodoDePago TINYINT(1) NOT NULL DEFAULT 1,
  Latitud DECIMAL(10, 8) NOT NULL,
  Longitud DECIMAL(10, 8) NOT NULL,
  FOREIGN KEY(IdOrganizacion) REFERENCES MinicioSesionOrganizacion(IdOrganizacion) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(IdPeriodoDePago) REFERENCES CPeriodoDePago(IdPeriodoDePago) ON UPDATE CASCADE,
  FOREIGN KEY(IdCategoria) REFERENCES CCategoria(IdCategoria) ON UPDATE CASCADE
);

CREATE TABLE DOfertaCompetencias(
  IdOferta INT NOT NULL,
  IdCompetencia SMALLINT(3) NOT NULL,                 
  FOREIGN KEY(IdOferta) REFERENCES COferta(IdOferta) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(IdCompetencia) REFERENCES CCompetenciasProfesionales(IdCompetencia) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE DUsuarioOferta(
  IdSolicitud INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  IdUsuario INT(8) NOT NULL,
  IdOferta INT NOT NULL,
  FOREIGN KEY(IdUsuario) REFERENCES MInicioSesionUsuario(IdUsuario) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(IdOferta) REFERENCES COferta(IdOferta) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CArticulo(
  IdArticulo INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  IdOrganizacion INT(8) NOT NULL,
  Titulo VARCHAR(80) NOT NULL,
  Miniatura VARCHAR(255) NOT NULL,
  Contenido TEXT(20000) NOT NULL,
  Fuentes TEXT(500) NOT NULL,
  FOREIGN KEY(IdOrganizacion) REFERENCES MInicioSesionOrganizacion(IdOrganizacion) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE VIEW VWMInicioSesion AS 
  SELECT 
    CorreoElectronico AS Mail, PassUsuario AS AccessPass
  FROM
    MInicioSesionUsuario
  UNION ALL
  SELECT 
    CorreoElectronico AS Mail, PassOrganizacion AS AccessPass
  FROM
    MInicioSesionOrganizacion;

CREATE VIEW VWLocalidad AS
  SELECT 
    DLocalidad.IdLocalidad,
    CEstado.Estado,
    CMunicipioDelegacion.MunicipioDelegacion
  FROM
    DLocalidad
  INNER JOIN 
    CEstado
  ON
    DLocalidad.IdEstado = CEstado.IdEstado
  INNER JOIN
    CMunicipioDelegacion
  ON
    DLocalidad.IdMunicipioDelegacion = CMunicipioDelegacion.IdMunicipioDelegacion;

CREATE VIEW VWInformacionUSuario AS
  SELECT 
    MInicioSesionUsuario.IdUsuario,
    MInicioSesionUsuario.CorreoElectronico,
    MInicioSesionUsuario.PassUsuario,
    CUsuario.Nombre,
    CUsuario.ApellidoPaterno,
    CUsuario.ApellidoMaterno,
    CUsuario.NumeroTelefonico,
    CUsuario.FotoPerfil,
    CUsuario.FechaDeNacimiento,
    CUsuario.Hobbies,
    TIMESTAMPDIFF (YEAR, CUsuario.FechaDeNacimiento, CURDATE()) AS Edad,
    CSexo.Sexo,
    VWLocalidad.Estado,
    VWLocalidad.MunicipioDelegacion
  FROM
    MInicioSesionUsuario
  INNER JOIN 
    CUsuario
  ON
    MInicioSesionUsuario.IdUsuario = CUsuario.IdUsuario
  INNER JOIN
    CSexo
  ON
    CUsuario.IdSexo = CSexo.IdSexo
  INNER JOIN
    VWLocalidad
  ON
    CUsuario.IdLocalidad = VWLocalidad.IdLocalidad;

CREATE VIEW VWPerfilesUsuario AS
  SELECT 
    CPerfilUsuario.IdUsuario,
    CPerfilUsuario.idPerfil,
    CCategoria.Categoria,
    CCategoria.FotoCategoria,
    CPerfilUsuario.PerfilProfesional
  FROM 
    CPerfilUsuario
  INNER JOIN
    CCategoria
  ON
    CPerfilUsuario.IdCategoria = CCategoria.IdCategoria;

CREATE VIEW VWCompetenciasUsuario AS
  SELECT 
    DCompetenciasUsuario.IdUsuario,
    CCompetenciasProfesionales.Competencia,
    DCompetenciasUsuario.Dominio


  FROM 
    DCompetenciasUsuario
  INNER JOIN 
    CCompetenciasProfesionales
  ON 
    DCompetenciasUsuario.IdCompetencia = CCompetenciasProfesionales.IdCompetencia;

CREATE VIEW VWIdiomasUsuario AS
  SELECT 
    DIdiomaUsuario.IdUsuario,
    CIdioma.Idioma,
    DIdiomaUsuario.Dominio
  FROM    
    DIdiomaUsuario
  INNER JOIN
    CIdioma
  ON
    DIdiomaUsuario.IdIdioma = CIdioma.IdIdioma;

CREATE VIEW VWEscuelaGradoTitulo AS
  SELECT 
    DescuelaGradoTitulo.IdUsuario,
    CEscuela.Escuela,
    CGrado.Grado,
    DescuelaGradoTitulo.Titulo
  FROM
    DescuelaGradoTitulo
  INNER JOIN
    CEscuela
  ON
    DescuelaGradoTitulo.IdEscuela = CEscuela.IdEscuela
  INNER JOIN
    CGrado
  ON
    DescuelaGradoTitulo.IdGrado = CGrado.IdGrado; 

CREATE VIEW VWInformacionOrganizacion AS 
  SELECT
    MInicioSesionOrganizacion.IdOrganizacion,
    MInicioSesionOrganizacion.CorreoElectronico,
    COrganizacion.NombreOrganizacion,
    COrganizacion.FotoOrganizacion,
    COrganizacion.NumeroTelefonico,
    VWLocalidad.Estado,
    VWLocalidad.MunicipioDelegacion,
    COrganizacion.Direccion,
    CCategoriaOrganizacion.CategoriaOrganizacion,
    CPerfilOrganizacion.Eslogan,
    CPerfilOrganizacion.Descripcion,
    CPerfilOrganizacion.Mision,
    CPerfilOrganizacion.Vision,
    CPerfilOrganizacion.Valores
  FROM
    COrganizacion
  INNER JOIN
    MInicioSesionOrganizacion
  ON
    COrganizacion.IdOrganizacion =MInicioSesionOrganizacion.IdOrganizacion 
  INNER JOIN
    VWLocalidad
  ON
    COrganizacion.IdLocalidad = VWLocalidad.IdLocalidad
  INNER JOIN
    CCategoriaOrganizacion
  ON
    COrganizacion.IdCategoriaOrganizacion = CCategoriaOrganizacion.IdCategoriaOrganizacion
  INNER JOIN
    CPerfilORganizacion
  ON
    COrganizacion.IdOrganizacion = CPerfilOrganizacion.IdOrganizacion;

DELIMITER //

CREATE PROCEDURE RegistroUsuario(
  IN _Mail VARCHAR(255),
  IN _PassR CHAR(32),
  IN _Name VARCHAR(40),
  IN _Surname1 VARCHAR(24),
  IN _Surname2 VARCHAR(24),
  IN _ProfPic VARCHAR(255),
  IN _TelNum CHAR(10),
  IN _BDate DATE,
  IN _IdSex TINYINT(1),
  IN _IdEstate TINYINT(2),
  IN _IdMunicipality SMALLINT(4),
  IN _Hobbies TEXT(400)
)
BEGIN
  INSERT INTO 
    MInicioSesion(
      CorreoElectronico, 
      PassUsuario
    ) 
  VALUES(
    _Mail, 
    _PassR
  );

  INSERT INTO 
    CUsuario(
      IdUsuario,
      Nombre,
      ApellidoPaterno,
      ApellidoMaterno,
      NumeroTelefonico,
      FechaDeNacimiento,
      IdSexo,
      IdLocalidad,
      Hobbies
    )
  VALUES(
    (SELECT IdUsuario FROM MInicioSesionUsuario WHERE CorreoElectronico = _Mail),
    _Name, 
    _Surname1,
    _Surname2,
    _ProfPic,
    _TelNum,
    _BDate,
    _IdSex,
    (SELECT IdLocalidad FROM DLocalidad WHERE IdEstado = _IdEstate AND IdMunicipioDelegacion = _IdMunicipality),
    _Hobbies
  );
END//

CREATE PROCEDURE EditarUsuario(
  IN _IdUser INT(8),
  IN _Mail VARCHAR(255),
  IN _TelNum CHAR(10),
  IN _ProfPic BLOB,
  IN _IdEstate TINYINT(2),
  IN _IdMunicipality SMALLINT(4),
  IN _Hobbies TEXT(400)
)
BEGIN
  UPDATE MInicioSesionUsuario 
  SET CorreoElectronico = _Mail
  WHERE IdUsuario = _IdUser;

  UPDATE CUsuario
  SET NumeroTelefonico = _TelNum,
      FotoPerfil = _ProfPic,
      Hobbies = _Hobbies
  WHERE IdUsuario = _IdUser;

  UPDATE DLocalidad
  SET IdLocalidad = (SELECT IdLocalidad FROM DLocalidad WHERE IdEstado = _IdEstate AND IdMunicipioDelegacion = _IdMunicipality)
  WHERE IdUsuario = _IdUser;
END//

CREATE PROCEDURE EliminarUSuario(
  IN _IdUser INT(8)
)
BEGIN
  DELETE FROM MInicioSesionUsuario 
  WHERE IdUsuario = _IdUser;
END//

CREATE PROCEDURE IngresarEscuela(
  IN _IdUser INT(8),
  IN _IdSchool SMALLINT(4),
  IN _IdGrade TINYINT(1), 
  IN _Title VARCHAR(255)
)
BEGIN
  INSERT INTO DEscuelaGradoTitulo(
    IdUsuario,
    IdEscuela,
    IdGrado,
    Titulo
    )
  VALUES(
    _IdUser,
    _IdSchool,
    _IdGrade,
    _Title
    );
END//

CREATE PROCEDURE EditarEscuela(
  IN _IdUser INT(8),
  IN _IdSchoolN SMALLINT(4),
  IN _IdSchool SMALLINT(4),
  IN _IdGrade TINYINT(1),
  IN _Title VARCHAR(255)
)
BEGIN
  UPDATE DEscuelaGradoTitulo 
  SET IdEscuela = _IdSchoolN,
      IdGrado = _IdGrade,
      Titulo = _Title
  WHERE IdEscuela = _IdSchool AND IdUsuario = _IdUser;
END//

CREATE PROCEDURE EliminarEscuela(
  IN _IdUser INT(8),
  IN _IdSchool SMALLINT(4)
)
BEGIN
  DELETE FROM DEscuelaGradoTitulo 
  WHERE IdUsuario = _IdUser AND IdEscuela = _IdSchool;
END//

CREATE PROCEDURE IngresarIdioma(
  IN _IdUser INT(8),
  IN _IdLang SMALLINT(3),
  IN _Domain TINYINT(2)
)
BEGIN
  INSERT INTO DIdiomaUsuario(
    IdUSuario,
    IdIdioma,
    Dominio
    )VALUES(
    _IdUser,
    _IdLang,
    _Domain
    );
END// 

CREATE PROCEDURE EditarIdioma(
  IN _Idlang VARCHAR(255),
  IN _IdUser INT(8),
  IN _Domain TINYINT(2)
)
BEGIN
  UPDATE DIdiomaUsuario
    SET Dominio = _Domain
    WHERE IdUSuario = _IdUser AND Idioma = _IdLang;
END//

CREATE PROCEDURE EliminarIdioma(
  IN _IdUser INT(8),
  IN _Idlang SMALLINT(3)
)
BEGIN
  DELETE FROM DIdiomaUsuario  
  WHERE IdIdioma = _IdLang AND IdUSuario = _IdUser;
END//

CREATE PROCEDURE IngresarCompetencia(
  IN _IdUser INT(8),
  IN _IdCompetence SMALLINT(3),
  IN _Domain TINYINT(2)
)
BEGIN
  INSERT INTO DCompetenciasUsuario(
      IdUsuario,
      IdCompetencia,
      Dominio
    )VALUES(
      _IdUser,
      _IdCompetence,
      _Domain
    );
END//

CREATE PROCEDURE EliminarCompetencia(
  IN _IdUser INT(8),
  IN _IdCompetence SMALLINT(3)
)
BEGIN
  DELETE FROM DCompetenciasUsuario 
  WHERE IdUsuario = _IdUser AND IdCompetencia = _IdCompetence;
END//

CREATE PROCEDURE IngresarPerfilProfesional(
  IN _IdUser INT(8),
  IN _IdCategory TINYINT(2),
  IN _Profile TEXT(450)
)
BEGIN
  INSERT INTO CPerfilUsuario(
      IdUsuario,
      IdCategoria,
      PerfilProfesional
    )VALUES(
      _IdUser,
      _IdCategory,
      _Profile
    );
END//

CREATE PROCEDURE EditarPerfilProfesional(
  IN _IdProfile INT,
  IN _IdCategory TINYINT(2),
  IN _Profile TEXT(450)
)
BEGIN
  UPDATE CPerfilUsuario 
  SET IdCategoria = _IdCategory,
      PerfilProfesional = _Profile
  WHERE IdPerfil = _IdProfile;
END//

CREATE PROCEDURE EliminarPerfilProfesional(
  IN _IdProfile INT
)
BEGIN
  DELETE FROM CPerfilUsuario 
  WHERE IdPerfil = _IdProfile;
END//

CREATE PROCEDURE RegistroOrganizacion(
  IN _Mail VARCHAR(255),
  IN _PassR CHAR(32),
  IN _NameOrganization VARCHAR(255),
  IN _LogOrganization VARCHAR(255),
  IN _TelephoneNumber CHAR(8),
  IN _IdEstate TINYINT(2),
  IN _IdMunicipality SMALLINT(4),
  IN _Location VARCHAR(255),
  IN _IdOrgCategory TINYINT(2),
  IN _Slogan VARCHAR(255),
  IN _Description TEXT(400),
  IN _Mision VARCHAR(255),
  IN _Vision VARCHAR(255),
  IN _Values TEXT(500)
)
BEGIN
  INSERT INTO MInicioSesionOrganizacion(
      CorreoElectronico,
      PassOrganizacion
    )VALUES(
      _Mail,
      _PassR
    );

  INSERT INTO COrganizacion(
      IdOrganizacion,
      NombreOrganizacion,
      FotoOrganizacion,
      NumeroTelefonico,
      IdLocalidad,
      Direccion,
      IdCategoriaOrganizacion
    )VALUES(
      (SELECT IdOrganizacion FROM MInicioSesionOrganizacion WHERE CorreoElectronico = _Mail),
      _NameOrganization,
      _LogOrganization,
      _TelephoneNumber,
      (SELECT IdLocalidad FROM DLocalidad WHERE IdEstado = _IdEstate AND IdMunicipioDelegacion = _IdMunicipality),
      _Location,
      _IdOrgCategory
    );

    INSERT INTO CPerfilOrganizacion(
      IdOrganizacion,
      Eslogan,
      Descripcion,
      Mision,
      Vision,
      Valores
    )VALUES(
      (SELECT IdOrganizacion FROM MInicioSesionOrganizacion WHERE CorreoElectronico = _Mail),
      _Slogan,
      _Description,
      _Mision,
      _Vision,
      _Values
    );

END// 

CREATE PROCEDURE EditarOrganizacion(
  IN _IdOrg INT(8),
  IN _Mail VARCHAR(255),
  IN _NameOrganization VARCHAR(255),
  IN _LogOrganization VARCHAR(255),
  IN _TelephoneNumber CHAR(8),
  IN _IdEstate TINYINT(2),
  IN _IdMunicipality SMALLINT(4),
  IN _Location VARCHAR(255),
  IN _IdOrgCategory TINYINT(2)
)
BEGIN
  UPDATE MInicioSesionOrganizacion 
  SET CorreoElectronico = _Mail
  WHERE IdOrganizacion = _IdOrg;

  UPDATE COrganizacion 
  SET NombreOrganizacion = _NameOrganization,
      FotoOrganizacion = _LogOrganization,
      NumeroTelefonico = _TelephoneNumber,
      IdLocalidad = (SELECT IdLocalidad from DLocalidad WHERE IdEstado = _IdEstate AND IdMunicipioDelegacion = _IdMunicipality),
      Direccion = _Location,
      IdCategoriaOrganizacion = _IdOrgCategory;
END//

CREATE PROCEDURE EditarPerfilOrganizacion(
  IN _IdOrg INT(8),
  IN _Slogan VARCHAR(255),
  IN _Description TEXT(400),
  IN _Mision VARCHAR(255),
  IN _Vision VARCHAR(255),
  IN _Values TEXT(500)
)
BEGIN
  UPDATE CPerfilOrganizacion 
  SET Eslogan = _Slogan,
      Descripcion = _Description,
      Mision = _Mision,
      Vision = _Vision,
      Valores = _Values
  WHERE idOrganizacion = _IdOrg;
END//

CREATE PROCEDURE EliminarOrganizacion(
  IN _IdOrg INT(8)
)
BEGIN
  DELETE FROM MInicioSesionOrganizacion 
  WHERE IdOrganizacion = _IdOrg;
END//

CREATE PROCEDURE IngresarRepresentante(
  IN _IdOrg INT(8),
  IN _AgentName VARCHAR(40),
  IN _AgentSurname VARCHAR(24),
  IN _AgentMail VARCHAR(255),
  IN _AgentCharge VARCHAR(255),
  IN _AgentProfPic VARCHAR(255)
)
BEGIN
  INSERT INTO CRepresentanteOrganizacion(
    IdOrganizacion,
    Nombre,
    ApellidoPaterno,
    CorreoElectronico,
    Cargo,
    FotoRepresentante
  )VALUES(
    _IdOrg,
    _AgentName,
    _AgentSurname,
    _AgentMail,
    _AgentCharge,
    _AgentProfPic
  );
END//

CREATE PROCEDURE EditarRepresentante(
  IN _IdAgent INT,
  IN _AgentName VARCHAR(40),
  IN _AgentSurname VARCHAR(24),
  IN _AgentMail VARCHAR(255),
  IN _AgentCharge VARCHAR(255),
  IN _AgentProfPic VARCHAR(255)
)
BEGIN
  UPDATE CRepresentanteOrganizacion 
  SET Nombre = _AgentName,
      ApellidoPaterno = _AgentSurname,
      CorreoElectronico = _AgentMail,
      Cargo = _AgentCharge,
      FotoRepresentante = _AgentProfPic
  WHERE IdRepresentanteOrganizacion = _IdAgent;
END//

CREATE PROCEDURE EliminarRepresentante(
  IN _IdAgent INT
)
BEGIN
  DELETE FROM CRepresentanteOrganizacion 
  WHERE IdRepresentanteOrganizacion = _IdAgent;
END//

CREATE PROCEDURE GuardarOferta(
  IN _IdOrg INT(8),
  IN _Title VARCHAR(40),
  IN _Description VARCHAR(140),
  IN _Bennefits VARCHAR(255),
  IN _Pay DECIMAL(10, 8), 
  IN _IdPayPeriod TINYINT(1),
  IN _Latitude DECIMAL(10, 8),
  IN _Longitude DECIMAL(10, 8)
)
BEGIN
  INSERT INTO COferta(
    IdOrganizacion,
    Titulo,
    Descripcion,
    Beneficios,
    Pago,
    IdPeriodoDePago,
    Latitud,
    Longitud
  )VALUES(
    _IdOrg,
    _Title,
    _Description,
    _Bennefits,
    _Pay,
    _IdPayPeriod,
    _Latitude,
    _Longitude
  );
END//

CREATE PROCEDURE InsertarCompetenciaOferta(
  _IdOffer INT,
  _IdCompetence SMALLINT(3)
)
BEGIN
  INSERT INTO DOfertaCompetencias(
    IdOferta,
    IdCompetencia
  )VALUES(
    _IdOffer,
    _IdCompetence
  );
END//

CREATE PROCEDURE EditarOferta(
  IN _IdOffer INT,
  IN _Title VARCHAR(40),
  IN _Description VARCHAR(140),
  IN _Bennefits VARCHAR(255),
  IN _Pay DECIMAL(10, 8), 
  IN _IdPayPeriod TINYINT(1),
  IN _Latitude DECIMAL(10, 8),
  IN _Longitude DECIMAL(10, 8)
)
BEGIN
  UPDATE COferta 
  SET Titulo = _Title,
      Descripcion = _Description,
      Beneficios = _Bennefits,
      Pago = _Pay,
      IdPeriodoDePago = _IdPayPeriod,
      Latitud = _Latitude,
      Longitud = _Longitude
  WHERE IdOferta = _IdOffer;
END//

CREATE PROCEDURE EliminarOferta(
  IN _IdOffer INT
)
BEGIN
  DELETE FROM COferta 
  WHERE IdOferta = _IdOffer;
END//

CREATE PROCEDURE SolicitarOferta(
  IN _IdUser INT(8),
  IN _IdOffer INT
)
BEGIN
  INSERT INTO DUsuarioOferta(
      IdUsuario,
      IdOferta
    )VALUES(
      _IdUser,
      _IdOffer
    );
END//

CREATE PROCEDURE EliminarSolicitud(
  IN _IdUser INT(8),
  IN _IdOffer INT
)
BEGIN
  DELETE FROM DUsuarioOferta 
  WHERE IdUsuario = _IdUser AND IdOferta = _IdOffer;
END//

CREATE PROCEDURE PublicarArticulo(
  _IdOrg INT(8),
  _Title VARCHAR(80),
  _Thumb VARCHAR(255),
  _Content TEXT(20000),
  _Bibliography TEXT(500)
)
BEGIN
  INSERT INTO CArticulo(
    IdOrganizacion,
    Titulo,
    Miniatura,
    Contenido,
    Fuentes
  )VALUES(
    _IdOrg,
    _Title,
    _Thumb,
    _Content,
    _Bibliography
  );  
END//

CREATE PROCEDURE EliminarArticulo(
  _IdArticle INT
)
BEGIN
  DELETE FROM CArticulo 
  WHERE IdArticulo = _IdArticle;
END//

DELIMITER ;

INSERT INTO CEstado(Estado)
VALUES('Estado no especificado'),
('Ciudad de M�xico'),
('M�xico');

INSERT INTO CMunicipioDelegacion(MunicipioDelegacion)
VALUES('Municipio no especificado'),
('�lvaro Obreg�n'),
('Azcapotzalco'),
('Benito Ju�rez'),
('Coyoac�n'),
('Cuajimalpa de Morelos'),
('Cuauht�moc'),
('Gustavo A. Madero'),
('Iztacalco'),
('Iztapalapa'),
('La Magdalena Contreras'),
('Miguel Hidalgo'),
('Milpa Alta'),
('Tl�huac'),
('Tlalpan'),
('Venustiano Carranza'),
('Xochimilco'),
('Toluca'),
('Acambay de Ru�z Casta�eda'),
('Aculco'),
('Temascalcingo'),
('Atlacomulco'),
('Timilpan'),
('Morelos'),
('El Oro'),
('San Felipe del Progreso'),
('San Jos� del Rinc�n'),
('Jocotitl�n'),
('Ixtlahuaca'),
('Jiquipilco'),
('Temoaya'),
('Almoloya de Ju�rez'),
('Villa Victoria'),
('Villa de Allende'),
('Donato Guerra'),
('Ixtapan del Oro'),
('Santo Tom�s'),
('Otzoloapan'),
('Zacazonapan'),
('Valle de Bravo'),
('Amanalco'),
('Temascaltepec'),
('Zinacantepec'),
('Tejupilco'),
('Luvianos'),
('San Sim�n de Guerrero'),
('Amatepec'),
('Tlatlaya'),
('Sultepec'),
('Texcaltitl�n'),
('Coatepec Harinas'),
('Villa Guerrero'),
('Zacualpan'),
('Almoloya de Alquisiras'),
('Ixtapan de la Sal'),
('Tonatico'),
('Zumpahuac�n'),
('Lerma'),
('Xonacatl�n'),
('Otzolotepec'),
('San Mateo Atenco'),
('Metepec'),
('Mexicaltzingo'),
('Calimaya'),
('Chapultepec'),
('San Antonio la Isla'),
('Tenango del Valle'),
('Ray�n'),
('Joquicingo'),
('Tenancingo'),
('Malinalco'),
('Ocuilan'),
('Atizap�n'),
('Almoloya del R�o'),
('Texcalyacac'),
('Tianguistenco'),
('Xalatlaco'),
('Capulhuac'),
('Ocoyoacac'),
('Huixquilucan'),
('Atizap�n de Zaragoza'),
('Naucalpan de Ju�rez'),
('Tlalnepantla de Baz'),
('Polotitl�n'),
('Jilotepec'),
('Soyaniquilpan de Ju�rez'),
('Villa del Carb�n'),
('Chapa de Mota'),
('Nicol�s Romero'),
('Isidro Fabela'),
('Jilotzingo'),
('Tepotzotl�n'),
('Coyotepec'),
('Huehuetoca'),
('Cuautitl�n Izcalli'),
('Teoloyucan'),
('Cuautitl�n'),
('Melchor Ocampo'),
('Tultitl�n'),
('Tultepec'),
('Ecatepec de Morelos'),
('Zumpango'),
('Tequixquiac'),
('Apaxco'),
('Hueypoxtla'),
('Coacalco de Berrioz�bal'),
('Tec�mac'),
('Jaltenco'),
('Tonanitla'),
('Nextlalpan'),
('Teotihuac�n'),
('San Mart�n de las Pir�mides'),
('Acolman'),
('Otumba'),
('Axapusco'),
('Nopaltepec'),
('Temascalapa'),
('Tezoyuca'),
('Chiautla'),
('Papalotla'),
('Tepetlaoxtoc'),
('Texcoco'),
('Chiconcuac'),
('Atenco'),
('Chimalhuac�n'),
('Chicoloapan'),
('La Paz'),
('Ixtapaluca'),
('Chalco'),
('Valle de Chalco Solidaridad'),
('Temamatla'),
('Cocotitl�n'),
('Tlalmanalco'),
('Ayapango'),
('Tenango del Aire'),
('Ozumba'),
('Juchitepec'),
('Tepetlixpa'),
('Amecameca'),
('Atlautla'),
('Ecatzingo'),
('Nezahualc�yotl');

INSERT INTO DLocalidad (IdEstado, IdMunicipioDelegacion)
VALUES(1, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 13),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(3, 18),
(3, 19),
(3, 20),
(3, 21),
(3, 22),
(3, 23),
(3, 24),
(3, 25),
(3, 26),
(3, 27),
(3, 28),
(3, 29),
(3, 30),
(3, 31),
(3, 32),
(3, 33),
(3, 34),
(3, 35),
(3, 36),
(3, 37),
(3, 38),
(3, 39),
(3, 40),
(3, 41),
(3, 42),
(3, 43),
(3, 44),
(3, 45),
(3, 46),
(3, 47),
(3, 48),
(3, 49),
(3, 50),
(3, 51),
(3, 52),
(3, 53),
(3, 54),
(3, 55),
(3, 56),
(3, 57),
(3, 58),
(3, 59),
(3, 60),
(3, 61),
(3, 62),
(3, 63),
(3, 64),
(3, 65),
(3, 66),
(3, 67),
(3, 68),
(3, 69),
(3, 70),
(3, 71),
(3, 72),
(3, 73),
(3, 74),
(3, 75),
(3, 76),
(3, 77),
(3, 78),
(3, 79),
(3, 80),
(3, 81),
(3, 82),
(3, 83),
(3, 84),
(3, 85),
(3, 86),
(3, 87),
(3, 88),
(3, 89),
(3, 90),
(3, 91),
(3, 92),
(3, 93),
(3, 94),
(3, 95),
(3, 96),
(3, 97),
(3, 98),
(3, 99),
(3, 100),
(3, 101),
(3, 102),
(3, 103),
(3, 104),
(3, 105),
(3, 106),
(3, 107),
(3, 108),
(3, 109),
(3, 110),
(3, 111),
(3, 112),
(3, 113),
(3, 114),
(3, 115),
(3, 116),
(3, 117),
(3, 118),
(3, 119),
(3, 121),
(3, 122),
(3, 123),
(3, 124),
(3, 125),
(3, 126),
(3, 127),
(3, 128),
(3, 129),
(3, 130),
(3, 131),
(3, 132),
(3, 133),
(3, 134),
(3, 135),
(3, 136),
(3, 137),
(3, 138),
(3, 139),
(3, 140),
(3, 141),
(3, 142);

INSERT INTO CSexo(Sexo)
VALUES('Hombre'),
('Mujer');

INSERT INTO CCategoria(Categoria, FotoCategoria)
VALUES('Artes y Dise�o', '#FF9D68'),
('Ciencias F�sico Mate�ticas', '#7CC6FF'),
('Ciencias M�dico Biol�gicas', '#75BDD3'),
('Ciencias Sociales Administrativas', '#CCCCCC');

INSERT INTO CCompetenciasProfesionales(Competencia)
VALUES('Creatividad'),
('Capacidad para tomar deciciones'),
('Capacidad para actuar en nuevas situaciones'),
('Habilidad para trabajar de forma aut�noma'),
('Capacidad cr�tica y autocr�tica'),
('Capacidad para formular y gestionar proyectos'),
('Habilidades en el uso de las TIC'),
('Capacidad de trabajo en equipo'),
('Capacidad de comunicaci�n oral y escrita'),
('Capacidad para motivar y conducir hacia metas comunes'),
('Habilidades interpersonales'),
('Capacidad de comunicacion en un segundo idioma'),
('Habilidad para trabajar en contextos internacionales'),
('Responsabilidad social y compromiso ciudadano'),
('Compromiso con su medio sociocultural'),
('Compromiso �tico'),
('Compromiso con la calidad'),
('Valoraci�n y respeto por la diversidad y la multicultiralidad'),
('Compromiso con la preservaci�n del medio ambiente'),
('Conocimientos sobre el area de estudio y la profesi�n'),
('Capacidad de aplicar conocimientos en la practica'),
('Capacidad de abstracci�n an�lisis y sintesis'),
('Capacidad de identificar, plantear y resolver problemas'),
('Capacidad de investigaci�n'),
('Capacidad de aprendizaje y actualizaci�n permanentes'),
('Habilidad para buscar, procesar, y analizar informaci�n procedente de fuentes diversas'),
('Capacidad de organizar y planificar tiempo');

INSERT INTO CIdioma(Idioma)
VALUES('Espa�ol'),
('Ingl�s'),
('Hindi'),
('�rabe'),
('Portugu�s'),
('Bengal�'),
('Ruso'),
('Japon�s'),
('Panyab�'),
('Turco');

INSERT INTO CEscuela(TipoEscuela, Escuela)
VALUES('B', 'CECyT No. 1 Gonzalo V�zquez Vela'),
('B', 'CECyT No. 2 Miguel Bernard'),
('B', 'CECyT No. 3 Estanislao Ram�rez Ruiz'),
('B', 'CECyT No. 4 L�zaro C�rdenas del R�o'),
('B', 'CECyT No. 5 Benito Ju�rez'),
('B', 'CECyT No. 6 Miguel Oth�n de Mendiz�bal'),
('B', 'CECyT No. 7 Cuauht�moc'),
('B', 'CECyT No. 8 Narciso Bassols'),
('B', 'CECyT No. 9 Juan de Dios B�tiz'),
('B', 'CECyT No. 10 Carlos Vallejo M�rquez'),
('B', 'CECyT No. 11 Wilfrido Massieu'),
('B', 'CECyT No. 12 Jos� Mar�a Morelos'),
('B', 'CECyT No. 13 Ricardo Flores Mag�n'),
('B', 'CECyT No. 14 Luis Enrique Erro Soler'),
('B', 'CECyT No. 15 Di�doro Ant�nez Echegaray'),
('B', 'CECyT No. 16 Hidalgo'),
('B', 'CECyT No. 17 Le�n-Guanajuato'),
('B', 'CECyT No. 18 Zacatecas'),
('B', 'CET 1 Walter Cross Buchanan'),
('B', 'CCH Plantel Azcapotzalco'),
('B', 'CCH Plantel Naucalpan'),
('B', 'CCH Plantel Oriente'),
('B', 'CCH Plantel Sur'),
('B', 'CCH Plantel Vallejo'),
('B', 'ENP Plantel 1 "Gabino Barreda"'),
('B', 'ENP Plantel 2 "Erasmo Castellanos Quinto"'),
('B', 'ENP 3 "Justo Sierra"'),
('B', 'ENP 4 "Vidal Casta�eda y N�jera"'),
('B', 'ENP 5 "Jos� Vasconcelos"'),
('B', 'ENP 6 "Antonio Caso"'),
('B', 'ENP 7 "Ezequiel A. Ch�vez"'),
('B', 'ENP 8 "Miguel E. Schulz"'),
('B', 'ENP 9 "Pedro de Alba"'),
('U', 'IPN: CICS Unidad Santo Tom�s'),
('U', 'IPN: ESIME Unidad Zacatenco'),
('U', 'IPN: ENCB'),
('U', 'IPN: ENMyH '),
('U', 'IPN: ESCA Unidad Santo Tom�s'),
('U', 'IPN: ESCA Unidad Tepepan'),
('U', 'IPN: ESCOM'),
('U', 'IPN: ESE'),
('U', 'IPN: ESEO'),
('U', 'IPN: ESFM'),
('U', 'IPN: ESIME Unidad Azcapotzalco'),
('U', 'IPN: ESIME Unidad Culhuac�n'),
('U', 'IPN: ESIME Unidad Ticom�n'),
('U', 'IPN: ESIQIE'),
('U', 'IPN: ESIT'),
('U', 'IPN: ESIA Unidad Tecamachalco'),
('U', 'IPN: ESIA Unidad Ticom�n'),
('U', 'IPN: ESIA Unidad Zacatenco'),
('U', 'IPN: ESM'),
('U', 'IPN: EST'),
('U', 'IPN: UPIBI'),
('U', 'IPN: UPIIG Campus Guanajuato'),
('U', 'IPN: UPIIZ Campus Zacatecas'),
('U', 'IPN: UPIICSA'),
('U', 'IPN: UPIITA'),
('U', 'IPN: CICS Unidad Milpa Alta'),
('U', 'IPN: UPIIH Campus Hidalgo'),
('U', 'UNAM: Facultad de Arquitectura'),
('U', 'UNAM: Facultad de Artes y Dise�o'),
('U', 'UNAM: Facultad de Ciencias'),
('U', 'UNAM: Facultad de Ciencias Pol�ticas y Sociales'),
('U', 'UNAM: Facultad de Contadur�a y Administraci�n'),
('U', 'UNAM: Facultad de Derecho'),
('U', 'UNAM: Facultad de Econom�a'),
('U', 'UNAM: Facultad de Estudios Superiores (FES) Acatl�n'),
('U', 'UNAM: Facultad de Estudios Superiores (FES) Arag�n'),
('U', 'UNAM: Facultad de Estudios Superiores (FES) Cuautitl�n'),
('U', 'UNAM: Facultad de Estudios Superiores (FES) Iztacala'),
('U', 'UNAM: Facultad de Estudios Superiores (FES) Zaragoza'),
('U', 'UNAM: Facultad de Filosof�a y Letras'),
('U', 'UNAM: Facultad de Ingenier�a'),
('U', 'UNAM: Facultad de Medicina'),
('U', 'UNAM: Facultad de Medicina Veterinaria y Zootecnia'),
('U', 'UNAM: Facultad de M�sica'),
('U', 'UNAM: Facultad de Odontolog�a'),
('U', 'UNAM: Facultad de Psicolog�a'),
('U', 'UNAM: Facultad de Qu�mica');

INSERT INTO CGrado(Grado)
VALUES('Diplomado'),
('Bachillerato'),
('Carrera T�cnica'),
('Lisenciatura'),
('Maestr�a'),
('Doctorado');

INSERT INTO CCategoriaOrganizacion(CategoriaOrganizacion)
VALUES('Alimenticia'),
('Farmac�utica'),
('Sider�rgica'),
('Metalurgica'),
('Qu�mica'),
('Petroqu�mica'),
('Textil'),
('Automotriz'),
('Inmobiliaria'),
('Rob�tica'),
('Inform�tica'),
('Astron�utica'),
('Mec�nica'),
('Aeroespacial');

INSERT INTO CPeriodoDePago(PeriodoDePago)
VALUES('Diario'),
('Semanal'),
('Quincenal'),
('Mensual');
