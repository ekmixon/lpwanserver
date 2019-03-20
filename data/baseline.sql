--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5 (Debian 10.5-2.pgdg90+1)
-- Dumped by pg_dump version 10.5 (Debian 10.5-2.pgdg90+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: applicationNetworkTypeLinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."applicationNetworkTypeLinks" (
    id bigint NOT NULL,
    "applicationId" bigint,
    "networkTypeId" bigint,
    "networkSettings" text
);


--
-- Name: applicationNetworkTypeLinks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."applicationNetworkTypeLinks" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."applicationNetworkTypeLinks_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: applications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.applications (
    id bigint NOT NULL,
    "companyId" bigint,
    name text,
    description text,
    "baseUrl" text,
    "reportingProtocolId" bigint
);


--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.applications ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.companies (
    id bigint NOT NULL,
    name text,
    type bigint
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.companies ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: companyNetworkTypeLinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."companyNetworkTypeLinks" (
    id bigint NOT NULL,
    "companyId" bigint,
    "networkTypeId" bigint,
    "networkSettings" text
);


--
-- Name: companyNetworkTypeLinks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."companyNetworkTypeLinks" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."companyNetworkTypeLinks_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: companyTypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."companyTypes" (
    type bigint NOT NULL,
    name text
);


--
-- Name: companyTypes_type_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."companyTypes" ALTER COLUMN type ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."companyTypes_type_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: deviceNetworkTypeLinks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."deviceNetworkTypeLinks" (
    id bigint NOT NULL,
    "deviceId" bigint,
    "networkTypeId" bigint,
    "deviceProfileId" bigint,
    "networkSettings" text
);


--
-- Name: deviceNetworkTypeLinks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."deviceNetworkTypeLinks" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."deviceNetworkTypeLinks_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: deviceProfiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."deviceProfiles" (
    id bigint NOT NULL,
    "networkTypeId" bigint,
    "companyId" bigint,
    name text,
    description text,
    "networkSettings" text
);


--
-- Name: deviceProfiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."deviceProfiles" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."deviceProfiles_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: devices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.devices (
    id bigint NOT NULL,
    "applicationId" bigint,
    name text,
    description text,
    "deviceModel" text
);


--
-- Name: devices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.devices ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.devices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: emailVerifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."emailVerifications" (
    id bigint NOT NULL,
    "userId" bigint,
    uuid text,
    email text,
    "changeRequested" text
);


--
-- Name: emailVerifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."emailVerifications" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."emailVerifications_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: networkProtocols; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."networkProtocols" (
    id bigint NOT NULL,
    name text,
    "protocolHandler" text,
    "networkTypeId" bigint,
    "networkProtocolVersion" text,
    "masterProtocol" bigint
);


--
-- Name: networkProtocols_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."networkProtocols" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."networkProtocols_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: networkProviders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."networkProviders" (
    id bigint NOT NULL,
    name text
);


--
-- Name: networkProviders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."networkProviders" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."networkProviders_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: networkTypes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."networkTypes" (
    id bigint NOT NULL,
    name text
);


--
-- Name: networkTypes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."networkTypes" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."networkTypes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: networks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.networks (
    id bigint NOT NULL,
    name text,
    "networkProviderId" bigint,
    "networkTypeId" bigint,
    "networkProtocolId" bigint,
    "baseUrl" text,
    "securityData" text
);


--
-- Name: networks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.networks ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.networks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: passwordPolicies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."passwordPolicies" (
    id bigint NOT NULL,
    "ruleText" text,
    "ruleRegExp" text,
    "companyId" bigint
);


--
-- Name: passwordPolicies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."passwordPolicies" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."passwordPolicies_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: protocolData; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."protocolData" (
    id bigint NOT NULL,
    "networkId" bigint,
    "networkProtocolId" bigint,
    "dataIdentifier" text,
    "dataValue" text
);


--
-- Name: protocolData_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."protocolData" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."protocolData_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reportingProtocols; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."reportingProtocols" (
    id bigint NOT NULL,
    name text,
    "protocolHandler" text
);


--
-- Name: reportingProtocols_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."reportingProtocols" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."reportingProtocols_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: userRoles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."userRoles" (
    "roleId" bigint NOT NULL,
    name text
);


--
-- Name: userRoles_roleId_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public."userRoles" ALTER COLUMN "roleId" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public."userRoles_roleId_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username text,
    email text,
    "lastVerifiedEmail" text,
    "emailVerified" boolean DEFAULT false,
    "companyId" bigint,
    "passwordHash" text,
    role bigint
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: applicationNetworkTypeLinks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."applicationNetworkTypeLinks" (id, "applicationId", "networkTypeId", "networkSettings") FROM stdin;
\.


--
-- Data for Name: applications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.applications (id, "companyId", name, description, "baseUrl", "reportingProtocolId") FROM stdin;
\.


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.companies (id, name, type) FROM stdin;
1	SysAdmins	1
2	cablelabs	1
\.


--
-- Data for Name: companyNetworkTypeLinks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."companyNetworkTypeLinks" (id, "companyId", "networkTypeId", "networkSettings") FROM stdin;
\.


--
-- Data for Name: companyTypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."companyTypes" (type, name) FROM stdin;
1	admin
2	vendor
\.


--
-- Data for Name: deviceNetworkTypeLinks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."deviceNetworkTypeLinks" (id, "deviceId", "networkTypeId", "deviceProfileId", "networkSettings") FROM stdin;
\.


--
-- Data for Name: deviceProfiles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."deviceProfiles" (id, "networkTypeId", "companyId", name, description, "networkSettings") FROM stdin;
\.


--
-- Data for Name: devices; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.devices (id, "applicationId", name, description, "deviceModel") FROM stdin;
\.


--
-- Data for Name: emailVerifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."emailVerifications" (id, "userId", uuid, email, "changeRequested") FROM stdin;
\.


--
-- Data for Name: networkProtocols; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."networkProtocols" (id, name, "protocolHandler", "networkTypeId", "networkProtocolVersion", "masterProtocol") FROM stdin;
\.


--
-- Data for Name: networkProviders; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."networkProviders" (id, name) FROM stdin;
\.


--
-- Data for Name: networkTypes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."networkTypes" (id, name) FROM stdin;
1	LoRa
\.


--
-- Data for Name: networks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.networks (id, name, "networkProviderId", "networkTypeId", "networkProtocolId", "baseUrl", "securityData") FROM stdin;
\.


--
-- Data for Name: passwordPolicies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."passwordPolicies" (id, "ruleText", "ruleRegExp", "companyId") FROM stdin;
1	Must be at least 6 characters long	^\\S{6,}$	1
\.


--
-- Data for Name: protocolData; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."protocolData" (id, "networkId", "networkProtocolId", "dataIdentifier", "dataValue") FROM stdin;
\.


--
-- Data for Name: reportingProtocols; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."reportingProtocols" (id, name, "protocolHandler") FROM stdin;
1	POST	postHandler
\.


--
-- Data for Name: userRoles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public."userRoles" ("roleId", name) FROM stdin;
1	user
2	admin
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, username, email, "lastVerifiedEmail", "emailVerified", "companyId", "passwordHash", role) FROM stdin;
1	admin	admin@fakeco.co	\N	f	2	000000100000003238bd33bdf92cfc3a8e7847e377e51ff8a3689913919b39d7dd0fe77c89610ce2947ab0b43a36895510d7d1f2924d84ab	2
\.


--
-- Name: applicationNetworkTypeLinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."applicationNetworkTypeLinks_id_seq"', 1, false);


--
-- Name: applications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.applications_id_seq', 1, false);


--
-- Name: companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.companies_id_seq', 2, false);


--
-- Name: companyNetworkTypeLinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."companyNetworkTypeLinks_id_seq"', 1, false);


--
-- Name: companyTypes_type_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."companyTypes_type_seq"', 3, false);


--
-- Name: deviceNetworkTypeLinks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."deviceNetworkTypeLinks_id_seq"', 1, false);


--
-- Name: deviceProfiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."deviceProfiles_id_seq"', 1, false);


--
-- Name: devices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.devices_id_seq', 1, false);


--
-- Name: emailVerifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."emailVerifications_id_seq"', 1, false);


--
-- Name: networkProtocols_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."networkProtocols_id_seq"', 4, false);


--
-- Name: networkProviders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."networkProviders_id_seq"', 1, false);


--
-- Name: networkTypes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."networkTypes_id_seq"', 2, false);


--
-- Name: networks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.networks_id_seq', 1, false);


--
-- Name: passwordPolicies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."passwordPolicies_id_seq"', 2, false);


--
-- Name: protocolData_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."protocolData_id_seq"', 1, false);


--
-- Name: reportingProtocols_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."reportingProtocols_id_seq"', 2, false);


--
-- Name: userRoles_roleId_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public."userRoles_roleId_seq"', 3, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 2, false);


--
-- Name: applicationNetworkTypeLinks applicationNetworkTypeLinks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."applicationNetworkTypeLinks"
    ADD CONSTRAINT "applicationNetworkTypeLinks_pkey" PRIMARY KEY (id);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: companyNetworkTypeLinks companyNetworkTypeLinks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."companyNetworkTypeLinks"
    ADD CONSTRAINT "companyNetworkTypeLinks_pkey" PRIMARY KEY (id);


--
-- Name: companyTypes companyTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."companyTypes"
    ADD CONSTRAINT "companyTypes_pkey" PRIMARY KEY (type);


--
-- Name: deviceNetworkTypeLinks deviceNetworkTypeLinks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."deviceNetworkTypeLinks"
    ADD CONSTRAINT "deviceNetworkTypeLinks_pkey" PRIMARY KEY (id);


--
-- Name: deviceProfiles deviceProfiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."deviceProfiles"
    ADD CONSTRAINT "deviceProfiles_pkey" PRIMARY KEY (id);


--
-- Name: devices devices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT devices_pkey PRIMARY KEY (id);


--
-- Name: emailVerifications emailVerifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."emailVerifications"
    ADD CONSTRAINT "emailVerifications_pkey" PRIMARY KEY (id);


--
-- Name: networkProtocols networkProtocols_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."networkProtocols"
    ADD CONSTRAINT "networkProtocols_pkey" PRIMARY KEY (id);


--
-- Name: networkProviders networkProviders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."networkProviders"
    ADD CONSTRAINT "networkProviders_pkey" PRIMARY KEY (id);


--
-- Name: networkTypes networkTypes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."networkTypes"
    ADD CONSTRAINT "networkTypes_pkey" PRIMARY KEY (id);


--
-- Name: networks networks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.networks
    ADD CONSTRAINT networks_pkey PRIMARY KEY (id);


--
-- Name: passwordPolicies passwordPolicies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."passwordPolicies"
    ADD CONSTRAINT "passwordPolicies_pkey" PRIMARY KEY (id);


--
-- Name: protocolData protocolData_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."protocolData"
    ADD CONSTRAINT "protocolData_pkey" PRIMARY KEY (id);


--
-- Name: reportingProtocols reportingProtocols_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."reportingProtocols"
    ADD CONSTRAINT "reportingProtocols_pkey" PRIMARY KEY (id);


--
-- Name: userRoles userRoles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."userRoles"
    ADD CONSTRAINT "userRoles_pkey" PRIMARY KEY ("roleId");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: protocolData_dataIdentifier_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "protocolData_dataIdentifier_index" ON public."protocolData" USING btree ("dataIdentifier");


--
-- Name: sqlite_autoindex_applicationNetworkTypeLinks_1; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "sqlite_autoindex_applicationNetworkTypeLinks_1" ON public."applicationNetworkTypeLinks" USING btree ("applicationId", "networkTypeId");


--
-- Name: sqlite_autoindex_companies_1; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX sqlite_autoindex_companies_1 ON public.companies USING btree (name);


--
-- Name: sqlite_autoindex_companyNetworkTypeLinks_1; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "sqlite_autoindex_companyNetworkTypeLinks_1" ON public."companyNetworkTypeLinks" USING btree ("companyId", "networkTypeId");


--
-- Name: sqlite_autoindex_companyTypes_1; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "sqlite_autoindex_companyTypes_1" ON public."companyTypes" USING btree (name);


--
-- Name: sqlite_autoindex_deviceNetworkTypeLinks_1; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "sqlite_autoindex_deviceNetworkTypeLinks_1" ON public."deviceNetworkTypeLinks" USING btree ("deviceId", "networkTypeId");


--
-- Name: sqlite_autoindex_emailVerifications_1; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "sqlite_autoindex_emailVerifications_1" ON public."emailVerifications" USING btree (uuid);


--
-- Name: sqlite_autoindex_userRoles_1; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "sqlite_autoindex_userRoles_1" ON public."userRoles" USING btree (name);


--
-- Name: sqlite_autoindex_users_1; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX sqlite_autoindex_users_1 ON public.users USING btree (username);


--
-- Name: applicationNetworkTypeLinks applicationNetworkTypeLinks_applicationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."applicationNetworkTypeLinks"
    ADD CONSTRAINT "applicationNetworkTypeLinks_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES public.applications(id) ON DELETE CASCADE;


--
-- Name: applicationNetworkTypeLinks applicationNetworkTypeLinks_networkTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."applicationNetworkTypeLinks"
    ADD CONSTRAINT "applicationNetworkTypeLinks_networkTypeId_fkey" FOREIGN KEY ("networkTypeId") REFERENCES public."networkTypes"(id) ON DELETE CASCADE;


--
-- Name: applications applications_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT "applications_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: applications applications_reportingProtocolId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT "applications_reportingProtocolId_fkey" FOREIGN KEY ("reportingProtocolId") REFERENCES public."reportingProtocols"(id);


--
-- Name: companies companies_type_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.companies
    ADD CONSTRAINT companies_type_fkey FOREIGN KEY (type) REFERENCES public."companyTypes"(type);


--
-- Name: companyNetworkTypeLinks companyNetworkTypeLinks_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."companyNetworkTypeLinks"
    ADD CONSTRAINT "companyNetworkTypeLinks_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: companyNetworkTypeLinks companyNetworkTypeLinks_networkTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."companyNetworkTypeLinks"
    ADD CONSTRAINT "companyNetworkTypeLinks_networkTypeId_fkey" FOREIGN KEY ("networkTypeId") REFERENCES public."networkTypes"(id) ON DELETE CASCADE;


--
-- Name: deviceNetworkTypeLinks deviceNetworkTypeLinks_deviceId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."deviceNetworkTypeLinks"
    ADD CONSTRAINT "deviceNetworkTypeLinks_deviceId_fkey" FOREIGN KEY ("deviceId") REFERENCES public.devices(id) ON DELETE CASCADE;


--
-- Name: deviceNetworkTypeLinks deviceNetworkTypeLinks_deviceProfileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."deviceNetworkTypeLinks"
    ADD CONSTRAINT "deviceNetworkTypeLinks_deviceProfileId_fkey" FOREIGN KEY ("deviceProfileId") REFERENCES public."deviceProfiles"(id);


--
-- Name: deviceNetworkTypeLinks deviceNetworkTypeLinks_networkTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."deviceNetworkTypeLinks"
    ADD CONSTRAINT "deviceNetworkTypeLinks_networkTypeId_fkey" FOREIGN KEY ("networkTypeId") REFERENCES public."networkTypes"(id) ON DELETE CASCADE;


--
-- Name: deviceProfiles deviceProfiles_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."deviceProfiles"
    ADD CONSTRAINT "deviceProfiles_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: deviceProfiles deviceProfiles_networkTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."deviceProfiles"
    ADD CONSTRAINT "deviceProfiles_networkTypeId_fkey" FOREIGN KEY ("networkTypeId") REFERENCES public."networkTypes"(id) ON DELETE CASCADE;


--
-- Name: devices devices_applicationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.devices
    ADD CONSTRAINT "devices_applicationId_fkey" FOREIGN KEY ("applicationId") REFERENCES public.applications(id) ON DELETE CASCADE;


--
-- Name: emailVerifications emailVerifications_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."emailVerifications"
    ADD CONSTRAINT "emailVerifications_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: networkProtocols networkProtocols_masterProtocol_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

-- ALTER TABLE ONLY public."networkProtocols"
--     ADD CONSTRAINT "networkProtocols_masterProtocol_fkey" FOREIGN KEY ("masterProtocol") REFERENCES public."networkProtocols"(id) ON DELETE SET NULL;


--
-- Name: networkProtocols networkProtocols_networkTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."networkProtocols"
    ADD CONSTRAINT "networkProtocols_networkTypeId_fkey" FOREIGN KEY ("networkTypeId") REFERENCES public."networkTypes"(id);


--
-- Name: networks networks_networkProtocolId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.networks
    ADD CONSTRAINT "networks_networkProtocolId_fkey" FOREIGN KEY ("networkProtocolId") REFERENCES public."networkProtocols"(id);


--
-- Name: networks networks_networkProviderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.networks
    ADD CONSTRAINT "networks_networkProviderId_fkey" FOREIGN KEY ("networkProviderId") REFERENCES public."networkProviders"(id);


--
-- Name: networks networks_networkTypeId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.networks
    ADD CONSTRAINT "networks_networkTypeId_fkey" FOREIGN KEY ("networkTypeId") REFERENCES public."networkTypes"(id);


--
-- Name: passwordPolicies passwordPolicies_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."passwordPolicies"
    ADD CONSTRAINT "passwordPolicies_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: protocolData protocolData_networkId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."protocolData"
    ADD CONSTRAINT "protocolData_networkId_fkey" FOREIGN KEY ("networkId") REFERENCES public.networks(id) ON DELETE CASCADE;


--
-- Name: protocolData protocolData_networkProtocolId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."protocolData"
    ADD CONSTRAINT "protocolData_networkProtocolId_fkey" FOREIGN KEY ("networkProtocolId") REFERENCES public."networkProtocols"(id) ON DELETE CASCADE;


--
-- Name: users users_companyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT "users_companyId_fkey" FOREIGN KEY ("companyId") REFERENCES public.companies(id) ON DELETE CASCADE;


--
-- Name: users users_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_fkey FOREIGN KEY (role) REFERENCES public."userRoles"("roleId");


--
-- PostgreSQL database dump complete
--
