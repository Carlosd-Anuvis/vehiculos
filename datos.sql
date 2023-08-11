CREATE TABLE IF NOT EXISTS public.vehiculos
(
    id_vehiculo serial NOT NULL,
    modelo character varying NOT NULL,
    precio numeric NOT NULL,
    descuento numeric,
    potencia_motor character varying NOT NULL,
    capacidad_cilindro character varying NOT NULL,
    id_modelo integer,
    id_marca integer,
    PRIMARY KEY (id_vehiculo)
);

-- Tabla Modelos
CREATE TABLE IF NOT EXISTS public.modelos
(
    id_modelo serial NOT NULL,
    nombre character varying NOT NULL,
    PRIMARY KEY (id_modelo)
);

-- Tabla Extras
CREATE TABLE IF NOT EXISTS public.extras
(
    id_extras serial NOT NULL,
    aire_acondicionado character varying NOT NULL,
    airbag_copiloto character varying NOT NULL,
    pintura_especial character varying NOT NULL,
    estereo character varying NOT NULL,
    precio numeric NOT NULL,
    airbag_conductor character varying,
    bloqueo_central character varying,
    id_modelo integer,
    PRIMARY KEY (id_extras)
);

-- Tabla Inventario
CREATE TABLE IF NOT EXISTS public.inventario
(
    id_inventario serial NOT NULL,
    cantidad integer NOT NULL,
    id_vehiculos integer,
    "tienda_principal" integer,
    PRIMARY KEY (id_inventario)
);

-- Tabla TiendaPrincipal
CREATE TABLE IF NOT EXISTS public.tienda_principal
(
    id_nombre serial NOT NULL,
    direccion character varying NOT NULL,
    nit character varying NOT NULL,
    PRIMARY KEY (id_nombre)
);

-- Tabla ServicioOficial
CREATE TABLE IF NOT EXISTS public.servicio_oficial
(
    id_servicio_oficial serial NOT NULL,
    nombre character varying NOT NULL,
    direccion character varying NOT NULL,
    nit character varying NOT NULL,
    tienda_principal integer,
    PRIMARY KEY (id_servicio_oficial)
);

-- Tabla Vendedores
CREATE TABLE IF NOT EXISTS public.vendedores
(
    id_vendedor serial NOT NULL,
    nombre character varying NOT NULL,
    direccion character varying NOT NULL,
    documento character varying NOT NULL,
    correo_electronico character varying NOT NULL,
    id_servicio_oficial integer,
    PRIMARY KEY (id_vendedor),
    CONSTRAINT correo_electronico UNIQUE (correo_electronico)
);

-- Tabla Ventas
CREATE TABLE IF NOT EXISTS public.ventas
(
    id_venta serial NOT NULL,
    precio numeric NOT NULL,
    metodo_pago character varying NOT NULL,
    fecha_limite date NOT NULL,
    matricula character varying NOT NULL,
    id_vehiculo integer,
    id_vendedor integer,
    PRIMARY KEY (id_venta)
);

-- Tabla Marcas
CREATE TABLE IF NOT EXISTS public.marcas
(
    id_marca serial NOT NULL,
    nombre character varying NOT NULL,
    PRIMARY KEY (id_marca)
);

ALTER TABLE IF EXISTS public.vehiculos
    ADD CONSTRAINT fk_id_modelo FOREIGN KEY (id_modelo)
    REFERENCES public.modelos (id_modelo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.vehiculos
    ADD CONSTRAINT fk_id_marca FOREIGN KEY (id_marca)
    REFERENCES public.marcas (id_marca) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.extras
    ADD CONSTRAINT fk_id_modelo FOREIGN KEY (id_modelo)
    REFERENCES public.modelos (id_modelo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.inventario
    ADD CONSTRAINT fk_id_vehiculos FOREIGN KEY (id_vehiculos)
    REFERENCES public.vehiculos (id_vehiculo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.inventario
    ADD CONSTRAINT fk_tienda_principal FOREIGN KEY ("tienda_principal")
    REFERENCES public.tienda_principal (id_nombre) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.servicio_oficial
    ADD CONSTRAINT fk_tienda_principal_id FOREIGN KEY (tienda_principal)
    REFERENCES public.tienda_principal (id_nombre) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.vendedores
    ADD CONSTRAINT fk_id_servicio_oficial FOREIGN KEY (id_servicio_oficial)
    REFERENCES public.servicio_oficial (id_servicio_oficial) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.ventas
    ADD CONSTRAINT fk_id_vehiculo FOREIGN KEY (id_vehiculo)
    REFERENCES public.vehiculos (id_vehiculo) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

ALTER TABLE IF EXISTS public.ventas
    ADD CONSTRAINT fk_id_vendedor FOREIGN KEY (id_vendedor)
    REFERENCES public.vendedores (id_vendedor) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
