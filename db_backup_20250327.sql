--
-- PostgreSQL database dump
--

-- Dumped from database version 13.18 (Debian 13.18-1.pgdg120+1)
-- Dumped by pg_dump version 13.18 (Debian 13.18-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: account_emailaddress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_emailaddress (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    verified boolean NOT NULL,
    "primary" boolean NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.account_emailaddress OWNER TO postgres;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_emailaddress_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailaddress_id_seq OWNER TO postgres;

--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_emailaddress_id_seq OWNED BY public.account_emailaddress.id;


--
-- Name: account_emailconfirmation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account_emailconfirmation (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    sent timestamp with time zone,
    key character varying(64) NOT NULL,
    email_address_id integer NOT NULL
);


ALTER TABLE public.account_emailconfirmation OWNER TO postgres;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.account_emailconfirmation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.account_emailconfirmation_id_seq OWNER TO postgres;

--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.account_emailconfirmation_id_seq OWNED BY public.account_emailconfirmation.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO postgres;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_groups_id_seq OWNER TO postgres;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_groups_id_seq OWNED BY public.auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_id_seq OWNER TO postgres;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_id_seq OWNED BY public.auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_user_user_permissions_id_seq OWNED BY public.auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE public.django_site OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_site_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_site_id_seq OWNER TO postgres;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_site_id_seq OWNED BY public.django_site.id;


--
-- Name: socialaccount_socialaccount; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialaccount_socialaccount (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    uid character varying(191) NOT NULL,
    last_login timestamp with time zone NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    extra_data text NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialaccount OWNER TO postgres;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.socialaccount_socialaccount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialaccount_id_seq OWNER TO postgres;

--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.socialaccount_socialaccount_id_seq OWNED BY public.socialaccount_socialaccount.id;


--
-- Name: socialaccount_socialapp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialaccount_socialapp (
    id integer NOT NULL,
    provider character varying(30) NOT NULL,
    name character varying(40) NOT NULL,
    client_id character varying(191) NOT NULL,
    secret character varying(191) NOT NULL,
    key character varying(191) NOT NULL
);


ALTER TABLE public.socialaccount_socialapp OWNER TO postgres;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.socialaccount_socialapp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_id_seq OWNER TO postgres;

--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.socialaccount_socialapp_id_seq OWNED BY public.socialaccount_socialapp.id;


--
-- Name: socialaccount_socialapp_sites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialaccount_socialapp_sites (
    id bigint NOT NULL,
    socialapp_id integer NOT NULL,
    site_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialapp_sites OWNER TO postgres;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.socialaccount_socialapp_sites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialapp_sites_id_seq OWNER TO postgres;

--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.socialaccount_socialapp_sites_id_seq OWNED BY public.socialaccount_socialapp_sites.id;


--
-- Name: socialaccount_socialtoken; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.socialaccount_socialtoken (
    id integer NOT NULL,
    token text NOT NULL,
    token_secret text NOT NULL,
    expires_at timestamp with time zone,
    account_id integer NOT NULL,
    app_id integer NOT NULL
);


ALTER TABLE public.socialaccount_socialtoken OWNER TO postgres;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.socialaccount_socialtoken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.socialaccount_socialtoken_id_seq OWNER TO postgres;

--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.socialaccount_socialtoken_id_seq OWNED BY public.socialaccount_socialtoken.id;


--
-- Name: tracker_dailyprogress; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tracker_dailyprogress (
    id bigint NOT NULL,
    date date NOT NULL,
    duration_completed integer NOT NULL,
    effort_percentage integer NOT NULL,
    schedule_id uuid NOT NULL,
    CONSTRAINT tracker_dailyprogress_duration_completed_check CHECK ((duration_completed >= 0)),
    CONSTRAINT tracker_dailyprogress_effort_percentage_check CHECK ((effort_percentage >= 0))
);


ALTER TABLE public.tracker_dailyprogress OWNER TO postgres;

--
-- Name: tracker_dailyprogress_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tracker_dailyprogress_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tracker_dailyprogress_id_seq OWNER TO postgres;

--
-- Name: tracker_dailyprogress_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tracker_dailyprogress_id_seq OWNED BY public.tracker_dailyprogress.id;


--
-- Name: tracker_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tracker_schedule (
    title character varying(100) NOT NULL,
    description text,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    profile_id bigint NOT NULL,
    uuid uuid NOT NULL,
    streak integer NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    completed_at timestamp with time zone,
    duration integer NOT NULL,
    CONSTRAINT tracker_schedule_duration_check CHECK ((duration >= 0)),
    CONSTRAINT tracker_schedule_streak_check CHECK ((streak >= 0))
);


ALTER TABLE public.tracker_schedule OWNER TO postgres;

--
-- Name: tracker_threedmodel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tracker_threedmodel (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    file_path character varying(255) NOT NULL,
    description text NOT NULL,
    camera_position_z double precision NOT NULL
);


ALTER TABLE public.tracker_threedmodel OWNER TO postgres;

--
-- Name: tracker_threedmodel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tracker_threedmodel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tracker_threedmodel_id_seq OWNER TO postgres;

--
-- Name: tracker_threedmodel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tracker_threedmodel_id_seq OWNED BY public.tracker_threedmodel.id;


--
-- Name: tracker_threedmodel_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tracker_threedmodel_profiles (
    id bigint NOT NULL,
    threedmodel_id bigint NOT NULL,
    profile_id bigint NOT NULL
);


ALTER TABLE public.tracker_threedmodel_profiles OWNER TO postgres;

--
-- Name: tracker_threedmodel_profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tracker_threedmodel_profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tracker_threedmodel_profiles_id_seq OWNER TO postgres;

--
-- Name: tracker_threedmodel_profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tracker_threedmodel_profiles_id_seq OWNED BY public.tracker_threedmodel_profiles.id;


--
-- Name: users_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_comment (
    id bigint NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    post_id uuid NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.users_comment OWNER TO postgres;

--
-- Name: users_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_comment_id_seq OWNER TO postgres;

--
-- Name: users_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_comment_id_seq OWNED BY public.users_comment.id;


--
-- Name: users_like; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_like (
    id bigint NOT NULL,
    created_at timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    post_id uuid
);


ALTER TABLE public.users_like OWNER TO postgres;

--
-- Name: users_like_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_like_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_like_id_seq OWNER TO postgres;

--
-- Name: users_like_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_like_id_seq OWNED BY public.users_like.id;


--
-- Name: users_post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_post (
    content text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    profile_id integer NOT NULL,
    image character varying(100),
    uuid uuid NOT NULL
);


ALTER TABLE public.users_post OWNER TO postgres;

--
-- Name: users_profile; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_profile (
    id bigint NOT NULL,
    gender text,
    date_of_birth date,
    location character varying(100),
    user_id integer NOT NULL,
    body_fat double precision,
    height double precision,
    profile_picture character varying(100),
    weight double precision,
    phone_number character varying(15),
    chosen_model_id bigint,
    active_model_id bigint
);


ALTER TABLE public.users_profile OWNER TO postgres;

--
-- Name: users_profile_available_models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_profile_available_models (
    id bigint NOT NULL,
    profile_id bigint NOT NULL,
    threedmodel_id bigint NOT NULL
);


ALTER TABLE public.users_profile_available_models OWNER TO postgres;

--
-- Name: users_profile_available_models_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_profile_available_models_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_profile_available_models_id_seq OWNER TO postgres;

--
-- Name: users_profile_available_models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_profile_available_models_id_seq OWNED BY public.users_profile_available_models.id;


--
-- Name: users_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_profile_id_seq OWNER TO postgres;

--
-- Name: users_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_profile_id_seq OWNED BY public.users_profile.id;


--
-- Name: account_emailaddress id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailaddress ALTER COLUMN id SET DEFAULT nextval('public.account_emailaddress_id_seq'::regclass);


--
-- Name: account_emailconfirmation id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailconfirmation ALTER COLUMN id SET DEFAULT nextval('public.account_emailconfirmation_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user ALTER COLUMN id SET DEFAULT nextval('public.auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups ALTER COLUMN id SET DEFAULT nextval('public.auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site ALTER COLUMN id SET DEFAULT nextval('public.django_site_id_seq'::regclass);


--
-- Name: socialaccount_socialaccount id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialaccount ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialaccount_id_seq'::regclass);


--
-- Name: socialaccount_socialapp id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialapp_id_seq'::regclass);


--
-- Name: socialaccount_socialapp_sites id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialapp_sites_id_seq'::regclass);


--
-- Name: socialaccount_socialtoken id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken ALTER COLUMN id SET DEFAULT nextval('public.socialaccount_socialtoken_id_seq'::regclass);


--
-- Name: tracker_dailyprogress id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_dailyprogress ALTER COLUMN id SET DEFAULT nextval('public.tracker_dailyprogress_id_seq'::regclass);


--
-- Name: tracker_threedmodel id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_threedmodel ALTER COLUMN id SET DEFAULT nextval('public.tracker_threedmodel_id_seq'::regclass);


--
-- Name: tracker_threedmodel_profiles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_threedmodel_profiles ALTER COLUMN id SET DEFAULT nextval('public.tracker_threedmodel_profiles_id_seq'::regclass);


--
-- Name: users_comment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_comment ALTER COLUMN id SET DEFAULT nextval('public.users_comment_id_seq'::regclass);


--
-- Name: users_like id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_like ALTER COLUMN id SET DEFAULT nextval('public.users_like_id_seq'::regclass);


--
-- Name: users_profile id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile ALTER COLUMN id SET DEFAULT nextval('public.users_profile_id_seq'::regclass);


--
-- Name: users_profile_available_models id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile_available_models ALTER COLUMN id SET DEFAULT nextval('public.users_profile_available_models_id_seq'::regclass);


--
-- Data for Name: account_emailaddress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_emailaddress (id, email, verified, "primary", user_id) FROM stdin;
2	bekarys.j2003@gmail.com	t	t	5
\.


--
-- Data for Name: account_emailconfirmation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account_emailconfirmation (id, created, sent, key, email_address_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add profile	7	add_profile
26	Can change profile	7	change_profile
27	Can delete profile	7	delete_profile
28	Can view profile	7	view_profile
29	Can add schedule	8	add_schedule
30	Can change schedule	8	change_schedule
31	Can delete schedule	8	delete_schedule
32	Can view schedule	8	view_schedule
33	Can add post	9	add_post
34	Can change post	9	change_post
35	Can delete post	9	delete_post
36	Can view post	9	view_post
37	Can add like	10	add_like
38	Can change like	10	change_like
39	Can delete like	10	delete_like
40	Can view like	10	view_like
41	Can add comment	11	add_comment
42	Can change comment	11	change_comment
43	Can delete comment	11	delete_comment
44	Can view comment	11	view_comment
45	Can add site	12	add_site
46	Can change site	12	change_site
47	Can delete site	12	delete_site
48	Can view site	12	view_site
49	Can add email address	13	add_emailaddress
50	Can change email address	13	change_emailaddress
51	Can delete email address	13	delete_emailaddress
52	Can view email address	13	view_emailaddress
53	Can add email confirmation	14	add_emailconfirmation
54	Can change email confirmation	14	change_emailconfirmation
55	Can delete email confirmation	14	delete_emailconfirmation
56	Can view email confirmation	14	view_emailconfirmation
57	Can add social account	15	add_socialaccount
58	Can change social account	15	change_socialaccount
59	Can delete social account	15	delete_socialaccount
60	Can view social account	15	view_socialaccount
61	Can add social application	16	add_socialapp
62	Can change social application	16	change_socialapp
63	Can delete social application	16	delete_socialapp
64	Can view social application	16	view_socialapp
65	Can add social application token	17	add_socialtoken
66	Can change social application token	17	change_socialtoken
67	Can delete social application token	17	delete_socialtoken
68	Can view social application token	17	view_socialtoken
69	Can add schedule	18	add_schedule
70	Can change schedule	18	change_schedule
71	Can delete schedule	18	delete_schedule
72	Can view schedule	18	view_schedule
73	Can add daily progress	19	add_dailyprogress
74	Can change daily progress	19	change_dailyprogress
75	Can delete daily progress	19	delete_dailyprogress
76	Can view daily progress	19	view_dailyprogress
77	Can add shape	20	add_shape
78	Can change shape	20	change_shape
79	Can delete shape	20	delete_shape
80	Can view shape	20	view_shape
81	Can add three d model	21	add_threedmodel
82	Can change three d model	21	change_threedmodel
83	Can delete three d model	21	delete_threedmodel
84	Can view three d model	21	view_threedmodel
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
5	!blM7k6Cig4VFV11gWCI8M8UF4kjmG9YphBsIF53D	2025-03-22 04:53:58.299897+00	f	beki	beka		bekarys.j2003@gmail.com	f	t	2025-03-12 02:24:02.173+00
1	pbkdf2_sha256$320000$Rm0N4524uT3kHZWqoxd3us$9JVpmVpo6ymym+UgK/itnMzh3IbZa6uysWUtmkaXIpE=	2025-03-27 00:12:09.068823+00	t	beka			bek.arys@inbox.ru	t	t	2025-03-12 01:33:33.390287+00
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2025-03-12 02:07:31.020199+00	3	http://127.0.0.1:8000	1	[{"added": {}}]	12	1
2	2025-03-12 02:08:43.647854+00	1	Google	1	[{"added": {}}]	16	1
3	2025-03-12 02:11:39.139664+00	1	Google	2	[]	16	1
4	2025-03-12 02:15:18.271222+00	1	Google	2	[]	16	1
5	2025-03-12 02:15:26.105955+00	3	http://127.0.0.1:8000	2	[]	12	1
6	2025-03-12 02:15:36.255914+00	2	example.com	3		12	1
7	2025-03-12 02:18:45.82795+00	3	http://127.0.0.1:8000	2	[{"changed": {"fields": ["Display name"]}}]	12	1
8	2025-03-12 02:22:19.995574+00	2	beki	3		4	1
9	2025-03-12 02:23:08.694173+00	3	beki	3		4	1
10	2025-03-12 02:23:48.85645+00	4	beki	3		4	1
11	2025-03-16 17:30:04.191935+00	7	wooow (17:28:03 - 17:28:03)	1	[{"added": {}}]	18	1
12	2025-03-17 04:20:23.814831+00	1	beka	2	[{"changed": {"fields": ["Phone number"]}}]	7	1
13	2025-03-17 04:35:55.913686+00	11	qwd (04:36:50 - 04:37:53)	1	[{"added": {}}]	18	1
14	2025-03-17 21:37:02.42541+00	11	qwd (04:36:50 - 04:37:53)	3		18	1
15	2025-03-17 21:37:02.434296+00	7	wooow (17:28:03 - 17:28:03)	3		18	1
16	2025-03-17 21:42:20.169319+00	13	work (21:43:08 - 21:44:12)	1	[{"added": {}}]	18	1
17	2025-03-18 16:05:39.190051+00	13	work (21:43:08 - 21:44:12)	3		18	1
18	2025-03-18 16:05:39.19712+00	12	qwd (14:41:00 - 14:44:00)	3		18	1
19	2025-03-18 18:49:35.370407+00	bc861064-f317-4bb6-9669-551aaf06783a	Post by beki	2	[]	9	1
20	2025-03-18 18:49:39.557424+00	1a25ec83-be03-46f6-a5ac-b41a5fe27b10	Post by beki	2	[]	9	1
21	2025-03-18 19:21:13.138654+00	e24b8a5f-8840-409e-bf96-528c66e413af	qwd (02:31:00 - 02:13:00)	3		18	1
22	2025-03-18 19:21:13.144098+00	9de90545-3be7-4798-80a5-2c8ebadf39cd	qwd (00:12:00 - 00:12:00)	3		18	1
23	2025-03-18 19:21:35.219991+00	84be7117-e867-40e6-918e-e8cca1289b53	work (12:30:00 - 12:45:00)	1	[{"added": {}}]	18	1
24	2025-03-18 19:21:48.502299+00	84be7117-e867-40e6-918e-e8cca1289b53	work (12:30:00 - 12:45:00)	2	[{"changed": {"fields": ["Streak"]}}]	18	1
25	2025-03-18 19:21:54.902466+00	84be7117-e867-40e6-918e-e8cca1289b53	work (12:30:00 - 12:45:00)	2	[{"changed": {"fields": ["Streak"]}}]	18	1
26	2025-03-18 19:29:13.475896+00	9eb9d3a0-5b8b-47cb-8858-813041a7083d	qwe (17:29:06 - 17:29:09)	1	[{"added": {}}]	18	1
27	2025-03-18 23:27:10.951916+00	ac59588a-75ea-491c-994e-3b6dc7b5e945	123 (00:23:00 - 00:32:00)	2	[]	18	1
28	2025-03-18 23:27:14.499003+00	54b401ef-7bfb-430e-a909-bf10ff82d240	qwe (12:12:00 - 12:12:00)	2	[]	18	1
29	2025-03-19 01:35:00.46252+00	ac59588a-75ea-491c-994e-3b6dc7b5e945	123 (00:23:00 - 00:32:00)	2	[]	18	1
30	2025-03-19 01:35:04.657528+00	54b401ef-7bfb-430e-a909-bf10ff82d240	qwe (12:12:00 - 12:12:00)	2	[]	18	1
31	2025-03-19 01:35:08.213528+00	1f810b2f-c1d6-4e9d-8e51-f299a3399727	q2e (12:12:00 - 12:12:00)	2	[]	18	1
32	2025-03-19 01:35:11.650682+00	1f19f0e4-3d96-4864-929c-75bdd89f7dd4	asd (12:12:00 - 12:12:00)	2	[]	18	1
33	2025-03-19 01:41:25.807059+00	ac59588a-75ea-491c-994e-3b6dc7b5e945	123 (00:23:00 - 00:32:00)	2	[]	18	1
34	2025-03-19 01:42:17.053513+00	ac59588a-75ea-491c-994e-3b6dc7b5e945	123 (00:23:00 - 00:32:00)	2	[{"changed": {"fields": ["Duration completed", "Effort percentage"]}}]	18	1
35	2025-03-19 02:57:40.646071+00	1	qwe - 2025-03-19	2	[]	19	1
36	2025-03-19 03:25:23.056079+00	3	qwe - 2025-03-20	1	[{"added": {}}]	19	1
37	2025-03-19 03:25:37.408366+00	4	qwe - 2025-03-21	1	[{"added": {}}]	19	1
38	2025-03-19 03:26:21.171395+00	5	qwe - 2025-03-22	1	[{"added": {}}]	19	1
39	2025-03-19 03:26:42.934166+00	6	qwe - 2025-03-24	1	[{"added": {}}]	19	1
40	2025-03-19 20:36:04.106636+00	fa9fb4ff-095c-4ada-9eaf-310daf0e61b6	work (13:36:55 - 13:37:58)	1	[{"added": {}}]	18	1
41	2025-03-19 23:09:31.546892+00	1	1	1	[{"added": {}}]	20	1
42	2025-03-19 23:09:40.942563+00	2	2	1	[{"added": {}}]	20	1
43	2025-03-19 23:09:46.462871+00	3	3	1	[{"added": {}}]	20	1
44	2025-03-20 02:03:33.126639+00	3	3	2	[{"changed": {"fields": ["Color"]}}]	20	1
45	2025-03-20 02:03:40.199875+00	2	2	2	[{"changed": {"fields": ["Color"]}}]	20	1
46	2025-03-20 02:03:43.044921+00	1	1	2	[]	20	1
95	2025-03-25 19:17:31.476982+00	3	beki	2	[{"changed": {"fields": ["Phone number", "Active model"]}}]	7	1
96	2025-03-25 19:17:54.714394+00	1	beka	2	[{"changed": {"fields": ["Active model"]}}]	7	1
103	2025-03-26 20:05:51.130694+00	1	beka	2	[{"changed": {"fields": ["Chosen model"]}}]	7	1
104	2025-03-27 00:13:05.383231+00	6	/static/models/grab_johannes_zach.glb	2	[{"changed": {"fields": ["Profiles"]}}]	21	1
105	2025-03-27 00:13:56.563951+00	5	2_person_statue_scan_medpoly.glb	2	[]	21	1
106	2025-03-27 00:14:04.346211+00	6	/static/models/grab_johannes_zach.glb	2	[{"changed": {"fields": ["Profiles"]}}]	21	1
107	2025-03-27 00:14:21.477247+00	6	/static/models/grab_johannes_zach.glb	2	[{"changed": {"fields": ["Profiles"]}}]	21	1
108	2025-03-27 00:22:36.356476+00	6	/static/models/grab_johannes_zach.glb	2	[{"changed": {"fields": ["Profiles"]}}]	21	1
109	2025-03-27 00:22:41.194366+00	5	2_person_statue_scan_medpoly.glb	2	[{"changed": {"fields": ["Profiles"]}}]	21	1
110	2025-03-27 01:14:51.234828+00	3	beki	2	[{"changed": {"fields": ["Active model", "Available models"]}}]	7	1
111	2025-03-27 01:15:01.212208+00	1	beka	2	[{"changed": {"fields": ["Active model", "Available models"]}}]	7	1
112	2025-03-27 01:15:07.013937+00	1	beka	2	[]	7	1
113	2025-03-27 01:15:10.714338+00	3	beki	2	[]	7	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	users	profile
8	users	schedule
9	users	post
10	users	like
11	users	comment
12	sites	site
13	account	emailaddress
14	account	emailconfirmation
15	socialaccount	socialaccount
16	socialaccount	socialapp
17	socialaccount	socialtoken
18	tracker	schedule
19	tracker	dailyprogress
20	tracker	shape
21	tracker	threedmodel
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2025-03-12 01:32:54.059405+00
2	auth	0001_initial	2025-03-12 01:32:54.111053+00
3	account	0001_initial	2025-03-12 01:32:54.126814+00
4	account	0002_email_max_length	2025-03-12 01:32:54.130784+00
5	admin	0001_initial	2025-03-12 01:32:54.140528+00
6	admin	0002_logentry_remove_auto_add	2025-03-12 01:32:54.144834+00
7	admin	0003_logentry_add_action_flag_choices	2025-03-12 01:32:54.148445+00
8	contenttypes	0002_remove_content_type_name	2025-03-12 01:32:54.156211+00
9	auth	0002_alter_permission_name_max_length	2025-03-12 01:32:54.15991+00
10	auth	0003_alter_user_email_max_length	2025-03-12 01:32:54.163644+00
11	auth	0004_alter_user_username_opts	2025-03-12 01:32:54.167902+00
12	auth	0005_alter_user_last_login_null	2025-03-12 01:32:54.171515+00
13	auth	0006_require_contenttypes_0002	2025-03-12 01:32:54.172481+00
14	auth	0007_alter_validators_add_error_messages	2025-03-12 01:32:54.176065+00
15	auth	0008_alter_user_username_max_length	2025-03-12 01:32:54.181174+00
16	auth	0009_alter_user_last_name_max_length	2025-03-12 01:32:54.184768+00
17	auth	0010_alter_group_name_max_length	2025-03-12 01:32:54.189944+00
18	auth	0011_update_proxy_permissions	2025-03-12 01:32:54.194585+00
19	auth	0012_alter_user_first_name_max_length	2025-03-12 01:32:54.198935+00
20	sessions	0001_initial	2025-03-12 01:32:54.204441+00
21	sites	0001_initial	2025-03-12 01:32:54.207359+00
22	sites	0002_alter_domain_unique	2025-03-12 01:32:54.211457+00
23	socialaccount	0001_initial	2025-03-12 01:32:54.242578+00
24	socialaccount	0002_token_max_lengths	2025-03-12 01:32:54.252507+00
25	socialaccount	0003_extra_data_default_dict	2025-03-12 01:32:54.256275+00
26	users	0001_initial	2025-03-12 02:06:12.81721+00
27	users	0002_profile_delete_customuser	2025-03-12 02:06:12.830278+00
28	users	0003_rename_bio_profile_gender_profile_body_fat_and_more	2025-03-12 02:06:12.845876+00
29	users	0004_schedule	2025-03-12 02:06:12.858616+00
30	users	0005_post_like	2025-03-12 02:06:12.879386+00
31	users	0006_like_image	2025-03-12 02:06:12.884302+00
32	users	0007_remove_like_image_post_image	2025-03-12 02:06:12.893163+00
33	users	0008_post_likes_alter_like_post	2025-03-12 02:06:12.909053+00
34	users	0009_remove_post_likes	2025-03-12 02:06:12.91574+00
35	users	0010_remove_post_id_post_uuid_comment	2025-03-12 02:06:12.935058+00
36	users	0002_delete_schedule	2025-03-12 23:16:05.409433+00
37	tracker	0001_initial	2025-03-12 23:16:05.426913+00
38	users	0003_profile_phone_number	2025-03-17 04:20:06.847639+00
39	tracker	0002_remove_schedule_id_schedule_uuid	2025-03-18 17:31:22.932559+00
40	tracker	0003_schedule_streak	2025-03-18 19:03:50.86635+00
41	tracker	0004_schedule_updated_at	2025-03-18 19:20:16.801076+00
42	tracker	0005_schedule_completed_at	2025-03-18 19:56:12.684971+00
43	tracker	0006_schedule_duration_schedule_duration_completed_and_more	2025-03-18 23:19:33.821926+00
44	tracker	0007_remove_schedule_duration_completed_and_more	2025-03-19 02:05:39.860738+00
45	tracker	0008_shape	2025-03-19 23:06:35.259115+00
46	tracker	0009_threedmodel_delete_shape	2025-03-21 02:38:39.706055+00
47	tracker	0010_threedmodel_profile	2025-03-22 04:12:15.187982+00
48	tracker	0011_alter_threedmodel_profile	2025-03-22 04:12:15.209219+00
49	tracker	0012_threedmodel_camera_position_z	2025-03-22 04:31:43.483496+00
50	tracker	0013_remove_threedmodel_profile_threedmodel_profiles	2025-03-25 19:00:52.396706+00
51	users	0004_profile_active_model	2025-03-25 19:16:09.071137+00
52	users	0005_remove_profile_active_model	2025-03-25 21:02:54.197109+00
53	tracker	0013_profile_relationship_fix	2025-03-26 20:03:30.385483+00
54	users	0004_add_chosen_model	2025-03-26 20:03:41.5461+00
55	users	0004_profile_active_model_profile_available_models	2025-03-27 01:06:14.695034+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
w8c2x97pyche9um95e3uxux8m7rpspos	e30:1tsAyt:Hwi1L5pWJiKjH2C7i2ZDtY0dAwuqXsatTV9TzZYHTQo	2025-03-26 01:33:59.266664+00
815h5zbvvz43yawd1k75pko8ncakaxz2	e30:1tsAzE:HaSvVhB2zqd6AY_bAeqvHFftWMQgy3F_sbKlvfUaLt8	2025-03-26 01:34:20.080799+00
7zddmkmjqd9ign91cph0wjgxb1t6zrwi	e30:1tsB38:WNCebO6jWAWIB83c_j-9OIt9vSjji2NTZF8xBkkH824	2025-03-26 01:38:22.196522+00
7ykna6d2bkjjqjkenyhlsd92muu4fmpx	e30:1tsBDb:RY9E2iAjn4m6uMGCwZZ7PD2tLVcvLFEv-o6e9vs6J9A	2025-03-26 01:49:11.431608+00
ej3gl8dh7ee4ds9u2m830y0df6ydfuwd	e30:1tsBGn:jhI8IZ2K3xF61-dtaW8LDGKPKmksVM1coxbpB9p4RQA	2025-03-26 01:52:29.849365+00
pl8k095cnekzt1co2bn2kv7cu6g6kavb	e30:1tsBHX:oh7j2rz9crQj3E6-DXGsp5zjcukl6gVA6OVEcmsZEHA	2025-03-26 01:53:15.462349+00
kvg1mlfidttg2wq048u2ribq8mwcz4ct	e30:1tsBTD:tW1-t7ibEEigvdi_7g4Eaw25cEB0vcE1UDW_HL2Jhzo	2025-03-26 02:05:19.396834+00
ix3xthbetbq0o8hux0d0fl32dhjtsajn	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1tv65U:vq5Fj_0DfIFMK59hAvRfIELVQEpxXMcG2wKIKqJmaOY	2025-04-03 02:56:52.097015+00
6xfrmqup5vl0sks5le9foyij8muvq9i7	.eJxVjU0OwiAQhe_C2pAOlALu7EWaYRgDsaGJwMp4d1vThS7f3_deYsHe0tIrP5ccxVUYcfn1AtKDyxHguh62RKKtlya_nTOu8rYrLi0TtryV-Vz9oRLWtHOioSkoM6AbOVoCdBNbPZICg4q1gsmh187BaCEoBr1_BLAw2Lv3HIJ4fwCxDjwK:1tv7Fk:qiemo2cy_gaOKXfqoPwDz6sN_L7vjkXB2UjaZOKl11I	2025-04-03 04:11:32.664226+00
mgkp36o8sslnxmy2dgwb4l1xjlrna5gk	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1tv7SZ:Gi_kfMiBMjsk7_lZIrGo1HP-UY5t34-U_LaCcxa_8Tw	2025-04-03 04:24:47.349533+00
326bgxlkluziod51mgro0exagfo134ql	.eJxVjU0OwiAQhe_C2pAOlALu7EWaYRgDsaGJwMp4d1vThS7f3_deYsHe0tIrP5ccxVUYcfn1AtKDyxHguh62RKKtlya_nTOu8rYrLi0TtryV-Vz9oRLWtHOioSkoM6AbOVoCdBNbPZICg4q1gsmh187BaCEoBr1_BLAw2Lv3HIJ4fwCxDjwK:1tv7XM:IKPYvK9S0oUhZJFPT-OMCmYzWQ4kz6QvIFseqNnN31I	2025-04-03 04:29:44.157172+00
wip0l2m6s40gpy4jgnvwu42gezbi9i0x	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1tv852:i_h80u8qQ5Lft0y177HAaNIROig_QgUm5DIH-MCpTvo	2025-04-03 05:04:32.401312+00
o015aku8o8ih9c48m4m5ddyn0msmdulv	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1tv8GF:GH7l9qHjgLn2GUoI4G6BGL6imwIoG9v14cPtq2iWmhc	2025-04-03 05:16:07.733335+00
t7hoxpaffiw3ml41up7ddemzzgq1p2wt	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1tvNLt:8DP4oBe1SC3pxYiyr86WIEdhrQSP-wVGdRiCwQYTIxk	2025-04-03 21:22:57.010998+00
8fkxk0bd60nonhbc4n8svg3no916idp4	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1tvRkS:DvuuRDt8SDghv2dhXmLSu1SeQz8rubfZyMsmYi01J9E	2025-04-04 02:04:36.998766+00
qjqlpq9ju36temujove9chnonryveje5	.eJxVjU0OwiAQhe_C2pAOlALu7EWaYRgDsaGJwMp4d1vThS7f3_deYsHe0tIrP5ccxVUYcfn1AtKDyxHguh62RKKtlya_nTOu8rYrLi0TtryV-Vz9oRLWtHOioSkoM6AbOVoCdBNbPZICg4q1gsmh187BaCEoBr1_BLAw2Lv3HIJ4fwCxDjwK:1tsCDI:TSC4rKqGSA-znuEKlEir72AooEXCojZB7sRRg2ARESk	2025-03-26 02:52:56.837484+00
fbpj60beqy094vvizabhwrdhwpml2gv0	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1tvRkr:0mmD2szrWirmxLXIzyAANVLGGL0kEEzN4kHHu6puOns	2025-04-04 02:05:01.553227+00
gkx477zlmtmwodr136umzdhh9dmyyb9e	.eJxVjU0OwiAQhe_C2pAOlALu7EWaYRgDsaGJwMp4d1vThS7f3_deYsHe0tIrP5ccxVUYcfn1AtKDyxHguh62RKKtlya_nTOu8rYrLi0TtryV-Vz9oRLWtHOioSkoM6AbOVoCdBNbPZICg4q1gsmh187BaCEoBr1_BLAw2Lv3HIJ4fwCxDjwK:1tsSgJ:5Zd1vXeEERQNtZuEknrcWT2zJnaqElREO2mL5mowods	2025-03-26 20:27:59.043414+00
iuv1w9od2d3uo77fyc32942mx03nuedk	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1tvTKO:12e3rO4QFysMOl_aRtFyR78iZoFZ3EgrCPQ2X9xm4Yc	2025-04-04 03:45:48.0624+00
k6spm1na6ijxm4hbf9ttgs1k9oo7xaiw	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1tvTQq:4XMRketFgh6xBscG-u5AXKdNlLg6fIaQMzSIeBEHP1Q	2025-04-04 03:52:28.919214+00
i5f4d5m2t0e8amtb7l13rbtglmhmayh9	.eJxVjU0OwiAQhe_C2pAOlALu7EWaYRgDsaGJwMp4d1vThS7f3_deYsHe0tIrP5ccxVUYcfn1AtKDyxHguh62RKKtlya_nTOu8rYrLi0TtryV-Vz9oRLWtHOioSkoM6AbOVoCdBNbPZICg4q1gsmh187BaCEoBr1_BLAw2Lv3HIJ4fwCxDjwK:1tsUUv:RLYvmkX-Vu3JDhCEGWzFB9fXZzyBPn6PpNgCFvy9CCI	2025-03-26 22:24:21.284647+00
qk130r87h456c1gxyds0ilutwdpb4tkg	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1tvU6v:hxWL3CbDEeDdwQO2hGyLu0nMUXXWvc1LjTQbGbRvwLg	2025-04-04 04:35:57.635741+00
pwce3zkzj3z9hgmw5ct23mg3jbo1kn79	.eJxVjU0OwiAQhe_C2pAOlALu7EWaYRgDsaGJwMp4d1vThS7f3_deYsHe0tIrP5ccxVUYcfn1AtKDyxHguh62RKKtlya_nTOu8rYrLi0TtryV-Vz9oRLWtHOioSkoM6AbOVoCdBNbPZICg4q1gsmh187BaCEoBr1_BLAw2Lv3HIJ4fwCxDjwK:1tsUVY:pBXzkYWXNmDZh41YNPJXqgdGoEYHSflyIZwcNf9r2qw	2025-03-26 22:25:00.050892+00
hb6yawan3qc4dqvlu5u43yxrqrnar3u1	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1tvUIH:HaqSDdPGN6pPuwo-SwodC0_40aOz4K8wCc1vWRM5irE	2025-04-04 04:47:41.334862+00
soa5ovpdtk4lrodwo5dmqqhmhj8vyiql	.eJxVjU0OwiAQhe_C2pAOlALu7EWaYRgDsaGJwMp4d1vThS7f3_deYsHe0tIrP5ccxVUYcfn1AtKDyxHguh62RKKtlya_nTOu8rYrLi0TtryV-Vz9oRLWtHOioSkoM6AbOVoCdBNbPZICg4q1gsmh187BaCEoBr1_BLAw2Lv3HIJ4fwCxDjwK:1tu1m6:vAKyyg9bF5D1JB8g-S3CXJ3z118OLg9CZ_CIsdaI-dk	2025-03-31 04:08:26.647438+00
5wksv8o62gh1qz37uz94l5crm13t9n46	.eJxVjsFqwzAQRP9lz8a1tZYc59YWcmhvPRVKMauVEouqkrFkKIT8e-XgS247M2-HuUKK7MgTc1xDHlOmbOH4dYVg_zIc4QkqmJfINqWifLy4UJzEcS4YlJPWPI0zLfS7AXCr4HTy-lO_vvvu4w2-KxjvyJrsMjpTmBYePE38Y8MWkPebXe9j6juzx6l-LsqG7Jiyi-Fl_3qomihNpUc0neno3GikQ6usNdT3Z5Si1WgagxIHEoxD06ExB0WShGRUKORghFLUw-0fuepboQ:1tubhV:uENSLY2umt2hEkIamS1HU_TqxFzx4_hSPFTDUfSPCoQ	2025-04-01 18:30:05.368252+00
72kr7f7qibsznbsetwp0onopmluw59oc	.eJxVjsFugzAQRP9lz4iCF5uQW9uc0kOPOUQVWtZOcUtsCxupUpR_r4m45LYz83Y0N4ieLU3E7BeX-pgoGdifb-DMX4I9vEABYfZsYsxq8t_WZSeyDxmDfNKSxj7QTNcVgHsB7x_d8fBzCuH4ifBVQP9Almjm3urM1PDkDcS_xq0BTdNql9uY8sFscSxfszIuWaZkvXvbvp6qRopj7hFVoxu6VAPSrlbGaGrbC0pRD6grjRI7Eoxd1aDWO0WShGRUKGSnhVLUwv0fpCFbhQ:1tukGG:XxmlHTnWb80F-6CkHypqJc3YKXxo_r2sWa4UNb4uV6c	2025-04-02 03:38:32.979989+00
rwniy01cvfhyva82rheobdkqx57b3qou	.eJxVjsFugzAQRP9lz4iCF5uQW6tG6rWHnqoKLWsT3BAb2UaqFOXfayIuue3MvB3NDaJnSzMx-9WlPiZKBo7fN3DmL8ERXqCAJXg2MWY1-7N12Ynsl4xBPmlNU79QoOsGwL2Ad_Vx-g1f4eLHT_gpoH8gazShtzozNTx5A_HFuC2ged7sch9TPpg9juVrVsYly5Ssd2_711PVRHHKPaJqdENjNSAdamWMprYdUYp6QF1plNiRYOyqBrU-KJIkJKNCITstlKIW7v_8O1v-:1tv0aQ:IAzBh4jGl35OhYuIiFp7uzO1DvDKWun19PfgmwpntN8	2025-04-02 21:04:26.474935+00
lub2wx63q8sg20qkuoa3mppu02w2cyuw	.eJxVjU0OwiAQhe_C2pAOlALu7EWaYRgDsaGJwMp4d1vThS7f3_deYsHe0tIrP5ccxVUYcfn1AtKDyxHguh62RKKtlya_nTOu8rYrLi0TtryV-Vz9oRLWtHOioSkoM6AbOVoCdBNbPZICg4q1gsmh187BaCEoBr1_BLAw2Lv3HIJ4fwCxDjwK:1tvqrd:ouq2QJl7a9wNHgZPpQnwrHSuOy50NcriS0eezu08KJY	2025-04-05 04:53:41.459143+00
n7bihtnjc7lbw5trpsa1xi09yjvgoepd	.eJxVjU0OwiAQhe_C2pAOlALu7EWaYRgDsaGJwMp4d1vThS7f3_deYsHe0tIrP5ccxVUYcfn1AtKDyxHguh62RKKtlya_nTOu8rYrLi0TtryV-Vz9oRLWtHOioSkoM6AbOVoCdBNbPZICg4q1gsmh187BaCEoBr1_BLAw2Lv3HIJ4fwCxDjwK:1tvqru:n95oaHjOO4l-x2-VuISwdSiFLdmZmmTn7b-aJcPcBt4	2025-04-05 04:53:58.317416+00
s7lhxys76bxx4902umlw91fxmrbdt840	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1tvrRm:_Qj7Ulg07pGl3209YsqjjYsUq05L9BBUBY5oVpPDVKA	2025-04-05 05:31:02.857474+00
g1shwgg1yw1uxwwxj44ggnd38niqfhvf	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1twD67:qcdEZgGmqSdWkGIed3G7eNJXev0sirmw2VJ3ZJGK40c	2025-04-06 04:38:07.795396+00
o2ewh5gpdndhlbyzq4drx4e470f0085g	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1twDDy:xnEsuRYYqQIDF01_slqXRruYqT-CMHn8I0SplvnaHno	2025-04-06 04:46:14.966374+00
vfkb6azh3wrti6lhcz8w0ly1ky9jw78g	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1txAUz:yWolTQbsv6Jbek9AtJd5qLztOJwin9GhOep_VEa6tiw	2025-04-08 20:03:45.660971+00
8ctjuq9j9zxu4oj6lu4lgdm2qommlrqm	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1txAm8:-Nl0nqDPCHFTEicfyjueCQ6B6VXY-6v1XYC-wJw0J3k	2025-04-08 20:21:28.005313+00
1xrhnnc69b7kpaovb1lxaixamw1x7csn	.eJxVjMsOwiAURP-FtWmAy6N1pz9CBi5NGxuaWFgZ_93WdKHLOTNzXiKg1Sm0LT_DzOIqlLj8soj0yOUosCwH7pDS2krtvpuz3rrbnnKpc0Kd13I_X3-qCdu0e7Q0bDDKSOiVy5nh_UhWq0gsmSwN0IkGaYi5d7DQNpEjbQfWzsGL9we2PDvQ:1txaqv:glA_aXWpyPcwDgBYi8efb-vrxcDLddwA_mdoj8s-40c	2025-04-10 00:12:09.086401+00
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_site (id, domain, name) FROM stdin;
3	http://127.0.0.1:8000	http://127.0.0.1:8000
\.


--
-- Data for Name: socialaccount_socialaccount; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socialaccount_socialaccount (id, provider, uid, last_login, date_joined, extra_data, user_id) FROM stdin;
2	google	110214830202279201739	2025-03-22 04:53:58.289346+00	2025-03-12 02:24:03.994399+00	{"id": "110214830202279201739", "email": "bekarys.j2003@gmail.com", "verified_email": true, "name": "beka", "given_name": "beka", "picture": "https://lh3.googleusercontent.com/a/ACg8ocLpOqgapQOTz5FBoJBQZQJ8y7sr7CTYRZVM4MFfAXnqvgmHlw=s96-c"}	5
\.


--
-- Data for Name: socialaccount_socialapp; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socialaccount_socialapp (id, provider, name, client_id, secret, key) FROM stdin;
1	google	Google	9816983038-8o5d2pkadhjpqejl7pon0krfpfmbpbrr.apps.googleusercontent.com	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	
\.


--
-- Data for Name: socialaccount_socialapp_sites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socialaccount_socialapp_sites (id, socialapp_id, site_id) FROM stdin;
1	1	3
\.


--
-- Data for Name: socialaccount_socialtoken; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.socialaccount_socialtoken (id, token, token_secret, expires_at, account_id, app_id) FROM stdin;
2	ya29.a0AeXRPp62FD2mu9GusjR7qIzZOQfJG-NZDrGEbgZqEW4QHmgSnlchlSZf9Y24gvZ7LXR0zglTgsy-JKLsNGQBrSYyTMD5NtQbKYi9udR4LWeUoBkJsk4gMOQpUPgxlPiEsC_zxFw8HmD2uK9IAjWznEkay3RFnnJYbQ8vW-KHv9YaCgYKAQESARESFQHGX2Midi_ivPb2y8x5pkaySWLKpA0178		2025-03-22 05:53:56.20849+00	2	1
\.


--
-- Data for Name: tracker_dailyprogress; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tracker_dailyprogress (id, date, duration_completed, effort_percentage, schedule_id) FROM stdin;
3	2025-03-20	70	90	92996701-fbdd-45c1-a18d-fefd378604a5
5	2025-03-22	40	70	92996701-fbdd-45c1-a18d-fefd378604a5
6	2025-03-24	25	77	92996701-fbdd-45c1-a18d-fefd378604a5
7	2025-03-19	50	45	fa9fb4ff-095c-4ada-9eaf-310daf0e61b6
2	2025-03-19	90	100	92996701-fbdd-45c1-a18d-fefd378604a5
4	2025-03-21	75	55	92996701-fbdd-45c1-a18d-fefd378604a5
\.


--
-- Data for Name: tracker_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tracker_schedule (title, description, start_time, end_time, profile_id, uuid, streak, updated_at, completed_at, duration) FROM stdin;
qwe	13	00:23:00	14:31:00	1	92996701-fbdd-45c1-a18d-fefd378604a5	0	2025-03-19 04:05:32.994406+00	2025-03-19 04:05:32.974994+00	60
work	working hard	13:36:55	13:37:58	1	fa9fb4ff-095c-4ada-9eaf-310daf0e61b6	0	2025-03-19 20:36:03.966742+00	\N	60
\.


--
-- Data for Name: tracker_threedmodel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tracker_threedmodel (id, name, file_path, description, camera_position_z) FROM stdin;
5	2_person_statue_scan_medpoly.glb	/static/models/2_person_statue_scan_medpoly.glb	2_person_statue_scan_medpoly.glb	1.5
6	/static/models/grab_johannes_zach.glb	/static/models/grab_johannes_zach.glb	/static/models/grab_johannes_zach.glb	2.5
\.


--
-- Data for Name: tracker_threedmodel_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tracker_threedmodel_profiles (id, threedmodel_id, profile_id) FROM stdin;
4	5	3
5	6	1
\.


--
-- Data for Name: users_comment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_comment (id, content, created_at, post_id, user_id) FROM stdin;
8	hiiii	2025-03-18 22:53:09.235991+00	79d67891-7a77-470c-b8eb-d8f7b2777939	1
9	yoooo	2025-03-18 22:53:15.229061+00	79d67891-7a77-470c-b8eb-d8f7b2777939	1
10	hey hey	2025-03-18 22:53:35.924852+00	79d67891-7a77-470c-b8eb-d8f7b2777939	1
\.


--
-- Data for Name: users_like; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_like (id, created_at, user_id, post_id) FROM stdin;
7	2025-03-25 20:51:41.030302+00	1	79d67891-7a77-470c-b8eb-d8f7b2777939
8	2025-03-25 20:51:48.798855+00	1	ca29be94-77cf-491a-aa76-9f5c2e40ed3f
\.


--
-- Data for Name: users_post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_post (content, created_at, profile_id, image, uuid) FROM stdin;
2wqd23f	2025-03-18 22:46:45.226984+00	1	post_images/IMG_2762.jpeg	79d67891-7a77-470c-b8eb-d8f7b2777939
ewqfcqw	2025-03-19 21:36:18.320634+00	1		1fe8acce-bc99-4418-b5af-5f0e809eba64
qwsq	2025-03-21 03:48:31.697082+00	1		ca29be94-77cf-491a-aa76-9f5c2e40ed3f
qwe	2025-03-27 00:12:12.482981+00	1		c6746b1a-fc18-4808-8b91-f099e0e27d2b
\.


--
-- Data for Name: users_profile; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_profile (id, gender, date_of_birth, location, user_id, body_fat, height, profile_picture, weight, phone_number, chosen_model_id, active_model_id) FROM stdin;
3	male	2003-12-10	vancouver	5	9	1.81	profile_pics/IMG_2766.jpeg	62	6047194707	\N	5
1	male	2023-12-10	Vancouver	1	9	1.81	profile_pics/IMG_2799.jpeg	62	6047194707	5	6
\.


--
-- Data for Name: users_profile_available_models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users_profile_available_models (id, profile_id, threedmodel_id) FROM stdin;
1	3	5
2	3	6
3	1	5
4	1	6
\.


--
-- Name: account_emailaddress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_emailaddress_id_seq', 2, true);


--
-- Name: account_emailconfirmation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.account_emailconfirmation_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 84, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 5, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 113, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 21, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 55, true);


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_site_id_seq', 3, true);


--
-- Name: socialaccount_socialaccount_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socialaccount_socialaccount_id_seq', 2, true);


--
-- Name: socialaccount_socialapp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socialaccount_socialapp_id_seq', 1, true);


--
-- Name: socialaccount_socialapp_sites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socialaccount_socialapp_sites_id_seq', 1, true);


--
-- Name: socialaccount_socialtoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.socialaccount_socialtoken_id_seq', 2, true);


--
-- Name: tracker_dailyprogress_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tracker_dailyprogress_id_seq', 7, true);


--
-- Name: tracker_threedmodel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tracker_threedmodel_id_seq', 7, true);


--
-- Name: tracker_threedmodel_profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tracker_threedmodel_profiles_id_seq', 6, true);


--
-- Name: users_comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_comment_id_seq', 10, true);


--
-- Name: users_like_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_like_id_seq', 8, true);


--
-- Name: users_profile_available_models_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_profile_available_models_id_seq', 4, true);


--
-- Name: users_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_profile_id_seq', 3, true);


--
-- Name: account_emailaddress account_emailaddress_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_email_key UNIQUE (email);


--
-- Name: account_emailaddress account_emailaddress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_pkey PRIMARY KEY (id);


--
-- Name: account_emailconfirmation account_emailconfirmation_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_key_key UNIQUE (key);


--
-- Name: account_emailconfirmation account_emailconfirmation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirmation_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_provider_uid_fc810c6e_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_provider_uid_fc810c6e_uniq UNIQUE (provider, uid);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp__socialapp_id_site_id_71a9a768_uniq UNIQUE (socialapp_id, site_id);


--
-- Name: socialaccount_socialapp socialaccount_socialapp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp
    ADD CONSTRAINT socialaccount_socialapp_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialapp_sites socialaccount_socialapp_sites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_socialapp_sites_pkey PRIMARY KEY (id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq UNIQUE (app_id, account_id);


--
-- Name: socialaccount_socialtoken socialaccount_socialtoken_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_socialtoken_pkey PRIMARY KEY (id);


--
-- Name: tracker_dailyprogress tracker_dailyprogress_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_dailyprogress
    ADD CONSTRAINT tracker_dailyprogress_pkey PRIMARY KEY (id);


--
-- Name: tracker_dailyprogress tracker_dailyprogress_schedule_id_date_9d6d0107_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_dailyprogress
    ADD CONSTRAINT tracker_dailyprogress_schedule_id_date_9d6d0107_uniq UNIQUE (schedule_id, date);


--
-- Name: tracker_schedule tracker_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_schedule
    ADD CONSTRAINT tracker_schedule_pkey PRIMARY KEY (uuid);


--
-- Name: tracker_threedmodel tracker_threedmodel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_threedmodel
    ADD CONSTRAINT tracker_threedmodel_pkey PRIMARY KEY (id);


--
-- Name: tracker_threedmodel_profiles tracker_threedmodel_prof_threedmodel_id_profile_i_308cf263_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_threedmodel_profiles
    ADD CONSTRAINT tracker_threedmodel_prof_threedmodel_id_profile_i_308cf263_uniq UNIQUE (threedmodel_id, profile_id);


--
-- Name: tracker_threedmodel_profiles tracker_threedmodel_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_threedmodel_profiles
    ADD CONSTRAINT tracker_threedmodel_profiles_pkey PRIMARY KEY (id);


--
-- Name: users_comment users_comment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_comment
    ADD CONSTRAINT users_comment_pkey PRIMARY KEY (id);


--
-- Name: users_like users_like_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_like
    ADD CONSTRAINT users_like_pkey PRIMARY KEY (id);


--
-- Name: users_post users_post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_post
    ADD CONSTRAINT users_post_pkey PRIMARY KEY (uuid);


--
-- Name: users_profile_available_models users_profile_available__profile_id_threedmodel_i_fb05b624_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile_available_models
    ADD CONSTRAINT users_profile_available__profile_id_threedmodel_i_fb05b624_uniq UNIQUE (profile_id, threedmodel_id);


--
-- Name: users_profile_available_models users_profile_available_models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile_available_models
    ADD CONSTRAINT users_profile_available_models_pkey PRIMARY KEY (id);


--
-- Name: users_profile users_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_pkey PRIMARY KEY (id);


--
-- Name: users_profile users_profile_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_user_id_key UNIQUE (user_id);


--
-- Name: account_emailaddress_email_03be32b2_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailaddress_email_03be32b2_like ON public.account_emailaddress USING btree (email varchar_pattern_ops);


--
-- Name: account_emailaddress_user_id_2c513194; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailaddress_user_id_2c513194 ON public.account_emailaddress USING btree (user_id);


--
-- Name: account_emailconfirmation_email_address_id_5b7f8c58; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailconfirmation_email_address_id_5b7f8c58 ON public.account_emailconfirmation USING btree (email_address_id);


--
-- Name: account_emailconfirmation_key_f43612bd_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX account_emailconfirmation_key_f43612bd_like ON public.account_emailconfirmation USING btree (key varchar_pattern_ops);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);


--
-- Name: socialaccount_socialaccount_user_id_8146e70c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialaccount_user_id_8146e70c ON public.socialaccount_socialaccount USING btree (user_id);


--
-- Name: socialaccount_socialapp_sites_site_id_2579dee5; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialapp_sites_site_id_2579dee5 ON public.socialaccount_socialapp_sites USING btree (site_id);


--
-- Name: socialaccount_socialapp_sites_socialapp_id_97fb6e7d; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialapp_sites_socialapp_id_97fb6e7d ON public.socialaccount_socialapp_sites USING btree (socialapp_id);


--
-- Name: socialaccount_socialtoken_account_id_951f210e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialtoken_account_id_951f210e ON public.socialaccount_socialtoken USING btree (account_id);


--
-- Name: socialaccount_socialtoken_app_id_636a42d7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX socialaccount_socialtoken_app_id_636a42d7 ON public.socialaccount_socialtoken USING btree (app_id);


--
-- Name: tracker_dailyprogress_schedule_id_e5209fd1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tracker_dailyprogress_schedule_id_e5209fd1 ON public.tracker_dailyprogress USING btree (schedule_id);


--
-- Name: tracker_schedule_profile_id_4f745321; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tracker_schedule_profile_id_4f745321 ON public.tracker_schedule USING btree (profile_id);


--
-- Name: tracker_threedmodel_profiles_profile_id_33726ab7; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tracker_threedmodel_profiles_profile_id_33726ab7 ON public.tracker_threedmodel_profiles USING btree (profile_id);


--
-- Name: tracker_threedmodel_profiles_threedmodel_id_a03fb794; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX tracker_threedmodel_profiles_threedmodel_id_a03fb794 ON public.tracker_threedmodel_profiles USING btree (threedmodel_id);


--
-- Name: users_comment_post_id_fb15d6ef; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_comment_post_id_fb15d6ef ON public.users_comment USING btree (post_id);


--
-- Name: users_comment_user_id_2af09c44; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_comment_user_id_2af09c44 ON public.users_comment USING btree (user_id);


--
-- Name: users_like_user_id_f08494bc; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_like_user_id_f08494bc ON public.users_like USING btree (user_id);


--
-- Name: users_post_profile_id_688bcbc8; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_post_profile_id_688bcbc8 ON public.users_post USING btree (profile_id);


--
-- Name: users_profile_active_model_id_9334f8be; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_profile_active_model_id_9334f8be ON public.users_profile USING btree (active_model_id);


--
-- Name: users_profile_available_models_profile_id_4fcbf1c1; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_profile_available_models_profile_id_4fcbf1c1 ON public.users_profile_available_models USING btree (profile_id);


--
-- Name: users_profile_available_models_threedmodel_id_ed195f94; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_profile_available_models_threedmodel_id_ed195f94 ON public.users_profile_available_models USING btree (threedmodel_id);


--
-- Name: users_profile_chosen_model_id_97379bb2; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_profile_chosen_model_id_97379bb2 ON public.users_profile USING btree (chosen_model_id);


--
-- Name: account_emailaddress account_emailaddress_user_id_2c513194_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailaddress
    ADD CONSTRAINT account_emailaddress_user_id_2c513194_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: account_emailconfirmation account_emailconfirm_email_address_id_5b7f8c58_fk_account_e; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account_emailconfirmation
    ADD CONSTRAINT account_emailconfirm_email_address_id_5b7f8c58_fk_account_e FOREIGN KEY (email_address_id) REFERENCES public.account_emailaddress(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken socialaccount_social_account_id_951f210e_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_social_account_id_951f210e_fk_socialacc FOREIGN KEY (account_id) REFERENCES public.socialaccount_socialaccount(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialtoken socialaccount_social_app_id_636a42d7_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialtoken
    ADD CONSTRAINT socialaccount_social_app_id_636a42d7_fk_socialacc FOREIGN KEY (app_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites socialaccount_social_site_id_2579dee5_fk_django_si; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_social_site_id_2579dee5_fk_django_si FOREIGN KEY (site_id) REFERENCES public.django_site(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialapp_sites socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialapp_sites
    ADD CONSTRAINT socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc FOREIGN KEY (socialapp_id) REFERENCES public.socialaccount_socialapp(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: socialaccount_socialaccount socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.socialaccount_socialaccount
    ADD CONSTRAINT socialaccount_socialaccount_user_id_8146e70c_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tracker_dailyprogress tracker_dailyprogres_schedule_id_e5209fd1_fk_tracker_s; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_dailyprogress
    ADD CONSTRAINT tracker_dailyprogres_schedule_id_e5209fd1_fk_tracker_s FOREIGN KEY (schedule_id) REFERENCES public.tracker_schedule(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tracker_schedule tracker_schedule_profile_id_4f745321_fk_users_profile_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_schedule
    ADD CONSTRAINT tracker_schedule_profile_id_4f745321_fk_users_profile_id FOREIGN KEY (profile_id) REFERENCES public.users_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tracker_threedmodel_profiles tracker_threedmodel__profile_id_33726ab7_fk_users_pro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_threedmodel_profiles
    ADD CONSTRAINT tracker_threedmodel__profile_id_33726ab7_fk_users_pro FOREIGN KEY (profile_id) REFERENCES public.users_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: tracker_threedmodel_profiles tracker_threedmodel__threedmodel_id_a03fb794_fk_tracker_t; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tracker_threedmodel_profiles
    ADD CONSTRAINT tracker_threedmodel__threedmodel_id_a03fb794_fk_tracker_t FOREIGN KEY (threedmodel_id) REFERENCES public.tracker_threedmodel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_comment users_comment_post_id_fb15d6ef_fk_users_post_uuid; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_comment
    ADD CONSTRAINT users_comment_post_id_fb15d6ef_fk_users_post_uuid FOREIGN KEY (post_id) REFERENCES public.users_post(uuid) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_comment users_comment_user_id_2af09c44_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_comment
    ADD CONSTRAINT users_comment_user_id_2af09c44_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_like users_like_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_like
    ADD CONSTRAINT users_like_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.users_post(uuid);


--
-- Name: users_like users_like_user_id_f08494bc_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_like
    ADD CONSTRAINT users_like_user_id_f08494bc_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_post users_post_profile_id_688bcbc8_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_post
    ADD CONSTRAINT users_post_profile_id_688bcbc8_fk_auth_user_id FOREIGN KEY (profile_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_profile users_profile_active_model_id_9334f8be_fk_tracker_t; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_active_model_id_9334f8be_fk_tracker_t FOREIGN KEY (active_model_id) REFERENCES public.tracker_threedmodel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_profile_available_models users_profile_availa_profile_id_4fcbf1c1_fk_users_pro; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile_available_models
    ADD CONSTRAINT users_profile_availa_profile_id_4fcbf1c1_fk_users_pro FOREIGN KEY (profile_id) REFERENCES public.users_profile(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_profile_available_models users_profile_availa_threedmodel_id_ed195f94_fk_tracker_t; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile_available_models
    ADD CONSTRAINT users_profile_availa_threedmodel_id_ed195f94_fk_tracker_t FOREIGN KEY (threedmodel_id) REFERENCES public.tracker_threedmodel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_profile users_profile_chosen_model_id_97379bb2_fk_tracker_t; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_chosen_model_id_97379bb2_fk_tracker_t FOREIGN KEY (chosen_model_id) REFERENCES public.tracker_threedmodel(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: users_profile users_profile_user_id_2112e78d_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_profile
    ADD CONSTRAINT users_profile_user_id_2112e78d_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

