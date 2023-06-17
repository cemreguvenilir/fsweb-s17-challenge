-- Tasarımını yaptığınız tabloları oluşturan sql ifadeleri buraya yazınız.
-- veri tiplerine, nullable olma durumuna, default değerine ve tablolar arası foreign key kullanımına dikkat.
BEGIN;


CREATE TABLE IF NOT EXISTS public.users
(
    user_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    name character varying(20) NOT NULL,
    surname character varying(30) NOT NULL,
    email character varying NOT NULL,
    tel_no character varying(11) NOT NULL,
    membership_date date NOT NULL,
    PRIMARY KEY (user_id)
);

CREATE TABLE IF NOT EXISTS public.favorites
(
    fav_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    user_id smallint NOT NULL,
    ilan_id smallint NOT NULL,
    PRIMARY KEY (fav_id)
);

CREATE TABLE IF NOT EXISTS public.ilan
(
    ilan_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    fotograf character varying,
    baslik character varying(80) NOT NULL,
    aciklama character varying NOT NULL,
    ilan_date date NOT NULL,
    user_id smallint NOT NULL,
    category_id smallint NOT NULL,
    PRIMARY KEY (ilan_id)
);

CREATE TABLE IF NOT EXISTS public.category
(
    category_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    category_name character varying(30) NOT NULL,
    PRIMARY KEY (category_id)
);

CREATE TABLE IF NOT EXISTS public.sub_category
(
    sub_category_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    name character varying(30) NOT NULL,
    category_id smallint NOT NULL,
    PRIMARY KEY (sub_category_id)
);

CREATE TABLE IF NOT EXISTS public.message
(
    message_id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 ),
    text character varying NOT NULL,
    ilan_id smallint NOT NULL,
    user_id smallint NOT NULL,
    PRIMARY KEY (message_id)
);

ALTER TABLE IF EXISTS public.favorites
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.favorites
    ADD FOREIGN KEY (ilan_id)
    REFERENCES public.ilan (ilan_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.ilan
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.ilan
    ADD FOREIGN KEY (category_id)
    REFERENCES public.category (category_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.sub_category
    ADD FOREIGN KEY (category_id)
    REFERENCES public.category (category_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.message
    ADD FOREIGN KEY (ilan_id)
    REFERENCES public.ilan (ilan_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.message
    ADD FOREIGN KEY (user_id)
    REFERENCES public.users (user_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;