--
-- PostgreSQL database dump
--

\restrict 4F67rIa9bfaeWjAxPTWUdFX3nzveksfwaHj3XDhUjrEgLpkxqeIxW1sbFtuoSkr

-- Dumped from database version 17.10 (Debian 17.10-1.pgdg13+1)
-- Dumped by pg_dump version 17.9

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: BinanceIntentStatus; Type: TYPE; Schema: public; Owner: pacha
--

CREATE TYPE public."BinanceIntentStatus" AS ENUM (
    'PENDING',
    'CONFIRMED',
    'REJECTED',
    'EXPIRED'
);


ALTER TYPE public."BinanceIntentStatus" OWNER TO pacha;

--
-- Name: CreatorReferralRewardStatus; Type: TYPE; Schema: public; Owner: pacha
--

CREATE TYPE public."CreatorReferralRewardStatus" AS ENUM (
    'PAID',
    'REVERSED'
);


ALTER TYPE public."CreatorReferralRewardStatus" OWNER TO pacha;

--
-- Name: CreatorReferralStatus; Type: TYPE; Schema: public; Owner: pacha
--

CREATE TYPE public."CreatorReferralStatus" AS ENUM (
    'ACTIVE',
    'DISABLED',
    'PENDING'
);


ALTER TYPE public."CreatorReferralStatus" OWNER TO pacha;

--
-- Name: DepositStatus; Type: TYPE; Schema: public; Owner: pacha
--

CREATE TYPE public."DepositStatus" AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED'
);


ALTER TYPE public."DepositStatus" OWNER TO pacha;

--
-- Name: MediaType; Type: TYPE; Schema: public; Owner: pacha
--

CREATE TYPE public."MediaType" AS ENUM (
    'IMAGE',
    'VIDEO'
);


ALTER TYPE public."MediaType" OWNER TO pacha;

--
-- Name: PaymentType; Type: TYPE; Schema: public; Owner: pacha
--

CREATE TYPE public."PaymentType" AS ENUM (
    'QR',
    'TRANSFERENCIA'
);


ALTER TYPE public."PaymentType" OWNER TO pacha;

--
-- Name: ServiceType; Type: TYPE; Schema: public; Owner: pacha
--

CREATE TYPE public."ServiceType" AS ENUM (
    'MESSAGE',
    'CALL',
    'VIDEO_CALL',
    'MESSAGE_SEND'
);


ALTER TYPE public."ServiceType" OWNER TO pacha;

--
-- Name: TransactionType; Type: TYPE; Schema: public; Owner: pacha
--

CREATE TYPE public."TransactionType" AS ENUM (
    'DEPOSIT',
    'WITHDRAWAL',
    'MESSAGE_UNLOCK',
    'EARNING',
    'IMAGE_UNLOCK',
    'CALL_PAYMENT',
    'MESSAGE_SEND',
    'SUBSCRIPTION',
    'CHAT_IMAGE_UNLOCK',
    'REFERRAL_CREATOR_REWARD',
    'REFERRAL_CREATOR_REWARD_REVERSAL'
);


ALTER TYPE public."TransactionType" OWNER TO pacha;

--
-- Name: UserRole; Type: TYPE; Schema: public; Owner: pacha
--

CREATE TYPE public."UserRole" AS ENUM (
    'USER',
    'ADMIN',
    'ANFITRIONA'
);


ALTER TYPE public."UserRole" OWNER TO pacha;

--
-- Name: WithdrawalMethodType; Type: TYPE; Schema: public; Owner: pacha
--

CREATE TYPE public."WithdrawalMethodType" AS ENUM (
    'BCP',
    'OTHER_BANK',
    'PAYPAL',
    'BYBIT',
    'BINANCE'
);


ALTER TYPE public."WithdrawalMethodType" OWNER TO pacha;

--
-- Name: WithdrawalStatus; Type: TYPE; Schema: public; Owner: pacha
--

CREATE TYPE public."WithdrawalStatus" AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED'
);


ALTER TYPE public."WithdrawalStatus" OWNER TO pacha;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Banks; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public."Banks" (
    name text NOT NULL,
    logo_url text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    id integer NOT NULL
);


ALTER TABLE public."Banks" OWNER TO pacha;

--
-- Name: Banks_id_seq; Type: SEQUENCE; Schema: public; Owner: pacha
--

CREATE SEQUENCE public."Banks_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Banks_id_seq" OWNER TO pacha;

--
-- Name: Banks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pacha
--

ALTER SEQUENCE public."Banks_id_seq" OWNED BY public."Banks".id;


--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO pacha;

--
-- Name: anfitrione_images; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.anfitrione_images (
    id text NOT NULL,
    "profileId" text NOT NULL,
    url text NOT NULL,
    "publicId" text,
    "sortOrder" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isPremium" boolean DEFAULT false NOT NULL,
    "isVisible" boolean DEFAULT true NOT NULL,
    "unlockCredits" double precision
);


ALTER TABLE public.anfitrione_images OWNER TO pacha;

--
-- Name: anfitrione_profile_social_links; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.anfitrione_profile_social_links (
    id text NOT NULL,
    "anfitrionaProfileId" text NOT NULL,
    "socialNetworkId" text NOT NULL,
    url text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.anfitrione_profile_social_links OWNER TO pacha;

--
-- Name: anfitrione_profiles; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.anfitrione_profiles (
    id text NOT NULL,
    "userId" text NOT NULL,
    "dateOfBirth" timestamp(3) without time zone NOT NULL,
    cedula text NOT NULL,
    username text NOT NULL,
    "idDocUrl" text,
    "idDocPublicId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "avatarUrl" text,
    "avatarPublicId" text,
    bio text,
    "rateCredits" integer,
    "isOnline" boolean DEFAULT false NOT NULL,
    "coverUrl" text,
    "coverPublicId" text
);


ALTER TABLE public.anfitrione_profiles OWNER TO pacha;

--
-- Name: anfitrione_subscriptions; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.anfitrione_subscriptions (
    id text NOT NULL,
    "profileId" text NOT NULL,
    price double precision NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.anfitrione_subscriptions OWNER TO pacha;

--
-- Name: bank_accounts; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.bank_accounts (
    id bigint NOT NULL,
    "userId" text NOT NULL,
    "bankId" integer,
    "anfitrionaProfileId" text NOT NULL,
    "accountNumber" character varying(50),
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    "accountHolderName" character varying(100),
    type public."WithdrawalMethodType" DEFAULT 'BCP'::public."WithdrawalMethodType" NOT NULL,
    "paypalEmail" text
);


ALTER TABLE public.bank_accounts OWNER TO pacha;

--
-- Name: bank_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: pacha
--

CREATE SEQUENCE public.bank_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bank_accounts_id_seq OWNER TO pacha;

--
-- Name: bank_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: pacha
--

ALTER SEQUENCE public.bank_accounts_id_seq OWNED BY public.bank_accounts.id;


--
-- Name: binance_deposit_intents; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.binance_deposit_intents (
    id text NOT NULL,
    "userId" text NOT NULL,
    "packageId" text NOT NULL,
    "packageName" text NOT NULL,
    "creditsToDeliver" integer NOT NULL,
    network text NOT NULL,
    coin text NOT NULL,
    "walletAddress" text NOT NULL,
    "expectedAmount" numeric(20,8) NOT NULL,
    "microDelta" numeric(20,8) NOT NULL,
    txid text,
    status public."BinanceIntentStatus" DEFAULT 'PENDING'::public."BinanceIntentStatus" NOT NULL,
    "failureReason" text,
    "binanceData" jsonb,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    "confirmedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.binance_deposit_intents OWNER TO pacha;

--
-- Name: conversations; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.conversations (
    id text NOT NULL,
    "user1Id" text NOT NULL,
    "user2Id" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.conversations OWNER TO pacha;

--
-- Name: creator_referral_reward_events; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.creator_referral_reward_events (
    id text NOT NULL,
    "referralId" text NOT NULL,
    "referrerCreatorId" text NOT NULL,
    "referredUserId" text,
    "purchaseCreatorId" text,
    "sourceTransactionId" text NOT NULL,
    "rewardTransactionId" text NOT NULL,
    "sourceAmount" numeric(10,2) NOT NULL,
    percent numeric(5,2) NOT NULL,
    "rewardAmount" numeric(10,2) NOT NULL,
    status public."CreatorReferralRewardStatus" DEFAULT 'PAID'::public."CreatorReferralRewardStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "reversedAt" timestamp(3) without time zone,
    "referredCreatorId" text
);


ALTER TABLE public.creator_referral_reward_events OWNER TO pacha;

--
-- Name: creator_referral_settings; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.creator_referral_settings (
    id text NOT NULL,
    "creatorId" text NOT NULL,
    percent numeric(5,2) NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.creator_referral_settings OWNER TO pacha;

--
-- Name: creator_referrals; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.creator_referrals (
    id text NOT NULL,
    "referrerCreatorId" text NOT NULL,
    "referredUserId" text,
    "referralCodeUsed" text NOT NULL,
    status public."CreatorReferralStatus" DEFAULT 'ACTIVE'::public."CreatorReferralStatus" NOT NULL,
    "qualifiedAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "referredCreatorId" text,
    percent numeric(5,2) DEFAULT 0 NOT NULL
);


ALTER TABLE public.creator_referrals OWNER TO pacha;

--
-- Name: deposit_requests; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.deposit_requests (
    id text NOT NULL,
    "userId" text NOT NULL,
    "packageId" text,
    "paymentMethodId" text,
    amount numeric(10,2) NOT NULL,
    "receiptUrl" text NOT NULL,
    "receiptPublicId" text,
    status public."DepositStatus" DEFAULT 'PENDING'::public."DepositStatus" NOT NULL,
    "rejectionReason" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "creditsToDeliver" integer DEFAULT 0 NOT NULL,
    "packageNameAtMoment" text
);


ALTER TABLE public.deposit_requests OWNER TO pacha;

--
-- Name: histories; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.histories (
    id text NOT NULL,
    "userId" text NOT NULL,
    "mediaUrl" text NOT NULL,
    "mediaType" public."MediaType" DEFAULT 'IMAGE'::public."MediaType" NOT NULL,
    "publicId" text,
    "priceCredits" integer DEFAULT 0 NOT NULL,
    "publishedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.histories OWNER TO pacha;

--
-- Name: history_views; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.history_views (
    id text NOT NULL,
    "userId" text NOT NULL,
    "historyId" text NOT NULL,
    "viewedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.history_views OWNER TO pacha;

--
-- Name: image_unlocks; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.image_unlocks (
    id text NOT NULL,
    "imageId" text NOT NULL,
    "userId" text NOT NULL,
    "creditsSpent" double precision NOT NULL,
    "transactionId" text,
    "unlockedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.image_unlocks OWNER TO pacha;

--
-- Name: likes; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.likes (
    id text NOT NULL,
    "userId" text NOT NULL,
    "anfitrionaId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.likes OWNER TO pacha;

--
-- Name: message_image_unlocks; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.message_image_unlocks (
    id text NOT NULL,
    "messageId" text NOT NULL,
    "userId" text NOT NULL,
    "creditsSpent" double precision NOT NULL,
    "transactionId" text,
    "unlockedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "imageUrl" text NOT NULL
);


ALTER TABLE public.message_image_unlocks OWNER TO pacha;

--
-- Name: message_unlocks; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.message_unlocks (
    id text NOT NULL,
    "messageId" text NOT NULL,
    "userId" text NOT NULL,
    "creditsSpent" double precision NOT NULL,
    "transactionId" text,
    "unlockedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.message_unlocks OWNER TO pacha;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.messages (
    id text NOT NULL,
    "conversationId" text NOT NULL,
    "senderId" text NOT NULL,
    text text,
    read boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "isLocked" boolean DEFAULT false NOT NULL,
    price double precision,
    "imagePublicId" text,
    "imageUrl" text
);


ALTER TABLE public.messages OWNER TO pacha;

--
-- Name: packages; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.packages (
    id text NOT NULL,
    name character varying(100) NOT NULL,
    credits integer NOT NULL,
    price numeric(10,2) NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.packages OWNER TO pacha;

--
-- Name: payment_methods; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.payment_methods (
    id text NOT NULL,
    type public."PaymentType" NOT NULL,
    "bankName" text,
    "accountName" text,
    "accountNumber" text,
    "qrImageUrl" text,
    "qrPublicId" text,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "logoPublicId" text,
    "logoUrl" text
);


ALTER TABLE public.payment_methods OWNER TO pacha;

--
-- Name: saved_anfitrionas; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.saved_anfitrionas (
    id text NOT NULL,
    "userId" text NOT NULL,
    "anfitrionaId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.saved_anfitrionas OWNER TO pacha;

--
-- Name: service_prices; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.service_prices (
    id text NOT NULL,
    "profileId" text NOT NULL,
    "serviceType" public."ServiceType" NOT NULL,
    price double precision NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.service_prices OWNER TO pacha;

--
-- Name: social_networks; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.social_networks (
    id text NOT NULL,
    name text NOT NULL,
    icon text,
    "iconPublicId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.social_networks OWNER TO pacha;

--
-- Name: transactions; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.transactions (
    id text NOT NULL,
    "walletId" text NOT NULL,
    "depositRequestId" text,
    amount numeric(10,2) NOT NULL,
    type public."TransactionType" NOT NULL,
    description text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.transactions OWNER TO pacha;

--
-- Name: user_profile; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.user_profile (
    id text NOT NULL,
    "userId" text NOT NULL,
    "userName" text,
    bio text,
    "avatarUrl" text,
    "avatarPublicId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.user_profile OWNER TO pacha;

--
-- Name: user_subscriptions; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.user_subscriptions (
    id text NOT NULL,
    "userId" text NOT NULL,
    "subscriptionId" text NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.user_subscriptions OWNER TO pacha;

--
-- Name: users; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.users (
    id text NOT NULL,
    "phoneNumber" text,
    email text,
    password text,
    "firstName" text,
    "lastName" text,
    "isProfileComplete" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "lastLogin" timestamp(3) without time zone,
    role public."UserRole" DEFAULT 'USER'::public."UserRole" NOT NULL,
    "resetPasswordExpiry" timestamp(3) without time zone,
    "resetPasswordToken" text,
    "isActive" boolean DEFAULT true NOT NULL,
    "fcmToken" text,
    "lastActiveAt" timestamp(3) without time zone,
    "referralCode" text
);


ALTER TABLE public.users OWNER TO pacha;

--
-- Name: wallets; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.wallets (
    id text NOT NULL,
    balance numeric(10,2) DEFAULT 0.00 NOT NULL,
    "userId" text NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.wallets OWNER TO pacha;

--
-- Name: web_push_credentials; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.web_push_credentials (
    id text NOT NULL,
    "userId" text NOT NULL,
    token text NOT NULL,
    "userAgent" text,
    "lastSeenAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.web_push_credentials OWNER TO pacha;

--
-- Name: withdrawal_requests; Type: TABLE; Schema: public; Owner: pacha
--

CREATE TABLE public.withdrawal_requests (
    id text NOT NULL,
    "walletId" text NOT NULL,
    "bankAccountId" bigint NOT NULL,
    credits numeric(10,2) NOT NULL,
    soles numeric(10,2) NOT NULL,
    status public."WithdrawalStatus" DEFAULT 'PENDING'::public."WithdrawalStatus" NOT NULL,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "receiptPublicId" text,
    "receiptUrl" text,
    "rejectionReason" text,
    "payoutCurrency" text DEFAULT 'PEN'::text NOT NULL
);


ALTER TABLE public.withdrawal_requests OWNER TO pacha;

--
-- Name: Banks id; Type: DEFAULT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public."Banks" ALTER COLUMN id SET DEFAULT nextval('public."Banks_id_seq"'::regclass);


--
-- Name: bank_accounts id; Type: DEFAULT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.bank_accounts ALTER COLUMN id SET DEFAULT nextval('public.bank_accounts_id_seq'::regclass);


--
-- Data for Name: Banks; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public."Banks" (name, logo_url, "createdAt", "updatedAt", id) FROM stdin;
Banco de Crédito BCP	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1774037652/20_dise%C3%B1os_en_los_que_queda_patente_que_menos_es_m%C3%A1s_-_Cultura_Inquieta_k1pylb.jpg	2026-03-26 14:08:22.601	2026-03-26 14:08:22.601	1
Banco de Crédito BCP	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1774037652/20_dise%C3%B1os_en_los_que_queda_patente_que_menos_es_m%C3%A1s_-_Cultura_Inquieta_k1pylb.jpg	2026-03-26 14:08:22.601	2026-03-26 14:08:22.601	2
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
de0f2d2f-f4f4-44d1-b4b0-d88def792e66	57a5187120d3b8baa2690e5d5f4d5d9ef058eda28273e7075949caddd6a72cd8	2026-03-28 22:11:23.244913+00	20260306002746_init	\N	\N	2026-03-28 22:11:22.073178+00	1
20f232fd-8347-4a99-a95f-e14b75bff084	9ac03c9ab29592be4e14aead2db08237aa7a1298bcca127aab6586d499f9bec8	2026-03-28 22:11:44.457796+00	20260320205834_add_earning_transaction_type	\N	\N	2026-03-28 22:11:43.301288+00	1
3b64f716-212f-4777-bce9-7ad9cf04cf0a	3eb820ad37380317c9c1d78ae3af80da22c6fb180cdffb25095a70d0a0dbe7b3	2026-03-28 22:11:24.91702+00	20260306151229_delete_unnecesary_tables2	\N	\N	2026-03-28 22:11:23.709057+00	1
9af5a50b-4124-49cb-9286-502a1ea4d51a	2613f75fe0c4ebc51f43ba3b3e5bbcc546896b9c3dbb5cdc247576a155426b6e	2026-03-28 22:11:26.534209+00	20260307031052_merge_wallet_anfitriona	\N	\N	2026-03-28 22:11:25.385428+00	1
1818f2e1-f555-4150-a4f9-65e795100f12	af50cf38b77e89093df0fad6278a8c2052990c06de0f3398cbf5e4d5cbac129b	\N	20260425000000_add_bybit_binance_method	A migration failed to apply. New migrations cannot be applied before the error is recovered from. Read more about how to resolve migration issues in a production database: https://pris.ly/d/migrate-resolve\n\nMigration name: 20260425000000_add_bybit_binance_method\n\nDatabase error code: 42710\n\nDatabase error:\nERROR: enum label "BYBIT" already exists\n\nDbError { severity: "ERROR", parsed_severity: Some(Error), code: SqlState(E42710), message: "enum label \\"BYBIT\\" already exists", detail: None, hint: None, position: None, where_: None, schema: None, table: None, column: None, datatype: None, constraint: None, file: Some("pg_enum.c"), line: Some(348), routine: Some("AddEnumLabel") }\n\n   0: sql_schema_connector::apply_migration::apply_script\n           with migration_name="20260425000000_add_bybit_binance_method"\n             at schema-engine\\connectors\\sql-schema-connector\\src\\apply_migration.rs:113\n   1: schema_commands::commands::apply_migrations::Applying migration\n           with migration_name="20260425000000_add_bybit_binance_method"\n             at schema-engine\\commands\\src\\commands\\apply_migrations.rs:95\n   2: schema_core::state::ApplyMigrations\n             at schema-engine\\core\\src\\state.rs:246	2026-04-27 00:43:31.281377+00	2026-04-27 00:43:17.087464+00	0
593efb55-dbf9-48ff-98dd-d739800e2a9d	c7c40d3a551280b4f0a2722a40ce1c2ee1c6d83439aab3a68f1beb1ce9ec70df	2026-03-28 22:11:28.161423+00	20260311000000_add_anfitriona_profile_fields	\N	\N	2026-03-28 22:11:26.988852+00	1
7d9f7f07-5522-49cc-b288-2d61b932ec45	4b8a6dcdba0d1ad715738ac4aadd0869ecbc590639df3158f9b575aab30ed45f	2026-03-28 22:11:46.08063+00	20260320224228_add_bank_and_bank_accounts	\N	\N	2026-03-28 22:11:44.932898+00	1
8c046215-c17a-4d91-a46c-dd3849d39088	5655d9818200a94cc6cf2f08259d5e8833980d2d355daa875daf52fc75e2a460	2026-03-28 22:11:29.780837+00	20260311015243_improve_history_model	\N	\N	2026-03-28 22:11:28.625205+00	1
37a83a95-2242-4c3f-968a-f41adeb42bd9	5908e47fa12cdf27ccea207612e398694066d08a07a0c7b99d82fbb2e2903694	2026-03-28 22:11:31.425071+00	20260313154120_improve_history_view_model	\N	\N	2026-03-28 22:11:30.255301+00	1
2f0b0d9d-d2a2-4386-afb5-804ac205bd83	af62df224246b270ff8dc191a239658e479b5b21dafe3fbdb3f2a70c2f4eb15d	2026-03-30 22:07:35.104246+00	20260330220732_add_fcm_token	\N	\N	2026-03-30 22:07:33.938997+00	1
61083a64-ee4d-4be4-b254-9128811bae8a	defef83a76a1d6fe6d168a8eb681e9f2de4b2c587a6170289af3392ebc9312cf	2026-03-28 22:11:33.048829+00	20260314031746_add_likes	\N	\N	2026-03-28 22:11:31.882624+00	1
9e341697-09ca-4ea1-8741-ce15e01d6e09	e300e50788cf33855104a7487f356a285ae114d0d4bb12809bb3c1a167a3822a	2026-03-28 22:11:47.704856+00	20260320230943_add_withdrawal_request	\N	\N	2026-03-28 22:11:46.541616+00	1
5d28a107-d533-44d5-b635-123dffe36db5	d64fb535ee5d798b85327a79736c426350fb5c95be5bbd739359be2979d30207	2026-03-28 22:11:34.676899+00	20260319140617_add_conversations_and_messages	\N	\N	2026-03-28 22:11:33.521089+00	1
f47fcd7e-21f4-4a68-8dfd-6abe0322291f	3319be6d4b6524573ea8fc7e3fce6bd0e71641c211e0415026657332962f80b6	2026-03-28 22:11:36.309328+00	20260319162039_add_premium_fields_to_anfitrione_image	\N	\N	2026-03-28 22:11:35.142275+00	1
0ec973d7-9771-4917-8e83-4464c133f689	d8659199edeecaf5167a93f7bfc99f5b0ecd82168382b373c4118c1c9b219cd4	2026-03-28 22:11:37.924895+00	20260320023956_deposits	\N	\N	2026-03-28 22:11:36.772888+00	1
e8c7ceb1-a143-49ce-ba31-f5e7ff0892da	07d15b934ce441acbd1c227155a3b722b0bfe0ec2c41d2d46f086f490809dde0	2026-03-28 22:11:49.340789+00	20260321142428_add_image_unlock	\N	\N	2026-03-28 22:11:48.172974+00	1
2c5d5547-c2b3-4470-89a8-d9b6912df42f	9e45fe7b7f2f521c257e42201b41404d8fe140a1093f228a6bd7a6fe1eae8949	2026-03-28 22:11:39.536653+00	20260320044051_add_message_locking_and_service_prices	\N	\N	2026-03-28 22:11:38.381221+00	1
1e1fa8f6-9e54-46ae-83c6-20c39b52dde8	e6e831ee81bae79bf92e723ee41c702f2905a117643b4d1697bc81b195f7f5f8	2026-03-28 22:11:41.168748+00	20260320172128_update_deposits_request	\N	\N	2026-03-28 22:11:40.000859+00	1
ec058ebc-ac75-46fa-956f-44ba1daeb726	af50cf38b77e89093df0fad6278a8c2052990c06de0f3398cbf5e4d5cbac129b	2026-04-27 00:43:31.704032+00	20260425000000_add_bybit_binance_method		\N	2026-04-27 00:43:31.704032+00	0
ff548a6c-72c4-4525-bfa7-d748f026ff26	8de508f62ec6690a24f872e0b7b2fdb405ce4484004a7e4fd59d234f684585fb	2026-03-28 22:11:42.822213+00	20260320194656_update_payment_method	\N	\N	2026-03-28 22:11:41.644881+00	1
f51ae2ef-8c97-45ae-9955-aaa0dc99fe5a	33960b5d12425a19b05188b93a68cf2c7a04421aec1aa216def0501d5ab48328	2026-03-28 22:11:50.941786+00	20260321163607_create_user_profile	\N	\N	2026-03-28 22:11:49.797003+00	1
669574b9-7e11-4bec-8bc8-fd9d35cd9616	7b0b8539420222135a8ecdbef876f5cef76d50ca22344c92c868450fd75c26c8	2026-04-06 03:32:57.646126+00	20260406033255_change_service_price_to_float	\N	\N	2026-04-06 03:32:56.518467+00	1
c6a923e5-4684-4053-97ea-bca210d80fe1	0cbd3041e1f04d343b2e58115f4d1ab78044f2b9fad478aae1b9e2e60efc5110	2026-03-28 22:11:52.573178+00	20260321180000_add_cover_url_to_anfitriona_profile	\N	\N	2026-03-28 22:11:51.408969+00	1
432e2fa4-8fd5-4a2b-9d25-a01663ee97e4	6799bc984ba7c3d83f16ee00e813d2100b753612d6f193336cb763deff8da59a	2026-03-28 22:11:54.192675+00	20260322014808_save_anfitrionas	\N	\N	2026-03-28 22:11:53.041124+00	1
b5fec9cd-50c0-4a30-9909-7a4308c24563	eb66ed140b2f85a4fe0441c73a7d7bcae6832125901c22741bdcf46506430e84	2026-03-28 22:11:55.812759+00	20260327134020_add_withdrawal_receipt_fields	\N	\N	2026-03-28 22:11:54.656865+00	1
d2740ac6-7c9c-45ad-adf4-236b5dca037f	57a5187120d3b8baa2690e5d5f4d5d9ef058eda28273e7075949caddd6a72cd8	2026-03-21 18:04:02.867477+00	20260306002746_init	\N	\N	2026-03-21 18:04:02.263752+00	1
e0d43bbe-ba66-4b14-9bc1-e7526fa6d997	9ac03c9ab29592be4e14aead2db08237aa7a1298bcca127aab6586d499f9bec8	2026-03-21 18:04:14.140784+00	20260320205834_add_earning_transaction_type	\N	\N	2026-03-21 18:04:13.559147+00	1
8fada386-c5d0-41d5-ba05-987b741e6937	3eb820ad37380317c9c1d78ae3af80da22c6fb180cdffb25095a70d0a0dbe7b3	2026-03-21 18:04:03.688803+00	20260306151229_delete_unnecesary_tables2	\N	\N	2026-03-21 18:04:03.100729+00	1
832c000d-8dcb-4427-86de-3908a260b328	2613f75fe0c4ebc51f43ba3b3e5bbcc546896b9c3dbb5cdc247576a155426b6e	2026-03-21 18:04:04.518368+00	20260307031052_merge_wallet_anfitriona	\N	\N	2026-03-21 18:04:03.92278+00	1
2eb75b7d-70c5-4635-82d7-09dea0492546	659242e2a31d1f38334f104833e231c7c1935a0de65c95ab26fa86264c0b5203	2026-04-22 01:46:00.454128+00	20260422014556_add_new_tabla	\N	\N	2026-04-22 01:45:59.238214+00	1
8cc24dfb-cd00-4e33-b1f6-8027fb28338b	508742154444653afb5d8ba42cfc46a62dc3cabebb4a95286d7f0877fd6c94ab	2026-04-23 04:55:50.901611+00	20260423045547_add_last_active_at	\N	\N	2026-04-23 04:55:49.378779+00	1
7543b89e-902f-4ec7-99f6-ee0019e0621d	da1e120772f4a844126e62fcbd961eed64fe0c43c41e22d6c2c4930e6cec90f6	2026-04-27 00:42:49.311132+00	20260424000000_add_withdrawal_method_type		\N	2026-04-27 00:42:49.311132+00	0
d4959891-1439-4ce3-8cbf-6d0335d5c50c	f70dc1f0de0a7cd4a27a20f26d9e1b1dfccf3718a58bbb488e7f71e8b8220439	2026-05-21 15:00:37.749823+00	20260520180000_creator_referrals_phase1	\N	\N	2026-05-21 15:00:36.607539+00	1
c3e3b8ac-a5e5-478b-bcc2-682828e3e270	c7c40d3a551280b4f0a2722a40ce1c2ee1c6d83439aab3a68f1beb1ce9ec70df	2026-03-21 18:04:05.334293+00	20260311000000_add_anfitriona_profile_fields	\N	\N	2026-03-21 18:04:04.749719+00	1
5d5b1e92-ede1-41b6-bfe8-9ebe748d2864	4b8a6dcdba0d1ad715738ac4aadd0869ecbc590639df3158f9b575aab30ed45f	2026-03-21 18:04:14.963061+00	20260320224228_add_bank_and_bank_accounts	\N	\N	2026-03-21 18:04:14.371394+00	1
8181cc76-c605-4745-9510-52525e14ff5f	da07b090848a213ce2bfc22650fd7510a1bd0160cffba9a38ecb31768e22cdeb	2026-03-21 18:04:06.148913+00	20260311015243_improve_history_model	\N	\N	2026-03-21 18:04:05.566284+00	1
5d1c3bcd-ef1a-484d-8ed5-0e67ac857c46	181d6c0efa2bc60b825b1c079c8c092b0b20b7eb86dad87931b0904c200d2bc8	2026-03-21 18:04:06.966808+00	20260313154120_improve_history_view_model	\N	\N	2026-03-21 18:04:06.381331+00	1
011ae37c-e547-43f1-8b86-574de82d9cf7	defef83a76a1d6fe6d168a8eb681e9f2de4b2c587a6170289af3392ebc9312cf	2026-03-21 18:04:08.099433+00	20260314031746_add_likes	\N	\N	2026-03-21 18:04:07.199376+00	1
81537fdf-5c4f-4ed0-aef9-2beeaf35caeb	e300e50788cf33855104a7487f356a285ae114d0d4bb12809bb3c1a167a3822a	2026-03-21 18:04:15.779257+00	20260320230943_add_withdrawal_request	\N	\N	2026-03-21 18:04:15.19515+00	1
6f91b8ad-5cd7-48e1-b02b-89def51a31df	f4580c6eb065667589178cd25f933c0753786a5c551e28a96f8638c548100d26	2026-03-21 18:04:08.922449+00	20260319140617_add_conversations_and_messages	\N	\N	2026-03-21 18:04:08.332716+00	1
b5fbfdcd-96a8-4dd4-95df-1ba4f0f499db	3319be6d4b6524573ea8fc7e3fce6bd0e71641c211e0415026657332962f80b6	2026-03-21 18:04:09.739072+00	20260319162039_add_premium_fields_to_anfitrione_image	\N	\N	2026-03-21 18:04:09.153862+00	1
9da725fb-8617-4a2f-8f84-bdefe7ffd01c	e27bd6ed7f857ef2fd353b7d2033c04d512c61dfaae90387b10766ce57050154	2026-03-21 18:04:10.562847+00	20260320023956_deposits	\N	\N	2026-03-21 18:04:09.973222+00	1
b8ccc0db-6117-4733-8edf-cd2dcd253bad	07d15b934ce441acbd1c227155a3b722b0bfe0ec2c41d2d46f086f490809dde0	2026-03-21 18:04:16.59848+00	20260321142428_add_image_unlock	\N	\N	2026-03-21 18:04:16.012693+00	1
85af246e-552c-4793-8c7e-d99a606030bf	e4b5b135510e4ccabd4508bfe6dd6ee5f91cbaabeb1f2f390370dba03d08d3c0	2026-03-21 18:04:11.388195+00	20260320044051_add_message_locking_and_service_prices	\N	\N	2026-03-21 18:04:10.794476+00	1
db1bc1db-7716-45a6-8ae3-ec3a3b0ac9dd	7169a49d9aceb93e48e977c31eef7debd2f765aaaedf6cda2e272e29d925fd04	2026-03-21 18:04:12.198145+00	20260320172128_update_deposits_request	\N	\N	2026-03-21 18:04:11.620125+00	1
6c249328-df2d-4981-b765-a6710eafdc36	1f57bcec58a59855e92e6706367ac2fdb2f81c1d69552e03d2827310aad9be16	2026-03-21 18:04:13.326246+00	20260320194656_update_payment_method	\N	\N	2026-03-21 18:04:12.429762+00	1
b9ed49da-c707-4665-bb75-d96940066f8e	a5af8fe5d7a0e7a7d4a2503c4817df3c0c223860a4d8bfad36e09bf3a1ee83cd	2026-03-21 18:04:17.41606+00	20260321163607_create_user_profile	\N	\N	2026-03-21 18:04:16.830897+00	1
14a5960b-b7e6-4d58-8dbf-4412cf404b51	0cbd3041e1f04d343b2e58115f4d1ab78044f2b9fad478aae1b9e2e60efc5110	2026-03-21 18:04:18.230873+00	20260321180000_add_cover_url_to_anfitriona_profile	\N	\N	2026-03-21 18:04:17.648108+00	1
59edf948-d951-4cc9-9cb4-bea457713bb7	ea2b2122850960179c58fc2ede87a5870665df6971b29af7488a62d4514a38ff	2026-03-22 01:48:09.50566+00	20260322014808_save_anfitrionas	\N	\N	2026-03-22 01:48:08.912354+00	1
90ce2546-ed90-442e-aa44-836baec0448d	b74ea6006d07338a16c109363a0c2728e90b8cf612e6736088ce6287ad4f9fd1	2026-03-27 13:40:21.698259+00	20260327134020_add_withdrawal_receipt_fields	\N	\N	2026-03-27 13:40:21.10393+00	1
eef3b3b1-e594-40d0-ade8-fb1dfcb7f0ae	4d5ed8ad2df04dda1e99d069b5afcb2791beb4f62199dbf4a8c245445b8f71a4	2026-04-06 01:50:13.919928+00	20260406015011_add_message_send_price	\N	\N	2026-04-06 01:50:12.751713+00	1
53611cc8-bc73-4e93-adc5-b665e757a9ca	475bcabf9f8ee99a9bb9713e67bd90baf9f7ad36ddd0c1021e1e96319641f0e7	2026-04-06 20:46:29.726544+00	20260406204627_add_subscriptions	\N	\N	2026-04-06 20:46:28.501997+00	1
2c14cb71-ffbf-4b98-8f85-6c1ceb495d34	87321c0c86d1177e6d0130730c1f98e3f9418408e4a7ddeab3f29cf376dce0aa	2026-04-22 02:12:08.039864+00	20260422021204_add_colum_new_tabla	\N	\N	2026-04-22 02:12:06.497121+00	1
4efb038c-fbc1-4642-9bad-3b7564c0f1d5	0728ac1bd13b3270b43b3a3fd8248eda38b19e48c5fdd7e13d340c046dba8146	2026-04-27 00:43:44.832736+00	20260426000000_add_binance_deposit_intents	\N	\N	2026-04-27 00:43:43.698577+00	1
df0ee85c-8741-42ba-b091-31df38699235	da1e120772f4a844126e62fcbd961eed64fe0c43c41e22d6c2c4930e6cec90f6	\N	20260424000000_add_withdrawal_method_type	A migration failed to apply. New migrations cannot be applied before the error is recovered from. Read more about how to resolve migration issues in a production database: https://pris.ly/d/migrate-resolve\n\nMigration name: 20260424000000_add_withdrawal_method_type\n\nDatabase error code: 42710\n\nDatabase error:\nERROR: type "WithdrawalMethodType" already exists\n\nDbError { severity: "ERROR", parsed_severity: Some(Error), code: SqlState(E42710), message: "type \\"WithdrawalMethodType\\" already exists", detail: None, hint: None, position: None, where_: None, schema: None, table: None, column: None, datatype: None, constraint: None, file: Some("typecmds.c"), line: Some(1177), routine: Some("DefineEnum") }\n\n   0: sql_schema_connector::apply_migration::apply_script\n           with migration_name="20260424000000_add_withdrawal_method_type"\n             at schema-engine\\connectors\\sql-schema-connector\\src\\apply_migration.rs:113\n   1: schema_commands::commands::apply_migrations::Applying migration\n           with migration_name="20260424000000_add_withdrawal_method_type"\n             at schema-engine\\commands\\src\\commands\\apply_migrations.rs:95\n   2: schema_core::state::ApplyMigrations\n             at schema-engine\\core\\src\\state.rs:246	2026-04-27 00:42:48.877578+00	2026-04-27 00:39:21.541957+00	0
db418d19-204c-438d-9e45-10c9243b4257	e5cf82267213dd77d4e00cc9cb87b121ebdb1e874cf333218c81a6ba8aaf27e9	2026-05-21 19:21:53.27041+00	20260521103000_creator_referrals_creator_to_creator_phase2	\N	\N	2026-05-21 19:21:52.100869+00	1
90dc46af-abe2-4cde-8243-07e8f7c30ff6	32b44e7985e441197ad70f42e3924ef5d4f6087434720622a12401d0834542b5	2026-05-22 16:47:38.400231+00	20260522090000_add_pending_creator_referral_status	\N	\N	2026-05-22 16:47:37.317437+00	1
5559d126-8721-4fc5-8642-cafd2c1733ba	717095d52d7b300f204ab8153974dc258e845cd9fd70fc408c2c84732f9fc22a	2026-07-14 02:32:20.652113+00	20260713230000_add_web_push_credentials		\N	2026-07-14 02:32:20.652113+00	0
\.


--
-- Data for Name: anfitrione_images; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.anfitrione_images (id, "profileId", url, "publicId", "sortOrder", "createdAt", "isPremium", "isVisible", "unlockCredits") FROM stdin;
63de5d0b-a5ff-4dea-826c-8af57b21523d	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1775320880/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1775320880654.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1775320880654	0	2026-04-04 16:41:22.325	t	t	10
9fd943ff-4ef4-4412-a3c3-99a027bb26c8	b946a33e-2ba4-4526-82df-4b44026a7500	https://res.cloudinary.com/dai7rtja6/image/upload/v1775362878/pachamama/anfitrionas/982f221b-fe45-496e-b958-70b8c4d0d2fc/gallery/gallery_1775362878348.jpg	pachamama/anfitrionas/982f221b-fe45-496e-b958-70b8c4d0d2fc/gallery/gallery_1775362878348	0	2026-04-05 04:21:19.29	f	t	\N
519f7989-8e79-402e-b4ac-6c1a695cc86d	858f43c5-4b7d-43a8-a79d-92732698fe31	https://res.cloudinary.com/dai7rtja6/image/upload/v1775369813/pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/gallery/gallery_1775369812682.jpg	pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/gallery/gallery_1775369812682	0	2026-04-05 06:16:54.211	f	t	\N
7af770eb-ece8-4704-ba69-9c9eeb33f431	858f43c5-4b7d-43a8-a79d-92732698fe31	https://res.cloudinary.com/dai7rtja6/image/upload/v1775370400/pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/gallery/gallery_1775370399558.jpg	pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/gallery/gallery_1775370399558	0	2026-04-05 06:26:40.883	t	t	50
1546c3c4-54ba-4ee8-9934-94b773bca473	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	https://res.cloudinary.com/dai7rtja6/image/upload/v1775374033/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775374033272.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775374033272	0	2026-04-05 07:27:14.278	t	t	30
3df12a97-5a89-430d-a699-eac1f8b1ea06	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	https://res.cloudinary.com/dai7rtja6/image/upload/v1775374134/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775374134019.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775374134019	0	2026-04-05 07:28:55.515	t	t	30
5d5f3c56-b06f-45e1-8f09-5c0480465e4e	5a46d608-6458-4ae5-ab32-afc0b456dd79	https://res.cloudinary.com/dai7rtja6/image/upload/v1775442877/pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1775442876600.png	pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1775442876600	0	2026-04-06 02:34:38.333	f	t	\N
4f25a15b-9052-4be2-a797-8671829d1dc4	58c26008-8639-4374-aa26-8ca3f75856aa	https://res.cloudinary.com/dai7rtja6/image/upload/v1774959238/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1774959238083.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1774959238083	1	2026-04-04 03:03:45.55	f	t	\N
4cb8ed08-3fa7-4460-8e0d-6c0ce92bdc30	58c26008-8639-4374-aa26-8ca3f75856aa	https://res.cloudinary.com/dai7rtja6/image/upload/v1774959264/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1774959263473.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1774959263473	0	2026-04-04 03:03:45.55	f	t	\N
68b11dac-7f44-4984-a541-3cfa44936896	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1774959238/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1774959238083.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1774959238083	1	2026-03-31 12:13:59.125	f	t	\N
4919d5f3-87aa-4d10-97ce-a81e1257e82e	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775410716/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775410715393.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775410715393	1	2026-04-05 17:38:36.701	t	t	30
092a902d-5f5b-42b6-acb8-940919facccb	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775412289/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775412288934.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775412288934	1	2026-04-05 18:04:49.917	f	t	\N
61ce7c0d-97ce-405d-abec-76e8075ae64a	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1775320134/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1775320134721.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1775320134721	0	2026-04-04 16:28:56.142	t	t	11
6cf1ed78-365b-4c3f-be0d-9269f6fa0aca	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1775320906/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1775320907695.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1775320907695	0	2026-04-04 16:41:48.945	t	t	10
fc6b47b4-1155-4917-823a-5fd41e8c704f	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1775338396/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1775338397639.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1775338397639	0	2026-04-04 21:33:19.279	t	t	12
4802bc3f-d690-4610-9ed1-2087719b99b4	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1775339191/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1775339192993.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1775339192993	0	2026-04-04 21:46:34.73	t	t	12
a3532184-f3b8-4398-9587-36783a1cc5a7	858f43c5-4b7d-43a8-a79d-92732698fe31	https://res.cloudinary.com/dai7rtja6/image/upload/v1775369846/pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/gallery/gallery_1775369845487.jpg	pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/gallery/gallery_1775369845487	0	2026-04-05 06:17:27.035	t	t	30
0fee547b-dc4d-45e1-8a80-45a9280eca6d	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	https://res.cloudinary.com/dai7rtja6/image/upload/v1775373514/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775373513078.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775373513078	0	2026-04-05 07:18:34.497	f	t	\N
4e493ddb-04e3-4ab6-8907-dd542d7878f8	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	https://res.cloudinary.com/dai7rtja6/image/upload/v1775374074/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775374073319.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775374073319	0	2026-04-05 07:27:54.548	f	t	\N
204a8e03-e244-459f-9996-f01c20d121bf	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1774265920/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1774265920293.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1774265920293	0	2026-03-23 11:38:41.086	t	t	20
f3573980-a9f5-40ed-8c9e-47ccd5035e6d	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1774127090/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1774127088539.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1774127088539	1	2026-03-21 21:04:50.422	t	t	10
ce257b84-dd3e-493a-b57e-df1996b1acaa	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1774127165/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1774127162744.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1774127162744	0	2026-03-21 21:06:05.163	t	t	2
5073246c-721a-43ae-9a3a-90ea1492ba58	5a46d608-6458-4ae5-ab32-afc0b456dd79	https://res.cloudinary.com/dai7rtja6/image/upload/v1775422215/pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1775422214551.jpg	pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1775422214551	0	2026-04-05 20:50:16.06	f	t	\N
1b7c9700-a3e1-4407-9e63-a7b51932ec9c	5a46d608-6458-4ae5-ab32-afc0b456dd79	https://res.cloudinary.com/dai7rtja6/image/upload/v1775442983/pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1775442982712.jpg	pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1775442982712	0	2026-04-06 02:36:24.205	f	t	\N
6e280c91-3643-444f-b476-13343cd0e0dd	6e72aec2-dff0-4b66-b031-99acde32af39	https://res.cloudinary.com/dai7rtja6/image/upload/v1775422768/pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/gallery/gallery_1775422767801.png	pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/gallery/gallery_1775422767801	0	2026-04-05 20:59:29.1	t	t	5
ed5f2de1-217e-4270-8054-db1a61a21681	7683de0a-a380-4be2-a89a-a51b36ad118e	https://res.cloudinary.com/dai7rtja6/image/upload/v1775175302/pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/gallery/gallery_1775175301656.jpg	pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/gallery/gallery_1775175301656	0	2026-04-03 00:15:02.946	f	t	\N
cd77c8df-792e-4b37-8e58-6dc6cb1ca607	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1775320160/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1775320161482.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1775320161482	0	2026-04-04 16:29:22.604	t	t	12
f1ee9f17-ff95-4edb-a1e1-b9d38561f402	858f43c5-4b7d-43a8-a79d-92732698fe31	https://res.cloudinary.com/dai7rtja6/image/upload/v1775369770/pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/gallery/gallery_1775369770293.jpg	pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/gallery/gallery_1775369770293	0	2026-04-05 06:16:11.448	f	t	\N
1a41d9ed-1db3-4e5a-ad69-859cc3c584a7	858f43c5-4b7d-43a8-a79d-92732698fe31	https://res.cloudinary.com/dai7rtja6/image/upload/v1775369780/pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/gallery/gallery_1775369779797.jpg	pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/gallery/gallery_1775369779797	0	2026-04-05 06:16:20.724	f	t	\N
d8df51fe-e685-4524-9b56-06352bebf420	858f43c5-4b7d-43a8-a79d-92732698fe31	https://res.cloudinary.com/dai7rtja6/image/upload/v1775369791/pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/gallery/gallery_1775369790625.jpg	pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/gallery/gallery_1775369790625	0	2026-04-05 06:16:31.614	f	t	\N
16cc3ca3-edaa-4227-b443-117380ff04d7	5a46d608-6458-4ae5-ab32-afc0b456dd79	https://res.cloudinary.com/dai7rtja6/image/upload/v1775370293/pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1775370292608.jpg	pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1775370292608	0	2026-04-05 06:24:53.815	f	t	\N
f86e137f-a42f-4d73-a27c-551479ff3d3b	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	https://res.cloudinary.com/dai7rtja6/image/upload/v1775373712/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775373711630.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775373711630	0	2026-04-05 07:21:53.08	t	t	30
6b2f7ccc-6a77-4cc9-97da-bbaf85b67631	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	https://res.cloudinary.com/dai7rtja6/image/upload/v1775374086/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775374085887.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775374085887	0	2026-04-05 07:28:07.111	f	t	\N
3cbcba4e-5a55-4e73-9376-10205fec8e92	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	https://res.cloudinary.com/dai7rtja6/image/upload/v1775374095/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775374095361.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775374095361	0	2026-04-05 07:28:16.239	f	t	\N
53feffe4-4cc2-4aa9-8a49-06757a54eff9	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	https://res.cloudinary.com/dai7rtja6/image/upload/v1775374104/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775374103920.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775374103920	0	2026-04-05 07:28:24.705	f	t	\N
bdf1c506-0e89-474d-ab5e-bbdff65a0d68	6e72aec2-dff0-4b66-b031-99acde32af39	https://res.cloudinary.com/dai7rtja6/image/upload/v1775422480/pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/gallery/gallery_1775422479554.jpg	pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/gallery/gallery_1775422479554	0	2026-04-05 20:54:40.655	t	t	15
d2cf51c2-072d-4426-b519-e7e725fa0fe0	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	https://res.cloudinary.com/dai7rtja6/image/upload/v1775448578/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775448578357.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775448578357	0	2026-04-06 04:09:39.374	t	t	30
37ea7e0d-d1e6-4be7-b1b0-eca65f791708	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1774959264/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1774959263473.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1774959263473	1	2026-03-31 12:14:24.654	f	t	\N
a9847d2e-3a21-4116-a963-30dcfd784002	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775412147/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775412146898.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775412146898	1	2026-04-05 18:02:28.349	f	t	\N
0aea64bb-bbd7-474d-bc19-9b4919a3e77a	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775410680/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775410679890.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775410679890	1	2026-04-05 17:38:00.866	f	t	\N
d04c85d6-f0c1-4e9f-9b07-6f6da38d8d4b	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775410665/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775410664849.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775410664849	1	2026-04-05 17:37:45.984	f	t	\N
934cff3c-b626-4cdd-9dd3-be218b5324c5	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775412270/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775412270022.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775412270022	1	2026-04-05 18:04:31.1	f	t	\N
20f9c97e-cf4f-4a13-8036-a00c0440155a	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775416687/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775416686777.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775416686777	1	2026-04-05 19:18:07.739	t	t	30
149c914c-f2ef-4548-8b1f-a1475caaf6d8	12f7b8d1-cf0c-47dd-a5db-6d36a02cb3d5	https://res.cloudinary.com/dai7rtja6/image/upload/v1775770047/pachamama/anfitrionas/f334565b-4fa3-4c9a-9608-832f8c472aee/gallery/gallery_1775770047181.jpg	pachamama/anfitrionas/f334565b-4fa3-4c9a-9608-832f8c472aee/gallery/gallery_1775770047181	0	2026-04-09 21:27:28.178	t	t	10
101a035f-721e-44bc-82dd-f3feb22f388e	12f7b8d1-cf0c-47dd-a5db-6d36a02cb3d5	https://res.cloudinary.com/dai7rtja6/image/upload/v1775770058/pachamama/anfitrionas/f334565b-4fa3-4c9a-9608-832f8c472aee/gallery/gallery_1775770058131.jpg	pachamama/anfitrionas/f334565b-4fa3-4c9a-9608-832f8c472aee/gallery/gallery_1775770058131	0	2026-04-09 21:27:39.185	f	t	\N
358d3fa0-616d-4fbf-9fa3-9dd480b18195	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775501424/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775501423882.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775501423882	0	2026-04-06 18:50:24.965	t	f	5
c5badfce-c794-42c4-9432-5b999ca2ce33	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775506780/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775506779687.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775506779687	0	2026-04-06 20:19:41.605	t	t	200
2b9f998f-a51c-4fd8-b40d-a404e0e439e4	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775506792/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775506791675.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775506791675	0	2026-04-06 20:19:52.649	t	t	200
13e503ca-2907-46ad-8f53-751cdfa4852b	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775506800/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775506799964.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775506799964	0	2026-04-06 20:20:00.909	f	t	\N
cda9e835-11a9-4c4a-badd-f1b39172cf2e	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775523784/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775523784174.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775523784174	0	2026-04-07 01:03:05.223	f	t	\N
04644a64-dceb-498c-8439-7792cb7bf126	6e72aec2-dff0-4b66-b031-99acde32af39	https://res.cloudinary.com/dai7rtja6/image/upload/v1775530053/pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/gallery/gallery_1775530052628.jpg	pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/gallery/gallery_1775530052628	0	2026-04-07 02:47:33.527	f	t	\N
f9503b71-f4dd-4e50-9afa-8724843aff34	7683de0a-a380-4be2-a89a-a51b36ad118e	https://res.cloudinary.com/dai7rtja6/image/upload/v1775553707/pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/gallery/gallery_1775553706269.jpg	pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/gallery/gallery_1775553706269	0	2026-04-07 09:21:47.815	f	t	\N
5758ff23-e0db-4a13-996f-08e290e5776e	7683de0a-a380-4be2-a89a-a51b36ad118e	https://res.cloudinary.com/dai7rtja6/image/upload/v1775553742/pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/gallery/gallery_1775553741385.jpg	pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/gallery/gallery_1775553741385	0	2026-04-07 09:22:22.51	f	t	\N
8167f0ce-8fd8-4f46-9028-41f85aa1982a	8ebe3560-3215-4b5d-8d00-040942f57465	https://res.cloudinary.com/dai7rtja6/image/upload/v1775514383/pachamama/anfitrionas/850654ff-c2a8-4215-bc96-c0afdb615949/gallery/gallery_1775514382925.jpg	pachamama/anfitrionas/850654ff-c2a8-4215-bc96-c0afdb615949/gallery/gallery_1775514382925	0	2026-04-06 22:26:24.416	t	t	15
4efd78b6-5507-46ff-b15b-27899f239e54	8ebe3560-3215-4b5d-8d00-040942f57465	https://res.cloudinary.com/dai7rtja6/image/upload/v1775514274/pachamama/anfitrionas/850654ff-c2a8-4215-bc96-c0afdb615949/gallery/gallery_1775514273884.jpg	pachamama/anfitrionas/850654ff-c2a8-4215-bc96-c0afdb615949/gallery/gallery_1775514273884	0	2026-04-06 22:24:35.234	t	t	15
298bd8af-9041-4f0b-8b1c-8f23a91de60f	8ebe3560-3215-4b5d-8d00-040942f57465	https://res.cloudinary.com/dai7rtja6/image/upload/v1775606092/pachamama/anfitrionas/850654ff-c2a8-4215-bc96-c0afdb615949/gallery/gallery_1775606091735.jpg	pachamama/anfitrionas/850654ff-c2a8-4215-bc96-c0afdb615949/gallery/gallery_1775606091735	0	2026-04-07 23:54:52.654	t	t	15
e79abb91-43d5-4c89-b9dc-31cb3f461015	7683de0a-a380-4be2-a89a-a51b36ad118e	https://res.cloudinary.com/dai7rtja6/image/upload/v1775633906/pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/gallery/gallery_1775633906322.jpg	pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/gallery/gallery_1775633906322	0	2026-04-08 07:38:27.352	f	t	\N
8fbfbf48-8c4a-48e4-9d50-05741703da47	7683de0a-a380-4be2-a89a-a51b36ad118e	https://res.cloudinary.com/dai7rtja6/image/upload/v1775634013/pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/gallery/gallery_1775634012990.jpg	pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/gallery/gallery_1775634012990	0	2026-04-08 07:40:14.044	f	t	\N
0b0db9a6-c2b4-4457-8880-b57b72ff90d1	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775770444/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775770443821.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775770443821	0	2026-04-09 21:34:05.458	t	t	10
2438f3d9-a89d-4ac3-8fa0-66a30597c40c	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775854802/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775854801382.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775854801382	0	2026-04-10 21:00:02.735	f	t	\N
a905a827-a38f-44c0-b5b9-fafc1d89349c	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775861305/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775861304425.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775861304425	0	2026-04-10 22:48:25.581	f	t	\N
375e4da3-de03-4a38-8284-ba7aa6537a78	6c85dc06-f2e9-4dc1-bcc5-6f2df559f290	https://res.cloudinary.com/dai7rtja6/image/upload/v1775867847/pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/gallery/gallery_1775867846223.jpg	pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/gallery/gallery_1775867846223	0	2026-04-11 00:37:27.783	t	t	25
a8d0a3f5-c1a2-49ac-8d88-4910c1aeac55	6c85dc06-f2e9-4dc1-bcc5-6f2df559f290	https://res.cloudinary.com/dai7rtja6/image/upload/v1775867884/pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/gallery/gallery_1775867883463.jpg	pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/gallery/gallery_1775867883463	0	2026-04-11 00:38:05.139	t	t	300
1abd98cc-88d5-4e71-8a3e-2a1ae52805c4	6c85dc06-f2e9-4dc1-bcc5-6f2df559f290	https://res.cloudinary.com/dai7rtja6/image/upload/v1775867907/pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/gallery/gallery_1775867906543.jpg	pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/gallery/gallery_1775867906543	0	2026-04-11 00:38:27.648	f	t	\N
a213608d-dde6-4e8f-8734-c584ffd12131	6c85dc06-f2e9-4dc1-bcc5-6f2df559f290	https://res.cloudinary.com/dai7rtja6/image/upload/v1775868462/pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/gallery/gallery_1775868462116.jpg	pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/gallery/gallery_1775868462116	0	2026-04-11 00:47:43.474	t	t	36
56ec23a5-6939-481b-9b0d-dc296dae2b87	6c85dc06-f2e9-4dc1-bcc5-6f2df559f290	https://res.cloudinary.com/dai7rtja6/image/upload/v1775868738/pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/gallery/gallery_1775868738134.jpg	pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/gallery/gallery_1775868738134	0	2026-04-11 00:52:19.077	f	t	\N
7fc1f940-f3d3-45b6-84dc-f6d8dc04a8ff	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775868973/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775868972924.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775868972924	0	2026-04-11 00:56:14.008	f	t	\N
64bcfadd-083c-4acf-a4ba-8ae6475eaf01	6e72aec2-dff0-4b66-b031-99acde32af39	https://res.cloudinary.com/dai7rtja6/image/upload/v1775876226/pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/gallery/gallery_1775876226291.jpg	pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/gallery/gallery_1775876226291	0	2026-04-11 02:57:07.619	f	t	\N
9b9caa41-3585-4c4d-92f3-13790437da56	6e72aec2-dff0-4b66-b031-99acde32af39	https://res.cloudinary.com/dai7rtja6/image/upload/v1775876276/pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/gallery/gallery_1775876275780.jpg	pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/gallery/gallery_1775876275780	0	2026-04-11 02:57:56.832	f	t	\N
37a46bfb-fead-4271-9faf-c33e8de691cf	6e72aec2-dff0-4b66-b031-99acde32af39	https://res.cloudinary.com/dai7rtja6/image/upload/v1775877086/pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/gallery/gallery_1775877085575.jpg	pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/gallery/gallery_1775877085575	0	2026-04-11 03:11:26.674	f	t	\N
10270d0d-981d-4b2d-b604-38b2ca1d889e	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775877822/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775877822055.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775877822055	0	2026-04-11 03:23:43.198	f	t	\N
2cf77eff-5db8-4f7d-80e9-b417d691df09	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	https://res.cloudinary.com/dai7rtja6/image/upload/v1775880098/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775880097817.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1775880097817	0	2026-04-11 04:01:38.972	f	t	\N
4d0c01b8-1a95-4665-a672-12ec7c3fee50	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775881283/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775881282587.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775881282587	0	2026-04-11 04:21:23.591	f	t	\N
b975c7b4-fe3e-4cf6-a9d6-da4a119eceff	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775906831/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775906831329.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775906831329	0	2026-04-11 11:27:12.204	f	t	\N
1e8dbd18-f4bc-4b8c-9071-0df992527fa5	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1775939002/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775939001491.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1775939001491	0	2026-04-11 20:23:22.603	f	t	\N
6d0a04be-a0eb-4b6f-b7a8-404d4af58d06	5a46d608-6458-4ae5-ab32-afc0b456dd79	https://res.cloudinary.com/dai7rtja6/image/upload/v1776214580/pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1776214580043.jpg	pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1776214580043	0	2026-04-15 00:56:22.553	f	t	\N
25093441-667f-4ec7-8498-d86d987fc76b	5a46d608-6458-4ae5-ab32-afc0b456dd79	https://res.cloudinary.com/dai7rtja6/image/upload/v1776214602/pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1776214601202.jpg	pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1776214601202	0	2026-04-15 00:56:43.13	f	t	\N
90568fdc-7374-4f01-af7f-b4139be76bbf	3d70c55e-5e40-489a-a5ff-bc5305ba79d6	https://res.cloudinary.com/dai7rtja6/image/upload/v1776266939/pachamama/anfitrionas/6cd4c719-68fb-4e7c-8455-f7909ce58666/gallery/gallery_1776266939188.jpg	pachamama/anfitrionas/6cd4c719-68fb-4e7c-8455-f7909ce58666/gallery/gallery_1776266939188	0	2026-04-15 15:29:00.295	t	t	15
d4b14678-1b61-4eda-953c-f0427d6abb07	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1777165005/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1777165005159.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1777165005159	0	2026-04-26 00:56:46.223	t	t	12
8f43848a-3f3e-490e-abb8-8fc5b00f0464	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1777165507/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1777165506594.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1777165506594	0	2026-04-26 01:05:07.795	t	t	13
196ef15d-4ab6-4f24-bce5-b190087a6042	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1777173698/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1777173698309.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1777173698309	0	2026-04-26 03:21:39.523	t	t	5.5
540ef306-6d7c-4dda-86cc-fadcd0ffe662	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1777173767/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1777173766984.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1777173766984	0	2026-04-26 03:22:48.137	t	t	3.4
f2ddbdd0-687f-4c30-b6ab-719e8e9a7b86	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1777173795/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1777173794681.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1777173794681	0	2026-04-26 03:23:15.593	t	t	2.6
d03a844f-8c50-47eb-8487-77abbdce893d	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	https://res.cloudinary.com/dai7rtja6/image/upload/v1777173913/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1777173913272.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/gallery/gallery_1777173913272	0	2026-04-26 03:25:14.75	t	t	8.4
50506c5a-ad82-4eb9-9e11-06756472e492	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1777277787/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1777277786765.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1777277786765	0	2026-04-27 08:16:27.708	f	t	\N
0b5686c0-1c0c-4eb4-a792-78563f2e9cfb	5a46d608-6458-4ae5-ab32-afc0b456dd79	https://res.cloudinary.com/dai7rtja6/image/upload/v1777703334/pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1777703333534.jpg	pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/gallery/gallery_1777703333534	0	2026-05-02 06:28:55.001	f	t	\N
567f401d-500f-464b-8fa3-6d72665cfe2f	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	https://res.cloudinary.com/dai7rtja6/image/upload/v1777703655/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1777703654791.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/gallery/gallery_1777703654791	0	2026-05-02 06:34:15.888	f	t	\N
b43a2010-380d-4fc9-bfe6-d34ec116cdeb	89021f50-7097-4ed7-ba0d-29de9acfb743	https://res.cloudinary.com/dai7rtja6/image/upload/v1777711698/pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/gallery/gallery_1777711697726.jpg	pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/gallery/gallery_1777711697726	0	2026-05-02 08:48:18.545	f	t	\N
89ff4ab1-bcee-40c7-9e3b-4c9150609c38	89021f50-7097-4ed7-ba0d-29de9acfb743	https://res.cloudinary.com/dai7rtja6/image/upload/v1777792714/pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/gallery/gallery_1777792714242.jpg	pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/gallery/gallery_1777792714242	0	2026-05-03 07:18:35.191	f	t	\N
a3f0c53f-6c52-4e75-8db9-252402050e6b	89021f50-7097-4ed7-ba0d-29de9acfb743	https://res.cloudinary.com/dai7rtja6/image/upload/v1777792746/pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/gallery/gallery_1777792746214.jpg	pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/gallery/gallery_1777792746214	0	2026-05-03 07:19:07.169	f	t	\N
baf825e6-52eb-4be2-ac4b-594de4272ac0	89021f50-7097-4ed7-ba0d-29de9acfb743	https://res.cloudinary.com/dai7rtja6/image/upload/v1777792838/pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/gallery/gallery_1777792837535.jpg	pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/gallery/gallery_1777792837535	0	2026-05-03 07:20:38.601	f	t	\N
c44d5d16-b6ad-4244-ac6c-b79192b7e14f	89021f50-7097-4ed7-ba0d-29de9acfb743	https://res.cloudinary.com/dai7rtja6/image/upload/v1777793128/pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/gallery/gallery_1777793127639.jpg	pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/gallery/gallery_1777793127639	0	2026-05-03 07:25:28.519	f	t	\N
bb26ef8b-ba30-405e-959b-c480b00debb4	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1777894400/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1777894399609.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1777894399609	0	2026-05-04 11:33:21.361	f	t	\N
f916fc93-2dd0-4b1f-b440-0a32365b2600	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1778043169/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778043168419.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778043168419	0	2026-05-06 04:52:49.421	f	t	\N
d57333b0-3ce1-4729-a87d-45270d51b554	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1778235798/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778235798011.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778235798011	0	2026-05-08 10:23:19.076	f	t	\N
df8c95a2-3edd-4e33-9c72-1a293fc6f81c	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1778292994/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778292993720.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778292993720	0	2026-05-09 02:16:34.578	f	t	\N
c2563e72-2ac6-45ce-b1d9-64268a7501ba	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1778342450/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778342449705.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778342449705	0	2026-05-09 16:00:51.212	f	t	\N
8b328ab9-97ec-4d80-aa6b-16fe5681cb15	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1778342485/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778342484620.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778342484620	0	2026-05-09 16:01:25.494	f	t	\N
47addee0-422e-4132-a68b-0f7b40828826	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1778457274/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778457273915.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778457273915	0	2026-05-10 23:54:35.202	f	t	\N
3f35ac22-6506-45da-8f3c-dc393c3cb37f	251daae3-0255-4334-a530-b02a59a578d3	https://res.cloudinary.com/dai7rtja6/image/upload/v1778532245/pachamama/anfitrionas/16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c/gallery/gallery_1778532241971.jpg	pachamama/anfitrionas/16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c/gallery/gallery_1778532241971	0	2026-05-11 20:44:03.92	f	t	\N
40561945-8c0c-4e9b-b541-8f86f14dae19	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1778666350/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778666349463.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778666349463	0	2026-05-13 09:59:10.716	f	t	\N
ec8d4e5b-531b-4770-8efe-c8249c47fa57	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1778813237/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778813237062.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778813237062	0	2026-05-15 02:47:18.347	f	t	\N
027f574e-fb78-48cb-a76a-a80cd93e8eb2	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1778978430/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778978430277.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1778978430277	0	2026-05-17 00:40:31.439	f	t	\N
7d87b9d0-8909-4bf0-9445-96db016a3586	1be77621-2065-4cb7-a867-e991f8f167a8	https://res.cloudinary.com/dai7rtja6/image/upload/v1779469335/pachamama/anfitrionas/b8f63138-a5ba-4b5c-b25c-ffd88ec1386b/gallery/gallery_1779469334289.jpg	pachamama/anfitrionas/b8f63138-a5ba-4b5c-b25c-ffd88ec1386b/gallery/gallery_1779469334289	0	2026-05-22 17:02:15.807	t	t	1000
b65e2214-8018-4915-bba5-3747d0d07858	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1779670697/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1779670695639.png	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1779670695639	0	2026-05-25 00:58:17.703	f	t	\N
a2c552c6-b516-47d9-a613-cb107a0d0340	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1779670716/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1779670715376.png	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1779670715376	0	2026-05-25 00:58:37.259	f	t	\N
29788fcd-1236-4378-8e44-3103b44640e3	793eff2c-99ec-4316-bbf5-3149af1487b8	https://res.cloudinary.com/dai7rtja6/image/upload/v1780553820/pachamama/anfitrionas/b827b865-dde5-4384-9b10-cd7f858c4d0f/gallery/gallery_1780553819211.jpg	pachamama/anfitrionas/b827b865-dde5-4384-9b10-cd7f858c4d0f/gallery/gallery_1780553819211	0	2026-06-04 06:17:00.961	f	t	\N
6c2eb200-cba9-44d2-917c-cdbe7dc20c98	793eff2c-99ec-4316-bbf5-3149af1487b8	https://res.cloudinary.com/dai7rtja6/image/upload/v1780553864/pachamama/anfitrionas/b827b865-dde5-4384-9b10-cd7f858c4d0f/gallery/gallery_1780553863511.jpg	pachamama/anfitrionas/b827b865-dde5-4384-9b10-cd7f858c4d0f/gallery/gallery_1780553863511	0	2026-06-04 06:17:44.899	t	t	50
f876afc2-3979-49eb-b446-563c05b860da	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1781120036/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1781120035982.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1781120035982	0	2026-06-10 19:33:57.521	f	t	\N
9f1f1a4d-3a72-49a4-90f3-3dfee8e4653d	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1779911257/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1779911256127.png	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1779911256127	0	2026-05-27 19:47:38.334	f	t	\N
b45c07a6-4cf6-4678-856a-830a238bbbbd	c7cc225e-3a86-4a63-b72c-c352cea9d0af	https://res.cloudinary.com/dai7rtja6/image/upload/v1780181472/pachamama/anfitrionas/8a3bb928-b6e1-4334-a038-55d49c49d7ce/gallery/gallery_1780181471527.jpg	pachamama/anfitrionas/8a3bb928-b6e1-4334-a038-55d49c49d7ce/gallery/gallery_1780181471527	0	2026-05-30 22:51:12.95	f	t	\N
23953197-8324-43f9-9bcb-9bf64375179c	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1782770067/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1782770066798.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1782770066798	0	2026-06-29 21:54:28.524	f	t	\N
3e9fb068-caa1-4c60-b74f-9ea5f3abac31	ff990cd5-2c90-4eb6-b791-1df919079baf	https://res.cloudinary.com/dai7rtja6/image/upload/v1783392907/pachamama/anfitrionas/9900429a-7d71-4fb3-8919-a5e2bb7e1460/gallery/gallery_1783392914764.jpg	pachamama/anfitrionas/9900429a-7d71-4fb3-8919-a5e2bb7e1460/gallery/gallery_1783392914764	0	2026-07-07 02:55:16.27	f	t	\N
18b67a5d-0ecc-4fee-b2bf-572367e47c07	ff990cd5-2c90-4eb6-b791-1df919079baf	https://res.cloudinary.com/dai7rtja6/image/upload/v1783392946/pachamama/anfitrionas/9900429a-7d71-4fb3-8919-a5e2bb7e1460/gallery/gallery_1783392953467.jpg	pachamama/anfitrionas/9900429a-7d71-4fb3-8919-a5e2bb7e1460/gallery/gallery_1783392953467	0	2026-07-07 02:55:54.994	f	t	\N
de254486-6c52-4e1b-8c89-b0e983459b92	1d9fb2e9-90a5-4154-aa1f-8b823309554c	https://res.cloudinary.com/dai7rtja6/image/upload/v1783542594/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783542593844.jpg	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783542593844	1	2026-07-08 20:29:54.97	f	t	\N
ea2c4795-ec43-426b-b40e-dd4395f2dfec	1d9fb2e9-90a5-4154-aa1f-8b823309554c	https://res.cloudinary.com/dai7rtja6/image/upload/v1783542624/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783542624723.jpg	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783542624723	1	2026-07-08 20:30:26.017	f	t	\N
3bd5718c-46a9-4738-8d55-2c663229c9aa	1d9fb2e9-90a5-4154-aa1f-8b823309554c	https://res.cloudinary.com/dai7rtja6/image/upload/v1783542649/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783542648954.jpg	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783542648954	1	2026-07-08 20:30:50.4	t	t	5
9fe02046-10d0-47c9-a77d-7d5cc4621d6c	1d9fb2e9-90a5-4154-aa1f-8b823309554c	https://res.cloudinary.com/dai7rtja6/image/upload/v1783395349/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783395357120.jpg	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783395357120	1	2026-07-07 03:35:58.125	f	t	\N
6fa61283-b8dd-4d68-a587-2d8d1d8c2a0e	1d9fb2e9-90a5-4154-aa1f-8b823309554c	https://res.cloudinary.com/dai7rtja6/image/upload/v1783468584/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783468592005.jpg	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783468592005	1	2026-07-07 23:56:35.596	f	t	\N
e1385b47-72ff-46d6-9a47-dab445539be9	1d9fb2e9-90a5-4154-aa1f-8b823309554c	https://res.cloudinary.com/dai7rtja6/image/upload/v1783468602/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783468612806.jpg	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783468612806	1	2026-07-07 23:56:54.041	t	t	10
fd32c187-3a18-43dc-9d8c-9977037ef1a0	1d9fb2e9-90a5-4154-aa1f-8b823309554c	https://res.cloudinary.com/dai7rtja6/image/upload/v1783468629/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783468639950.jpg	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783468639950	1	2026-07-07 23:57:21.444	t	t	5
55f56755-cafd-445d-9558-245903b30ee0	1d9fb2e9-90a5-4154-aa1f-8b823309554c	https://res.cloudinary.com/dai7rtja6/image/upload/v1783542674/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783542674711.jpg	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783542674711	1	2026-07-08 20:31:16.062	t	t	5
79828fbd-8b2e-4e8c-81af-bf0c2dc2346d	1d9fb2e9-90a5-4154-aa1f-8b823309554c	https://res.cloudinary.com/dai7rtja6/image/upload/v1783960212/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783960216161.png	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783960216161	1	2026-07-13 16:30:18.643	f	t	\N
11bb483e-7998-4c70-945a-f25addf62a82	1d9fb2e9-90a5-4154-aa1f-8b823309554c	https://res.cloudinary.com/dai7rtja6/image/upload/v1783960262/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783960266809.jpg	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783960266809	1	2026-07-13 16:31:08.32	t	t	12
8c94fd86-fc8a-469b-bc1a-92527515663e	1d9fb2e9-90a5-4154-aa1f-8b823309554c	https://res.cloudinary.com/dai7rtja6/image/upload/v1783960317/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783960319915.png	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783960319915	1	2026-07-13 16:32:03.184	t	t	15
9e8f346d-e48d-42f4-93f0-813b9e66e7a3	1d9fb2e9-90a5-4154-aa1f-8b823309554c	https://res.cloudinary.com/dai7rtja6/image/upload/v1783542566/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783542565407.jpg	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/gallery/gallery_1783542565407	0	2026-07-08 20:29:27.036	t	t	2
e8548baa-6229-4646-9a1b-9dcc5a1ee271	a1c9542f-aee8-44be-b313-627df56c5c8e	https://res.cloudinary.com/dai7rtja6/image/upload/v1784179389/pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/gallery/gallery_1784179389467.jpg	pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/gallery/gallery_1784179389467	0	2026-07-16 05:23:10.429	f	t	\N
9c0230b1-be80-4c1f-a646-74f92174be8a	a1c9542f-aee8-44be-b313-627df56c5c8e	https://res.cloudinary.com/dai7rtja6/image/upload/v1784179433/pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/gallery/gallery_1784179432959.jpg	pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/gallery/gallery_1784179432959	0	2026-07-16 05:23:53.831	f	t	\N
6142fe28-0213-4c8e-ae8b-ab02dc9140cf	a1c9542f-aee8-44be-b313-627df56c5c8e	https://res.cloudinary.com/dai7rtja6/image/upload/v1784179441/pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/gallery/gallery_1784179441457.jpg	pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/gallery/gallery_1784179441457	0	2026-07-16 05:24:02.405	f	t	\N
8051ff57-0c93-45ba-8077-d479e84e1a25	a1c9542f-aee8-44be-b313-627df56c5c8e	https://res.cloudinary.com/dai7rtja6/image/upload/v1784179454/pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/gallery/gallery_1784179453821.jpg	pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/gallery/gallery_1784179453821	0	2026-07-16 05:24:15.182	f	t	\N
1e90654d-ebf8-434e-8929-e52903e0bff1	a1c9542f-aee8-44be-b313-627df56c5c8e	https://res.cloudinary.com/dai7rtja6/image/upload/v1784179475/pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/gallery/gallery_1784179475337.jpg	pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/gallery/gallery_1784179475337	0	2026-07-16 05:24:36.398	t	t	30
65cc56af-beea-42f7-9829-855e41648988	a1c9542f-aee8-44be-b313-627df56c5c8e	https://res.cloudinary.com/dai7rtja6/image/upload/v1784179493/pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/gallery/gallery_1784179493576.jpg	pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/gallery/gallery_1784179493576	0	2026-07-16 05:24:54.415	t	t	30
621e4976-35b3-4781-917c-9e5008676e03	7a3e2e94-7fbb-4360-89b4-8e6db6dbc9ab	https://res.cloudinary.com/dai7rtja6/image/upload/v1784597310/pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597310330.png	pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597310330	0	2026-07-21 01:28:31.299	f	t	\N
5ff2a977-4cc2-42a4-8493-6134ea59bf3f	7a3e2e94-7fbb-4360-89b4-8e6db6dbc9ab	https://res.cloudinary.com/dai7rtja6/image/upload/v1784597312/pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597311990.png	pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597311990	0	2026-07-21 01:28:32.725	f	t	\N
019c2938-0840-4075-a6dd-a5e24957e8a7	7a3e2e94-7fbb-4360-89b4-8e6db6dbc9ab	https://res.cloudinary.com/dai7rtja6/image/upload/v1784597313/pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597313422.png	pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597313422	0	2026-07-21 01:28:34.119	f	t	\N
65c06811-643d-4cbc-9750-9f8ee3f75277	7a3e2e94-7fbb-4360-89b4-8e6db6dbc9ab	https://res.cloudinary.com/dai7rtja6/image/upload/v1784597315/pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597314810.png	pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597314810	0	2026-07-21 01:28:35.578	f	t	\N
170d7ff0-7fb5-4eb2-8d07-3abeae50d147	7a3e2e94-7fbb-4360-89b4-8e6db6dbc9ab	https://res.cloudinary.com/dai7rtja6/image/upload/v1784597318/pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597317714.png	pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597317714	0	2026-07-21 01:28:38.489	t	t	10
180aebfd-7c6c-4e16-9371-2f5f70e29f54	7a3e2e94-7fbb-4360-89b4-8e6db6dbc9ab	https://res.cloudinary.com/dai7rtja6/image/upload/v1784597316/pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597316258.png	pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597316258	0	2026-07-21 01:28:37.031	f	t	\N
a150a9e7-edd8-4b2c-bbf9-7b72ca9830df	7a3e2e94-7fbb-4360-89b4-8e6db6dbc9ab	https://res.cloudinary.com/dai7rtja6/image/upload/v1784597319/pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597319172.png	pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/gallery/gallery_1784597319172	0	2026-07-21 01:28:40.103	t	t	10
662d2f1e-b5c7-49d8-b249-0e86f56038b7	9f1b2121-6ed7-48d1-a320-ea48c0f416db	https://res.cloudinary.com/dai7rtja6/image/upload/v1784598226/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1784598226012.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/gallery/gallery_1784598226012	0	2026-07-21 01:43:47.533	f	t	\N
\.


--
-- Data for Name: anfitrione_profile_social_links; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.anfitrione_profile_social_links (id, "anfitrionaProfileId", "socialNetworkId", url, "createdAt", "updatedAt") FROM stdin;
8800ed56-8b38-4f9b-ab6d-e75f1fda23ae	0a354ef6-1664-4df0-82d6-bdaca769dd43	c0d8c0b1-959e-4799-9ae2-24f85740a6db	https://classroom.google.com/u/1/c/ODY5MDI5Mjk3MTA2	2026-07-16 00:11:59.822	2026-07-16 00:11:59.822
0d5d0ef9-bc58-48be-8c24-17ce8bcaae16	1d9fb2e9-90a5-4154-aa1f-8b823309554c	adf96712-1a61-42d2-8fd3-faa68ec86142	https://www.tiktok.com/@ericcpoter/video/7654441847808363797?is_from_webapp=1&sender_device=pc	2026-07-16 04:29:26.463	2026-07-16 04:29:26.463
0ca5c7b4-b1db-413a-8cd2-f66fa9643fc7	1d9fb2e9-90a5-4154-aa1f-8b823309554c	517d30f5-1249-4e2c-89a8-76851bf648ef	https://www.tiktok.com/@ericcpoter/video/7654441847808363797?is_from_webapp=1&sender_device=pc	2026-07-16 04:29:34.654	2026-07-16 04:29:34.654
7524df5c-da11-4b18-962d-33e8ffec9bd0	1d9fb2e9-90a5-4154-aa1f-8b823309554c	c363628b-56c0-4a8a-9f5d-3535c29a08c8	https://www.tiktok.com/@ericcpoter/video/7654441847808363797?is_from_webapp=1&sender_device=pc	2026-07-16 04:29:41.836	2026-07-16 04:29:41.836
e4586792-92f2-409a-9d50-99a3535c8db6	1d9fb2e9-90a5-4154-aa1f-8b823309554c	cdda26e6-420a-4efb-9208-1c31be5a82eb	https://www.tiktok.com/@ericcpoter/video/7654441847808363797?is_from_webapp=1&sender_device=pc	2026-07-16 04:29:49.105	2026-07-16 04:29:49.105
62150780-0001-4e22-b6a6-702fbdc4cf55	1d9fb2e9-90a5-4154-aa1f-8b823309554c	17894517-b737-4cef-b7ac-0b6a1607282c	https://www.tiktok.com/@ericcpoter/video/7654441847808363797?is_from_webapp=1&sender_device=pc	2026-07-16 04:30:01.658	2026-07-16 04:30:01.658
44466248-b584-46b9-9a0a-fc4b3f30e28c	1d9fb2e9-90a5-4154-aa1f-8b823309554c	56fda5fb-d658-477b-92a6-96433d7b78b5	https://www.tiktok.com/@ericcpoter/video/7654441847808363797?is_from_webapp=1&sender_device=pc	2026-07-16 04:30:10.529	2026-07-16 04:30:10.529
\.


--
-- Data for Name: anfitrione_profiles; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.anfitrione_profiles (id, "userId", "dateOfBirth", cedula, username, "idDocUrl", "idDocPublicId", "createdAt", "updatedAt", "avatarUrl", "avatarPublicId", bio, "rateCredits", "isOnline", "coverUrl", "coverPublicId") FROM stdin;
0a354ef6-1664-4df0-82d6-bdaca769dd43	705bcf07-fd33-4f4d-a2c3-9fb8d2ab97c7	2000-05-05 00:00:00	14112658	Sonia primera	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--LikEm-AK--/v1/pachamama/anfitrionas/705bcf07-fd33-4f4d-a2c3-9fb8d2ab97c7/identity/id_doc_1781752500500?_a=BAMAOGUs0	pachamama/anfitrionas/705bcf07-fd33-4f4d-a2c3-9fb8d2ab97c7/identity/id_doc_1781752500500	2026-06-18 03:15:02.377	2026-07-13 02:34:25.342	\N	\N		\N	t	\N	\N
c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	2000-11-12 00:00:00	15515168	Estefani	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/identity/id_doc_1774120028620	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/identity/id_doc_1774120028620	2026-03-21 19:07:10.398	2026-04-08 04:29:45.337	https://res.cloudinary.com/dai7rtja6/image/upload/v1774127271/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/avatar/avatar_1774127269138.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/avatar/avatar_1774127269138	soy sexi	15	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1774127222/pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/cover/cover_1774127220355.jpg	pachamama/anfitrionas/43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256/cover/cover_1774127220355
7683de0a-a380-4be2-a89a-a51b36ad118e	5893d81a-370d-46e6-8783-926054e7c5d7	2007-07-16 00:00:00	61081693	Candy	pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/identity/id_doc_1774937906658	pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/identity/id_doc_1774937906658	2026-03-31 06:18:27.767	2026-04-10 01:32:00.097	https://res.cloudinary.com/dai7rtja6/image/upload/v1774938590/pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/avatar/avatar_1774938589592.jpg	pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/avatar/avatar_1774938589592		0	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1774938590/pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/cover/cover_1774938590643.jpg	pachamama/anfitrionas/5893d81a-370d-46e6-8783-926054e7c5d7/cover/cover_1774938590643
43559ff0-4f8f-4869-9fc2-94e4aa658206	85299925-2366-4fd7-8a87-272883e763a0	2003-08-13 00:00:00	62268761	Jimena	pachamama/anfitrionas/85299925-2366-4fd7-8a87-272883e763a0/identity/id_doc_1775360856083	pachamama/anfitrionas/85299925-2366-4fd7-8a87-272883e763a0/identity/id_doc_1775360856083	2026-04-05 03:47:37.235	2026-04-05 03:47:37.235	\N	\N	\N	\N	f	\N	\N
5a46d608-6458-4ae5-ab32-afc0b456dd79	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2000-12-28 00:00:00	76969002	Karol	pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/identity/id_doc_1775363591147	pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/identity/id_doc_1775363591147	2026-04-05 04:33:12.029	2026-05-02 06:30:07.619	https://res.cloudinary.com/dai7rtja6/image/upload/v1775363978/pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/avatar/avatar_1775363977837.jpg	pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/avatar/avatar_1775363977837	Bella Y Sexy💋	\N	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1775873377/pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/cover/cover_1775873377402.jpg	pachamama/anfitrionas/affb0349-62e6-46a4-b877-f5a0e5a60ca0/cover/cover_1775873377402
0fdb71dd-796c-48a0-bbec-e78dee2afa84	b5b75c40-3df4-4efc-a9c9-ed40804cf0e3	2007-05-30 00:00:00	34563168	Camila	pachamama/anfitrionas/b5b75c40-3df4-4efc-a9c9-ed40804cf0e3/identity/id_doc_1774929305489	pachamama/anfitrionas/b5b75c40-3df4-4efc-a9c9-ed40804cf0e3/identity/id_doc_1774929305489	2026-03-31 03:55:06.52	2026-03-31 04:11:23.203	https://res.cloudinary.com/dai7rtja6/image/upload/v1774930281/pachamama/anfitrionas/b5b75c40-3df4-4efc-a9c9-ed40804cf0e3/avatar/avatar_1774930281026.jpg	pachamama/anfitrionas/b5b75c40-3df4-4efc-a9c9-ed40804cf0e3/avatar/avatar_1774930281026	Soy sexy 😋	1	f	https://res.cloudinary.com/dai7rtja6/image/upload/v1774930282/pachamama/anfitrionas/b5b75c40-3df4-4efc-a9c9-ed40804cf0e3/cover/cover_1774930282504.jpg	pachamama/anfitrionas/b5b75c40-3df4-4efc-a9c9-ed40804cf0e3/cover/cover_1774930282504
b4d211fd-e802-4b4c-8bf8-c326fedf8010	b2b9ec93-8741-4fa9-be0c-18b84d7d6ade	2005-08-14 00:00:00	60128406	Stefania	pachamama/anfitrionas/b2b9ec93-8741-4fa9-be0c-18b84d7d6ade/identity/id_doc_1774943088462	pachamama/anfitrionas/b2b9ec93-8741-4fa9-be0c-18b84d7d6ade/identity/id_doc_1774943088462	2026-03-31 07:44:49.69	2026-03-31 07:44:49.69	\N	\N	\N	\N	f	\N	\N
bc7feebc-ebb0-4109-a89f-e661c241b148	6f9dd63d-2ffa-4634-a840-0617804df6b7	2003-08-13 00:00:00	62268762	Jimena2	pachamama/anfitrionas/6f9dd63d-2ffa-4634-a840-0617804df6b7/identity/id_doc_1775361145082	pachamama/anfitrionas/6f9dd63d-2ffa-4634-a840-0617804df6b7/identity/id_doc_1775361145082	2026-04-05 03:52:26.123	2026-04-06 22:14:53.847	https://res.cloudinary.com/dai7rtja6/image/upload/v1775419074/pachamama/anfitrionas/6f9dd63d-2ffa-4634-a840-0617804df6b7/avatar/avatar_1775419074362.jpg	pachamama/anfitrionas/6f9dd63d-2ffa-4634-a840-0617804df6b7/avatar/avatar_1775419074362	Sexy Atrevida	\N	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1775363264/pachamama/anfitrionas/6f9dd63d-2ffa-4634-a840-0617804df6b7/cover/cover_1775363263836.jpg	pachamama/anfitrionas/6f9dd63d-2ffa-4634-a840-0617804df6b7/cover/cover_1775363263836
b946a33e-2ba4-4526-82df-4b44026a7500	982f221b-fe45-496e-b958-70b8c4d0d2fc	2005-08-14 00:00:00	60128407	Stefania2	pachamama/anfitrionas/982f221b-fe45-496e-b958-70b8c4d0d2fc/identity/id_doc_1775013771360	pachamama/anfitrionas/982f221b-fe45-496e-b958-70b8c4d0d2fc/identity/id_doc_1775013771360	2026-04-01 03:22:52.591	2026-04-01 03:22:52.591	\N	\N	\N	\N	f	\N	\N
58c26008-8639-4374-aa26-8ca3f75856aa	cadca8ec-879f-4f06-9295-1a9731149965	1999-06-14 00:00:00	SOFI-1775271824839-5322	Sofi_luna	\N	\N	2026-04-04 03:03:45.077	2026-04-06 13:47:41.093	https://res.cloudinary.com/dai7rtja6/image/upload/v1774959182/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/avatar/avatar_1774959181981.png	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/avatar/avatar_1774959181981		5	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1774959184/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/cover/cover_1774959183776.png	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/cover/cover_1774959183776
858f43c5-4b7d-43a8-a79d-92732698fe31	6f5b20d3-fb68-475a-b304-7aa067456fe5	2007-01-06 00:00:00	32663959	Sarita	pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/identity/id_doc_1774925965702	pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/identity/id_doc_1774925965702	2026-03-31 02:59:26.984	2026-04-05 06:17:44.846	https://res.cloudinary.com/dai7rtja6/image/upload/v1774927377/pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/avatar/avatar_1774927376458.jpg	pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/avatar/avatar_1774927376458	😘Sexy Sabrosa Y Dulce🥰	1	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1774927377/pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/cover/cover_1774927377402.jpg	pachamama/anfitrionas/6f5b20d3-fb68-475a-b304-7aa067456fe5/cover/cover_1774927377402
9f1b2121-6ed7-48d1-a320-ea48c0f416db	bac87303-3c5f-4c06-aa9d-c2013ceeef53	1996-07-05 00:00:00	006845161	Luisa	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/identity/id_doc_1774958929924	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/identity/id_doc_1774958929924	2026-03-31 12:08:51.751	2026-04-27 19:01:57.639	https://res.cloudinary.com/dai7rtja6/image/upload/v1774959182/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/avatar/avatar_1774959181981.png	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/avatar/avatar_1774959181981	Sexy	1	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1775506908/pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/cover/cover_1775506907975.jpg	pachamama/anfitrionas/bac87303-3c5f-4c06-aa9d-c2013ceeef53/cover/cover_1775506907975
d8f29236-4a06-4ebb-a9f8-423876fe579b	5ee22644-5713-4342-b613-088344267c67	2003-08-11 00:00:00	111111112	Gordita linda	pachamama/anfitrionas/5ee22644-5713-4342-b613-088344267c67/identity/id_doc_1775410959469	pachamama/anfitrionas/5ee22644-5713-4342-b613-088344267c67/identity/id_doc_1775410959469	2026-04-05 17:42:40.877	2026-04-05 18:06:05.499	https://res.cloudinary.com/dai7rtja6/image/upload/v1775412364/pachamama/anfitrionas/5ee22644-5713-4342-b613-088344267c67/avatar/avatar_1775412363908.jpg	pachamama/anfitrionas/5ee22644-5713-4342-b613-088344267c67/avatar/avatar_1775412363908		\N	t	\N	\N
af0d09d6-891f-429e-b0d7-46cec713c93e	832aabaf-e4ec-4683-98aa-75eec4924379	2002-08-31 00:00:00	30443396	Ester	pachamama/anfitrionas/832aabaf-e4ec-4683-98aa-75eec4924379/identity/id_doc_1774926837923	pachamama/anfitrionas/832aabaf-e4ec-4683-98aa-75eec4924379/identity/id_doc_1774926837923	2026-03-31 03:13:58.92	2026-04-05 06:20:03.243	https://res.cloudinary.com/dai7rtja6/image/upload/v1774927164/pachamama/anfitrionas/832aabaf-e4ec-4683-98aa-75eec4924379/avatar/avatar_1774927163324.jpg	pachamama/anfitrionas/832aabaf-e4ec-4683-98aa-75eec4924379/avatar/avatar_1774927163324	🔥🔥	0	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1774927164/pachamama/anfitrionas/832aabaf-e4ec-4683-98aa-75eec4924379/cover/cover_1774927164422.jpg	pachamama/anfitrionas/832aabaf-e4ec-4683-98aa-75eec4924379/cover/cover_1774927164422
71b5cf85-eef6-43e5-a180-2c28ce937b54	6b72ce53-38fc-4334-b789-b75a4fe111d5	2007-09-15 00:00:00	60274611	Melany	pachamama/anfitrionas/6b72ce53-38fc-4334-b789-b75a4fe111d5/identity/id_doc_1775628203015	pachamama/anfitrionas/6b72ce53-38fc-4334-b789-b75a4fe111d5/identity/id_doc_1775628203015	2026-04-08 06:03:24.078	2026-04-08 06:03:24.078	\N	\N	\N	\N	f	\N	\N
a80ac954-23de-457a-bad5-4c843dea06dc	ebc57105-d551-4f37-b5fe-924e337de7aa	2000-05-12 00:00:00	12548636	Patricia prins	pachamama/anfitrionas/ebc57105-d551-4f37-b5fe-924e337de7aa/identity/id_doc_1775663623880	pachamama/anfitrionas/ebc57105-d551-4f37-b5fe-924e337de7aa/identity/id_doc_1775663623880	2026-04-08 15:53:45.262	2026-04-08 15:53:45.262	\N	\N	\N	\N	f	\N	\N
a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	6e276e63-0515-4855-95b6-f65ff85dbf24	2007-01-06 00:00:00	32663958	Sara2	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/identity/id_doc_1775373388455	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/identity/id_doc_1775373388455	2026-04-05 07:16:30.016	2026-04-05 07:21:25.854	https://res.cloudinary.com/dai7rtja6/image/upload/v1775373684/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/avatar/avatar_1775373683919.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/avatar/avatar_1775373683919	Sexy y Atrevida😈😻🥰	\N	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1775373685/pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/cover/cover_1775373685230.jpg	pachamama/anfitrionas/6e276e63-0515-4855-95b6-f65ff85dbf24/cover/cover_1775373685230
193e30f4-9096-42b0-9c56-b17bd59e1a19	7ce68788-0883-4d55-aef1-dc64dfe7e184	2000-05-11 00:00:00	11111111	Lola prins	\N	\N	2026-04-08 16:12:40.355	2026-04-08 16:12:40.355	\N	\N	\N	\N	f	\N	\N
6e72aec2-dff0-4b66-b031-99acde32af39	55818434-6bf8-4190-851d-96dae9acb2b1	2007-06-08 00:00:00	009147186	Nazareth	pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/identity/id_doc_1775365657066	pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/identity/id_doc_1775365657066	2026-04-05 05:07:39.043	2026-04-05 21:21:56.949	https://res.cloudinary.com/dai7rtja6/image/upload/v1775365846/pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/avatar/avatar_1775365845438.png	pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/avatar/avatar_1775365845438	Sedy	0	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1775424116/pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/cover/cover_1775424115994.jpg	pachamama/anfitrionas/55818434-6bf8-4190-851d-96dae9acb2b1/cover/cover_1775424115994
e3e902be-2a4f-4101-a2e5-0c9ea338f645	162560a3-6076-4e84-810d-4d0f94abe28b	2000-02-11 00:00:00	11111112	Estefani prins	pachamama/anfitrionas/162560a3-6076-4e84-810d-4d0f94abe28b/identity/id_doc_1775666641421	pachamama/anfitrionas/162560a3-6076-4e84-810d-4d0f94abe28b/identity/id_doc_1775666641421	2026-04-08 16:44:02.808	2026-04-08 16:44:02.808	\N	\N	\N	\N	f	\N	\N
7b114474-282a-4c81-9140-db8f1e51c4b9	1b22e452-ca71-4eed-81af-1839e08acae2	2000-05-11 00:00:00	11111113	Lola	pachamama/anfitrionas/1b22e452-ca71-4eed-81af-1839e08acae2/identity/id_doc_1775669115209	pachamama/anfitrionas/1b22e452-ca71-4eed-81af-1839e08acae2/identity/id_doc_1775669115209	2026-04-08 17:25:16.619	2026-04-08 17:25:16.619	\N	\N	\N	\N	f	\N	\N
b3f90486-5759-48f0-b9a1-4242b3b5899d	801e144e-1c66-4032-aaec-587d3db15034	2000-05-11 00:00:00	11111116	sofis	pachamama/anfitrionas/801e144e-1c66-4032-aaec-587d3db15034/identity/id_doc_1775669855938	pachamama/anfitrionas/801e144e-1c66-4032-aaec-587d3db15034/identity/id_doc_1775669855938	2026-04-08 17:37:37.677	2026-04-08 17:37:37.677	\N	\N	\N	\N	f	\N	\N
3eb6833f-c9ad-43ec-b27c-eee8111537df	fd8ab344-97a1-4130-ba7d-48903ff2978c	2000-05-12 00:00:00	25488248	Day anita prins	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--uHGz78BU--/v1/pachamama/anfitrionas/fd8ab344-97a1-4130-ba7d-48903ff2978c/identity/id_doc_1775672467394?_a=BAMAOGUs0	pachamama/anfitrionas/fd8ab344-97a1-4130-ba7d-48903ff2978c/identity/id_doc_1775672467394	2026-04-08 18:21:08.686	2026-04-08 18:21:08.686	\N	\N	\N	\N	f	\N	\N
39bc5a31-519c-42c5-a3ce-cb925d214647	ce3225ba-19c4-42d9-a94e-547708f6d44a	2007-11-11 00:00:00	61219680	Zully	pachamama/anfitrionas/ce3225ba-19c4-42d9-a94e-547708f6d44a/identity/id_doc_1775675771801	pachamama/anfitrionas/ce3225ba-19c4-42d9-a94e-547708f6d44a/identity/id_doc_1775675771801	2026-04-08 19:16:12.925	2026-04-08 19:16:12.925	\N	\N	\N	\N	f	\N	\N
f85cfe57-3831-4364-a865-f8dc297af74d	9ae2ae60-ae26-4a7b-910b-08bbfc38db30	2001-02-14 00:00:00	4223164246	camilita	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--ErWanikX--/v1/pachamama/anfitrionas/9ae2ae60-ae26-4a7b-910b-08bbfc38db30/identity/id_doc_1775710662201?_a=BAMAOGWQ0	pachamama/anfitrionas/9ae2ae60-ae26-4a7b-910b-08bbfc38db30/identity/id_doc_1775710662201	2026-04-09 04:57:43.285	2026-04-09 04:57:43.285	\N	\N	\N	\N	f	\N	\N
8ebe3560-3215-4b5d-8d00-040942f57465	850654ff-c2a8-4215-bc96-c0afdb615949	2007-09-16 00:00:00	60341708	Reyna	pachamama/anfitrionas/850654ff-c2a8-4215-bc96-c0afdb615949/identity/id_doc_1775509200988	pachamama/anfitrionas/850654ff-c2a8-4215-bc96-c0afdb615949/identity/id_doc_1775509200988	2026-04-06 21:00:02.495	2026-04-09 17:38:10.236	https://res.cloudinary.com/dai7rtja6/image/upload/v1775509519/pachamama/anfitrionas/850654ff-c2a8-4215-bc96-c0afdb615949/avatar/avatar_1775509519600.jpg	pachamama/anfitrionas/850654ff-c2a8-4215-bc96-c0afdb615949/avatar/avatar_1775509519600		\N	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1775509520/pachamama/anfitrionas/850654ff-c2a8-4215-bc96-c0afdb615949/cover/cover_1775509520625.jpg	pachamama/anfitrionas/850654ff-c2a8-4215-bc96-c0afdb615949/cover/cover_1775509520625
12f7b8d1-cf0c-47dd-a5db-6d36a02cb3d5	f334565b-4fa3-4c9a-9608-832f8c472aee	1996-05-15 00:00:00	933453022	Argelia	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--GNpKFhrT--/v1/pachamama/anfitrionas/f334565b-4fa3-4c9a-9608-832f8c472aee/identity/id_doc_1775769205599?_a=BAMAOGWQ0	pachamama/anfitrionas/f334565b-4fa3-4c9a-9608-832f8c472aee/identity/id_doc_1775769205599	2026-04-09 21:13:27.049	2026-04-09 21:25:38.09	https://res.cloudinary.com/dai7rtja6/image/upload/v1775769936/pachamama/anfitrionas/f334565b-4fa3-4c9a-9608-832f8c472aee/avatar/avatar_1775769936497.jpg	pachamama/anfitrionas/f334565b-4fa3-4c9a-9608-832f8c472aee/avatar/avatar_1775769936497	Sexy Y Adorable	\N	f	https://res.cloudinary.com/dai7rtja6/image/upload/v1775769937/pachamama/anfitrionas/f334565b-4fa3-4c9a-9608-832f8c472aee/cover/cover_1775769937494.jpg	pachamama/anfitrionas/f334565b-4fa3-4c9a-9608-832f8c472aee/cover/cover_1775769937494
6c85dc06-f2e9-4dc1-bcc5-6f2df559f290	dd0257c2-4f37-4b20-b336-b13494e0ba74	2004-10-27 00:00:00	31269981	Adonay	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--DiuZ4wb1--/v1/pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/identity/id_doc_1775867608060?_a=BAMAOGWQ0	pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/identity/id_doc_1775867608060	2026-04-11 00:33:29.104	2026-04-13 05:24:14.462	https://res.cloudinary.com/dai7rtja6/image/upload/v1775867710/pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/avatar/avatar_1775867709949.jpg	pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/avatar/avatar_1775867709949	Sexy	\N	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1775867711/pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/cover/cover_1775867710942.png	pachamama/anfitrionas/dd0257c2-4f37-4b20-b336-b13494e0ba74/cover/cover_1775867710942
7c050f65-3601-4ab3-8a6f-2279e4f01bf3	92491ea2-42e2-4803-81f2-c9856f9503c1	2005-04-26 00:00:00	77436007	mari tnt	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--l2-PqNJe--/v1/pachamama/anfitrionas/92491ea2-42e2-4803-81f2-c9856f9503c1/identity/id_doc_1775857395845?_a=BAMAOGWQ0	pachamama/anfitrionas/92491ea2-42e2-4803-81f2-c9856f9503c1/identity/id_doc_1775857395845	2026-04-10 21:43:17.442	2026-04-15 15:22:25.789	https://res.cloudinary.com/dai7rtja6/image/upload/v1776266269/pachamama/anfitrionas/92491ea2-42e2-4803-81f2-c9856f9503c1/avatar/avatar_1776266269121.jpg	pachamama/anfitrionas/92491ea2-42e2-4803-81f2-c9856f9503c1/avatar/avatar_1776266269121	Baby	\N	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1776266270/pachamama/anfitrionas/92491ea2-42e2-4803-81f2-c9856f9503c1/cover/cover_1776266269901.jpg	pachamama/anfitrionas/92491ea2-42e2-4803-81f2-c9856f9503c1/cover/cover_1776266269901
3d70c55e-5e40-489a-a5ff-bc5305ba79d6	6cd4c719-68fb-4e7c-8455-f7909ce58666	2006-10-14 00:00:00	13356122	niki_priv	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--KPv35QlX--/v1/pachamama/anfitrionas/6cd4c719-68fb-4e7c-8455-f7909ce58666/identity/id_doc_1776183673044?_a=BAMAOGWQ0	pachamama/anfitrionas/6cd4c719-68fb-4e7c-8455-f7909ce58666/identity/id_doc_1776183673044	2026-04-14 16:21:15.097	2026-04-15 15:26:38.036	https://res.cloudinary.com/dai7rtja6/image/upload/v1776266788/pachamama/anfitrionas/6cd4c719-68fb-4e7c-8455-f7909ce58666/avatar/avatar_1776266787943.jpg	pachamama/anfitrionas/6cd4c719-68fb-4e7c-8455-f7909ce58666/avatar/avatar_1776266787943	✨🔥Aquí Estoy Para Cumplir Todas Tus Fantasías 🥵🔥	\N	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1776266789/pachamama/anfitrionas/6cd4c719-68fb-4e7c-8455-f7909ce58666/cover/cover_1776266789004.jpg	pachamama/anfitrionas/6cd4c719-68fb-4e7c-8455-f7909ce58666/cover/cover_1776266789004
14d60256-7031-4feb-8862-52f9a530346b	fdd45029-8e81-4f0c-81a5-e58cbebd0385	2005-01-05 00:00:00	12345678	cintia prins	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--acfuYEeC--/v1/pachamama/anfitrionas/fdd45029-8e81-4f0c-81a5-e58cbebd0385/identity/id_doc_1776997220906?_a=BAMAOGUs0	pachamama/anfitrionas/fdd45029-8e81-4f0c-81a5-e58cbebd0385/identity/id_doc_1776997220906	2026-04-24 02:20:21.98	2026-04-24 02:20:21.98	\N	\N	\N	\N	f	\N	\N
89021f50-7097-4ed7-ba0d-29de9acfb743	81a45612-532a-459c-890c-55d6d3391455	1998-05-24 00:00:00	27578649	andreaG	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--JNwP_PSU--/v1/pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/identity/id_doc_1777705634128?_a=BAMAOGX00	pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/identity/id_doc_1777705634128	2026-05-02 07:07:15.519	2026-05-16 05:04:06.924	https://res.cloudinary.com/dai7rtja6/image/upload/v1777711641/pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/avatar/avatar_1777711640799.jpg	pachamama/anfitrionas/81a45612-532a-459c-890c-55d6d3391455/avatar/avatar_1777711640799		\N	t	\N	\N
206fc757-97fd-4e31-81fd-8e68b7733d95	b41ef399-b937-4fd5-b26c-258d14a5845a	2006-06-23 00:00:00	31523390	camila_reina	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--z86A9Wkj--/v1/pachamama/anfitrionas/b41ef399-b937-4fd5-b26c-258d14a5845a/identity/id_doc_1777876898909?_a=BAMAOGX00	pachamama/anfitrionas/b41ef399-b937-4fd5-b26c-258d14a5845a/identity/id_doc_1777876898909	2026-05-04 06:41:40.339	2026-05-04 06:48:29.186	https://res.cloudinary.com/dai7rtja6/image/upload/v1777877203/pachamama/anfitrionas/b41ef399-b937-4fd5-b26c-258d14a5845a/avatar/avatar_1777877202437.jpg	pachamama/anfitrionas/b41ef399-b937-4fd5-b26c-258d14a5845a/avatar/avatar_1777877202437	Soy Divertida Jueguetona Y Muy Amable🥰😇	\N	f	https://res.cloudinary.com/dai7rtja6/image/upload/v1777877203/pachamama/anfitrionas/b41ef399-b937-4fd5-b26c-258d14a5845a/cover/cover_1777877203715.jpg	pachamama/anfitrionas/b41ef399-b937-4fd5-b26c-258d14a5845a/cover/cover_1777877203715
493b6556-86fc-4da4-b036-141bf92c1c10	296837fd-6a53-4694-9b6c-20465408e9cd	2007-11-08 00:00:00	61221516	Kuray	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--o4kDIeGe--/v1/pachamama/anfitrionas/296837fd-6a53-4694-9b6c-20465408e9cd/identity/id_doc_1777829996971?_a=BAMAOGX00	pachamama/anfitrionas/296837fd-6a53-4694-9b6c-20465408e9cd/identity/id_doc_1777829996971	2026-05-03 17:39:58.515	2026-05-04 16:13:51.526	https://res.cloudinary.com/dai7rtja6/image/upload/v1777903833/pachamama/anfitrionas/296837fd-6a53-4694-9b6c-20465408e9cd/avatar/avatar_1777903832920.jpg	pachamama/anfitrionas/296837fd-6a53-4694-9b6c-20465408e9cd/avatar/avatar_1777903832920	Vamos, Quiero Conocerte 😈	\N	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1777903834/pachamama/anfitrionas/296837fd-6a53-4694-9b6c-20465408e9cd/cover/cover_1777903834113.jpg	pachamama/anfitrionas/296837fd-6a53-4694-9b6c-20465408e9cd/cover/cover_1777903834113
e946a82f-8828-4377-a16c-014500fc5fa9	261efc59-4ced-447c-80d4-1070eada2618	2000-05-16 00:00:00	16402	princes	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--uEU1Jk50--/v1/pachamama/anfitrionas/261efc59-4ced-447c-80d4-1070eada2618/identity/id_doc_1779468120810?_a=BAMAOGTI0	pachamama/anfitrionas/261efc59-4ced-447c-80d4-1070eada2618/identity/id_doc_1779468120810	2026-05-22 16:42:02.192	2026-05-22 16:42:02.192	\N	\N	\N	\N	f	\N	\N
1be77621-2065-4cb7-a867-e991f8f167a8	b8f63138-a5ba-4b5c-b25c-ffd88ec1386b	2000-01-01 00:00:00	15973546	pruebas12	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--TCrla7rw--/v1/pachamama/anfitrionas/b8f63138-a5ba-4b5c-b25c-ffd88ec1386b/identity/id_doc_1779468953362?_a=BAMAOGTI0	pachamama/anfitrionas/b8f63138-a5ba-4b5c-b25c-ffd88ec1386b/identity/id_doc_1779468953362	2026-05-22 16:55:55.018	2026-05-22 16:55:55.018	\N	\N	\N	\N	f	\N	\N
817ecfe3-ded9-4d57-99b7-7cde8bf89885	11f7cff7-cc4e-4973-b09c-b415f8a4393f	2005-07-11 00:00:00	61186491	olkpriv	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--P9OYfneF--/v1/pachamama/anfitrionas/11f7cff7-cc4e-4973-b09c-b415f8a4393f/identity/id_doc_1778377815258?_a=BAMAOGX00	pachamama/anfitrionas/11f7cff7-cc4e-4973-b09c-b415f8a4393f/identity/id_doc_1778377815258	2026-05-10 01:50:16.499	2026-05-10 19:04:27.237	\N	\N	\N	\N	t	\N	\N
251daae3-0255-4334-a530-b02a59a578d3	16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c	1995-06-15 00:00:00	00000001	ana_torres	\N	\N	2026-05-11 20:23:55.539	2026-05-11 20:27:13.831	\N	\N	\N	\N	t	\N	\N
2e6bef9d-4934-4ce1-8ff8-0560e2dc048d	1808fc9e-a96d-4dc0-a466-3e5445ff8abd	1992-04-15 00:00:00	47018136	abril	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--atwPx_vm--/v1/pachamama/anfitrionas/1808fc9e-a96d-4dc0-a466-3e5445ff8abd/identity/id_doc_1778894805349?_a=BAMAOGX00	pachamama/anfitrionas/1808fc9e-a96d-4dc0-a466-3e5445ff8abd/identity/id_doc_1778894805349	2026-05-16 01:26:47.657	2026-05-16 05:33:48.227	https://res.cloudinary.com/dai7rtja6/image/upload/v1778896250/pachamama/anfitrionas/1808fc9e-a96d-4dc0-a466-3e5445ff8abd/avatar/avatar_1778896250162.jpg	pachamama/anfitrionas/1808fc9e-a96d-4dc0-a466-3e5445ff8abd/avatar/avatar_1778896250162	Me Gustan Los Regalos Comprar Soy Aries Apasionada Traviesa Si Me Engries TE Engrio	\N	f	https://res.cloudinary.com/dai7rtja6/image/upload/v1778895239/pachamama/anfitrionas/1808fc9e-a96d-4dc0-a466-3e5445ff8abd/cover/cover_1778895239105.jpg	pachamama/anfitrionas/1808fc9e-a96d-4dc0-a466-3e5445ff8abd/cover/cover_1778895239105
c7cc225e-3a86-4a63-b72c-c352cea9d0af	8a3bb928-b6e1-4334-a038-55d49c49d7ce	1990-01-08 00:00:00	46236942	Brier	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--3iU7eXdN--/v1/pachamama/anfitrionas/8a3bb928-b6e1-4334-a038-55d49c49d7ce/identity/id_doc_1780181056497?_a=BAMAOGZY0	pachamama/anfitrionas/8a3bb928-b6e1-4334-a038-55d49c49d7ce/identity/id_doc_1780181056497	2026-05-30 22:44:18.091	2026-05-30 22:44:18.091	\N	\N	\N	\N	f	\N	\N
c6d9c2b3-33f0-49d1-8141-53412af072f8	b3e7b293-ecbb-4ebc-a5bd-97d820611660	2005-05-05 00:00:00	55555555	marlene princs	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--hHcQwZtR--/v1/pachamama/anfitrionas/b3e7b293-ecbb-4ebc-a5bd-97d820611660/identity/id_doc_1781655142983?_a=BAMAOGUs0	pachamama/anfitrionas/b3e7b293-ecbb-4ebc-a5bd-97d820611660/identity/id_doc_1781655142983	2026-06-17 00:12:24.668	2026-06-17 00:12:24.668	\N	\N	\N	\N	f	\N	\N
793eff2c-99ec-4316-bbf5-3149af1487b8	b827b865-dde5-4384-9b10-cd7f858c4d0f	2003-10-20 00:00:00	79534258	Gonsalez	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--9ueZGht7--/v1/pachamama/anfitrionas/b827b865-dde5-4384-9b10-cd7f858c4d0f/identity/id_doc_1780553551719?_a=BAMAOGZY0	pachamama/anfitrionas/b827b865-dde5-4384-9b10-cd7f858c4d0f/identity/id_doc_1780553551719	2026-06-04 06:12:33.319	2026-06-05 22:17:25.628	https://res.cloudinary.com/dai7rtja6/image/upload/v1780553730/pachamama/anfitrionas/b827b865-dde5-4384-9b10-cd7f858c4d0f/avatar/avatar_1780553729580.jpg	pachamama/anfitrionas/b827b865-dde5-4384-9b10-cd7f858c4d0f/avatar/avatar_1780553729580		\N	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1780553731/pachamama/anfitrionas/b827b865-dde5-4384-9b10-cd7f858c4d0f/cover/cover_1780553731004.jpg	pachamama/anfitrionas/b827b865-dde5-4384-9b10-cd7f858c4d0f/cover/cover_1780553731004
bfb9913f-53e4-4986-ac08-edbd5e9b2c4c	07756b0f-e984-4beb-9fdd-1f03b3f9b811	2006-11-18 00:00:00	60880856	Cory_princ	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--pZP1YCGL--/v1/pachamama/anfitrionas/07756b0f-e984-4beb-9fdd-1f03b3f9b811/identity/id_doc_1781062561574?_a=BAMAOGZY0	pachamama/anfitrionas/07756b0f-e984-4beb-9fdd-1f03b3f9b811/identity/id_doc_1781062561574	2026-06-10 03:36:02.979	2026-06-11 05:59:03.16	https://res.cloudinary.com/dai7rtja6/image/upload/v1781063014/pachamama/anfitrionas/07756b0f-e984-4beb-9fdd-1f03b3f9b811/avatar/avatar_1781063014530.jpg	pachamama/anfitrionas/07756b0f-e984-4beb-9fdd-1f03b3f9b811/avatar/avatar_1781063014530	☺️👑	\N	t	\N	\N
35aeee52-f8e2-4448-9e6c-e05f72d9807d	50953781-3741-4d74-82a3-e6f009e9b033	2005-05-05 00:00:00	12345679	micaela princ	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--_1yso4rc--/v1/pachamama/anfitrionas/50953781-3741-4d74-82a3-e6f009e9b033/identity/id_doc_1781645643393?_a=BAMAOGUs0	pachamama/anfitrionas/50953781-3741-4d74-82a3-e6f009e9b033/identity/id_doc_1781645643393	2026-06-16 21:34:04.897	2026-06-16 21:34:04.897	\N	\N	\N	\N	f	\N	\N
8382db93-444d-41ab-b4e0-b3f6fc0ab632	1e726e4e-83df-4f9f-b369-0d4e9e9d3b81	2005-06-07 00:00:00	14112040	Saasita princesa	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--8e3z6VYs--/v1/pachamama/anfitrionas/1e726e4e-83df-4f9f-b369-0d4e9e9d3b81/identity/id_doc_1781646548048?_a=BAMAOGUs0	pachamama/anfitrionas/1e726e4e-83df-4f9f-b369-0d4e9e9d3b81/identity/id_doc_1781646548048	2026-06-16 21:49:09.806	2026-06-16 21:49:09.806	\N	\N	\N	\N	f	\N	\N
9dc5c218-af6e-4d98-b439-4112dd84b8a8	aa134fd6-6b30-4b19-844c-73d700d6800d	2005-05-05 00:00:00	68686554	mica	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--f9cvFhEW--/v1/pachamama/anfitrionas/aa134fd6-6b30-4b19-844c-73d700d6800d/identity/id_doc_1781655392318?_a=BAMAOGUs0	pachamama/anfitrionas/aa134fd6-6b30-4b19-844c-73d700d6800d/identity/id_doc_1781655392318	2026-06-17 00:16:34.277	2026-06-17 00:18:02.124	\N	\N	\N	\N	f	\N	\N
ed02018e-b3b8-43de-871b-2de61ec1d8c2	74b016d6-a584-47a6-b95b-c754b24f07b1	1986-08-23 00:00:00	16825876	pedro	\N	\N	2026-06-25 03:42:51.14	2026-06-25 03:42:51.14	\N	\N	\N	\N	f	\N	\N
ff990cd5-2c90-4eb6-b791-1df919079baf	9900429a-7d71-4fb3-8919-a5e2bb7e1460	2005-05-05 00:00:00	68534568	Lucía princsss	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--0oJqQAUu--/v1/pachamama/anfitrionas/9900429a-7d71-4fb3-8919-a5e2bb7e1460/identity/id_doc_1781656089929?_a=BAMAOGUs0	pachamama/anfitrionas/9900429a-7d71-4fb3-8919-a5e2bb7e1460/identity/id_doc_1781656089929	2026-06-17 00:28:11.58	2026-07-07 03:01:53.954	https://res.cloudinary.com/dai7rtja6/image/upload/v1783393304/pachamama/anfitrionas/9900429a-7d71-4fb3-8919-a5e2bb7e1460/avatar/avatar_1783393311671.jpg	pachamama/anfitrionas/9900429a-7d71-4fb3-8919-a5e2bb7e1460/avatar/avatar_1783393311671		\N	f	https://res.cloudinary.com/dai7rtja6/image/upload/v1783393304/pachamama/anfitrionas/9900429a-7d71-4fb3-8919-a5e2bb7e1460/cover/cover_1783393312780.jpg	pachamama/anfitrionas/9900429a-7d71-4fb3-8919-a5e2bb7e1460/cover/cover_1783393312780
d18fe091-2452-4bba-85a7-1aa973e199ba	3c1870c9-d5d5-4c25-8c49-8a2d2fc6fcc9	1996-07-15 00:00:00	12543625	Angelica_P	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--oDNd3xCm--/v1/pachamama/anfitrionas/3c1870c9-d5d5-4c25-8c49-8a2d2fc6fcc9/identity/id_doc_1784157494100?_a=BAMAOGcg0	pachamama/anfitrionas/3c1870c9-d5d5-4c25-8c49-8a2d2fc6fcc9/identity/id_doc_1784157494100	2026-07-15 23:18:15.275	2026-07-15 23:18:15.275	\N	\N	\N	\N	f	\N	\N
1d9fb2e9-90a5-4154-aa1f-8b823309554c	fa82f190-e133-460e-a800-145362c903a5	2005-05-10 00:00:00	65342794	satsi	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--YiMTow4v--/v1/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/identity/id_doc_1783395080241?_a=BAMAOGUs0	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/identity/id_doc_1783395080241	2026-07-07 03:31:21.68	2026-07-16 04:04:59.914	https://res.cloudinary.com/dai7rtja6/image/upload/v1783473667/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/avatar/avatar_1783473677214.jpg	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/avatar/avatar_1783473677214		\N	t	https://res.cloudinary.com/dai7rtja6/image/upload/v1783473668/pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/cover/cover_1783473679099.jpg	pachamama/anfitrionas/fa82f190-e133-460e-a800-145362c903a5/cover/cover_1783473679099
d4e97725-b786-488c-ba76-09e80afced1a	8c116257-5c9a-44ab-9ed1-f5412bf989f8	2006-05-20 00:00:00	60029961	Elizabeth.L	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--4TXat_4d--/v1/pachamama/anfitrionas/8c116257-5c9a-44ab-9ed1-f5412bf989f8/identity/id_doc_1784181246353?_a=BAMAOGcg0	pachamama/anfitrionas/8c116257-5c9a-44ab-9ed1-f5412bf989f8/identity/id_doc_1784181246353	2026-07-16 05:54:07.515	2026-07-16 06:06:27.899	https://res.cloudinary.com/dai7rtja6/image/upload/v1784181987/pachamama/anfitrionas/8c116257-5c9a-44ab-9ed1-f5412bf989f8/avatar/avatar_1784181986478.png	pachamama/anfitrionas/8c116257-5c9a-44ab-9ed1-f5412bf989f8/avatar/avatar_1784181986478	La mezcla perfecta entre un secreto prohibido y una tentación irresistible	\N	f	\N	\N
a1c9542f-aee8-44be-b313-627df56c5c8e	05c0a4ac-fe39-4689-90aa-c01f80b77da4	2008-01-22 00:00:00	60595158	Rosi	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--wTHCpPnD--/v1/pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/identity/id_doc_1784178086449?_a=BAMAOGcg0	pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/identity/id_doc_1784178086449	2026-07-16 05:01:27.642	2026-07-16 05:28:51.85	https://res.cloudinary.com/dai7rtja6/image/upload/v1784178307/pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/avatar/avatar_1784178306755.jpg	pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/avatar/avatar_1784178306755	Tu Bby🙈	\N	f	https://res.cloudinary.com/dai7rtja6/image/upload/v1784178307/pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/cover/cover_1784178307712.jpg	pachamama/anfitrionas/05c0a4ac-fe39-4689-90aa-c01f80b77da4/cover/cover_1784178307712
7a3e2e94-7fbb-4360-89b4-8e6db6dbc9ab	3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf	2000-01-01 00:00:00	13356914	camila_princesa	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--dFobTYwo--/v1/pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/identity/id_doc_1784597216855?_a=BAMAOGTI0	pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/identity/id_doc_1784597216855	2026-07-21 01:27:01.445	2026-07-21 01:28:28.566	https://res.cloudinary.com/dai7rtja6/image/upload/v1784597307/pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/avatar/avatar_1784597306168.png	pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/avatar/avatar_1784597306168	ME GUSTA	\N	f	https://res.cloudinary.com/dai7rtja6/image/upload/v1784597308/pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/cover/cover_1784597307659.png	pachamama/anfitrionas/3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf/cover/cover_1784597307659
c3ba27e9-fd39-4bea-9726-c15793901cef	20553dc3-047d-46f2-9ed3-c7419554a002	2000-09-26 00:00:00	76526170	kat2000katt@gmail.com	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--_bvex5Nn--/v1/pachamama/anfitrionas/20553dc3-047d-46f2-9ed3-c7419554a002/identity/id_doc_1784181343303?_a=BAMAOGcg0	pachamama/anfitrionas/20553dc3-047d-46f2-9ed3-c7419554a002/identity/id_doc_1784181343303	2026-07-16 05:55:44.647	2026-07-16 06:04:21.32	https://res.cloudinary.com/dai7rtja6/image/upload/v1784181566/pachamama/anfitrionas/20553dc3-047d-46f2-9ed3-c7419554a002/avatar/avatar_1784181566083.jpg	pachamama/anfitrionas/20553dc3-047d-46f2-9ed3-c7419554a002/avatar/avatar_1784181566083	Hola Soy Guapa Mido 1.50, Soy Super Carismática, Chevere, Risueña, Tomo Mucha Seriedad Ante Todo Con Mi trabajo	\N	f	https://res.cloudinary.com/dai7rtja6/image/upload/v1784181860/pachamama/anfitrionas/20553dc3-047d-46f2-9ed3-c7419554a002/cover/cover_1784181859867.jpg	pachamama/anfitrionas/20553dc3-047d-46f2-9ed3-c7419554a002/cover/cover_1784181859867
5fb8e812-e0fa-4efb-acb4-5b4ef417d775	1b001974-feef-4faf-8237-45118c83847f	2001-01-10 00:00:00	0321548	asdas	https://res.cloudinary.com/dai7rtja6/image/authenticated/s--s4mmz1rP--/v1/pachamama/anfitrionas/1b001974-feef-4faf-8237-45118c83847f/identity/id_doc_1784599492592?_a=BAMAOGcg0	pachamama/anfitrionas/1b001974-feef-4faf-8237-45118c83847f/identity/id_doc_1784599492592	2026-07-21 02:04:53.746	2026-07-21 02:04:53.746	\N	\N	\N	\N	f	\N	\N
\.


--
-- Data for Name: anfitrione_subscriptions; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.anfitrione_subscriptions (id, "profileId", price, "isActive", "createdAt", "updatedAt") FROM stdin;
82615729-ff9a-4b2f-b36a-b1fec9c32d7d	58c26008-8639-4374-aa26-8ca3f75856aa	50	t	2026-04-07 00:29:22.149	2026-04-07 00:29:22.149
94a3bd6b-320f-48da-b516-ef1bcb53595c	71b5cf85-eef6-43e5-a180-2c28ce937b54	300	t	2026-04-08 06:05:13.57	2026-04-08 06:05:22.906
cae2f4d3-f954-4288-be85-a562e4d08c50	12f7b8d1-cf0c-47dd-a5db-6d36a02cb3d5	200	t	2026-04-09 21:24:26.087	2026-04-09 21:24:26.087
9faeee2f-0f4f-420b-a2e6-bb61688ac576	6c85dc06-f2e9-4dc1-bcc5-6f2df559f290	300	t	2026-04-11 00:33:59.439	2026-04-11 00:40:29.47
d5050469-c651-47f6-abd0-00f9c5409d56	5a46d608-6458-4ae5-ab32-afc0b456dd79	300	t	2026-04-11 02:07:54.749	2026-04-11 02:07:54.749
1215488f-3d4f-41a6-8d9e-2f236e126c24	6e72aec2-dff0-4b66-b031-99acde32af39	300	t	2026-04-11 02:54:10.966	2026-04-11 02:54:10.966
d603a6fb-ffbe-4e47-b070-eb8df3925abb	af0d09d6-891f-429e-b0d7-46cec713c93e	300	t	2026-04-08 19:51:36.809	2026-04-11 03:28:18.246
602b48a2-a31e-4a5e-af66-98082ecc4d3d	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	300	t	2026-04-11 04:01:05.519	2026-04-11 04:01:05.519
8c31cb69-d499-4f00-bb65-a8ef0ebe0dbc	3d70c55e-5e40-489a-a5ff-bc5305ba79d6	300	t	2026-04-15 15:29:24.287	2026-04-15 15:29:36.155
f5a30de9-f772-4648-bf58-ea7174711f3d	7c050f65-3601-4ab3-8a6f-2279e4f01bf3	80	t	2026-04-15 15:33:19.183	2026-04-15 15:33:43.853
898676a1-7746-4099-add0-20799ce6a481	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	60.6	t	2026-04-06 21:14:11.707	2026-04-26 03:20:41.878
bf63446f-0530-4a6f-bb93-45ee2d627ddf	89021f50-7097-4ed7-ba0d-29de9acfb743	300	t	2026-05-03 07:15:36.536	2026-05-03 07:15:36.536
8ab9028d-dd87-4014-9adf-80b5b831f700	206fc757-97fd-4e31-81fd-8e68b7733d95	300	t	2026-05-04 06:48:50.038	2026-05-04 06:48:50.038
6f7c58e6-45fe-4c4a-a974-a1c99a2504bc	493b6556-86fc-4da4-b036-141bf92c1c10	95	t	2026-05-03 17:41:42.345	2026-05-04 19:59:43.868
b8bf1617-e18b-42a7-9aa4-f2b7e9a08725	251daae3-0255-4334-a530-b02a59a578d3	50	t	2026-05-11 20:34:56.484	2026-05-11 20:34:56.484
0c378cc1-4bb1-4f46-8f66-5b779ac3117b	2e6bef9d-4934-4ce1-8ff8-0560e2dc048d	1000	t	2026-05-16 01:47:45.856	2026-05-16 03:48:33.276
82a4bcac-d903-4d09-ac2a-f1d9a38539fe	c7cc225e-3a86-4a63-b72c-c352cea9d0af	200	t	2026-05-30 23:01:41.585	2026-05-30 23:01:41.585
4bf27c03-0d84-4a28-8d83-f60b86765cbf	793eff2c-99ec-4316-bbf5-3149af1487b8	500	t	2026-06-04 06:16:27.481	2026-06-04 06:16:27.481
315688a7-60a0-4115-86ba-e4122c624a0e	ff990cd5-2c90-4eb6-b791-1df919079baf	200	t	2026-07-07 02:21:40.209	2026-07-07 02:21:40.209
9fbe7727-5f4b-4af7-9677-a140efd7d4ae	1d9fb2e9-90a5-4154-aa1f-8b823309554c	15	t	2026-07-08 01:16:14.608	2026-07-13 15:48:52.232
12f0839b-c1fe-4a30-b945-2b53466672f9	a1c9542f-aee8-44be-b313-627df56c5c8e	200	t	2026-07-16 05:25:19.512	2026-07-16 05:25:19.512
0ebe2b99-74e7-4a97-a423-cdac0cdefbc7	9f1b2121-6ed7-48d1-a320-ea48c0f416db	300	t	2026-04-08 09:40:21.564	2026-07-22 00:27:55.586
\.


--
-- Data for Name: bank_accounts; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.bank_accounts (id, "userId", "bankId", "anfitrionaProfileId", "accountNumber", "createdAt", "updatedAt", "accountHolderName", type, "paypalEmail") FROM stdin;
1	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	1	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	12345678901234	2026-03-26 14:09:51.306	2026-03-26 14:09:51.306	Aanfitriona1	BCP	\N
3	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	1	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	12345678901234	2026-03-26 14:09:51.306	2026-03-26 14:09:51.306	Aanfitriona1	BCP	\N
5	832aabaf-e4ec-4683-98aa-75eec4924379	1	af0d09d6-891f-429e-b0d7-46cec713c93e	55555	2026-04-05 08:43:18.195	2026-04-05 08:43:18.195	\N	BCP	\N
6	f334565b-4fa3-4c9a-9608-832f8c472aee	1	12f7b8d1-cf0c-47dd-a5db-6d36a02cb3d5	9498805	2026-04-09 21:28:51.303	2026-04-09 21:28:51.303	Argelia Pérez rojas	BCP	\N
7	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2	9f1b2121-6ed7-48d1-a320-ea48c0f416db	933453022	2026-04-09 21:38:43.873	2026-04-09 21:38:43.873	Argelia onrelala Pérez rojas	BCP	\N
8	cadca8ec-879f-4f06-9295-1a9731149965	\N	58c26008-8639-4374-aa26-8ca3f75856aa	19867361	2026-04-25 13:49:32.68	2026-04-25 13:49:32.68	Prueba de funcionalidad	BINANCE	\N
9	cadca8ec-879f-4f06-9295-1a9731149965	\N	58c26008-8639-4374-aa26-8ca3f75856aa	\N	2026-04-25 13:50:39.161	2026-04-25 13:50:39.161	Ejdue ckfk	PAYPAL	cristofervera120@gmail.com
10	cadca8ec-879f-4f06-9295-1a9731149965	\N	58c26008-8639-4374-aa26-8ca3f75856aa	49538634	2026-04-25 13:50:58.906	2026-04-25 13:50:58.906	Dbxididl	BYBIT	\N
11	16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c	\N	251daae3-0255-4334-a530-b02a59a578d3	465987613	2026-05-11 20:36:01.406	2026-05-11 20:36:01.406	Prueba1	BCP	\N
12	16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c	\N	251daae3-0255-4334-a530-b02a59a578d3	\N	2026-05-11 20:36:14.408	2026-05-11 20:36:14.408	Preuba2	PAYPAL	prueba@gmail.com
13	16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c	\N	251daae3-0255-4334-a530-b02a59a578d3	000001	2026-05-11 20:36:46.504	2026-05-11 20:36:46.504	Prueba3	BYBIT	\N
14	16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c	\N	251daae3-0255-4334-a530-b02a59a578d3	1108216518	2026-05-11 20:37:09.728	2026-05-11 20:37:09.728	Prueba4	BINANCE	\N
15	1808fc9e-a96d-4dc0-a466-3e5445ff8abd	\N	2e6bef9d-4934-4ce1-8ff8-0560e2dc048d	4557881800653299	2026-05-16 01:45:33.132	2026-05-16 01:45:33.132	Olga María glassi Benites rasmussen	BCP	\N
16	fa82f190-e133-460e-a800-145362c903a5	\N	1d9fb2e9-90a5-4154-aa1f-8b823309554c	4242424242424424	2026-07-11 03:11:08.689	2026-07-11 03:11:08.689	orbyx	BCP	\N
17	705bcf07-fd33-4f4d-a2c3-9fb8d2ab97c7	\N	0a354ef6-1664-4df0-82d6-bdaca769dd43	43242423432423	2026-07-13 02:31:56.063	2026-07-13 02:31:56.063	sdfsdfdsfsd	BYBIT	\N
18	05c0a4ac-fe39-4689-90aa-c01f80b77da4	\N	a1c9542f-aee8-44be-b313-627df56c5c8e	+51900759214	2026-07-16 05:33:18.679	2026-07-16 05:33:18.679	Luz cam.	BCP	\N
\.


--
-- Data for Name: binance_deposit_intents; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.binance_deposit_intents (id, "userId", "packageId", "packageName", "creditsToDeliver", network, coin, "walletAddress", "expectedAmount", "microDelta", txid, status, "failureReason", "binanceData", "expiresAt", "confirmedAt", "createdAt", "updatedAt") FROM stdin;
f65c691f-1d38-4443-b31b-c35428e0384d	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	test	4	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	1.00000000	0.00000000	Off-chain transfer 366050108714	CONFIRMED	\N	{"id": "5021437215290030337", "coin": "USDT", "txId": "Off-chain transfer 366050108714", "amount": "1", "status": 1, "address": "0x4284fa5d3028665261b30e517b9bddae4e54b5de", "network": "MATIC", "addressTag": "", "insertTime": 1777259381000, "walletType": 0, "completeTime": 1777259420000, "confirmTimes": "0/1", "transferType": 1, "unlockConfirm": 2, "travelRuleStatus": 0}	2026-04-27 13:29:50.317	2026-04-27 12:59:55.781	2026-04-27 12:59:50.317	2026-04-27 12:59:55.783
3a525721-afb7-4b27-b78f-d764599f890e	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	Paquete inicial 	10	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	2.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-04-27 18:18:33.103	\N	2026-04-27 17:48:33.105	2026-04-27 18:19:00.338
8b32655c-a71a-4a92-abb4-6fe57c7bff7f	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	test	4	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	1.00000000	0.00000000	\N	EXPIRED	\N	\N	2026-04-27 18:19:30.921	\N	2026-04-27 17:49:30.922	2026-04-27 18:20:00.035
08c6dee9-fc3f-4db6-aac8-babd4c5a4a42	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	Paquete inicial 	10	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	2.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-04-27 19:35:31.226	\N	2026-04-27 19:05:31.226	2026-04-27 19:36:00.022
69379424-a828-4856-88cb-3fbb3a11e2da	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	Paquete inicial 	10	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	2.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-04-28 10:25:07.818	\N	2026-04-28 09:55:07.819	2026-04-28 10:26:00.026
28560662-befc-4fd0-87eb-3f89cf668285	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	Paquete inicial 	10	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	2.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-04-28 11:09:07.623	\N	2026-04-28 10:39:07.623	2026-04-28 11:10:00.028
8cf2246e-9160-4f75-9367-7ae0a927026e	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	Paquete inicial 	10	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	2.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-04-28 20:02:59.122	\N	2026-04-28 19:32:59.123	2026-04-28 20:03:00.053
41a8982e-e9a7-4851-a1bc-90479f069298	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	Paquete inicial 	10	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	2.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-04-29 09:04:54.064	\N	2026-04-29 08:34:54.068	2026-04-29 09:05:00.017
a35a5896-9bcf-4c06-9b1a-016fc491d086	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	e39aeeca-aabf-40b6-aac4-429348919a92	Otoño	30	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	7.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-04-30 00:34:18.497	\N	2026-04-30 00:04:18.5	2026-04-30 00:35:00.03
e06e950c-483d-4e05-bf62-6e2120e17f28	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	41fd4605-896e-4e63-a37d-df4b58d90f6f	Bronce	50	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	12.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-04-30 00:34:42.564	\N	2026-04-30 00:04:42.565	2026-04-30 00:35:00.03
7ae20949-1ea7-4fc9-9d05-892c7db5ad70	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	Paquete inicial 	10	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	2.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-04-30 07:07:37.978	\N	2026-04-30 06:37:37.979	2026-04-30 07:08:00.019
287de60f-5051-4377-b9e9-b1193f9f7d8f	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	Paquete inicial 	10	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	2.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-05-01 04:51:57.182	\N	2026-05-01 04:21:57.191	2026-05-01 04:52:00.035
d48c0377-f437-4415-a29c-b9e5a9b99170	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	Navidad	500	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	125.00000000	0.00000000	\N	EXPIRED	\N	\N	2026-05-01 13:56:15.444	\N	2026-05-01 13:26:15.45	2026-05-01 13:57:00.035
7ff7d7db-eba8-482b-8d31-7c8ae0b660b6	ed917127-6f95-432e-aed5-7c4a8cf4157f	e39aeeca-aabf-40b6-aac4-429348919a92	Otoño	30	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	7.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-05-02 06:00:14.281	\N	2026-05-02 05:30:14.282	2026-05-02 06:01:00.04
9e0e14b4-24e5-439a-858e-c8d96c18d46c	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	671670da-aa08-41f2-9fdc-fe408630cebe	Paquete inicial 	10	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	2.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-05-08 02:04:07.643	\N	2026-05-08 01:34:07.65	2026-05-08 02:05:00.044
c041b04a-a4de-485b-ae1e-621e5d40a3ac	a8c3a75d-a86c-499e-9636-de4a14cdad5c	671670da-aa08-41f2-9fdc-fe408630cebe	Paquete inicial 	10	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	2.50000000	0.00000000	\N	EXPIRED	\N	\N	2026-05-27 20:16:28.642	\N	2026-05-27 19:46:28.644	2026-05-27 20:17:00.036
37be6a24-751b-466e-b84f-f3c9ff083f0d	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	Navidad	500	TRX	USDT	TR2PBjZHaGJh2emj5ZBeiqmc45gcLpQZdb	125.00000000	0.00000000	\N	EXPIRED	\N	\N	2026-07-13 00:17:58.635	\N	2026-07-12 23:47:58.638	2026-07-13 00:18:00.04
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.conversations (id, "user1Id", "user2Id", "createdAt", "updatedAt") FROM stdin;
6c598a87-2e45-423c-b069-8391acce9231	304884e0-e87c-44b3-a135-525fcc3b24d6	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	2026-03-22 10:36:22.897	2026-03-22 10:36:22.897
76266860-ec1c-496e-bed9-dc6da0f51e0c	bac87303-3c5f-4c06-aa9d-c2013ceeef53	ed917127-6f95-432e-aed5-7c4a8cf4157f	2026-03-31 12:17:17.315	2026-03-31 12:17:17.315
7bb9533c-87a4-4306-a9aa-012b4e996747	5893d81a-370d-46e6-8783-926054e7c5d7	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	2026-03-31 19:31:22.672	2026-03-31 19:31:22.672
3a9b894d-918d-4eba-a9d4-278c8c2e762b	2e0740ed-8b4b-4f38-8c94-25812aff3cdf	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-03-31 20:29:54.636	2026-03-31 20:29:54.636
7befe41e-61b6-43c0-b500-a03ef1052faf	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	2026-04-02 04:34:10.255	2026-04-02 04:34:10.255
3f53622e-fba6-49c2-afb9-2d2eacf4e765	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-02 04:35:35.624	2026-04-02 04:35:35.624
51443e91-7b91-4053-bd1d-0b1f9487f941	2e0740ed-8b4b-4f38-8c94-25812aff3cdf	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-03 00:32:28.422	2026-04-03 00:32:28.422
fbceb03d-767a-44ba-8a68-36df82b065c1	2e0740ed-8b4b-4f38-8c94-25812aff3cdf	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	2026-04-03 02:39:16.28	2026-04-03 02:39:16.28
7466c052-5ab7-43cf-ae43-f34965190c33	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	4e7e7405-7841-436d-a277-55b2d8c4299e	2026-04-04 01:27:47.462	2026-04-04 01:27:47.462
8cddfebf-94c6-45bd-9b3b-7350fd3f9fa3	4e7e7405-7841-436d-a277-55b2d8c4299e	cadca8ec-879f-4f06-9295-1a9731149965	2026-04-04 03:11:23.676	2026-04-04 03:11:23.676
c3e84a80-4ec9-4d18-b215-902ab23fed1b	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	cadca8ec-879f-4f06-9295-1a9731149965	2026-04-04 13:02:17.432	2026-04-04 13:02:17.432
1c5cc341-204f-4925-943e-32f2c6f9155c	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	2026-04-04 14:30:33.696	2026-04-04 14:30:33.696
f6729ee5-5dfc-4ebb-bace-dbc839bb4f25	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	b6e54a63-4b05-46e5-8586-5f307f47006b	2026-04-04 20:51:43.166	2026-04-04 20:51:43.166
56e8724f-196b-49bd-944e-7dfc356c6554	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	2026-04-04 22:00:27.784	2026-04-04 22:00:27.784
d3a8bcbf-bf72-42f7-b3bf-c2592fa3b231	6f5b20d3-fb68-475a-b304-7aa067456fe5	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	2026-04-05 00:01:07.735	2026-04-05 00:01:07.735
046b0a8d-b757-40d4-a869-1fca9df5ec96	304884e0-e87c-44b3-a135-525fcc3b24d6	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-05 00:07:48.574	2026-04-05 00:07:48.574
ddd13620-9fe7-4dcf-88d9-0028f759b5a4	304884e0-e87c-44b3-a135-525fcc3b24d6	6f5b20d3-fb68-475a-b304-7aa067456fe5	2026-04-05 00:10:19.734	2026-04-05 00:10:19.734
15ebb5bb-2d93-481c-a7a4-026f5f05a65e	2e0740ed-8b4b-4f38-8c94-25812aff3cdf	cadca8ec-879f-4f06-9295-1a9731149965	2026-04-05 02:53:05.596	2026-04-05 02:53:05.596
7864812c-1142-421b-99fd-c6b368abfd5f	2e0740ed-8b4b-4f38-8c94-25812aff3cdf	6f9dd63d-2ffa-4634-a840-0617804df6b7	2026-04-05 04:00:41.912	2026-04-05 04:00:41.912
65109bb3-5652-4662-934f-4e09d05697d7	832aabaf-e4ec-4683-98aa-75eec4924379	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	2026-04-05 04:53:45.138	2026-04-05 04:53:45.138
35fd4080-97dd-4746-b89f-4eec0541f74e	6f9dd63d-2ffa-4634-a840-0617804df6b7	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	2026-04-05 04:54:05.409	2026-04-05 04:54:05.409
574802cd-1d23-433d-9cba-2b42b2e8349c	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-04-05 04:54:26.514	2026-04-05 04:54:26.514
76ff0bcf-3fbe-4b80-8b1d-726bbb501b1b	6f5b20d3-fb68-475a-b304-7aa067456fe5	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	2026-04-05 05:12:19.822	2026-04-05 05:12:19.822
c90addf0-b784-41a8-82d3-e0d192df2dfb	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	b5b75c40-3df4-4efc-a9c9-ed40804cf0e3	2026-04-05 05:13:41.138	2026-04-05 05:13:41.138
bdc6fa45-401d-4c5a-82e5-1c28b5945cc7	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	cadca8ec-879f-4f06-9295-1a9731149965	2026-04-05 05:19:14.449	2026-04-05 05:19:14.449
ce30ec25-170a-4996-b09c-b541758d01c1	6e276e63-0515-4855-95b6-f65ff85dbf24	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	2026-04-05 07:39:51.968	2026-04-05 07:39:51.968
f1ddf428-b8e7-4b21-b5e9-36932bf51145	599864fe-f89b-4445-8b25-7da50697043b	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-04-05 16:06:06.789	2026-04-05 16:06:06.789
de2adff4-840f-417a-bb2e-f71da5913dc6	42da48c6-0a1b-4783-98e6-8457d0fc8f7d	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-04-05 20:52:38.35	2026-04-05 20:52:38.35
f759f814-af89-4e6b-bae1-21848335b468	197e5a03-33be-498e-bf56-3943cdcebaac	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-06 05:54:11.56	2026-04-06 05:54:11.56
c949fd1d-b0c0-4f67-97c6-9f6a69ff26a7	5b861f19-1c5a-47c6-a9a1-b4fc35eda3c6	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-06 06:55:13.863	2026-04-06 06:55:13.863
67aae1f4-54a2-44cc-b315-5f271a006af3	5b861f19-1c5a-47c6-a9a1-b4fc35eda3c6	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-06 07:02:13.484	2026-04-06 07:02:13.484
53dd0aa1-f095-43af-8e7a-a8cd9ea3eda9	6f9dd63d-2ffa-4634-a840-0617804df6b7	867a333a-9f97-4133-8a15-ba350f41a16f	2026-04-06 10:04:39.8	2026-04-06 10:04:39.8
572bdbbc-14f4-44d7-b51b-f35080b1e381	6f9dd63d-2ffa-4634-a840-0617804df6b7	fe63bb9a-4219-4da1-bf8f-c52412f6e801	2026-04-06 13:09:58.448	2026-04-06 13:09:58.448
28e8c8cc-c099-493a-9f7b-0409cfac84f1	bac87303-3c5f-4c06-aa9d-c2013ceeef53	fe63bb9a-4219-4da1-bf8f-c52412f6e801	2026-04-06 13:10:15.926	2026-04-06 13:10:15.926
024e1add-00a8-4735-a057-f3d84569210b	6e276e63-0515-4855-95b6-f65ff85dbf24	e4264309-988e-468b-9f8b-868b750e973b	2026-04-06 14:42:37.794	2026-04-06 14:42:37.794
4e882d21-4411-4f1a-a4ed-df4995eb5412	cadca8ec-879f-4f06-9295-1a9731149965	dec3b28d-030e-49f1-af9b-441d3188a3a7	2026-04-06 15:34:26.159	2026-04-06 15:34:26.159
40e07baa-9439-4df8-a596-4b33c5196c1b	832aabaf-e4ec-4683-98aa-75eec4924379	867a333a-9f97-4133-8a15-ba350f41a16f	2026-04-06 18:24:30.626	2026-04-06 18:24:30.626
645d3f0b-5a06-4caa-881e-b4785197a8fb	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	867a333a-9f97-4133-8a15-ba350f41a16f	2026-04-06 18:25:11.758	2026-04-06 18:25:11.758
3ad5d755-05fb-4c58-acf9-6a3de9c59092	867a333a-9f97-4133-8a15-ba350f41a16f	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-06 18:25:26.339	2026-04-06 18:25:26.339
517ede0d-7bca-4853-9e90-da558e0877fa	867a333a-9f97-4133-8a15-ba350f41a16f	b5b75c40-3df4-4efc-a9c9-ed40804cf0e3	2026-04-06 18:26:37.353	2026-04-06 18:26:37.353
31f84414-1864-4e87-a61e-329831e6691b	36df8ef2-4651-426d-ba5f-a3edc5984168	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-06 21:57:00.549	2026-04-06 21:57:00.549
f5285cf7-fca8-4761-8456-f6c3d5ed8506	36df8ef2-4651-426d-ba5f-a3edc5984168	6f9dd63d-2ffa-4634-a840-0617804df6b7	2026-04-06 21:57:40.053	2026-04-06 21:57:40.053
ac8ab761-2554-4459-b94f-c06ddcf6854d	36df8ef2-4651-426d-ba5f-a3edc5984168	55818434-6bf8-4190-851d-96dae9acb2b1	2026-04-06 21:58:25.776	2026-04-06 21:58:25.776
49279641-af51-4147-aa86-6f5c1733a511	36df8ef2-4651-426d-ba5f-a3edc5984168	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-06 22:18:47.007	2026-04-06 22:18:47.007
3e02264f-11b9-4915-bc50-6a5a1835c920	832aabaf-e4ec-4683-98aa-75eec4924379	ed917127-6f95-432e-aed5-7c4a8cf4157f	2026-04-07 02:56:15.66	2026-04-07 02:56:15.66
caab2b62-9c84-4b01-a2f9-97e3d41b8044	6f5b20d3-fb68-475a-b304-7aa067456fe5	ed917127-6f95-432e-aed5-7c4a8cf4157f	2026-04-07 02:56:46.556	2026-04-07 02:56:46.556
2c69eae3-e026-4fd1-998e-09bd43645c4c	6e276e63-0515-4855-95b6-f65ff85dbf24	ed917127-6f95-432e-aed5-7c4a8cf4157f	2026-04-07 03:03:47.286	2026-04-07 03:03:47.286
9d82b1e6-6ca1-4923-910c-7348f4e4213f	6f9dd63d-2ffa-4634-a840-0617804df6b7	ae043ef6-64d1-4cdd-aead-cfaac366d79b	2026-04-07 03:32:34.609	2026-04-07 03:32:34.609
afed4252-bf52-4b55-a394-01b72e7707fc	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	850654ff-c2a8-4215-bc96-c0afdb615949	2026-04-07 08:01:34.972	2026-04-07 08:01:34.972
6dcfc5a4-76f3-40d6-9f84-b75da878815c	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-07 08:02:12.75	2026-04-07 08:02:12.75
b0bb594b-326b-47bc-acb0-a3abd5982d2a	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-07 08:02:31.986	2026-04-07 08:02:31.986
1df814de-d535-4774-a90f-9b08566663c4	1b80ea97-9a78-4674-804f-39ef05924c67	850654ff-c2a8-4215-bc96-c0afdb615949	2026-04-07 12:56:13.133	2026-04-07 12:56:13.133
eab1a6bd-c378-48bd-ac47-cffb517a1a46	0d6251c4-0c8d-47e1-871f-d7446ce48732	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-07 21:36:56.653	2026-04-07 21:36:56.653
a4804c5c-f213-465b-b383-e06222748b11	0d6251c4-0c8d-47e1-871f-d7446ce48732	6f9dd63d-2ffa-4634-a840-0617804df6b7	2026-04-07 21:41:49.163	2026-04-07 21:41:49.163
bab79ab6-a620-4e5c-87ab-5251421d9264	6f5b20d3-fb68-475a-b304-7aa067456fe5	e082d771-fb3c-41e8-805f-052e544edcc6	2026-04-09 20:13:46.798	2026-04-09 20:13:46.798
6fc3057f-2995-42b9-9011-2be0f16038d4	41e81b4b-c22c-40a2-9176-2546ccae0163	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-04-10 00:25:02.44	2026-04-10 00:25:02.44
f999d9f5-fa0b-415a-a456-8b32e952c596	41e81b4b-c22c-40a2-9176-2546ccae0163	6f9dd63d-2ffa-4634-a840-0617804df6b7	2026-04-10 00:27:28.728	2026-04-10 00:27:28.728
02f80b68-e52e-4b30-90e4-442bb2b89b23	a28528b4-e871-4137-a29b-b39f512397a6	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-10 19:46:25.895	2026-04-10 19:46:25.895
452465d0-1488-4446-9799-eb04df5e97ac	92491ea2-42e2-4803-81f2-c9856f9503c1	ed917127-6f95-432e-aed5-7c4a8cf4157f	2026-04-10 22:50:20.12	2026-04-10 22:50:20.12
59a98f39-0180-4629-98e5-24ba079e9cf3	dd0257c2-4f37-4b20-b336-b13494e0ba74	ed917127-6f95-432e-aed5-7c4a8cf4157f	2026-04-11 00:41:18.205	2026-04-11 00:41:18.205
4404b298-566f-4b7f-8223-7dc4e76961ad	0d6251c4-0c8d-47e1-871f-d7446ce48732	55818434-6bf8-4190-851d-96dae9acb2b1	2026-04-11 02:59:53.845	2026-04-11 02:59:53.845
395aa793-ec56-4d8e-9585-dedbe89405ab	ae043ef6-64d1-4cdd-aead-cfaac366d79b	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-11 05:22:25.384	2026-04-11 05:22:25.384
d92b9864-ebb1-4056-b2d0-a53260de05e1	bac87303-3c5f-4c06-aa9d-c2013ceeef53	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	2026-04-11 12:47:09.601	2026-04-11 12:47:09.601
18dcef78-785b-47b3-8dce-c4a049695d4e	5398b688-8844-424f-bc48-74b7cf60d774	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-16 04:17:47.487	2026-04-16 04:17:47.487
436f71d8-2147-4237-b900-419870a36b84	8378d82d-b63f-49d5-8856-f515f0e2ccd4	cadca8ec-879f-4f06-9295-1a9731149965	2026-04-24 14:29:21.362	2026-04-24 14:29:21.362
d6bfe597-9343-44f5-a46d-692515fda704	304884e0-e87c-44b3-a135-525fcc3b24d6	dec3b28d-030e-49f1-af9b-441d3188a3a7	2026-04-25 00:35:17.967	2026-04-25 00:35:17.967
d4c58912-8067-4600-bc41-d11a64aa5a08	a5e6330c-0958-4715-bca2-05477d265316	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-25 18:48:46.221	2026-04-25 18:48:46.221
2f9df242-dbf6-42df-93f6-da9596f01b38	41e81b4b-c22c-40a2-9176-2546ccae0163	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-30 05:31:01.714	2026-04-30 05:31:01.714
842de833-5779-4ac6-84a6-50c43a6b9345	41e81b4b-c22c-40a2-9176-2546ccae0163	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-30 05:31:19.835	2026-04-30 05:31:19.835
cbfbd9a3-7754-407e-b5c0-74bfd0f8e35e	41e81b4b-c22c-40a2-9176-2546ccae0163	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-04-30 05:31:59.137	2026-04-30 05:31:59.137
f81a5bfc-5e9f-449f-9e8d-1f94f128ad1d	41e81b4b-c22c-40a2-9176-2546ccae0163	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-04-30 05:32:48.249	2026-04-30 05:32:48.249
8f7af12f-62bb-4f2c-87d0-de9141e6a48f	41e81b4b-c22c-40a2-9176-2546ccae0163	850654ff-c2a8-4215-bc96-c0afdb615949	2026-04-30 05:36:29.569	2026-04-30 05:36:29.569
fe4d9e1f-0275-4d35-8299-bf8974fc81f3	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-05-02 06:24:35.541	2026-05-02 06:24:35.541
213ce9c3-28ea-4004-be98-c4884aff9b48	a5e6330c-0958-4715-bca2-05477d265316	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-05-02 06:24:55.503	2026-05-02 06:24:55.503
e85d1a8d-10a3-4c91-8b3e-0ebfb7cc45dd	0f7b4e7b-17f3-4d7c-878b-055ee8dac528	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-05-02 06:25:25.827	2026-05-02 06:25:25.827
86e709eb-6c6c-412a-8d49-3f0ed490da26	28ad9e87-7377-4515-ac11-5c14512a382b	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-05-02 06:25:33.106	2026-05-02 06:25:33.106
3afa11e8-8bf0-474b-ba30-f1cb0ce1ed2f	5398b688-8844-424f-bc48-74b7cf60d774	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-05-02 06:25:47.389	2026-05-02 06:25:47.389
e4eae867-1b15-4e18-832a-9a256f4326a7	bac87303-3c5f-4c06-aa9d-c2013ceeef53	fb41944b-5d8e-4c5e-8b9f-4e8661e007af	2026-05-04 04:35:36.312	2026-05-04 04:35:36.312
199ee1c9-f407-40e5-8d90-9ebf94e9ca04	6cd4c719-68fb-4e7c-8455-f7909ce58666	fb41944b-5d8e-4c5e-8b9f-4e8661e007af	2026-05-04 04:43:57.115	2026-05-04 04:43:57.115
cf8755d4-bfeb-4dbe-af01-112f31b1aed5	832aabaf-e4ec-4683-98aa-75eec4924379	fb41944b-5d8e-4c5e-8b9f-4e8661e007af	2026-05-04 04:46:41.59	2026-05-04 04:46:41.59
acd5d7b6-ad06-4857-9005-2e7d240810f1	81a45612-532a-459c-890c-55d6d3391455	fb41944b-5d8e-4c5e-8b9f-4e8661e007af	2026-05-04 04:51:31.615	2026-05-04 04:51:31.615
f82b78e0-7171-4d09-a041-055527043c61	6e276e63-0515-4855-95b6-f65ff85dbf24	fb41944b-5d8e-4c5e-8b9f-4e8661e007af	2026-05-04 04:55:10.158	2026-05-04 04:55:10.158
a6ddb078-a910-4559-99e6-70136c40093e	3d7da8a9-2210-4c42-89b6-1f9fa8c06d07	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 09:30:23.054	2026-05-04 09:30:23.054
e84078ca-6abe-4818-b2c5-9be652d37107	28a52218-067b-4816-ba7c-581f48308a23	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 09:30:31.594	2026-05-04 09:30:31.594
ef7a014a-356b-4042-981d-fb4f16948500	bac87303-3c5f-4c06-aa9d-c2013ceeef53	f77c3216-b665-48c3-b3c1-5d48953c7026	2026-05-04 09:31:30.284	2026-05-04 09:31:30.284
23dad417-fe53-448d-9e68-08fe3275f9c5	bac87303-3c5f-4c06-aa9d-c2013ceeef53	f6c000b1-9659-4fcb-b39b-d1f31258c870	2026-05-04 10:30:22.751	2026-05-04 10:30:22.751
8cfdaf25-21a8-482b-bcd7-be44263ff3d2	bac87303-3c5f-4c06-aa9d-c2013ceeef53	f3391727-9c64-4ab4-9623-7c92862899c6	2026-05-04 10:30:30.146	2026-05-04 10:30:30.146
53705383-e89d-481f-9546-513c719a82d6	109ecd1a-3b55-475c-bed3-f1339005e2c4	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 11:25:30.354	2026-05-04 11:25:30.354
dabb1bbe-be85-4a04-893a-e6324edc9e54	0cdaf38d-21f5-47cf-9bfd-77386ea5a211	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 11:25:38.028	2026-05-04 11:25:38.028
f478bf29-c2d3-49f6-b90e-5743fdbc3da5	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 11:54:37.965	2026-05-04 11:54:37.965
048e1223-0858-4598-85fc-3c1405a9eed0	bac87303-3c5f-4c06-aa9d-c2013ceeef53	d19fae64-dba5-4f3b-b12d-52a085efa21f	2026-05-04 12:28:13.471	2026-05-04 12:28:13.471
653f174b-10dd-4130-a9f0-933e6a63ae2e	6af62b72-c49f-49b4-90c8-b3e3467cd6ae	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 12:55:37.599	2026-05-04 12:55:37.599
c9aea6ee-0b92-4f17-8f3b-6722f24559b4	7276c868-9a13-4908-822f-403e45bca30b	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 13:13:58.592	2026-05-04 13:13:58.592
8f17a55c-3607-4385-a1f5-bdc3825216b4	bac87303-3c5f-4c06-aa9d-c2013ceeef53	da244740-12b0-4691-a6ca-280f6d83a716	2026-05-04 13:14:12.582	2026-05-04 13:14:12.582
29b7b6f7-b9fb-471d-80b8-7ed211fe9152	3e957107-e648-43cc-baea-c5878ab6732c	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 13:14:33.552	2026-05-04 13:14:33.552
c3dcd5e7-d7cb-4559-9b82-3c3a2cb0c210	bac87303-3c5f-4c06-aa9d-c2013ceeef53	d8e760c1-588f-4c94-be2b-2ea00e428332	2026-05-04 18:59:04.07	2026-05-04 18:59:04.07
33296e3f-845d-49b9-82d2-1171d3b41ed9	01d48b51-6cb9-43ea-bfdc-5c2000af4fbe	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 18:59:12.537	2026-05-04 18:59:12.537
3661a30e-6566-487c-8fe4-cc1d5d8c2f29	86860ded-58e9-43db-9e8e-00f1d4161fab	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 18:59:24.721	2026-05-04 18:59:24.721
5c9891e6-c758-4592-a4b9-3201ec01130b	1773eab2-4727-40ee-a9b0-d1952a2a388d	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 18:59:33.208	2026-05-04 18:59:33.208
bbc4895d-dccc-4a80-9364-40b13095abbf	579c6a3a-4186-4973-8522-bdebffcf304a	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 19:00:00.049	2026-05-04 19:00:00.049
a99eedb5-742f-4970-88f0-ea90c2515120	198da2c0-0a8e-486d-b715-6cad34b02bc0	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 19:00:05.919	2026-05-04 19:00:05.919
b18232d7-4eab-4f54-b77a-76a55a0852b4	47339094-1daa-4449-9dce-843579263fe4	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 19:00:12.888	2026-05-04 19:00:12.888
fc66073b-294f-410e-9f73-fcac59445a6b	bac87303-3c5f-4c06-aa9d-c2013ceeef53	c2e6c369-0649-46e8-a0e2-b888d83d131f	2026-05-04 19:25:13.684	2026-05-04 19:25:13.684
fba463be-9975-4657-83aa-284e46d149b9	a652dbc4-c42b-4f12-92bb-40ad705f0614	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 19:25:22.476	2026-05-04 19:25:22.476
e5dfd55e-71f6-432b-a643-9d6969a6b271	ab44e481-2f7a-49ea-91f0-16be463368ec	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 19:25:32.656	2026-05-04 19:25:32.656
0871a2ad-65ee-462e-84cc-ca09d1ac74f6	bac87303-3c5f-4c06-aa9d-c2013ceeef53	ddae2e8c-5157-4006-985b-eefa7a3f0199	2026-05-04 20:55:29.398	2026-05-04 20:55:29.398
00c74cce-d2f3-4937-b883-1276e58cbe56	7ebc1ad1-7828-4ed9-8c70-0201bf0905a0	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 20:55:36.404	2026-05-04 20:55:36.404
741bd59b-450e-4607-9961-651610b905db	9e7ae97a-42e8-4c75-9b92-a4dbf954ce19	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 20:55:40.864	2026-05-04 20:55:40.864
39158a33-8471-469c-9b09-1af4c8805589	bac87303-3c5f-4c06-aa9d-c2013ceeef53	d3bea0b4-86a4-46be-8c56-1cdb09c7da7c	2026-05-06 04:39:05.306	2026-05-06 04:39:05.306
d9deed1c-027e-472c-a03b-ed88990bbccd	6cd4c719-68fb-4e7c-8455-f7909ce58666	d3bea0b4-86a4-46be-8c56-1cdb09c7da7c	2026-05-06 04:39:39.664	2026-05-06 04:39:39.664
2e52215b-70a2-4ac6-b1af-534ec52ad47c	4e52747e-7e13-4333-98ea-a5c31722ed46	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-07 01:47:31.144	2026-05-07 01:47:31.144
74971633-e47d-43d4-a533-c5f4bb683d5e	832aabaf-e4ec-4683-98aa-75eec4924379	c7bd5193-a265-44ba-bc7a-ec8dae92b78b	2026-05-07 12:26:39.916	2026-05-07 12:26:39.916
e037f708-76a0-4199-a945-d664fd3ab563	6cd4c719-68fb-4e7c-8455-f7909ce58666	c7bd5193-a265-44ba-bc7a-ec8dae92b78b	2026-05-07 12:40:34.679	2026-05-07 12:40:34.679
84eb6b85-b7c8-4b28-b08a-005f7f446e8c	bac87303-3c5f-4c06-aa9d-c2013ceeef53	c7bd5193-a265-44ba-bc7a-ec8dae92b78b	2026-05-08 06:43:51.47	2026-05-08 06:43:51.47
9005e608-d43e-4e5d-b0ca-9e12dc13d2c9	135181f0-4f89-46db-86a1-eb721cf3913d	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 07:24:16.338	2026-05-08 07:24:16.338
8c3f7782-f73b-4da7-b303-ee3bbb5c6ea5	25b2a762-7e47-4134-bf3c-c69ef581863b	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 10:22:10.299	2026-05-08 10:22:10.299
70ef6c35-b4a6-4c4d-8d5e-25397e804996	6d13a28d-09ed-4bc2-bfdf-aa61c4dc03ac	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 10:22:21.051	2026-05-08 10:22:21.051
938969c2-7e65-4950-82f0-55b86993a7d4	bac87303-3c5f-4c06-aa9d-c2013ceeef53	ea97602c-9fc5-4aca-b2e1-e1142507c775	2026-05-08 10:22:27.02	2026-05-08 10:22:27.02
4623c39a-1fbf-4687-b080-72076d3a933d	69ae8322-3c79-47e8-9712-ee0f426bd787	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 10:43:35.661	2026-05-08 10:43:35.661
bb37814e-e9a9-4018-99ab-f5f8527ba80a	b9818e31-dfc8-4883-aaca-df0d3b536b3e	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 10:44:01.264	2026-05-08 10:44:01.264
5943d2cc-802a-4b19-be7d-a257f48b2efb	0d5b21f4-0dc6-466f-948f-9774bb5413f5	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 11:29:56.731	2026-05-08 11:29:56.731
cb1e82f6-9b33-4af2-a7cb-3f99f461f1e1	42ea5d02-a1fc-48d2-97d1-3bdd712dfd10	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 11:45:30.948	2026-05-08 11:45:30.948
e3a03262-4e64-4eac-a31c-5871a08dd23a	3eb8c9bf-adb0-40f3-bf0a-6d40339787ff	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 16:14:38.103	2026-05-08 16:14:38.103
79de9b56-8277-4125-b711-8d3bd84ce867	bac87303-3c5f-4c06-aa9d-c2013ceeef53	e5c103a5-43e8-45fc-91fe-164692d790dd	2026-05-08 16:14:54.315	2026-05-08 16:14:54.315
ebdbf216-64ab-482e-b8d6-3700315f3e29	bac87303-3c5f-4c06-aa9d-c2013ceeef53	fc72d3d5-2270-462d-87ab-0c1d6239a205	2026-05-08 16:15:01.502	2026-05-08 16:15:01.502
650fc5b5-3adc-44a8-8d6c-7d47263a0b6b	0efe47ef-da7e-48d2-b1fa-3236019ba015	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 16:15:08.425	2026-05-08 16:15:08.425
13775b85-b459-40b1-8e61-69d62d19b7d6	98a21c81-0a67-4b4c-8923-e06d43c844d8	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 16:15:24.681	2026-05-08 16:15:24.681
0f7d1775-4fb2-42f5-9bb8-ca983410c243	a9aa889e-3c05-40b3-986b-cb4bd653f10e	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 16:15:34.02	2026-05-08 16:15:34.02
574b2052-89b9-44a9-a979-a4d6a08870bb	58c3b43f-2de4-4f0a-8d99-bb8c2605cc4d	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 16:27:49.753	2026-05-08 16:27:49.753
057669de-bc18-4a77-b65f-174653e1d2c8	0ce11212-d428-4c69-ae11-c42946e0fe02	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 16:27:56.454	2026-05-08 16:27:56.454
ca625a4e-6cfa-4164-b8c2-a11c66dab020	bac87303-3c5f-4c06-aa9d-c2013ceeef53	e33e08f9-dc8a-48f1-810c-bfb657d9fd48	2026-05-08 16:28:02.467	2026-05-08 16:28:02.467
a3366ec8-cc71-4cde-ad66-979af608ed1a	8d15ad5d-09a9-49d7-bcf2-5bb2261f0c32	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 18:26:52.275	2026-05-08 18:26:52.275
a14ed221-9226-419a-86e1-49a8fef53d71	bac87303-3c5f-4c06-aa9d-c2013ceeef53	c8717ec0-2459-4453-9e07-def794fce32f	2026-05-08 18:27:28.207	2026-05-08 18:27:28.207
f607b794-d63b-4f67-8d3b-01da0f750123	7cdb0b1c-4dc2-40d0-877f-56ce39b46daa	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 18:27:33.958	2026-05-08 18:27:33.958
b82ae54c-f501-4d9a-8dee-85c000a3e8ed	2c6d2131-3229-4cba-ae3c-794f14ca9580	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 18:27:38.599	2026-05-08 18:27:38.599
03b5875a-bb4a-403a-878d-cc6d2caa3fdc	975162b0-1c94-4cc3-b740-b2b3a82c4870	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 18:27:44.326	2026-05-08 18:27:44.326
8babb5df-f90b-4ad0-b324-e821ebbb93e2	bac87303-3c5f-4c06-aa9d-c2013ceeef53	eebf9f36-165f-455b-a649-d5f55d69baa0	2026-05-08 18:27:49.096	2026-05-08 18:27:49.096
b3f6f88b-11e4-4299-834a-f10cb4934766	80140d9b-39a6-4691-bf0a-c0d00872de78	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 18:52:16.672	2026-05-08 18:52:16.672
8f3d0bee-487a-4447-bfb0-c77434e625ba	5317732e-ec0a-4c09-ade5-d28c2289c8f1	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 18:52:24.455	2026-05-08 18:52:24.455
75a4d63f-43d1-4689-a8e6-958d9684c069	b075c824-5525-4904-8f72-e3812b41c53c	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-08 22:45:36.184	2026-05-08 22:45:36.184
0474a984-df59-4c0c-83d4-3104ce397811	bac87303-3c5f-4c06-aa9d-c2013ceeef53	fe11c4ad-6c7a-41b2-ad11-84071a3914be	2026-05-09 01:50:28.447	2026-05-09 01:50:28.447
fc96535f-768c-4e1b-b2e5-9588861b5f91	20de6987-2064-4d47-84ba-4d3763b67d51	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-09 01:50:44.009	2026-05-09 01:50:44.009
58e8f175-1044-4b83-8ab9-c1d202599c61	13a6bff7-f64a-401f-8ff8-efe774497c49	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-09 01:50:48.847	2026-05-09 01:50:48.847
90df64d5-349f-454a-a067-0fbf415370e2	2b90c33b-af34-43b3-bec6-27c91d08d9e7	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-09 01:50:53.419	2026-05-09 01:50:53.419
98d7b6a9-16c3-4bf1-85c8-bb060f5895d1	b556b7a8-f229-47f0-9453-6106c9a68653	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-09 02:14:21.229	2026-05-09 02:14:21.229
b32674e3-7523-45f3-afcd-0c91c57ad21e	97181454-67d5-45d4-af28-e9eead994af0	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-09 04:01:40.836	2026-05-09 04:01:40.836
a51e573c-befc-41aa-b0f7-213fa450e0d6	bac87303-3c5f-4c06-aa9d-c2013ceeef53	d55352a5-24d8-4aa0-92ac-e47c2a8b8055	2026-05-10 12:45:20.135	2026-05-10 12:45:20.135
ba0a360b-59e2-4f61-b6b8-7926c4a8c2ff	0986237c-cb80-4d13-a8aa-f86253b614a6	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-10 12:45:32.665	2026-05-10 12:45:32.665
868a1d0a-ca54-4146-b9af-23c493fe0b78	bac87303-3c5f-4c06-aa9d-c2013ceeef53	da92e284-f3ac-4797-a6d6-f2860ae59752	2026-05-13 02:42:53.511	2026-05-13 02:42:53.511
05814321-ee78-4e7f-a06b-d85633e1a870	6cd4c719-68fb-4e7c-8455-f7909ce58666	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	2026-05-13 02:57:06.492	2026-05-13 02:57:06.492
d1bf3f56-a139-45f0-bf01-5a7b2a9a1240	585fe0ad-dc81-4fa4-b28f-c0ab16e62c25	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-13 04:38:32.698	2026-05-13 04:38:32.698
24118557-8126-4b97-bb40-bfde0717c708	a7cdc984-83f0-49e6-9351-53e0d7103501	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-05-13 21:53:21.882	2026-05-13 21:53:21.882
53e4300a-b22e-493d-8d89-4a79a639573c	3e6953f8-8684-499e-8b22-d9c8f0403332	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-13 22:48:09.154	2026-05-13 22:48:09.154
6458d00d-ef13-45c0-94a4-c33581ebdcec	370e5880-5ba0-4526-ba76-14f34e7dd92f	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-13 22:48:16.564	2026-05-13 22:48:16.564
3f5fb8b0-8d04-459a-9a7c-f2462e7b6f01	a7cdc984-83f0-49e6-9351-53e0d7103501	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-13 22:48:20.82	2026-05-13 22:48:20.82
8c036d9c-bd07-46b8-a44e-cfbc9a511ebb	4da2c430-d1ea-4387-bccd-dd27daded98c	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-14 01:03:10.028	2026-05-14 01:03:10.028
2ed33aec-d3a5-48a0-9bbd-37237afbfce1	10f0f50b-675d-4fb9-bb15-b5e57bdbc52b	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-15 02:46:42.142	2026-05-15 02:46:42.142
d7743c72-086f-425b-8091-06f0f839819b	bac87303-3c5f-4c06-aa9d-c2013ceeef53	c7d27475-082e-49f5-9810-2b87ed7428e0	2026-05-15 05:47:11.106	2026-05-15 05:47:11.106
d2d4fcbf-bc17-4483-9930-1097b22adea9	5927fde2-f73e-4a02-afcf-08212a5dd015	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-15 21:37:41.817	2026-05-15 21:37:41.817
dbf44de0-1943-497b-b08d-87c6f451cce2	5927fde2-f73e-4a02-afcf-08212a5dd015	850654ff-c2a8-4215-bc96-c0afdb615949	2026-05-15 21:42:28.003	2026-05-15 21:42:28.003
223489d1-77cf-416d-aa4a-2dc3d1c7f7c7	1808fc9e-a96d-4dc0-a466-3e5445ff8abd	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	2026-05-16 02:32:32.302	2026-05-16 02:32:32.302
0e2e46f4-c74c-49fe-996a-e4e1a8e3e388	1808fc9e-a96d-4dc0-a466-3e5445ff8abd	ed917127-6f95-432e-aed5-7c4a8cf4157f	2026-05-16 02:45:13.789	2026-05-16 02:45:13.789
9abf7b76-700f-486d-addf-e5a647c5c263	20f409ec-a9a0-4759-a2e0-841a58ad4583	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-16 04:38:53.35	2026-05-16 04:38:53.35
a82fb87c-a96e-402e-9e6e-acfbb4bf0591	bac87303-3c5f-4c06-aa9d-c2013ceeef53	d83c5124-fd8f-4204-a9c7-f413cbc3d73d	2026-05-16 18:19:36.131	2026-05-16 18:19:36.131
9e91b432-cd82-47c5-9439-0d5536928a49	bac87303-3c5f-4c06-aa9d-c2013ceeef53	bb77090c-f3fb-4421-851b-87649fdc9140	2026-05-17 00:39:11.671	2026-05-17 00:39:11.671
d44ebae7-5f11-4ec0-aa5c-a350dbf202aa	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	8378d82d-b63f-49d5-8856-f515f0e2ccd4	2026-05-17 00:43:37.066	2026-05-17 00:43:37.066
d809141e-1f78-414e-a88a-7b3f89f33c17	b3512702-02e5-4d5e-82e3-61c9c08973b5	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-17 02:16:50.029	2026-05-17 02:16:50.029
219f132f-aab8-499f-9c7e-f96ebdf18f8b	4166446a-428a-4e83-95a1-3491ff92f622	dd0257c2-4f37-4b20-b336-b13494e0ba74	2026-05-17 08:02:10.36	2026-05-17 08:02:10.36
6ec0a2a3-23b5-42b4-bd81-f2d41457e937	4166446a-428a-4e83-95a1-3491ff92f622	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-17 11:32:52.555	2026-05-17 11:32:52.555
42064083-c563-4235-b5b2-8a10ea989b16	6cd4c719-68fb-4e7c-8455-f7909ce58666	ba25f67a-9d84-4e41-b869-77062401666f	2026-05-17 22:33:23.671	2026-05-17 22:33:23.671
27639f4d-a0ce-4c13-8527-a23c00e52b4a	ba25f67a-9d84-4e41-b869-77062401666f	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-17 22:35:35.59	2026-05-17 22:35:35.59
1e0dfb46-6982-4899-bc0b-4430e04f3dae	bac87303-3c5f-4c06-aa9d-c2013ceeef53	dece3752-d51b-4d32-95ba-480d73b55db1	2026-05-19 08:38:27.006	2026-05-19 08:38:27.006
776ebbf5-926e-4d3b-b16e-17b89087697a	940e28c5-35f3-41ba-b0bf-5d958a85fbf7	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-20 11:05:27.917	2026-05-20 11:05:27.917
420387dc-ae2a-4622-9676-70339ff47cf9	a26f840d-db0d-40d8-b881-2005b8cf4473	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-22 11:18:45.192	2026-05-22 11:18:45.192
d9723d1b-837e-4171-aa35-26f2bfaf4b95	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-05-27 08:27:58.98	2026-05-27 08:27:58.98
82e3970f-50f1-4efe-956a-ea0f2ae15dfc	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-27 08:32:06.29	2026-05-27 08:32:06.29
3f1f7140-c276-4d1c-aad1-d7baeb4f65fb	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-05-27 08:32:55.62	2026-05-27 08:32:55.62
dad5faf5-8370-46ca-a76f-eba565f365d0	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	81a45612-532a-459c-890c-55d6d3391455	2026-05-27 08:36:21.107	2026-05-27 08:36:21.107
e00d35d5-99c8-4b78-af85-8618f55fbdd7	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	832aabaf-e4ec-4683-98aa-75eec4924379	2026-05-27 09:25:29.471	2026-05-27 09:25:29.471
719ca792-c25e-4093-947b-5c26348894b1	4e33169a-9f8c-4251-b531-fa7c38521bc7	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-27 13:05:21.092	2026-05-27 13:05:21.092
6b1d3411-de70-4ca6-88e9-11042bbdcee0	6cd4c719-68fb-4e7c-8455-f7909ce58666	a8c3a75d-a86c-499e-9636-de4a14cdad5c	2026-05-27 19:35:44.472	2026-05-27 19:35:44.472
323311e2-a04a-401e-bed9-cd30b47c457f	a8c3a75d-a86c-499e-9636-de4a14cdad5c	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-27 19:36:08.712	2026-05-27 19:36:08.712
07d586d3-c5bd-470e-a3d0-409211c00000	6e276e63-0515-4855-95b6-f65ff85dbf24	a8c3a75d-a86c-499e-9636-de4a14cdad5c	2026-05-27 19:37:55.453	2026-05-27 19:37:55.453
c7dbab19-c9e8-4078-98a6-cd4280f9a203	850654ff-c2a8-4215-bc96-c0afdb615949	a8c3a75d-a86c-499e-9636-de4a14cdad5c	2026-05-27 19:41:59.979	2026-05-27 19:41:59.979
d5110d81-32ca-4f7e-af7b-1e178ef9c946	55818434-6bf8-4190-851d-96dae9acb2b1	a8c3a75d-a86c-499e-9636-de4a14cdad5c	2026-05-27 19:51:30.114	2026-05-27 19:51:30.114
267e041c-1206-434a-9cbb-d90330bef4bb	a8c3a75d-a86c-499e-9636-de4a14cdad5c	b8f63138-a5ba-4b5c-b25c-ffd88ec1386b	2026-05-27 19:52:21.848	2026-05-27 19:52:21.848
92b066a5-f5da-4430-a416-b5260119b3dc	1808fc9e-a96d-4dc0-a466-3e5445ff8abd	a8c3a75d-a86c-499e-9636-de4a14cdad5c	2026-05-27 19:53:06.992	2026-05-27 19:53:06.992
d10ce56f-415f-41c3-9b2a-6cd1f01b2562	16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c	a8c3a75d-a86c-499e-9636-de4a14cdad5c	2026-05-28 01:13:28.623	2026-05-28 01:13:28.623
8113449b-196d-4c56-b0cf-ba5d8c718052	a63afb22-98a2-4499-ae4b-fc21ea76eed5	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-29 19:20:32.263	2026-05-29 19:20:32.263
a7c38de9-861f-45f1-ba7a-864224ea3df5	a63afb22-98a2-4499-ae4b-fc21ea76eed5	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-05-29 19:22:39.143	2026-05-29 19:22:39.143
953510c4-ac86-4329-9c74-59c2b54e3743	832aabaf-e4ec-4683-98aa-75eec4924379	a63afb22-98a2-4499-ae4b-fc21ea76eed5	2026-05-30 00:37:39.209	2026-05-30 00:37:39.209
462d9abe-e3a4-4263-ab92-77c50c7c35e0	5893d81a-370d-46e6-8783-926054e7c5d7	a63afb22-98a2-4499-ae4b-fc21ea76eed5	2026-05-30 00:42:25.63	2026-05-30 00:42:25.63
2f402cab-7cf6-4701-870e-d97462d8a1b5	6cd4c719-68fb-4e7c-8455-f7909ce58666	a63afb22-98a2-4499-ae4b-fc21ea76eed5	2026-05-30 00:46:29.897	2026-05-30 00:46:29.897
f1aa4b94-566d-418b-befe-fed03afb0d89	55818434-6bf8-4190-851d-96dae9acb2b1	a63afb22-98a2-4499-ae4b-fc21ea76eed5	2026-05-30 01:03:04.498	2026-05-30 01:03:04.498
eef6763b-f311-4930-9995-e360ca18d9d9	16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c	a63afb22-98a2-4499-ae4b-fc21ea76eed5	2026-05-30 10:43:39.707	2026-05-30 10:43:39.707
cfd9f37e-8cee-4067-adff-229717bde978	81a45612-532a-459c-890c-55d6d3391455	a63afb22-98a2-4499-ae4b-fc21ea76eed5	2026-05-30 10:43:59.993	2026-05-30 10:43:59.993
272ed26b-9ee0-424b-839b-b94a14958c89	8a3bb928-b6e1-4334-a038-55d49c49d7ce	ed917127-6f95-432e-aed5-7c4a8cf4157f	2026-05-30 22:51:39.243	2026-05-30 22:51:39.243
eec47463-384d-4c3b-933d-01f649d6e45c	a89853a8-82aa-4b46-9bf6-005479c699b6	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-31 04:34:03.191	2026-05-31 04:34:03.191
ae3f8845-7a7c-451a-8278-c69fbf95cf42	850654ff-c2a8-4215-bc96-c0afdb615949	a89853a8-82aa-4b46-9bf6-005479c699b6	2026-05-31 04:34:52.774	2026-05-31 04:34:52.774
db8da058-2db6-4a72-82bb-c3b7f73a9cd0	6e276e63-0515-4855-95b6-f65ff85dbf24	a89853a8-82aa-4b46-9bf6-005479c699b6	2026-05-31 04:43:15.505	2026-05-31 04:43:15.505
cec11803-ce7c-4254-9b25-c2f1d6855805	47aec11b-cf7d-4b92-81bc-70df20808a09	8a3bb928-b6e1-4334-a038-55d49c49d7ce	2026-06-01 23:43:25.047	2026-06-01 23:43:25.047
5a6d758c-55b3-4850-87ce-1fcbbfb4229d	47aec11b-cf7d-4b92-81bc-70df20808a09	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-06-04 08:16:36.744	2026-06-04 08:16:36.744
acc3b4f8-fa75-44df-93e9-99067161007a	60ff77b5-54f8-434f-a918-2a981a03112c	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-06-07 11:47:43.568	2026-06-07 11:47:43.568
35d36ad5-b295-4805-a284-a111d895f075	60ff77b5-54f8-434f-a918-2a981a03112c	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-06-07 11:49:33.159	2026-06-07 11:49:33.159
ba27a251-e1fd-4007-8363-89fd065ec246	60ff77b5-54f8-434f-a918-2a981a03112c	b827b865-dde5-4384-9b10-cd7f858c4d0f	2026-06-07 11:50:34.301	2026-06-07 11:50:34.301
faf33b08-6088-4586-8ccf-bd828ec06b85	60ff77b5-54f8-434f-a918-2a981a03112c	850654ff-c2a8-4215-bc96-c0afdb615949	2026-06-07 11:51:54.381	2026-06-07 11:51:54.381
070c092c-3ed3-4505-a8e2-dce058ea4da1	07756b0f-e984-4beb-9fdd-1f03b3f9b811	56ebdbbb-8356-4503-89fa-791d55f200e5	2026-06-10 03:50:06.183	2026-06-10 03:50:06.183
b73c77de-7962-4254-ae0b-14c08f045f71	07756b0f-e984-4beb-9fdd-1f03b3f9b811	a196b0f9-6e1a-41be-91df-cb19b320504a	2026-06-10 05:53:25.563	2026-06-10 05:53:25.563
25dbad66-2464-46bd-8b36-0c117b3c0383	07756b0f-e984-4beb-9fdd-1f03b3f9b811	60ff77b5-54f8-434f-a918-2a981a03112c	2026-06-10 05:53:42.229	2026-06-10 05:53:42.229
cddd5bcd-83ec-4f27-bd62-aff44c7c735b	6cd4c719-68fb-4e7c-8455-f7909ce58666	941d8710-2e84-45dc-a1a1-6bca465fb251	2026-06-10 16:43:43.188	2026-06-10 16:43:43.188
0a3d68ad-4124-494d-8b6e-eba62c3baf64	941d8710-2e84-45dc-a1a1-6bca465fb251	dd0257c2-4f37-4b20-b336-b13494e0ba74	2026-06-10 16:49:28.172	2026-06-10 16:49:28.172
9dca0d92-ccb9-4151-a59a-648b6910702f	941d8710-2e84-45dc-a1a1-6bca465fb251	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-06-10 19:19:23.523	2026-06-10 19:19:23.523
ca091f9b-38f6-4a5b-915b-4cdbb149cd30	07756b0f-e984-4beb-9fdd-1f03b3f9b811	b3c3c1e3-2c07-4014-99fe-9e888da32da0	2026-06-10 19:25:25.246	2026-06-10 19:25:25.246
636c270e-9b8c-4f53-b93e-7d7788103d97	07756b0f-e984-4beb-9fdd-1f03b3f9b811	a63afb22-98a2-4499-ae4b-fc21ea76eed5	2026-06-10 19:25:47.838	2026-06-10 19:25:47.838
9399b169-1d61-4511-baae-87d60a74d8c1	07756b0f-e984-4beb-9fdd-1f03b3f9b811	189b0b52-fd73-470d-a4b2-b478b48d6868	2026-06-10 20:17:23.465	2026-06-10 20:17:23.465
6f8a0ce1-50d6-4e48-be9b-bc03f0a674c7	6a5428d5-36cd-4d6e-ba3e-5977d06382ba	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-06-11 01:12:40.727	2026-06-11 01:12:40.727
cd2bd4ad-1d42-4ca9-bb1e-d508f3de8288	6a5428d5-36cd-4d6e-ba3e-5977d06382ba	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-06-11 01:13:10.532	2026-06-11 01:13:10.532
c1dca544-299b-403e-ad14-47139151be89	10a7e4d8-d4d0-48f6-9b6f-9b5ff680f74e	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-06-11 07:28:51.116	2026-06-11 07:28:51.116
ee771864-7ecd-4fc4-9e38-a82d62bba080	07756b0f-e984-4beb-9fdd-1f03b3f9b811	10a7e4d8-d4d0-48f6-9b6f-9b5ff680f74e	2026-06-11 07:30:40.584	2026-06-11 07:30:40.584
b2003214-781c-4a4b-a0ec-65b8bd88db9b	28fc4580-2010-4f0a-a39c-69cc54892617	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-06-15 21:24:12.279	2026-06-15 21:24:12.279
584708b5-6770-4208-a995-e290ca561765	28fc4580-2010-4f0a-a39c-69cc54892617	dd0257c2-4f37-4b20-b336-b13494e0ba74	2026-06-15 21:24:56.691	2026-06-15 21:24:56.691
10bb999e-561a-400c-a8f1-732baaa8f7ae	50953781-3741-4d74-82a3-e6f009e9b033	b06e72ed-13c3-4cff-823d-7977816685bc	2026-06-16 21:35:57.942	2026-06-16 21:35:57.942
6f782e13-9eff-46a5-9f37-6f7e9bf7deb7	705bcf07-fd33-4f4d-a2c3-9fb8d2ab97c7	c61a6045-e7e9-44b2-93fb-ad367b08cb93	2026-06-18 03:19:55.163	2026-06-18 03:19:55.163
ae20945c-9620-4dfc-92b1-0b0cb721c7c2	2ca49a07-c657-4a76-9898-8cee99b8bf5b	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-06-20 05:17:30.566	2026-06-20 05:17:30.566
c1c37c97-3779-44d6-ad51-fb05d2839c09	2ca49a07-c657-4a76-9898-8cee99b8bf5b	81a45612-532a-459c-890c-55d6d3391455	2026-06-20 05:18:11.874	2026-06-20 05:18:11.874
5d15e3ef-f8fb-450a-89cf-298aed892972	2ca49a07-c657-4a76-9898-8cee99b8bf5b	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-06-20 05:20:54.908	2026-06-20 05:20:54.908
da25344f-f73d-4977-9a54-efafd03a9ee0	81a45612-532a-459c-890c-55d6d3391455	c66c79d2-b59e-41c3-aef0-ec1ce54c77d3	2026-06-21 20:22:01.845	2026-06-21 20:22:01.845
6daccfcc-dba5-4599-a5a0-29671f8604f8	07756b0f-e984-4beb-9fdd-1f03b3f9b811	c66c79d2-b59e-41c3-aef0-ec1ce54c77d3	2026-06-21 20:22:23.334	2026-06-21 20:22:23.334
3578eae8-14e1-42ab-843c-044ce899508e	6f5b20d3-fb68-475a-b304-7aa067456fe5	c66c79d2-b59e-41c3-aef0-ec1ce54c77d3	2026-06-21 20:24:13.07	2026-06-21 20:24:13.07
8dd2ac18-8362-4145-bc70-6fa962c6a006	850654ff-c2a8-4215-bc96-c0afdb615949	c66c79d2-b59e-41c3-aef0-ec1ce54c77d3	2026-06-21 20:26:04.858	2026-06-21 20:26:04.858
fdc47c34-cd7d-4ce4-80ad-4278b0711cec	01b121d2-a965-4ac2-bc8d-bde43303ad39	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-06-22 07:50:16.554	2026-06-22 07:50:16.554
b7206482-7e5d-4242-8c29-aeba3c4ef410	01b121d2-a965-4ac2-bc8d-bde43303ad39	850654ff-c2a8-4215-bc96-c0afdb615949	2026-06-22 07:56:58.255	2026-06-22 07:56:58.255
59f6bbc6-d561-4f4c-b67c-02939b4d9c29	01b121d2-a965-4ac2-bc8d-bde43303ad39	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-06-22 07:59:00.4	2026-06-22 07:59:00.4
9d648f99-d884-48aa-a82f-3fa1e789de10	01b121d2-a965-4ac2-bc8d-bde43303ad39	07756b0f-e984-4beb-9fdd-1f03b3f9b811	2026-06-22 09:06:07.388	2026-06-22 09:06:07.388
b6d15087-5b6e-4146-ac47-7eb0f4684e03	b827b865-dde5-4384-9b10-cd7f858c4d0f	c66c79d2-b59e-41c3-aef0-ec1ce54c77d3	2026-06-22 19:09:24.025	2026-06-22 19:09:24.025
2885fcc2-47c9-4915-87ef-49e72d4c84e5	6885d8b2-726e-4e47-a1a5-b10d2234cd4d	dd0257c2-4f37-4b20-b336-b13494e0ba74	2026-06-23 10:41:48.037	2026-06-23 10:41:48.037
9f77f522-75df-45e0-b4b5-448cf2d3d530	6885d8b2-726e-4e47-a1a5-b10d2234cd4d	832aabaf-e4ec-4683-98aa-75eec4924379	2026-06-23 10:43:06.846	2026-06-23 10:43:06.846
48f4ab9d-a43f-4775-bacc-af3c2cc7e610	6885d8b2-726e-4e47-a1a5-b10d2234cd4d	850654ff-c2a8-4215-bc96-c0afdb615949	2026-06-23 10:43:22.496	2026-06-23 10:43:22.496
b172cfc8-e489-4bd8-b830-61f4542d1d68	6885d8b2-726e-4e47-a1a5-b10d2234cd4d	81a45612-532a-459c-890c-55d6d3391455	2026-06-23 10:53:45.868	2026-06-23 10:53:45.868
e8f52d2b-8084-40ee-a369-c6a8ab018743	6885d8b2-726e-4e47-a1a5-b10d2234cd4d	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-06-24 10:23:20.944	2026-06-24 10:23:20.944
e2585cb8-28e8-449e-957a-4068e1b7ffa9	6885d8b2-726e-4e47-a1a5-b10d2234cd4d	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-06-24 10:25:54.009	2026-06-24 10:25:54.009
a090edc9-e70a-4ac6-9ed8-ea5ed47cd805	6885d8b2-726e-4e47-a1a5-b10d2234cd4d	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-06-24 10:29:49.498	2026-06-24 10:29:49.498
1e25f906-5892-4a93-a2ba-ef6638a65659	16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c	6885d8b2-726e-4e47-a1a5-b10d2234cd4d	2026-06-24 10:30:08.62	2026-06-24 10:30:08.62
2e3bd016-9e70-49d5-92f8-a166e37e53ec	07756b0f-e984-4beb-9fdd-1f03b3f9b811	6885d8b2-726e-4e47-a1a5-b10d2234cd4d	2026-06-24 10:31:34.008	2026-06-24 10:31:34.008
7e62504c-3e49-4631-a734-131da343b99a	624d8d60-25d1-4344-981f-4ead2477afea	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-06-29 20:56:54.701	2026-06-29 20:56:54.701
e049fc61-104b-4af6-b78a-6019aa5f8efb	8b87715a-1a1b-42f2-a336-b106972cf7d0	9900429a-7d71-4fb3-8919-a5e2bb7e1460	2026-07-01 20:26:59.37	2026-07-01 20:26:59.37
bbd343d0-b4b5-4f69-b699-e2b386812a3c	6e276e63-0515-4855-95b6-f65ff85dbf24	8b87715a-1a1b-42f2-a336-b106972cf7d0	2026-07-01 20:27:12.365	2026-07-01 20:27:12.365
825173d7-82e2-46d0-a513-8ac61f773194	850654ff-c2a8-4215-bc96-c0afdb615949	8b87715a-1a1b-42f2-a336-b106972cf7d0	2026-07-01 20:27:37.752	2026-07-01 20:27:37.752
8ef971bc-ece3-4729-aa3a-f2f858e95ae1	81a45612-532a-459c-890c-55d6d3391455	e9985fa3-2a2c-40a3-bdf6-a4c9feb9de42	2026-07-05 02:05:21.434	2026-07-05 02:05:21.434
4daad773-e8ef-4eb6-97eb-ee10ec6a560a	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	fa82f190-e133-460e-a800-145362c903a5	2026-07-11 15:08:23.425	2026-07-11 15:08:23.425
932f5cc7-e916-4476-ae23-7faed7c463b5	9900429a-7d71-4fb3-8919-a5e2bb7e1460	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	2026-07-11 15:22:51.116	2026-07-11 15:22:51.116
952e3b3a-351f-4d74-8550-32086357ff89	705bcf07-fd33-4f4d-a2c3-9fb8d2ab97c7	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	2026-07-13 00:50:42.756	2026-07-13 00:50:42.756
3a49b3c1-e8b8-4018-befd-220748726a17	bac87303-3c5f-4c06-aa9d-c2013ceeef53	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-07-14 00:32:49.543	2026-07-14 00:32:49.543
e2b3eaaa-4230-4af6-8993-ed9d55e419fa	4215b759-9065-4de2-8d20-6397fffac991	fa82f190-e133-460e-a800-145362c903a5	2026-07-14 04:25:19.795	2026-07-14 04:25:19.795
681493f4-240c-4e53-bf16-f3c241991058	bac87303-3c5f-4c06-aa9d-c2013ceeef53	dc74b107-7bd8-421a-b762-c5fd6977ccb0	2026-07-15 06:18:32.669	2026-07-15 06:18:32.669
1b6c01a8-86ff-4d2f-bcec-a6d3b538ff46	2c406a15-425f-473a-aaca-1b04d8ecfd8f	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-07-15 06:28:20.954	2026-07-15 06:28:20.954
51a11070-891b-4d06-be3f-6323348bb2f9	bac87303-3c5f-4c06-aa9d-c2013ceeef53	fa07b0b3-9d12-49f7-95ce-68db809ea86e	2026-07-17 22:31:42.1	2026-07-17 22:31:42.1
259e9209-77e3-4781-a5dc-b2aba6fbb2d3	6a84b80a-11f1-47a3-bb87-5e6e9097930d	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-07-18 02:39:29.214	2026-07-18 02:39:29.214
e49f802f-b2ec-4994-80ff-a896aba048cd	6a84b80a-11f1-47a3-bb87-5e6e9097930d	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-07-18 02:41:21.52	2026-07-18 02:41:21.52
07a37087-9f3f-4963-b606-a7692b402c29	bac87303-3c5f-4c06-aa9d-c2013ceeef53	f7973d9c-5f40-4355-818b-27b87f63c686	2026-07-18 17:58:04.153	2026-07-18 17:58:04.153
8065b0d0-b32d-444a-9cd9-8173c8e0110d	bac87303-3c5f-4c06-aa9d-c2013ceeef53	dfadeb82-59f5-4f2d-824d-a435e40d7484	2026-07-19 02:11:42.847	2026-07-19 02:11:42.847
f18e0a49-bf70-43d5-ba36-6b56ab6e9210	bac87303-3c5f-4c06-aa9d-c2013ceeef53	ef1d27b4-7719-4bd7-89c3-c5b0f128bfee	2026-07-20 22:49:39.648	2026-07-20 22:49:39.648
762cf99d-76ab-4f45-b281-85988947453c	9c6ea184-db3d-471f-b8bf-a55877ee1ca7	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-07-21 04:36:55.338	2026-07-21 04:36:55.338
f064b47c-3d01-4cc2-90ca-f262d5926277	8eefeb9e-8d9e-4278-b904-778e5727cfb9	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-07-21 05:05:31.204	2026-07-21 05:05:31.204
e4295fad-0be9-403a-a84f-6c9bc007eb18	3a144e76-42a6-4a5f-b1e6-bac39df8c8a0	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-07-21 05:27:15.481	2026-07-21 05:27:15.481
9a329172-91af-43a1-8849-13f92bfab3bc	3a144e76-42a6-4a5f-b1e6-bac39df8c8a0	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-07-21 05:28:54.155	2026-07-21 05:28:54.155
1d2cbadd-0f91-4a87-9f70-a076cc80fc19	3a144e76-42a6-4a5f-b1e6-bac39df8c8a0	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-07-21 07:14:27.378	2026-07-21 07:14:27.378
8ac4adfe-6973-4ecd-9a8d-e091bd5f2585	3a144e76-42a6-4a5f-b1e6-bac39df8c8a0	b827b865-dde5-4384-9b10-cd7f858c4d0f	2026-07-21 07:15:16.213	2026-07-21 07:15:16.213
671953e7-c197-4c70-9dd0-afff4d41030d	bac87303-3c5f-4c06-aa9d-c2013ceeef53	c1d487fe-ca5d-4d9f-9bf7-5b85c3b96121	2026-07-21 15:08:44.965	2026-07-21 15:08:44.965
dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-07-22 01:36:36.928	2026-07-22 01:36:36.928
2fd09a30-1484-475e-b1df-7b1aa04924c1	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-07-22 01:46:48.003	2026-07-22 01:46:48.003
2a67cda2-ab29-4b44-a769-789770edca1a	63e172c7-36e6-4c68-a980-fccc0bdece37	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-07-22 03:00:24.61	2026-07-22 03:00:24.61
e7d56591-a11d-4cfb-b3fc-d33192cdb252	63e172c7-36e6-4c68-a980-fccc0bdece37	b827b865-dde5-4384-9b10-cd7f858c4d0f	2026-07-22 03:03:30.198	2026-07-22 03:03:30.198
5d8146bd-1b20-402b-b3c2-b83426d53f12	63e172c7-36e6-4c68-a980-fccc0bdece37	832aabaf-e4ec-4683-98aa-75eec4924379	2026-07-22 03:04:32.937	2026-07-22 03:04:32.937
36509c89-12c4-4980-b1cc-9862e1a4db75	07756b0f-e984-4beb-9fdd-1f03b3f9b811	63e172c7-36e6-4c68-a980-fccc0bdece37	2026-07-22 03:06:12.481	2026-07-22 03:06:12.481
ade07b31-7a4c-42e4-ad10-230ed94aaab9	63e172c7-36e6-4c68-a980-fccc0bdece37	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-07-22 03:06:41.535	2026-07-22 03:06:41.535
\.


--
-- Data for Name: creator_referral_reward_events; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.creator_referral_reward_events (id, "referralId", "referrerCreatorId", "referredUserId", "purchaseCreatorId", "sourceTransactionId", "rewardTransactionId", "sourceAmount", percent, "rewardAmount", status, "createdAt", "reversedAt", "referredCreatorId") FROM stdin;
b9f96dd4-411a-4d8a-b07b-b9bd3b9c2cf3	26ec8f31-f0be-43c3-996e-a7b5f293d634	cadca8ec-879f-4f06-9295-1a9731149965	b8f63138-a5ba-4b5c-b25c-ffd88ec1386b	b8f63138-a5ba-4b5c-b25c-ffd88ec1386b	6e0b4183-3e1c-4467-8ce3-b2c04d3bd31f	f3e6d06d-abe8-46c3-9569-1374b72b8a44	500.00	5.00	25.00	PAID	2026-05-22 17:03:02.588	\N	b8f63138-a5ba-4b5c-b25c-ffd88ec1386b
\.


--
-- Data for Name: creator_referral_settings; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.creator_referral_settings (id, "creatorId", percent, "isActive", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: creator_referrals; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.creator_referrals (id, "referrerCreatorId", "referredUserId", "referralCodeUsed", status, "qualifiedAt", "createdAt", "updatedAt", "referredCreatorId", percent) FROM stdin;
26ec8f31-f0be-43c3-996e-a7b5f293d634	cadca8ec-879f-4f06-9295-1a9731149965	b8f63138-a5ba-4b5c-b25c-ffd88ec1386b	SOFIU8ZE	ACTIVE	\N	2026-05-22 16:55:56.639	2026-05-22 16:57:46.964	b8f63138-a5ba-4b5c-b25c-ffd88ec1386b	5.00
929c082b-29a9-4bed-a0d6-ea69e35c7bb6	cadca8ec-879f-4f06-9295-1a9731149965	ce3225ba-19c4-42d9-a94e-547708f6d44a	SOFIU8ZE	ACTIVE	2026-05-24 02:47:38.086	2026-05-24 02:47:38.089	2026-05-24 02:47:38.089	ce3225ba-19c4-42d9-a94e-547708f6d44a	5.00
\.


--
-- Data for Name: deposit_requests; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.deposit_requests (id, "userId", "packageId", "paymentMethodId", amount, "receiptUrl", "receiptPublicId", status, "rejectionReason", "createdAt", "updatedAt", "creditsToDeliver", "packageNameAtMoment") FROM stdin;
eaf01ee4-b343-438a-befd-38705c537a5e	4e7e7405-7841-436d-a277-55b2d8c4299e	\N	3ba5b97f-1f37-4c33-a0b7-1111333a61fe	10.00	https://dummyimage.com/1200x800/eeeeee/111111.png&text=Comprobante+QA	seed/receipt-qa	APPROVED	\N	2026-04-04 01:45:38.952	2026-04-04 01:45:38.952	50	QA Recarga 50
5991a81c-f1ff-4508-9cf6-50bc4cd4f991	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	50.00	flow:9720B40F33FB3FE60E2472B4E2BB678CAADD808M	\N	APPROVED	\N	2026-04-05 06:48:52.553	2026-04-05 06:56:33.498	500	Navidad
70836388-6fc4-494d-bfef-748ea4e42612	599864fe-f89b-4445-8b25-7da50697043b	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:02F01325F19B30D5E0B9137ABFC4FB3F034F31FH	\N	APPROVED	\N	2026-04-05 19:30:32	2026-04-05 19:34:16.379	10	Paquete inicial 
44f97939-08ad-424e-b0be-2d8c04a88551	1da91f79-a244-4896-a7d7-08e15a34564b	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 01:30:14.155	2026-04-06 01:30:14.155	10	Paquete inicial 
7262edda-2d58-4c40-8440-a038a1772e2a	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	41fd4605-896e-4e63-a37d-df4b58d90f6f	\N	50.00	flow:pending	\N	PENDING	\N	2026-04-06 15:26:24.33	2026-04-06 15:26:24.33	50	Bronce
54fda281-c68e-421b-b5c7-2c60ff414f41	ed917127-6f95-432e-aed5-7c4a8cf4157f	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 19:14:39.467	2026-04-06 19:14:39.467	10	Paquete inicial 
d6a8eb57-78a5-426e-8ec4-ba17ad3afa61	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-06 20:47:13.369	2026-04-06 20:47:13.369	500	Navidad
e86dded7-046b-4720-9b9e-dc166694b03c	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e39aeeca-aabf-40b6-aac4-429348919a92	\N	30.00	flow:pending	\N	PENDING	\N	2026-04-06 20:47:22.101	2026-04-06 20:47:22.101	30	Otoño
e50ecbd8-bf50-4cfe-8d14-65106228ce7f	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 20:49:44.827	2026-04-06 20:49:44.827	10	Paquete inicial 
4f254c41-f1c4-42f8-9a19-1ceea49e0734	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 20:53:19.116	2026-04-06 20:53:19.116	10	Paquete inicial 
9c632a8a-6822-4307-9002-bbc2899a5f97	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:00:47.608	2026-04-06 21:00:47.608	10	Paquete inicial 
91bfbf1d-95d1-4f88-9520-d850fa06132c	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	41fd4605-896e-4e63-a37d-df4b58d90f6f	\N	50.00	flow:pending	\N	PENDING	\N	2026-04-06 21:05:57.107	2026-04-06 21:05:57.107	50	Bronce
e24c9790-f52a-42c3-b3ec-e8dde47ed2e5	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:11:19.472	2026-04-06 21:11:19.472	10	Paquete inicial 
e3596d4d-38ed-42bd-9933-4153306616a5	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:19:53.517	2026-04-06 21:19:53.517	10	Paquete inicial 
60640c11-f2ed-435f-93bf-9e586c5ec800	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:24:13.421	2026-04-06 21:24:13.421	10	Paquete inicial 
6f4f6caa-ffd9-4be6-98ab-f61a4a7d424d	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	17b2810a-310a-4391-b764-a7ceb8de256b	\N	200.00	flow:pending	\N	PENDING	\N	2026-04-06 21:29:06.795	2026-04-06 21:29:06.795	200	Premium
a99556b0-dda2-45aa-a41d-fdf864c24f19	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	01266b84-0479-49ab-bb22-2ae0276aeebf	\N	25.00	flow:pending	\N	PENDING	\N	2026-04-06 21:29:15.564	2026-04-06 21:29:15.564	25	Cash
e15e0093-699a-4f67-b59d-be869bfcd90d	04331537-fef9-439a-ab3e-c9ffbe3c2db4	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:50:48.133	2026-04-06 21:50:48.133	10	Paquete inicial 
ee029f8f-fcb9-4da8-91a9-db0bfb2daf58	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-06 22:00:27.849	2026-04-06 22:00:27.849	500	Navidad
4131c887-4c05-45f5-9beb-406307735bef	ab44e481-2f7a-49ea-91f0-16be463368ec	01266b84-0479-49ab-bb22-2ae0276aeebf	\N	25.00	flow:pending	\N	PENDING	\N	2026-04-06 22:38:11.184	2026-04-06 22:38:11.184	25	Cash
da98ab8c-77c7-4b52-bc7e-11593fe498a5	71406cb8-fd46-4cae-bf3c-bfef2cbd50a0	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 02:55:25.35	2026-04-07 02:55:25.35	10	Paquete inicial 
1daa550d-06cc-45d2-90d4-3e9705557ddc	ed917127-6f95-432e-aed5-7c4a8cf4157f	04423807-aaca-41e6-a305-66499af7ebf3	\N	100.00	flow:pending	\N	PENDING	\N	2026-04-07 04:16:50.074	2026-04-07 04:16:50.074	100	Platinium
e8e1652a-179b-4f07-a580-66724013917f	068de07b-6b37-4f64-9586-fb4196271108	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 04:48:09.737	2026-04-07 04:48:09.737	10	Paquete inicial 
5cda839d-2012-4807-8732-ce93d731c8e4	93586e5a-4fd0-4bd2-9287-fa4f308af08b	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 05:41:40.774	2026-04-07 05:41:40.774	10	Paquete inicial 
2eee56ee-80b9-4bc5-8ca9-accf450b68e4	1b80ea97-9a78-4674-804f-39ef05924c67	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-07 08:37:04.131	2026-04-07 08:37:04.131	500	Navidad
403a2531-9bc8-4423-a168-4a9bce470cf4	5643cd07-a7d4-478b-b66a-964dece5ad4f	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-07 12:39:14.12	2026-04-07 12:39:14.12	500	Navidad
a76f5671-a758-41ab-8669-192a6a0e8381	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 13:59:49.465	2026-04-07 13:59:49.465	10	Paquete inicial 
e9170094-fbe2-44ae-992a-0834212eee06	0d6251c4-0c8d-47e1-871f-d7446ce48732	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 21:13:47.77	2026-04-07 21:13:47.77	10	Paquete inicial 
a57545c2-aa57-4ef1-847c-aa72498547f9	9cfad3d0-e269-4d5e-adb2-1d745ab9d571	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-08 00:39:44.292	2026-04-08 00:39:44.292	10	Paquete inicial 
f9d150d5-7eac-4c49-ac70-143a79ca3845	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-08 19:30:15.768	2026-04-08 19:30:15.768	10	Paquete inicial 
118d3087-9e0b-4519-8fd5-5cd9433ee9d4	b2a44427-6ffb-4e4d-830b-714c80517b18	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-09 09:07:17.099	2026-04-09 09:07:17.099	10	Paquete inicial 
f04508b2-ebb8-43d6-9855-58673d1f8a8c	7fcb3884-c6b7-4320-b363-e1cefcd41878	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-10 09:52:38.16	2026-04-10 09:52:38.16	500	Navidad
f8cf410c-d23d-452e-a40d-c220fcf7006f	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-10 22:59:38.215	2026-04-10 22:59:38.215	500	Navidad
0a510b00-8376-4f9e-9b7e-0ca2dd99f6dd	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	01266b84-0479-49ab-bb22-2ae0276aeebf	\N	25.00	flow:pending	\N	PENDING	\N	2026-04-10 22:59:47.018	2026-04-10 22:59:47.018	25	Cash
b9df87b8-2ece-4c7b-9793-9798e7bf06e8	7669d18c-044c-4528-9acd-be58bd8bb137	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-11 04:00:36.82	2026-04-11 04:00:36.82	500	Navidad
c81f163c-b8f5-4490-a560-93536535d4de	2d91f582-36cd-4e9e-8224-cc02977a53c4	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-11 06:48:01.994	2026-04-11 06:48:01.994	10	Paquete inicial 
0a1991e2-4c5c-45a3-b2b9-f1d199583eb1	43747451-b9a7-4d8c-83a9-f6340bdc6c5c	17b2810a-310a-4391-b764-a7ceb8de256b	\N	200.00	flow:pending	\N	PENDING	\N	2026-04-11 12:54:43.664	2026-04-11 12:54:43.664	200	Premium
3afb128f-195f-4820-95cc-aa9367a7a24b	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-11 20:30:25.546	2026-04-11 20:30:25.546	500	Navidad
3c11b29f-21c9-4d3d-8b38-a628a2d1bf65	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	50.00	flow:pending	\N	PENDING	\N	2026-04-05 03:01:38.257	2026-04-05 03:01:38.257	500	Navidad
87e67e18-339f-401e-8b70-69d8cd4bf2d5	599864fe-f89b-4445-8b25-7da50697043b	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	50.00	flow:pending	\N	PENDING	\N	2026-04-05 13:21:55.92	2026-04-05 13:21:55.92	500	Navidad
4049b401-0320-4eba-94b6-ce8f04fff689	c66c79d2-b59e-41c3-aef0-ec1ce54c77d3	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-05 20:34:16.889	2026-04-05 20:34:16.889	10	Paquete inicial 
6c20a58a-4e08-4fcf-a6bf-f1f5b01349bd	a0275649-e6f1-48d5-9774-de80f2dcfd06	17b2810a-310a-4391-b764-a7ceb8de256b	\N	2000.00	flow:pending	\N	PENDING	\N	2026-04-06 02:43:34.267	2026-04-06 02:43:34.267	2000	Premiun
e074b278-7d56-4ca6-8185-a6a5a2fcce3f	fa4d11c0-b6a4-43db-81e9-2a0b247af9ef	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 17:53:04.675	2026-04-06 17:53:04.675	10	Paquete inicial 
6b7936c7-17b0-4bb8-9ac2-6dbcbc2911be	d2c48c15-9d40-47e7-ba16-12cb5d2ee4ca	01266b84-0479-49ab-bb22-2ae0276aeebf	\N	25.00	flow:pending	\N	PENDING	\N	2026-04-06 20:10:31.448	2026-04-06 20:10:31.448	25	Cash
34fc1c4f-cfcf-4e8d-a3d0-8faf147c0365	72ebb69d-756a-4924-8a1e-80d5b794c07b	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-06 20:36:33.95	2026-04-06 20:36:33.95	500	Navidad
ba507e9f-ffd6-4588-8e51-f3878502c04a	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 20:47:45.984	2026-04-06 20:47:45.984	10	Paquete inicial 
535cd5d2-e15a-4921-b771-18b0a504377d	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-06 20:52:17.103	2026-04-06 20:52:17.103	500	Navidad
c0b5cac9-394d-4268-831d-40150e1ed17e	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 20:56:57.969	2026-04-06 20:56:57.969	10	Paquete inicial 
c4b0599d-584b-48a2-b926-eb554c9ed659	17996dbb-d4ba-4bef-b265-115cb4a281aa	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-06 21:01:32.127	2026-04-06 21:01:32.127	500	Navidad
c8666d6d-781b-4c8c-b358-d2a6e95c7c9d	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-06 21:07:59.193	2026-04-06 21:07:59.193	500	Navidad
f4a01e08-9868-410d-bc0d-e819143fee2b	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	17b2810a-310a-4391-b764-a7ceb8de256b	\N	200.00	flow:pending	\N	PENDING	\N	2026-04-06 21:08:04.416	2026-04-06 21:08:04.416	200	Premium
6348371e-937a-4232-bea7-6f928faacdbd	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	01266b84-0479-49ab-bb22-2ae0276aeebf	\N	25.00	flow:pending	\N	PENDING	\N	2026-04-06 21:08:11.939	2026-04-06 21:08:11.939	25	Cash
2597fa36-022e-4ed1-9934-a0714260e752	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:08:20.334	2026-04-06 21:08:20.334	10	Paquete inicial 
c6cb89d5-bdc9-4f43-884b-0e46d4a136c8	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:13:28.454	2026-04-06 21:13:28.454	10	Paquete inicial 
86e8ebf8-3ec1-4731-8c52-86ff11a569c0	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e39aeeca-aabf-40b6-aac4-429348919a92	\N	30.00	flow:pending	\N	PENDING	\N	2026-04-06 21:13:35.02	2026-04-06 21:13:35.02	30	Otoño
c9c04227-142e-4f58-84c8-cd5376f3f526	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:13:40.801	2026-04-06 21:13:40.801	10	Paquete inicial 
9b092f10-7434-47b6-b8e2-5d798243b6ab	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:21:54.556	2026-04-06 21:21:54.556	10	Paquete inicial 
50c0f126-0184-47e2-b4aa-fec1b8c0655b	1d005ba4-b597-475f-964d-90ad921e9020	01266b84-0479-49ab-bb22-2ae0276aeebf	\N	25.00	flow:pending	\N	PENDING	\N	2026-04-06 21:27:49.281	2026-04-06 21:27:49.281	25	Cash
f2529da3-1e17-4a83-b6a0-a5e7f83294d2	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e39aeeca-aabf-40b6-aac4-429348919a92	\N	30.00	flow:pending	\N	PENDING	\N	2026-04-06 21:49:19.312	2026-04-06 21:49:19.312	30	Otoño
b5ddfac6-1854-49f8-9c4d-15886f854b91	03daa672-341a-4cce-91ab-81f3159a7036	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:54:19.325	2026-04-06 21:54:19.325	10	Paquete inicial 
be457f1b-0e03-4689-a625-aac1d7ad7cc6	36df8ef2-4651-426d-ba5f-a3edc5984168	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 22:12:07.748	2026-04-06 22:12:07.748	10	Paquete inicial 
0210b942-de1b-498e-aa02-e3f7926aa7c1	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-07 00:27:09.924	2026-04-07 00:27:09.924	500	Navidad
de8fe896-ebd3-4072-90b3-42433a65e57c	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 04:08:44.663	2026-04-07 04:08:44.663	10	Paquete inicial 
5dc9facf-a48c-49ad-b7d4-48bf1e664714	ed917127-6f95-432e-aed5-7c4a8cf4157f	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:3E9516EE2AF931B2D6294F68980E88FD8D059DAJ	\N	APPROVED	\N	2026-04-07 04:17:55.635	2026-04-07 04:19:01.517	10	Paquete inicial 
4afec911-ae02-4bc7-8e46-21844f8023df	66d5c599-eca6-4dd4-80a9-ba19de3f0e22	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 05:16:10.567	2026-04-07 05:16:10.567	10	Paquete inicial 
6df1cad9-0dbe-4563-9430-37cd812b5ba4	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 07:55:24.77	2026-04-07 07:55:24.77	10	Paquete inicial 
09325700-0b3d-461a-a343-b75ab554b16d	1b80ea97-9a78-4674-804f-39ef05924c67	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 08:37:57.222	2026-04-07 08:37:57.222	10	Paquete inicial 
bfd10b1e-eb59-4094-acd8-1da9e7e8479f	1b80ea97-9a78-4674-804f-39ef05924c67	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:2560066E8F4C828375328F35AE20D41D90C9AEBI	\N	APPROVED	\N	2026-04-07 12:44:22.681	2026-04-07 12:47:07.048	10	Paquete inicial 
c7248cf9-a46f-456c-896e-9992bf912095	8f939ead-58b8-4491-9485-1b885ad125b4	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 16:04:21.119	2026-04-07 16:04:21.119	10	Paquete inicial 
f0e0dffa-9883-419e-9359-6c84448d1dfc	6aea1710-2fa4-4f91-9516-365e823a32d4	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-08 00:04:34.247	2026-04-08 00:04:34.247	10	Paquete inicial 
23ea72a0-c662-45b2-831f-f28823ac8c54	178ced85-ad0e-4ba4-9cd7-27020fbd3777	01266b84-0479-49ab-bb22-2ae0276aeebf	\N	25.00	flow:pending	\N	PENDING	\N	2026-04-08 00:50:34.267	2026-04-08 00:50:34.267	25	Cash
c8ca8396-3650-4bc0-a4eb-d3da0b403052	81c8998a-a498-40ad-8c01-bb0825873033	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-09 02:34:02.298	2026-04-09 02:34:02.298	10	Paquete inicial 
f9e7cd97-d0d1-4698-ae7c-b7003178c278	5004709f-d63e-4e19-88e0-a888aa06482d	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-10 18:26:50.299	2026-04-10 18:26:50.299	10	Paquete inicial 
fe4633c1-bb42-4110-ac4c-db6833e948f8	36e462f3-a9c2-4837-b8ac-481293147bae	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-11 01:31:14.719	2026-04-11 01:31:14.719	10	Paquete inicial 
5e06575c-d426-460e-844d-38763a8e0383	b8875411-fa9d-4256-b7e0-6a725a3f1436	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-11 04:27:42.071	2026-04-11 04:27:42.071	10	Paquete inicial 
68ca33f1-adfe-4090-b7c2-fdb5b943ed39	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	01266b84-0479-49ab-bb22-2ae0276aeebf	\N	25.00	flow:pending	\N	PENDING	\N	2026-04-11 12:33:14.843	2026-04-11 12:33:14.843	25	Cash
ccaabb42-1dde-48d5-b218-b3839830755c	04273fa9-2979-4a3c-81e7-f8d17b3c2d4a	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-05 06:39:34.526	2026-04-05 06:39:34.526	100	Paquete inicial 
326c5a27-04f8-4b3a-b39e-225f24935155	c2e6c369-0649-46e8-a0e2-b888d83d131f	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-05 17:50:34.556	2026-04-05 17:50:34.556	10	Paquete inicial 
38a3b4b4-f137-4f8f-b2ee-c2fc584c9754	e66556cc-de35-467c-bffb-2bb10f08adef	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-05 22:52:05.52	2026-04-05 22:52:05.52	10	Paquete inicial 
4d0fe7d2-84da-4b9f-8b22-9f705fcc7f93	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 19:14:29.829	2026-04-06 19:14:29.829	10	Paquete inicial 
d720b550-d466-4e3a-8d96-0362cc77465f	59b401d0-9e20-4ada-82f4-ed81872c43d7	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 20:14:15.256	2026-04-06 20:14:15.256	10	Paquete inicial 
218cdab2-bc3c-4250-8c21-07ec69b2151e	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	04423807-aaca-41e6-a305-66499af7ebf3	\N	100.00	flow:pending	\N	PENDING	\N	2026-04-06 20:46:25.989	2026-04-06 20:46:25.989	100	Platinium
bf483c04-56bf-4489-8d94-adb91b8650f2	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 20:47:57.158	2026-04-06 20:47:57.158	10	Paquete inicial 
4e3a307d-48e9-4a9a-a8d2-5c3070d7c29c	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 20:52:53.82	2026-04-06 20:52:53.82	10	Paquete inicial 
7289027e-cfb3-4212-99c6-7fdb10b8aef0	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 20:57:49.406	2026-04-06 20:57:49.406	10	Paquete inicial 
4e91b931-48fa-4e24-bc5a-c803a7309af0	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:03:05.062	2026-04-06 21:03:05.062	10	Paquete inicial 
42fe1020-cb26-43db-9895-2939cdee680e	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:09:23.461	2026-04-06 21:09:23.461	10	Paquete inicial 
76ddd25f-695e-430d-b69d-1ae9e782c3be	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:16:46.393	2026-04-06 21:16:46.393	10	Paquete inicial 
e032cec5-c5cc-4eae-87bb-d0e913bced51	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:16:54.555	2026-04-06 21:16:54.555	10	Paquete inicial 
f1efecc7-77c0-4f45-9aa8-94e98d3ef23d	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:23:53.859	2026-04-06 21:23:53.859	10	Paquete inicial 
9ff11e5f-b770-4564-9b2d-fa4929b44018	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	41fd4605-896e-4e63-a37d-df4b58d90f6f	\N	50.00	flow:pending	\N	PENDING	\N	2026-04-06 21:28:52.667	2026-04-06 21:28:52.667	50	Bronce
cbb8fc47-63fc-4fdb-93a1-7b866ff83647	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	01266b84-0479-49ab-bb22-2ae0276aeebf	\N	25.00	flow:pending	\N	PENDING	\N	2026-04-06 21:49:59.193	2026-04-06 21:49:59.193	25	Cash
4545de7b-9df3-42a0-8f17-24e900e94a97	36df8ef2-4651-426d-ba5f-a3edc5984168	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-06 21:54:30.113	2026-04-06 21:54:30.113	10	Paquete inicial 
407c3a33-dc95-497d-bd51-f1a0990d0af1	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:AF8841FC31F43354797B5C76E81DCA51FE7EC59A	\N	APPROVED	\N	2026-04-03 12:43:39.19	2026-04-03 12:44:15.992	100	Paquete inicial 
d5163677-f342-40e2-8165-30af85dd54e0	304884e0-e87c-44b3-a135-525fcc3b24d6	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	50.00	flow:C2B283F1F8F55D1DFD29882919A1911B0F11C19P	\N	APPROVED	\N	2026-04-03 13:13:28.158	2026-04-03 13:14:13.77	500	Navidad
55ea5601-0666-411d-b38b-871aaab576be	304884e0-e87c-44b3-a135-525fcc3b24d6	17b2810a-310a-4391-b764-a7ceb8de256b	\N	200.00	flow:pending	\N	PENDING	\N	2026-04-03 16:35:57.915	2026-04-03 16:35:57.915	2000	Premiun
75ee4287-b143-4912-b9fb-52394a4fccca	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-03 16:37:10.413	2026-04-03 16:37:10.413	100	Paquete inicial 
67771959-6593-4e79-b9a2-0af0b43a8efa	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:5CA4A344AC477B56DFFC9A222357BBA89F53150R	\N	APPROVED	\N	2026-04-03 19:42:34.827	2026-04-03 19:43:03.487	100	Paquete inicial 
619a30c8-6641-457f-a210-8a4be8468ebf	304884e0-e87c-44b3-a135-525fcc3b24d6	17b2810a-310a-4391-b764-a7ceb8de256b	\N	200.00	flow:pending	\N	PENDING	\N	2026-04-03 20:18:51.41	2026-04-03 20:18:51.41	2000	Premiun
970b4d9c-5e3d-4dfd-8860-ac2d8715f885	304884e0-e87c-44b3-a135-525fcc3b24d6	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	50.00	flow:pending	\N	PENDING	\N	2026-04-03 20:19:22.333	2026-04-03 20:19:22.333	500	Navidad
ef9fa127-09ef-4927-aa19-d9904d5fbdd7	36df8ef2-4651-426d-ba5f-a3edc5984168	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:52ACF75DCBA6D8630F207825C1A19C8D0C5298ED	\N	APPROVED	\N	2026-04-06 22:24:29.129	2026-04-06 22:27:56.397	10	Paquete inicial 
42a7b1ce-0bc5-46d4-bdae-4b69e63a7b44	71406cb8-fd46-4cae-bf3c-bfef2cbd50a0	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-07 02:54:44.31	2026-04-07 02:54:44.31	500	Navidad
74cd03fb-0241-489d-ad11-76bd8fef5b85	ed917127-6f95-432e-aed5-7c4a8cf4157f	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 04:16:21.742	2026-04-07 04:16:21.742	10	Paquete inicial 
593bdd33-e9fd-40d7-aedf-21800cec38ae	ed917127-6f95-432e-aed5-7c4a8cf4157f	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:49CFA59D799F454298ABC2854C4AFC8856462EDC	\N	APPROVED	\N	2026-04-07 04:21:48.143	2026-04-07 04:23:50.247	10	Paquete inicial 
ceef15da-707a-43b6-8d35-f99634af2db4	b20f5b97-e85a-46e0-a77e-7839a7c5641f	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-07 05:22:53.795	2026-04-07 05:22:53.795	500	Navidad
cebaebba-0371-491e-87cc-507c60a702d3	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 07:56:03.897	2026-04-07 07:56:03.897	10	Paquete inicial 
37bc62c6-4de7-419c-91bc-92e5ae0ffeaa	d2a7dadb-154c-442e-9806-bb52e9e380f1	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 11:01:17.788	2026-04-07 11:01:17.788	10	Paquete inicial 
0569f351-6b1a-4971-8ffe-2bfcd9786d2a	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 12:53:05.705	2026-04-07 12:53:05.705	10	Paquete inicial 
067928ff-05f6-4139-81c7-042ac3bc4bfb	b2351447-b63a-4e96-ab43-092fb29b8b06	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-07 19:28:02.606	2026-04-07 19:28:02.606	10	Paquete inicial 
c40b82f3-7d43-401d-92e6-43fb8d54cf12	6aea1710-2fa4-4f91-9516-365e823a32d4	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-08 00:09:07.567	2026-04-08 00:09:07.567	10	Paquete inicial 
4536fedf-ba55-4376-9da2-97ba657ada1b	f5dafb55-6ad4-43f9-a8e2-8d2f29560c2a	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-08 12:26:00.667	2026-04-08 12:26:00.667	10	Paquete inicial 
80f6a349-0ac0-495d-837f-e070fb6daf8e	b2a44427-6ffb-4e4d-830b-714c80517b18	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-09 09:03:33.814	2026-04-09 09:03:33.814	10	Paquete inicial 
bb0c3717-1338-40e7-b791-f7e10ed91a81	a28528b4-e871-4137-a29b-b39f512397a6	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-10 19:40:30.565	2026-04-10 19:40:30.565	500	Navidad
741a0885-d587-4c95-aea4-4d3f046251c6	c1c9af7f-cbd3-4e91-87e9-2d233baf7ad6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-11 03:56:17.812	2026-04-11 03:56:17.812	10	Paquete inicial 
cc1651b8-343f-49dd-89ca-7e4de4270dbe	de5c1082-08ac-4424-a539-81a3a5d93100	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-12 02:29:11.039	2026-04-12 02:29:11.039	500	Navidad
0512720e-10e2-41a9-99e4-79fc44a544d7	3d050fac-5afa-4667-8363-63b858f7c7a1	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-12 04:14:43.634	2026-04-12 04:14:43.634	500	Navidad
6e6a6ba9-9e1a-422e-832c-4bd5bd42a0a4	fb214014-a2a2-41df-950b-b3950525c4b5	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-12 11:18:23.339	2026-04-12 11:18:23.339	500	Navidad
9c88c342-b08e-4237-9ffe-404f9f7a570c	ba6b5d64-e36a-45fa-ae19-6c740bc88681	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-12 11:25:25.888	2026-04-12 11:25:25.888	500	Navidad
212a00bd-2871-44fe-a443-0e0a5034c7b4	3b523806-29d5-4986-822d-20a397b04b97	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-12 14:35:33.576	2026-04-12 14:35:33.576	10	Paquete inicial 
29e7b48b-9755-41f5-8bbd-776f32d515c0	b32efeef-d31a-4665-b5ae-904cf68690cf	01266b84-0479-49ab-bb22-2ae0276aeebf	\N	25.00	flow:pending	\N	PENDING	\N	2026-04-12 19:29:56.384	2026-04-12 19:29:56.384	25	Cash
a4bd23d6-1adb-481a-bf7b-e8951d94901e	679437af-12b9-4053-b833-572033277abf	01266b84-0479-49ab-bb22-2ae0276aeebf	\N	25.00	flow:pending	\N	PENDING	\N	2026-04-15 02:25:46.231	2026-04-15 02:25:46.231	25	Cash
a9604bf1-16fb-454c-b5d3-00de146796f8	ed917127-6f95-432e-aed5-7c4a8cf4157f	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-17 06:48:28.551	2026-04-17 06:48:28.551	10	Paquete inicial 
ee9ea85b-b2b0-4108-8268-ea81b119efaf	67102934-186c-4281-8114-bfe9917fd8c0	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-17 21:55:54.147	2026-04-17 21:55:54.147	10	Paquete inicial 
1ed9dbe2-bdc5-49e0-a884-fc18e20c4071	28ad9e87-7377-4515-ac11-5c14512a382b	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-20 09:42:40.223	2026-04-20 09:42:40.223	500	Navidad
d2b0054d-4ee0-4fa4-842c-07d382924b52	28ad9e87-7377-4515-ac11-5c14512a382b	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-20 09:43:36.85	2026-04-20 09:43:36.85	10	Paquete inicial 
c71d4d7f-f243-438c-adce-bff2666cef90	28ad9e87-7377-4515-ac11-5c14512a382b	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-20 09:48:34.961	2026-04-20 09:48:34.961	10	Paquete inicial 
88fb0027-86bd-4322-bc1c-5ae0ddfec8d6	bb724137-7699-4ec2-9aa5-c59c6bfbe416	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-22 15:47:52.085	2026-04-22 15:47:52.085	500	Navidad
4cfc098f-d910-4c7b-9380-9b49d282d197	bb724137-7699-4ec2-9aa5-c59c6bfbe416	04423807-aaca-41e6-a305-66499af7ebf3	\N	100.00	flow:pending	\N	PENDING	\N	2026-04-22 15:48:59.27	2026-04-22 15:48:59.27	100	Platinium
016c2b1c-de4a-416d-b53c-66e43926567c	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-23 20:18:35.935	2026-04-23 20:18:35.935	10	Paquete inicial 
1b1d9605-fcd4-4f14-86c6-12df263e9f95	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-23 22:30:22.586	2026-04-23 22:30:22.586	500	Navidad
dc58bdbe-4548-4b26-946c-382a0fbd9895	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:pending	\N	PENDING	\N	2026-04-24 01:12:56.596	2026-04-24 01:12:56.596	10	Paquete inicial 
fc974fa0-0297-4157-a941-aef25a3e43b6	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:pending	\N	PENDING	\N	2026-04-24 01:15:56.159	2026-04-24 01:15:56.159	10	Paquete inicial 
dfc448ec-8a9d-418e-a9df-0815ada9c631	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	125.00	paypal:pending	\N	PENDING	\N	2026-04-24 01:18:59.542	2026-04-24 01:18:59.542	500	Navidad
71a3b257-1cbc-4667-999c-a2b7ce92c75e	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	125.00	paypal:0Y534996SJ090451A	\N	PENDING	\N	2026-04-24 01:26:36.259	2026-04-24 01:26:37.458	500	Navidad
f85bddce-e1ef-4e1b-bcf4-ad725e4ca26a	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:0L624023L0016452D	\N	PENDING	\N	2026-04-24 01:26:56.035	2026-04-24 01:26:56.718	10	Paquete inicial 
fdbfebe5-c170-4aae-9a9b-0530cab0fd82	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	125.00	paypal:9W412427YX355993R	\N	PENDING	\N	2026-04-24 01:28:19.779	2026-04-24 01:28:21.979	500	Navidad
c18056db-bc88-42f4-9c9d-322cb882daa3	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-24 01:37:35.442	2026-04-24 01:37:35.442	500	Navidad
9ff4e450-5ee6-4729-bb0e-e90d3076eff4	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	125.00	paypal:9PU356476W777023M	\N	PENDING	\N	2026-04-24 21:16:34.919	2026-04-24 21:16:35.655	500	Navidad
ef767179-aeb4-4c31-8402-80abad5e943b	ed917127-6f95-432e-aed5-7c4a8cf4157f	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-04-24 23:34:06.735	2026-04-24 23:34:06.735	10	Paquete inicial 
8b65a6db-3939-4bf8-8360-2948d7f23c02	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:12W20804T5099123C	\N	PENDING	\N	2026-04-24 23:47:42.783	2026-04-24 23:47:43.433	10	Paquete inicial 
f2ac948e-9ba8-4d15-9912-7d79a346bb0f	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:9YM92664FT762854A	\N	PENDING	\N	2026-04-24 23:48:40.096	2026-04-24 23:48:40.432	10	Paquete inicial 
63d97032-33a2-42b3-9035-d97e99bfa58b	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:78M275717M486964L	\N	PENDING	\N	2026-04-25 00:30:01.062	2026-04-25 00:30:01.436	10	Paquete inicial 
e1cbfd76-06dc-4a4b-9021-e83dd70cb767	304884e0-e87c-44b3-a135-525fcc3b24d6	04423807-aaca-41e6-a305-66499af7ebf3	\N	25.00	paypal:7LN98680ES035284V	\N	PENDING	\N	2026-04-25 00:31:50.789	2026-04-25 00:31:51.083	100	Platinium
cc9a0965-2154-49c9-934f-fa6742361658	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:5VM22410V7732405E	\N	PENDING	\N	2026-04-25 01:18:30.871	2026-04-25 01:18:31.336	10	Paquete inicial 
7195367c-9f6d-4e4c-9f6b-c23bfb71bd4b	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:16R22463EJ547420J	\N	PENDING	\N	2026-04-25 01:26:20.908	2026-04-25 01:26:21.224	10	Paquete inicial 
6adfcd06-f93b-45c0-ac15-56bb3df5096b	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:78V93311A77292454	\N	PENDING	\N	2026-04-25 01:35:25.3	2026-04-25 01:35:25.619	10	Paquete inicial 
a6a97a7a-3115-40e3-8029-c69aa9b2c9f8	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:3AB07801FE048382L	\N	PENDING	\N	2026-04-25 01:40:30.449	2026-04-25 01:40:31.166	10	Paquete inicial 
75c358b1-5d4e-4d32-9bfc-cacdf8ff4292	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:72770220UP773405M	\N	PENDING	\N	2026-04-25 01:41:07.562	2026-04-25 01:41:07.829	10	Paquete inicial 
8d4dd508-4493-4bfd-9b69-972bf8ac5558	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:5W531556EA920291E	\N	PENDING	\N	2026-04-25 01:43:55.44	2026-04-25 01:43:55.712	10	Paquete inicial 
25c93666-ef5a-4ded-ba8b-fa46af9314cc	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:5CP63469XX4927608	\N	PENDING	\N	2026-04-25 01:47:58.68	2026-04-25 01:47:58.984	10	Paquete inicial 
c7c0200f-8767-45a3-8be8-20b7fece9c56	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:28K154157S3755043	\N	PENDING	\N	2026-04-25 01:55:02.667	2026-04-25 01:55:02.988	10	Paquete inicial 
578cd387-9b5b-4590-861e-665e63efa2fd	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:8RG9581063886484X	\N	PENDING	\N	2026-04-25 01:58:43.499	2026-04-25 01:58:43.772	10	Paquete inicial 
e769be1d-92f1-4847-b1aa-b03fa3aa362e	304884e0-e87c-44b3-a135-525fcc3b24d6	01266b84-0479-49ab-bb22-2ae0276aeebf	\N	6.25	paypal:31X57075XK602891P	\N	PENDING	\N	2026-04-25 01:58:59.498	2026-04-25 01:58:59.753	25	Cash
410422db-9078-4119-839b-5acb0a95ea41	304884e0-e87c-44b3-a135-525fcc3b24d6	e39aeeca-aabf-40b6-aac4-429348919a92	\N	7.50	paypal:1KH35745NS720221N	\N	PENDING	\N	2026-04-25 01:59:10.227	2026-04-25 01:59:10.499	30	Otoño
ba5051a9-6752-4fb9-9161-9bcc267a1963	304884e0-e87c-44b3-a135-525fcc3b24d6	17b2810a-310a-4391-b764-a7ceb8de256b	\N	50.00	paypal:19J54616A15219401	\N	PENDING	\N	2026-04-25 01:59:30.102	2026-04-25 01:59:30.379	200	Premium
117266bd-7f16-4f78-8171-a1f849e2ad52	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:1AB18890GT5698206	\N	PENDING	\N	2026-04-25 09:06:00.143	2026-04-25 09:06:00.839	10	Paquete inicial 
d8d9c429-b465-4dbf-8fe7-b72a33f26363	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	125.00	paypal:6RB03802028250605	\N	PENDING	\N	2026-04-25 13:03:16.354	2026-04-25 13:03:17.079	500	Navidad
0d0f456f-0097-4e55-8076-bddd82a6e430	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	125.00	paypal:305647373B9325401	\N	PENDING	\N	2026-04-25 13:03:50.973	2026-04-25 13:03:51.308	500	Navidad
9cfe0e2c-1144-4262-bd79-a42be6a6b31e	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:77J57495AF6659455	\N	PENDING	\N	2026-04-25 13:04:00.326	2026-04-25 13:04:00.601	10	Paquete inicial 
26352a7c-e331-4085-b316-720b24854eec	a5e6330c-0958-4715-bca2-05477d265316	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-04-25 17:35:08.967	2026-04-25 17:35:08.967	500	Navidad
f2f60cec-1fcc-4090-9b5a-c58fd7210f07	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:12094348B7748270L	\N	PENDING	\N	2026-04-25 18:37:06.95	2026-04-25 18:37:07.344	10	Paquete inicial 
a6cf1579-7298-40dd-9e96-510fcd695a93	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:3Y702941DW593132W	\N	PENDING	\N	2026-04-25 19:39:22.456	2026-04-25 19:39:22.819	10	Paquete inicial 
3d54d5bf-da4f-49e1-88c3-93ce46c8cba5	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:3EL848040R5047058	\N	PENDING	\N	2026-04-25 19:41:11.657	2026-04-25 19:41:11.981	10	Paquete inicial 
b23167b3-ec9d-4097-87a1-205886c3f8dd	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:9R639454EC149024N	\N	PENDING	\N	2026-04-25 19:48:07.328	2026-04-25 19:48:07.674	10	Paquete inicial 
cf4b103e-41fd-462d-b4be-2648cf964869	304884e0-e87c-44b3-a135-525fcc3b24d6	e39aeeca-aabf-40b6-aac4-429348919a92	\N	7.50	paypal:75U83612T3377003F	\N	PENDING	\N	2026-04-25 20:31:08.905	2026-04-25 20:31:09.218	30	Otoño
f2e92f18-a4fe-4a0c-b2bc-2107fb6ecccf	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	125.00	paypal:7E526475E4931981Y	\N	PENDING	\N	2026-04-25 23:46:01.707	2026-04-25 23:46:03.198	500	Navidad
5caf3170-cd81-4ac7-8813-f0e2ec3dd67b	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:1M401726S5092335U	\N	PENDING	\N	2026-04-25 23:47:23.582	2026-04-25 23:47:24.449	10	Paquete inicial 
8690887a-1e2e-417b-8abf-b814aaa2232f	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:90J088868T566220P	\N	PENDING	\N	2026-04-26 00:08:44.788	2026-04-26 00:08:45.827	10	Paquete inicial 
61366f99-4a11-4981-a474-3c1fc6e38db1	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:1AR01146TA1959257	\N	PENDING	\N	2026-04-26 00:09:03.419	2026-04-26 00:09:04.065	10	Paquete inicial 
85607009-2370-431a-a6b5-7a92848e45b9	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:87S19358VK741031J	\N	PENDING	\N	2026-04-26 00:16:39.327	2026-04-26 00:16:40.907	10	Paquete inicial 
bc798643-4bc6-4a21-bb44-7d94a67d7d1f	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:6YH732264N432171D	\N	PENDING	\N	2026-04-26 00:21:26.307	2026-04-26 00:21:28.185	10	Paquete inicial 
3d71b906-974d-4828-b5c7-b5a2284a949f	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:5FC900939N4039256	\N	PENDING	\N	2026-04-26 00:24:37.43	2026-04-26 00:24:38.146	10	Paquete inicial 
96e0440a-c633-454a-ba7a-b107dca55499	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:2MN15580X4403904Y	\N	PENDING	\N	2026-04-26 00:50:20.38	2026-04-26 00:50:21.484	10	Paquete inicial 
f35eb513-c110-493c-9cb2-ee26abb997d8	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:22W39332PN170713B	\N	APPROVED	\N	2026-04-26 00:29:03.766	2026-04-26 00:33:09.952	10	Paquete inicial 
eb8505a8-0f23-47e6-ba95-3a6f69fa903c	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:6KG61456B7913594S	\N	PENDING	\N	2026-04-26 00:44:19.77	2026-04-26 00:44:21.16	10	Paquete inicial 
0f6ae9ba-e317-46d6-9a09-9da1658ec687	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:7DH44837WT980805W	\N	PENDING	\N	2026-04-26 00:53:04.989	2026-04-26 00:53:05.724	10	Paquete inicial 
8e18cf9b-7f49-46fc-b394-a587d3c5eabb	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:8T62546117652074J	\N	PENDING	\N	2026-04-26 00:54:39.585	2026-04-26 00:54:40.849	10	Paquete inicial 
cbc65948-7d6f-41f7-a553-ad218e4448b9	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:0AB67105068236512	\N	PENDING	\N	2026-04-26 00:55:18.378	2026-04-26 00:55:19.128	10	Paquete inicial 
32881e11-9e80-4284-a543-a5a1190da967	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:0DV873834W936824R	\N	PENDING	\N	2026-04-26 00:56:33.685	2026-04-26 00:56:34.822	10	Paquete inicial 
935ab14a-6ef6-401b-9379-6616164dc3d1	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:20U03889EJ855143N	\N	PENDING	\N	2026-04-26 00:57:04.587	2026-04-26 00:57:05.375	10	Paquete inicial 
8b8df09b-ff13-4240-bd92-71bc9628def9	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e39aeeca-aabf-40b6-aac4-429348919a92	\N	7.50	paypal:90A472063B969302T	\N	PENDING	\N	2026-04-26 00:57:33.589	2026-04-26 00:57:34.236	30	Otoño
4998b7d0-5de6-4349-a153-17cd28f12b58	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:2TM64772YY9781908	\N	PENDING	\N	2026-04-26 00:58:33.157	2026-04-26 00:58:33.907	10	Paquete inicial 
fb6485f0-ca82-464c-81ab-8d6c55ff6912	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:1J679979PT6378520	\N	PENDING	\N	2026-04-26 01:02:31.225	2026-04-26 01:02:31.894	10	Paquete inicial 
0e4cf87b-bf79-4c40-9aca-a44c0187f6fc	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:7R1648241N601564G	\N	PENDING	\N	2026-04-26 01:02:49.908	2026-04-26 01:02:50.461	10	Paquete inicial 
6e8787dc-5ed7-435c-85bf-9f60daba6544	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:7UC28004T02437423	\N	PENDING	\N	2026-04-26 01:03:39.595	2026-04-26 01:03:40.721	10	Paquete inicial 
12452ce1-1695-435a-ae4a-f060c685f6a4	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:9LN89285HK3729522	\N	PENDING	\N	2026-04-26 01:25:51.599	2026-04-26 01:25:51.947	10	Paquete inicial 
99dea216-78d5-4f29-83df-4872998802be	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:6RX19522CM4376415	\N	PENDING	\N	2026-04-26 21:09:41.36	2026-04-26 21:09:42.01	10	Paquete inicial 
8233464f-9291-4086-be0b-f14db892553d	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:1VV28922MG4892741	\N	PENDING	\N	2026-04-26 21:16:03.605	2026-04-26 21:16:03.94	10	Paquete inicial 
980ee7e5-ed87-4def-ac89-64a6612ecea3	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:4HK54798H02510446	\N	PENDING	\N	2026-04-27 00:17:25.523	2026-04-27 00:17:27.02	10	Paquete inicial 
318d5275-31a3-4fec-b732-b6e663907f30	5899b52e-6c02-4877-965d-0a4439257dae	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-04-29 00:53:33.542	2026-04-29 00:53:33.542	4	test
1df07374-dc14-49aa-8bad-5d0f2cebb880	5899b52e-6c02-4877-965d-0a4439257dae	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-04-29 00:54:16.502	2026-04-29 00:54:16.502	4	test
e37fccf2-537d-4730-9acf-88b1499a1a56	5899b52e-6c02-4877-965d-0a4439257dae	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-04-29 00:56:19.142	2026-04-29 00:56:19.142	4	test
42e25bb8-6d5a-4810-a3ca-2666ce2520d4	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	1.00	paypal:5A545155HH949535P	\N	PENDING	\N	2026-04-29 22:51:16.244	2026-04-29 22:51:17.017	4	test
7a76d17d-75d9-4de1-9add-9c137aef6722	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	41fd4605-896e-4e63-a37d-df4b58d90f6f	\N	50.00	flow:pending	\N	PENDING	\N	2026-04-30 00:12:19.154	2026-04-30 00:12:19.154	50	Bronce
50656222-9264-45e7-a113-5318b2eadc88	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	41fd4605-896e-4e63-a37d-df4b58d90f6f	\N	50.00	flow:pending	\N	PENDING	\N	2026-04-30 00:12:53.971	2026-04-30 00:12:53.971	50	Bronce
4cfaa3b3-258f-430c-9ad7-63ff38b59862	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	41fd4605-896e-4e63-a37d-df4b58d90f6f	\N	50.00	flow:pending	\N	PENDING	\N	2026-04-30 00:13:18.137	2026-04-30 00:13:18.137	50	Bronce
86eb2e1d-f0a9-41e6-aa2c-7ad536c08292	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	1.00	paypal:9EN185662S880760L	\N	PENDING	\N	2026-04-30 00:56:25.332	2026-04-30 00:56:25.648	4	test
23cf4c1a-aefc-4d85-9a6e-93914c60aeab	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	1.00	paypal:43777550JM213635G	\N	PENDING	\N	2026-04-30 01:46:51.157	2026-04-30 01:46:51.471	4	test
c3eb9ee8-aab6-427a-894d-24df449331e4	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	1.00	paypal:6YH597954E750054T	\N	PENDING	\N	2026-05-01 13:26:28.472	2026-05-01 13:26:29.871	4	test
0061d0a4-1762-4041-b073-5bdbd3163bdb	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:9UJ3265701275744C	\N	PENDING	\N	2026-05-01 13:28:27.974	2026-05-01 13:28:29.243	10	Paquete inicial 
2283f446-ffb4-4c38-9cc2-cb278d35cc4e	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	1.00	paypal:32442729TR8394251	\N	PENDING	\N	2026-05-01 13:28:53.658	2026-05-01 13:28:54.435	4	test
511ce048-40e3-430d-80b9-3ad726e05cb2	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	1.00	paypal:7M331307CE111133P	\N	PENDING	\N	2026-05-01 13:31:16.235	2026-05-01 13:31:16.949	4	test
e59d9059-8b2c-4ac5-96a6-b470f1c8737a	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	1.00	paypal:52P91172XY2481353	\N	PENDING	\N	2026-05-01 13:32:00.379	2026-05-01 13:32:01.096	4	test
ce0ec7eb-3a43-4fa4-a99d-6c1ea2ab326f	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	1.00	paypal:6F891036MA391753W	\N	PENDING	\N	2026-05-01 13:32:52.433	2026-05-01 13:32:53.066	4	test
79859003-3fae-4838-8391-30d667268dd8	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	1.00	paypal:8D619581LN776640K	\N	PENDING	\N	2026-05-01 13:35:43.302	2026-05-01 13:35:44.044	4	test
e76128d6-1562-461a-8643-501c4e7737b7	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	1.00	paypal:4NX83774M4500613F	\N	PENDING	\N	2026-05-01 13:58:11.066	2026-05-01 13:58:11.772	4	test
5aae0e7f-5cb5-4254-877b-fa76a64a3ee4	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	1.00	paypal:40669704JL4759512	\N	PENDING	\N	2026-05-01 18:29:55.337	2026-05-01 18:29:55.692	4	test
308c1b3d-6955-4703-9d22-4b41ada3c71d	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:7WG7652063587780R	\N	PENDING	\N	2026-05-01 21:55:37.785	2026-05-01 21:55:38.542	10	Paquete inicial 
0244e67b-3141-4935-a4fd-a46de9be1fb6	304884e0-e87c-44b3-a135-525fcc3b24d6	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	1.00	paypal:2MT16123BY6615930	\N	PENDING	\N	2026-05-01 22:43:30.194	2026-05-01 22:43:30.503	4	test
1c8be823-dd06-4d31-8176-a40dee856076	3e957107-e648-43cc-baea-c5878ab6732c	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-02 01:31:34.158	2026-05-02 01:31:34.158	4	test
7ef9e51a-11a6-42f1-9b4e-d24e78875dc5	ed917127-6f95-432e-aed5-7c4a8cf4157f	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-02 05:28:10.528	2026-05-02 05:28:10.528	10	Paquete inicial 
e1d4f49a-34c4-41af-a429-1ac5b22a43da	ed917127-6f95-432e-aed5-7c4a8cf4157f	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:42C88120L3960464X	\N	PENDING	\N	2026-05-02 05:28:48.306	2026-05-02 05:28:48.651	10	Paquete inicial 
99ae8e9e-3ae0-4e19-b492-d9fdfb932a01	ed917127-6f95-432e-aed5-7c4a8cf4157f	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:21432537KX011843A	\N	PENDING	\N	2026-05-02 06:15:56.437	2026-05-02 06:15:56.727	10	Paquete inicial 
45b6b74e-c13a-4611-9950-a36fdbde77f1	ed917127-6f95-432e-aed5-7c4a8cf4157f	e39aeeca-aabf-40b6-aac4-429348919a92	\N	7.50	paypal:1A6585129N712633F	\N	PENDING	\N	2026-05-02 06:16:08.386	2026-05-02 06:16:08.674	30	Otoño
97027048-0fef-4c9c-8a5e-d9d344d6a338	28a52218-067b-4816-ba7c-581f48308a23	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-04 09:24:17.11	2026-05-04 09:24:17.11	500	Navidad
cdf69474-3fe4-4c00-ac65-5be202d29764	f6c000b1-9659-4fcb-b39b-d1f31258c870	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-04 10:22:24.675	2026-05-04 10:22:24.675	500	Navidad
9ed1535c-6a0b-4abb-8445-c030d16c56f2	f3391727-9c64-4ab4-9623-7c92862899c6	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-04 10:23:12.66	2026-05-04 10:23:12.66	500	Navidad
4f33a6e3-6776-4bbf-b579-8c76890ad208	109ecd1a-3b55-475c-bed3-f1339005e2c4	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-04 10:34:26.243	2026-05-04 10:34:26.243	500	Navidad
d92e7f46-6143-4cfa-a6c0-a60d57f34b09	0cdaf38d-21f5-47cf-9bfd-77386ea5a211	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-04 11:26:38.388	2026-05-04 11:26:38.388	10	Paquete inicial 
4f3a9d90-3495-481c-b15d-49de3dacd8cb	d8e760c1-588f-4c94-be2b-2ea00e428332	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-04 14:23:26.278	2026-05-04 14:23:26.278	500	Navidad
e7cec852-366d-46df-8bd0-a757ad5d6731	d8e760c1-588f-4c94-be2b-2ea00e428332	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-04 14:25:36.814	2026-05-04 14:25:36.814	10	Paquete inicial 
fa130c06-303b-4d6e-8ca7-f37ea249ad1c	d8e760c1-588f-4c94-be2b-2ea00e428332	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-04 14:28:18.834	2026-05-04 14:28:18.834	10	Paquete inicial 
bf50a2c9-13c8-450b-a182-2e2fa3bad122	86860ded-58e9-43db-9e8e-00f1d4161fab	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-04 15:27:50.039	2026-05-04 15:27:50.039	10	Paquete inicial 
dac58992-d8bd-4705-a1a5-1124b231ae2b	198da2c0-0a8e-486d-b715-6cad34b02bc0	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-04 17:44:44.121	2026-05-04 17:44:44.121	500	Navidad
784f182b-7cbf-426e-b977-08eb9a0cadcc	9e7ae97a-42e8-4c75-9b92-a4dbf954ce19	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-04 20:17:22.514	2026-05-04 20:17:22.514	4	test
4cbbab83-b8f2-4cd8-835c-c38c091bda70	d3bea0b4-86a4-46be-8c56-1cdb09c7da7c	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-06 04:51:21.086	2026-05-06 04:51:21.086	4	test
faf48e7b-83b3-4120-8340-95b651bd9b37	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:8AK91381RT460260C	\N	PENDING	\N	2026-05-06 17:37:31.792	2026-05-06 17:37:32.429	10	Paquete inicial 
0fd12ef2-5445-4399-ab58-9539501b5a11	4e52747e-7e13-4333-98ea-a5c31722ed46	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-07 01:03:37.193	2026-05-07 01:03:37.193	500	Navidad
b157b1fe-1009-4cbb-8228-f7181f5ca677	c7bd5193-a265-44ba-bc7a-ec8dae92b78b	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-07 12:28:30.888	2026-05-07 12:28:30.888	4	test
d69ca487-b316-424b-ac86-f3d5e8c6260d	c7bd5193-a265-44ba-bc7a-ec8dae92b78b	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-07 12:33:10.501	2026-05-07 12:33:10.501	4	test
64a5ce1e-9c78-4be5-ae77-e33e20a55340	135181f0-4f89-46db-86a1-eb721cf3913d	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-08 07:07:08.65	2026-05-08 07:07:08.65	500	Navidad
3f690bf2-19e3-4ca9-9b30-f6d64fa67867	0d5b21f4-0dc6-466f-948f-9774bb5413f5	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-08 11:28:54.457	2026-05-08 11:28:54.457	500	Navidad
61a71d19-1fe4-4d0b-bfd2-65e7a8386cb2	42ea5d02-a1fc-48d2-97d1-3bdd712dfd10	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-08 11:45:46.366	2026-05-08 11:45:46.366	500	Navidad
ffb3fbd2-54ca-4a89-a991-94d195231600	e33e08f9-dc8a-48f1-810c-bfb657d9fd48	e39aeeca-aabf-40b6-aac4-429348919a92	\N	30.00	flow:pending	\N	PENDING	\N	2026-05-08 14:06:21.537	2026-05-08 14:06:21.537	30	Otoño
99e9f68f-2817-41f6-9bd0-3ffb9e38879a	0ce11212-d428-4c69-ae11-c42946e0fe02	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-08 14:42:17.118	2026-05-08 14:42:17.118	10	Paquete inicial 
ae7326ae-cc93-45cd-b394-4176e175b089	0efe47ef-da7e-48d2-b1fa-3236019ba015	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-08 14:49:21.401	2026-05-08 14:49:21.401	4	test
6c0ddcf4-2049-4c47-8e78-de1794525dcb	58c3b43f-2de4-4f0a-8d99-bb8c2605cc4d	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-08 14:51:11.277	2026-05-08 14:51:11.277	4	test
46a86159-7bac-4853-bc85-ff6453530d06	0efe47ef-da7e-48d2-b1fa-3236019ba015	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-08 14:53:08.608	2026-05-08 14:53:08.608	4	test
59f1950f-6077-43c6-9b48-3db13188a866	a9aa889e-3c05-40b3-986b-cb4bd653f10e	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-08 15:08:32.793	2026-05-08 15:08:32.793	500	Navidad
febc296f-3833-40cc-906d-afd2b8184bbe	fc72d3d5-2270-462d-87ab-0c1d6239a205	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-08 15:21:59.365	2026-05-08 15:21:59.365	4	test
67c19af6-e050-449e-add1-236f28bc762e	7cdb0b1c-4dc2-40d0-877f-56ce39b46daa	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-08 17:33:26.874	2026-05-08 17:33:26.874	10	Paquete inicial 
f1458938-e99c-4f8d-a60a-1c2b041bbd6f	eebf9f36-165f-455b-a649-d5f55d69baa0	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-08 18:10:56.501	2026-05-08 18:10:56.501	10	Paquete inicial 
8f72c88d-a3f6-41d2-b79c-3d5d3b9567bc	975162b0-1c94-4cc3-b740-b2b3a82c4870	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-08 18:12:52.651	2026-05-08 18:12:52.651	10	Paquete inicial 
38e6cd2f-bac2-4d79-89f7-57955e6b1f9c	eebf9f36-165f-455b-a649-d5f55d69baa0	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-08 18:14:13.879	2026-05-08 18:14:13.879	10	Paquete inicial 
eb70a2ac-52f1-4482-b93b-bd92f22322bd	5317732e-ec0a-4c09-ade5-d28c2289c8f1	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-08 18:51:44.603	2026-05-08 18:51:44.603	10	Paquete inicial 
4df18c1a-ce67-45ba-9e4d-3080475093c4	20de6987-2064-4d47-84ba-4d3763b67d51	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-08 20:20:31.845	2026-05-08 20:20:31.845	500	Navidad
e1bc24b2-d028-4c71-a1f7-bd3e4289f178	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	125.00	paypal:69M18194HG965841N	\N	PENDING	\N	2026-05-09 21:33:25.581	2026-05-09 21:33:26.791	500	Navidad
a43d4d72-e1ce-46e9-af86-74c532ef343b	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:7T011746TP5889639	\N	PENDING	\N	2026-05-09 21:34:54.653	2026-05-09 21:34:55.473	10	Paquete inicial 
8ac9cd69-08c6-46d7-b5a9-8a6888f71754	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:35934600AJ780693L	\N	PENDING	\N	2026-05-09 21:47:36.158	2026-05-09 21:47:37.147	10	Paquete inicial 
0e77de70-cff4-48e9-b5c3-abcfdcfd8283	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:6V904246WL488272A	\N	PENDING	\N	2026-05-09 21:47:46.385	2026-05-09 21:47:47.067	10	Paquete inicial 
d23b0e5b-773c-44cc-a311-6cdff9f95cfb	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:58A4958525208713S	\N	PENDING	\N	2026-05-09 21:48:12.463	2026-05-09 21:48:14.198	10	Paquete inicial 
953b38e0-29a1-4c90-8a75-6df0bcfebaa1	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	41fd4605-896e-4e63-a37d-df4b58d90f6f	\N	50.00	flow:pending	\N	PENDING	\N	2026-05-09 23:51:22.945	2026-05-09 23:51:22.945	50	Bronce
8890f0eb-0f41-4af0-9acc-b83329ae99b3	0986237c-cb80-4d13-a8aa-f86253b614a6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:615BE4577C35EDAC7649FB7F86AF8659C071499T	\N	APPROVED	\N	2026-05-10 05:07:24.919	2026-05-10 05:09:05.771	10	Paquete inicial 
7bc1323d-984d-45bb-92db-da3b6fbb0617	da92e284-f3ac-4797-a6d6-f2860ae59752	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-12 19:52:12.755	2026-05-12 19:52:12.755	4	test
181fbd94-1e55-4906-a1bd-4f66a49bb05c	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	41fd4605-896e-4e63-a37d-df4b58d90f6f	\N	50.00	flow:pending	\N	PENDING	\N	2026-05-13 02:23:09.123	2026-05-13 02:23:09.123	50	Bronce
396a12f1-9180-4bb6-8c1a-6ba481b508d1	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	41fd4605-896e-4e63-a37d-df4b58d90f6f	\N	50.00	flow:pending	\N	PENDING	\N	2026-05-13 02:24:24.848	2026-05-13 02:24:24.848	50	Bronce
c75f9845-1c72-4351-8e40-14f1fec73ce3	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	41fd4605-896e-4e63-a37d-df4b58d90f6f	\N	50.00	flow:025026F7DF37037A425CFD1D9F9D37280F53A07I	\N	APPROVED	\N	2026-05-13 02:25:38.582	2026-05-13 02:33:27.963	50	Bronce
b0fd419e-1813-4dce-93e5-e33df3fec78c	370e5880-5ba0-4526-ba76-14f34e7dd92f	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-13 20:33:51.734	2026-05-13 20:33:51.734	500	Navidad
3a9c6208-e9b1-4df4-bf25-cf310e455e4a	4da2c430-d1ea-4387-bccd-dd27daded98c	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-13 23:12:54.967	2026-05-13 23:12:54.967	10	Paquete inicial 
630fba21-eb6e-4918-b277-c9a978f2222b	304884e0-e87c-44b3-a135-525fcc3b24d6	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:1HX05719103140410	\N	PENDING	\N	2026-05-16 01:40:28.326	2026-05-16 01:40:28.993	10	Paquete inicial 
87e76355-52a2-46da-ab7e-a06561627432	ed917127-6f95-432e-aed5-7c4a8cf4157f	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:6DX21503K8940240L	\N	PENDING	\N	2026-05-16 05:14:09.436	2026-05-16 05:14:09.774	10	Paquete inicial 
250d3f5b-394e-4b66-b714-920c6b3c9334	940e28c5-35f3-41ba-b0bf-5d958a85fbf7	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-20 03:43:03.017	2026-05-20 03:43:03.017	500	Navidad
03f8a9b4-661e-4ddc-8a7a-511699ae5f21	940e28c5-35f3-41ba-b0bf-5d958a85fbf7	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-20 03:43:51.48	2026-05-20 03:43:51.48	4	test
47c72d7c-65ba-4e66-b95c-9e493365894c	d3bea0b4-86a4-46be-8c56-1cdb09c7da7c	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-21 06:23:31.609	2026-05-21 06:23:31.609	10	Paquete inicial 
7eadbd1e-3dc3-482a-a1be-9ca842e276f9	fdd45029-8e81-4f0c-81a5-e58cbebd0385	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-21 12:40:18.026	2026-05-21 12:40:18.026	10	Paquete inicial 
a295b5a1-be3f-4fe5-b188-ed6e2e644969	bac87303-3c5f-4c06-aa9d-c2013ceeef53	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-25 04:42:31.711	2026-05-25 04:42:31.711	500	Navidad
550ef90f-0902-4458-8a27-eacb045aefa1	47339094-1daa-4449-9dce-843579263fe4	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-25 05:02:21.984	2026-05-25 05:02:21.984	10	Paquete inicial 
b034cd85-8c04-4cef-95fa-c447ff0d9c02	bac87303-3c5f-4c06-aa9d-c2013ceeef53	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-25 08:52:21.938	2026-05-25 08:52:21.938	500	Navidad
656c370e-1c88-4187-84ef-8e3e55ad30af	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-27 08:46:12.291	2026-05-27 08:46:12.291	10	Paquete inicial 
6857c265-0995-48c0-a894-a40caf9e96ed	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-27 08:48:13.541	2026-05-27 08:48:13.541	10	Paquete inicial 
cc4a8997-fa86-4da8-b573-d053e4493e8b	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	671670da-aa08-41f2-9fdc-fe408630cebe	\N	2.50	paypal:2B673956TF177125L	\N	PENDING	\N	2026-05-27 08:48:33.67	2026-05-27 08:48:34.377	10	Paquete inicial 
97337b2e-106f-45bc-869c-4a821af5b95a	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:BF56F05CD232726AD6968C99B097833DB0F0EE9A	\N	APPROVED	\N	2026-05-27 08:48:44.203	2026-05-27 08:50:02.741	10	Paquete inicial 
eaf8b9f8-1cbb-4372-ae47-e9b6820e06e7	a8c3a75d-a86c-499e-9636-de4a14cdad5c	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-27 15:45:41.958	2026-05-27 15:45:41.958	4	test
3d2a8427-914e-4efc-9ebd-2f594018d13a	a8c3a75d-a86c-499e-9636-de4a14cdad5c	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-27 19:43:19.712	2026-05-27 19:43:19.712	4	test
f4617b18-7d69-4406-9cc6-29948ce6055d	a8c3a75d-a86c-499e-9636-de4a14cdad5c	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-05-27 19:46:57.757	2026-05-27 19:46:57.757	10	Paquete inicial 
b611dac2-1328-45e0-93f6-09f112d01853	ed917127-6f95-432e-aed5-7c4a8cf4157f	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:972E668F56FB7EEF921EB8D4715F7A49174A75DJ	\N	APPROVED	\N	2026-05-30 22:55:41.738	2026-05-30 22:57:49.026	10	Paquete inicial 
201823a8-e184-4848-9652-7ad40d8a7af0	58f02c46-5a60-47bf-b260-6935fba622d2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-05-31 03:54:03.41	2026-05-31 03:54:03.41	500	Navidad
854ed7d5-753c-4e31-86b6-b4415dff601e	58f02c46-5a60-47bf-b260-6935fba622d2	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-05-31 04:03:15.731	2026-05-31 04:03:15.731	4	test
557df0a4-384c-48ce-84e8-06dbb2b0f596	a196b0f9-6e1a-41be-91df-cb19b320504a	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-06-08 04:26:11.207	2026-06-08 04:26:11.207	500	Navidad
65b561e5-d04b-4869-a6b0-b39b02f4f907	6a5428d5-36cd-4d6e-ba3e-5977d06382ba	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-06-11 01:15:24.727	2026-06-11 01:15:24.727	10	Paquete inicial 
59878fe2-9e49-40af-a156-8faa9b82628c	10a7e4d8-d4d0-48f6-9b6f-9b5ff680f74e	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-06-11 07:30:13.788	2026-06-11 07:30:13.788	4	test
f66afabc-f523-4d99-bc5e-478781d586db	8e66e230-01a8-4503-bcdf-d90b4e431843	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-06-14 05:49:17.492	2026-06-14 05:49:17.492	4	test
01a068b9-9bf1-47a5-b1e4-5dcc43bda162	c66c79d2-b59e-41c3-aef0-ec1ce54c77d3	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-06-21 20:05:50.088	2026-06-21 20:05:50.088	10	Paquete inicial 
c7540543-d685-4d75-9cfe-eff0bda8eebb	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-07-07 16:04:59.235	2026-07-07 16:04:59.235	500	Navidad
657129b2-7342-454b-9c83-caacbdbb5814	e9159f6f-711d-4404-bb6e-e789072b7281	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-07-07 19:56:03.476	2026-07-07 19:56:03.476	4	test
1b374280-e800-4532-8e79-e574a835be22	e9159f6f-711d-4404-bb6e-e789072b7281	a5d24fd7-9212-499d-9174-8e9d3a1b01e7	\N	4.00	flow:pending	\N	PENDING	\N	2026-07-07 20:01:31.572	2026-07-07 20:01:31.572	4	test
a13beedc-817f-42b7-af46-d60c0a9c516c	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-07-08 04:27:57.116	2026-07-08 04:27:57.116	500	Navidad
74265f9b-90ca-49b6-b8aa-0e9cf28023f5	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-07-12 23:11:44.419	2026-07-12 23:11:44.419	500	Navidad
264b0d80-ad62-4afe-85fe-6f9dfd503a95	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	671670da-aa08-41f2-9fdc-fe408630cebe	\N	10.00	flow:pending	\N	PENDING	\N	2026-07-12 23:21:43.663	2026-07-12 23:21:43.663	10	Paquete inicial 
b8869d56-b32a-47de-90f4-8435d749742c	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	125.00	paypal:0YG33207TU654205F	\N	PENDING	\N	2026-07-12 23:43:11.299	2026-07-12 23:43:12.401	500	Navidad
13a12d01-a417-467e-b137-08f0ce187b72	ed917127-6f95-432e-aed5-7c4a8cf4157f	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-07-14 17:10:30.9	2026-07-14 17:10:30.9	500	Navidad
638c38c7-ddd7-4851-abea-d2587610a780	b4364d07-e796-45d1-9fd7-575a8ab796e7	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-07-15 22:44:26.957	2026-07-15 22:44:26.957	500	Navidad
adbe6873-e63a-47f6-aab1-a12943268c8b	b4364d07-e796-45d1-9fd7-575a8ab796e7	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	125.00	paypal:8TA801033W6953837	\N	PENDING	\N	2026-07-15 22:45:00.117	2026-07-15 22:45:00.837	500	Navidad
deeac7c4-9bb0-4fa1-bc8d-3cf3e93b16e0	dfadeb82-59f5-4f2d-824d-a435e40d7484	e9de0b53-8e7b-432e-8bb0-87489a27017a	\N	500.00	flow:pending	\N	PENDING	\N	2026-07-19 02:12:59.858	2026-07-19 02:12:59.858	500	Navidad
\.


--
-- Data for Name: histories; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.histories (id, "userId", "mediaUrl", "mediaType", "publicId", "priceCredits", "publishedAt", "createdAt", "updatedAt") FROM stdin;
\.


--
-- Data for Name: history_views; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.history_views (id, "userId", "historyId", "viewedAt") FROM stdin;
\.


--
-- Data for Name: image_unlocks; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.image_unlocks (id, "imageId", "userId", "creditsSpent", "transactionId", "unlockedAt") FROM stdin;
4ebb508b-bb43-4fd6-aa93-8b1f991404af	ce257b84-dd3e-493a-b57e-df1996b1acaa	304884e0-e87c-44b3-a135-525fcc3b24d6	2	5d2c90b0-8e11-45d0-806a-e296e942126d	2026-03-22 11:28:58.268
92c32621-5826-4e36-b39d-1f473296207f	f3573980-a9f5-40ed-8c9e-47ccd5035e6d	304884e0-e87c-44b3-a135-525fcc3b24d6	10	74a79a13-0f64-4146-9711-2623a4c88a27	2026-03-22 11:29:01.345
b4ca4515-4959-43b5-9193-58c95f721e32	204a8e03-e244-459f-9996-f01c20d121bf	2e0740ed-8b4b-4f38-8c94-25812aff3cdf	20	bef1138e-369c-460e-8fca-73ea9386d078	2026-04-03 02:39:51.318
250bf04a-8d36-45cd-be11-a313daaa204d	ce257b84-dd3e-493a-b57e-df1996b1acaa	2e0740ed-8b4b-4f38-8c94-25812aff3cdf	2	574b7efb-20b6-4051-a655-236c7f729909	2026-04-03 02:39:59.425
2b20825e-7a0d-40e9-a998-c856654ae9e4	204a8e03-e244-459f-9996-f01c20d121bf	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	20	ed80eacb-8490-4d37-b0ef-33a13eaf14a4	2026-04-04 16:20:22.672
399f60f6-fb17-4a8e-837b-d378008cd489	ce257b84-dd3e-493a-b57e-df1996b1acaa	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	2	d5c3d059-2194-4deb-bc19-9ed32e7e167e	2026-04-04 16:20:33.473
035bc451-39d6-43ed-8100-72fe3d8d55dc	f3573980-a9f5-40ed-8c9e-47ccd5035e6d	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	10	fcf29241-3724-4978-9fdf-5f998711cfa8	2026-04-04 16:28:00.21
ee9119c9-0d24-4bb5-8183-5210f22b46ee	61ce7c0d-97ce-405d-abec-76e8075ae64a	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	11	59e005b1-e7be-425b-9e8a-c6c983ad2a37	2026-04-04 16:29:53.994
3cb8eae3-51f6-4f46-9b49-ef13612f0749	63de5d0b-a5ff-4dea-826c-8af57b21523d	b6e54a63-4b05-46e5-8586-5f307f47006b	10	70199670-78bb-4a71-bfa6-8ee8b70f1e5e	2026-04-04 21:04:02.96
206ddeea-a1f2-42d4-8379-76e4cc265a70	61ce7c0d-97ce-405d-abec-76e8075ae64a	b6e54a63-4b05-46e5-8586-5f307f47006b	11	4a63ed06-833a-47e0-914a-fd21a13996ef	2026-04-04 21:04:13.266
54ca768f-b632-49b4-b5cf-f800c985bb35	6cf1ed78-365b-4c3f-be0d-9269f6fa0aca	b6e54a63-4b05-46e5-8586-5f307f47006b	10	ade3ee6c-1a77-4ad5-a63e-4be35a6c7ce3	2026-04-04 21:04:46.765
1b852838-8058-4143-a725-e7d46a016fe5	204a8e03-e244-459f-9996-f01c20d121bf	b6e54a63-4b05-46e5-8586-5f307f47006b	20	e21e646b-0785-431e-a61a-62cdcda1e833	2026-04-04 21:05:20.451
18b38928-731d-4f0c-9a9f-ad3703e132e0	0b0db9a6-c2b4-4457-8880-b57b72ff90d1	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	10	bb30c995-ddbf-4d7e-9d77-0ce14b18c479	2026-04-24 03:30:32.372
fcdc3106-082e-497b-b67b-7091577378cf	cd77c8df-792e-4b37-8e58-6dc6cb1ca607	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	12	af13593a-7286-484e-8887-5318778003e8	2026-04-24 03:47:22.428
3db39a88-2e7a-4717-b0c6-31f2e3499e31	6cf1ed78-365b-4c3f-be0d-9269f6fa0aca	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	10	0e33d449-2819-449b-8995-e599543d6ae9	2026-04-24 04:00:49.105
21214db0-68c5-4168-81c8-8b34628919d2	4802bc3f-d690-4610-9ed1-2087719b99b4	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	12	b6e35abc-15a4-4caf-a8ef-152fbe767609	2026-04-24 04:01:29.539
2b82bc72-40a3-47e4-820f-308473c3f247	63de5d0b-a5ff-4dea-826c-8af57b21523d	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	10	c6cda0e6-63f0-4a01-ad18-8f6c2e522613	2026-04-24 04:03:13.945
d498dad9-6cc5-41de-b6cf-0a52bc7e1ab6	fc6b47b4-1155-4917-823a-5fd41e8c704f	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	12	f8389ecb-edeb-41dc-a29c-6115df86f691	2026-04-26 00:51:37.418
c8dc40b8-468a-45ba-89f5-037b560193ed	d4b14678-1b61-4eda-953c-f0427d6abb07	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	12	8903cdac-54db-4b8e-9402-1816db4661d4	2026-04-26 03:29:23.523
133c4fe8-2f26-432f-82b0-cfb9d03a83fe	540ef306-6d7c-4dda-86cc-fadcd0ffe662	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	3.4	69c586ff-05a8-45e0-b230-66fbb120bbf1	2026-04-26 03:29:33.778
0667495a-e78c-492b-acd3-8b4b527cf354	f2ddbdd0-687f-4c30-b6ab-719e8e9a7b86	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	2.6	1b282b6c-1334-421c-a1bf-fa3449d9fa08	2026-04-26 03:30:33.155
094ebbfb-584a-4f87-b7d9-8a8b2089eea0	540ef306-6d7c-4dda-86cc-fadcd0ffe662	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	3.4	c8c7515b-d2e0-40ef-aee0-646b3cc60bc1	2026-04-27 02:58:47.951
4c0b864d-2132-4a53-8d47-79acc682c204	ce257b84-dd3e-493a-b57e-df1996b1acaa	8378d82d-b63f-49d5-8856-f515f0e2ccd4	2	23e5ad47-bdc7-4f16-981d-41d9f973d190	2026-05-17 01:10:27.529
95af5735-8505-47e9-b099-7f1ca6a77f84	7d87b9d0-8909-4bf0-9445-96db016a3586	4e7e7405-7841-436d-a277-55b2d8c4299e	1000	34afc4d2-bf23-4939-ab05-4f4dcfc7aa2a	2026-05-22 17:02:59.382
9756e850-2193-4508-80ea-b204e3235424	90568fdc-7374-4f01-af7f-b4139be76bbf	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	15	3c38e9d9-5eab-4d5e-9158-bdc0d1f86cc2	2026-07-11 14:48:04.669
5f59648b-de5d-41b0-972f-31e31c70604e	3bd5718c-46a9-4738-8d55-2c663229c9aa	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	5	c5d20dec-dc7b-4623-b4e2-ee227fbf7cd9	2026-07-11 14:48:50.449
59e93c88-2fc0-4de6-9f5a-f7df35be04df	fd32c187-3a18-43dc-9d8c-9977037ef1a0	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	5	f759131a-4943-405d-866e-0d5b053aa314	2026-07-11 14:48:55.29
2ebc0197-c81c-48be-8207-35600ec34e14	e1385b47-72ff-46d6-9a47-dab445539be9	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	10	086a6a7b-3e91-43f1-9276-12b4fefe55aa	2026-07-11 14:48:56.606
ce481ac5-03c8-4215-91cf-b97d22c5a79b	55f56755-cafd-445d-9558-245903b30ee0	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	5	4abf5e0b-a24a-4fb0-92a6-026d8c9cf072	2026-07-11 14:48:57.957
be770ecc-6354-4fea-810d-821ce6d8412a	9e8f346d-e48d-42f4-93f0-813b9e66e7a3	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	2	79327936-c6ea-4049-93fc-4b24255ed5a1	2026-07-11 14:48:59.473
2fe93900-fe8a-45f2-9bea-4afca2ed449d	8167f0ce-8fd8-4f46-9028-41f85aa1982a	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	15	f081b256-e267-4078-944d-cde573c3beff	2026-07-11 15:25:13.751
1ca249d6-414b-4a5f-af10-c5e37b7d5515	90568fdc-7374-4f01-af7f-b4139be76bbf	4215b759-9065-4de2-8d20-6397fffac991	15	d01a0088-60f3-4ac9-887a-5cb333a55744	2026-07-14 05:19:00.807
e1b9dbef-2eef-4ae3-8112-62f144eb1874	4efd78b6-5507-46ff-b15b-27899f239e54	4215b759-9065-4de2-8d20-6397fffac991	15	78b8c86b-e998-49b9-9cef-5cdbfea698c3	2026-07-14 05:19:23.711
58be824f-b5f8-4212-819a-8fdaad35d3cb	8167f0ce-8fd8-4f46-9028-41f85aa1982a	4215b759-9065-4de2-8d20-6397fffac991	15	480f48f9-8e33-4849-830b-0dac6bc1299a	2026-07-14 05:19:40.452
\.


--
-- Data for Name: likes; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.likes (id, "userId", "anfitrionaId", "createdAt") FROM stdin;
3ff0f74b-a21c-4518-86f4-817c10eee9bd	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	2026-03-31 19:30:08.135
ad264734-71a0-4696-9b8c-6ea07dae659f	2e0740ed-8b4b-4f38-8c94-25812aff3cdf	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-03-31 20:29:40.154
92079366-e637-4dcd-8d21-8c800f4c7a28	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-02 04:35:18.095
5299884b-fe1a-4197-983c-01b210d7615a	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	cadca8ec-879f-4f06-9295-1a9731149965	2026-04-04 12:55:42.348
325e2171-aeb5-44a0-a633-b9a5ba6f9331	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-05 05:12:00.693
73188205-8b56-4b7a-ba47-f9959f23f679	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	6f9dd63d-2ffa-4634-a840-0617804df6b7	2026-04-05 05:12:53.624
1c72e4a0-aec6-4a3e-a32e-1ba19022a971	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-05 12:16:14.848
8d1e076d-042f-4351-9f97-b2b7c894e5fd	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	2026-04-05 12:16:16.216
0ea7434d-fda6-4a2e-b92b-bc458ab4cded	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-04-05 12:16:18.412
a1431030-35df-41b5-a2d9-e79ec0c30470	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	55818434-6bf8-4190-851d-96dae9acb2b1	2026-04-05 12:16:19.765
3e42f562-e9aa-4df1-be1d-fd26180db7af	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-04-05 12:16:20.811
40ecdb5c-ab04-4a75-9e48-8f319f451999	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	6f5b20d3-fb68-475a-b304-7aa067456fe5	2026-04-05 12:16:21.88
ffc11aae-bb9e-4def-8407-a7a1e3de0afd	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	6f9dd63d-2ffa-4634-a840-0617804df6b7	2026-04-05 12:16:22.68
d27fc3b8-a5ed-49c5-a62f-0c96bf7ed38f	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	85299925-2366-4fd7-8a87-272883e763a0	2026-04-05 12:16:24.794
5008036d-63f2-4b44-80f5-cb00c04b8eb4	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	982f221b-fe45-496e-b958-70b8c4d0d2fc	2026-04-05 12:16:26.257
984ca81d-f87f-4708-8fd3-408022407d17	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	b2b9ec93-8741-4fa9-be0c-18b84d7d6ade	2026-04-05 12:16:30.299
1d606394-b07a-473c-8ced-89c266e87023	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	5893d81a-370d-46e6-8783-926054e7c5d7	2026-04-05 12:16:31.597
5a994a3b-69d2-4dde-bd28-5fc8380b8581	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	b5b75c40-3df4-4efc-a9c9-ed40804cf0e3	2026-04-05 12:16:32.698
a01957af-7e0c-4e1f-b0bc-5daaa188d1f1	599864fe-f89b-4445-8b25-7da50697043b	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-05 14:01:00.194
c98f12a4-2c95-4009-8bfd-0c760dc9892a	304884e0-e87c-44b3-a135-525fcc3b24d6	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-05 16:03:52.785
eb176955-7812-4bc5-8737-c22c3d357869	a652dbc4-c42b-4f12-92bb-40ad705f0614	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-05 22:02:29.47
ea360795-4a8c-4073-ac3f-8a8ba1cec1f2	0f618476-9f1f-40d6-8e89-3f8e2554af13	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-06 01:45:13.816
fac8b249-d06d-4784-88e2-556cba8cfdd8	fe63bb9a-4219-4da1-bf8f-c52412f6e801	6f9dd63d-2ffa-4634-a840-0617804df6b7	2026-04-06 06:07:41.955
38be4bbf-c713-4bb7-9f40-e9f1d13ac526	fe63bb9a-4219-4da1-bf8f-c52412f6e801	5ee22644-5713-4342-b613-088344267c67	2026-04-06 06:08:29.228
321ec76e-72d5-4acb-8872-adbae5984c88	fe63bb9a-4219-4da1-bf8f-c52412f6e801	b5b75c40-3df4-4efc-a9c9-ed40804cf0e3	2026-04-06 06:09:02.299
09a8cf47-baa5-4bc3-89ba-1363f9b49098	5b861f19-1c5a-47c6-a9a1-b4fc35eda3c6	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-06 07:02:23.83
87c2ce88-e4a4-4479-932c-7708e1ac9d4b	867a333a-9f97-4133-8a15-ba350f41a16f	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-06 09:59:10.019
aa5bacca-d1bb-417d-bf5a-6e53b32583c1	867a333a-9f97-4133-8a15-ba350f41a16f	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-06 09:59:12.181
1e06fb59-ce72-4458-9df8-bdedd84fc9fc	867a333a-9f97-4133-8a15-ba350f41a16f	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-04-06 10:00:17.214
d9400b40-b553-47a0-97a0-71e11204a25f	867a333a-9f97-4133-8a15-ba350f41a16f	6f9dd63d-2ffa-4634-a840-0617804df6b7	2026-04-06 10:00:35.532
5818e9e9-bbb0-4734-9f0b-547ccf0e0a72	e4264309-988e-468b-9f8b-868b750e973b	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-06 14:39:27.534
585129f2-1ba8-405b-83bc-e997fe64f8ce	6976b2a1-97f6-48c8-8411-b4207c2f440a	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-07 03:08:15.696
d043cf6d-2b60-482b-a1a4-c7be2f8671fd	6976b2a1-97f6-48c8-8411-b4207c2f440a	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-07 03:08:18.263
6819996a-ce09-45bd-8813-22b9fd418c72	ae043ef6-64d1-4cdd-aead-cfaac366d79b	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-07 03:30:26.721
2382a302-3570-4bd8-8e25-0a10ee333539	ae043ef6-64d1-4cdd-aead-cfaac366d79b	6f9dd63d-2ffa-4634-a840-0617804df6b7	2026-04-07 03:30:30.867
d668a5f5-6839-4aad-845d-4fce439220e2	ae043ef6-64d1-4cdd-aead-cfaac366d79b	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-04-07 03:30:33.909
72340434-fa3a-42f0-8c61-cf33e0b7e2ad	ae043ef6-64d1-4cdd-aead-cfaac366d79b	cadca8ec-879f-4f06-9295-1a9731149965	2026-04-07 03:30:39.486
bee79243-1598-4f06-80a4-528c74c11ea0	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-07 07:58:25.39
be128d11-c42e-4e68-89d3-d1853ac7a515	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-07 07:58:46.304
f338af41-2ee3-4659-b0a6-cb31c5972606	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	6f9dd63d-2ffa-4634-a840-0617804df6b7	2026-04-07 07:59:01.291
b32007be-7af4-470d-83f1-6d15bbd35cd7	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-04-07 08:00:51.045
cc0fb058-0d9a-4e68-a9ce-d625ba1720b9	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-04-07 08:01:02.357
25c2a1f2-8cbc-45d2-b951-1c0ee9979aa6	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	55818434-6bf8-4190-851d-96dae9acb2b1	2026-04-07 08:01:06.502
3b69d3a2-4978-4ac5-a02c-5b78993d1e30	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	850654ff-c2a8-4215-bc96-c0afdb615949	2026-04-07 08:01:18.812
9d179d45-0386-45c6-b057-08d92a276993	1b80ea97-9a78-4674-804f-39ef05924c67	850654ff-c2a8-4215-bc96-c0afdb615949	2026-04-07 12:55:39.576
830a9b8b-3468-48a2-9497-73c08e1da559	304884e0-e87c-44b3-a135-525fcc3b24d6	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-07 19:52:53.03
0452c671-2254-4325-8bc4-f15fa52120e5	0d6251c4-0c8d-47e1-871f-d7446ce48732	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-07 21:33:55.307
505a009c-8647-49a4-899f-c4fe5e465d79	69d3d892-68a5-45df-82a6-58a6ad40cb89	6f5b20d3-fb68-475a-b304-7aa067456fe5	2026-04-09 00:19:27.024
934a6675-0c1c-4dc8-a1a6-07e02f59f55d	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	850654ff-c2a8-4215-bc96-c0afdb615949	2026-04-10 22:57:41.827
32a41f21-13b3-47a4-a874-4efeb6528f6d	5398b688-8844-424f-bc48-74b7cf60d774	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-04-16 04:21:27.766
86275d14-78ca-49a1-88c7-ca9ae9a37925	5398b688-8844-424f-bc48-74b7cf60d774	6f5b20d3-fb68-475a-b304-7aa067456fe5	2026-04-16 04:21:37.991
43cead4d-c80d-4bd3-a7fc-c0390b895d11	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-30 00:04:05.657
7a2a87ab-468d-4bac-ba49-7658b0b8ce0a	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	832aabaf-e4ec-4683-98aa-75eec4924379	2026-04-30 00:04:08.242
cf85d51e-90e9-4670-b3b8-05b3b8aceaa8	41e81b4b-c22c-40a2-9176-2546ccae0163	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-04-30 05:34:49.908
19db4a3c-6a4c-400a-a937-9f698b801319	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	81a45612-532a-459c-890c-55d6d3391455	2026-05-03 12:05:59.644
c130ab7b-425e-4ad2-bc1d-a8e786b748e7	fb41944b-5d8e-4c5e-8b9f-4e8661e007af	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-04 04:35:48.708
bfbeafe8-950f-476f-8081-42d10d61216b	c7bd5193-a265-44ba-bc7a-ec8dae92b78b	832aabaf-e4ec-4683-98aa-75eec4924379	2026-05-07 12:27:28.849
6b464365-d2f2-40c4-abe6-c2e83e934e9a	3e6953f8-8684-499e-8b22-d9c8f0403332	dd0257c2-4f37-4b20-b336-b13494e0ba74	2026-05-14 20:45:35.569
cd3966c2-67a9-41c7-8fe1-2b121288f462	3e6953f8-8684-499e-8b22-d9c8f0403332	16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c	2026-05-14 20:45:37.869
7ace38da-d64f-424f-958d-670a8d905709	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-25 03:46:44.532
a0e2a2fe-d8ca-49de-9814-6c4fe69678da	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-27 08:26:44.644
a4775475-00b8-4030-a16c-ce5c80962bb9	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-05-27 08:32:41.95
8f5627d4-6ddf-4b42-b4d3-08050ae2769e	4e33169a-9f8c-4251-b531-fa7c38521bc7	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-27 13:04:24.148
140be792-4aae-44e7-9572-30d1fde8240f	a8c3a75d-a86c-499e-9636-de4a14cdad5c	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-27 19:35:27.752
7bed598e-a7c8-425a-857d-17717ed6c7a8	a8c3a75d-a86c-499e-9636-de4a14cdad5c	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-05-27 19:35:31.357
2f35ee22-d475-4801-8d9d-0dae2126bedd	a8c3a75d-a86c-499e-9636-de4a14cdad5c	850654ff-c2a8-4215-bc96-c0afdb615949	2026-05-27 19:35:34.978
690fa7dc-088e-4f21-8b55-0c7a3c540edd	a8c3a75d-a86c-499e-9636-de4a14cdad5c	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-05-27 19:35:37.709
f59c7257-cfd8-4e0b-ac94-e7faf45857ae	a8c3a75d-a86c-499e-9636-de4a14cdad5c	261efc59-4ced-447c-80d4-1070eada2618	2026-05-27 19:52:41.771
de135504-89d9-4b10-8093-0c8113381475	a8c3a75d-a86c-499e-9636-de4a14cdad5c	1808fc9e-a96d-4dc0-a466-3e5445ff8abd	2026-05-27 19:53:01.388
618a443f-c544-47f0-a0f1-1ccb69bac2d7	a8c3a75d-a86c-499e-9636-de4a14cdad5c	11f7cff7-cc4e-4973-b09c-b415f8a4393f	2026-05-28 01:14:44.043
0769b86d-a6a9-4623-bae0-bafa4f5b5f19	a8c3a75d-a86c-499e-9636-de4a14cdad5c	832aabaf-e4ec-4683-98aa-75eec4924379	2026-05-28 01:14:46.282
6facba8d-fc79-40ac-b449-ca367ac6b1ee	10a7e4d8-d4d0-48f6-9b6f-9b5ff680f74e	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-06-11 07:29:03.997
29236e61-0334-4859-a6f5-169ae859007b	c66c79d2-b59e-41c3-aef0-ec1ce54c77d3	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-06-21 20:26:31.241
c294e29c-f538-4016-b32d-c4492308210f	ee1cafe5-bb22-426b-bfec-c0471f2cff7f	850654ff-c2a8-4215-bc96-c0afdb615949	2026-06-21 21:49:06.527
6c94ff4d-3e1e-49bd-809e-feaa736465df	ee1cafe5-bb22-426b-bfec-c0471f2cff7f	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-06-21 21:49:08.472
293e6c67-5240-41ad-b5ec-68302321ab55	ee1cafe5-bb22-426b-bfec-c0471f2cff7f	dd0257c2-4f37-4b20-b336-b13494e0ba74	2026-06-21 21:49:48.828
4efc53b5-a83e-48d2-85f4-53194b80dbb5	ee1cafe5-bb22-426b-bfec-c0471f2cff7f	81a45612-532a-459c-890c-55d6d3391455	2026-06-21 21:51:32.645
e39a0422-121d-4ee9-97b3-607dc465d957	01b121d2-a965-4ac2-bc8d-bde43303ad39	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-06-22 08:00:25.707
4abd2408-8a0c-474e-8707-49084d13c60e	011655d4-c895-49d6-aedb-af203c5a274b	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-06-24 06:00:00.998
2d5ffadd-8acd-410c-8abd-244003d4fa08	011655d4-c895-49d6-aedb-af203c5a274b	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-06-24 06:02:58.286
c9ec554d-00e8-4933-93f2-a23150e21589	624d8d60-25d1-4344-981f-4ead2477afea	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-06-29 20:54:13.253
8755ae3f-4ddf-401e-ac8f-2866174860e0	624d8d60-25d1-4344-981f-4ead2477afea	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-06-29 20:54:59.005
\.


--
-- Data for Name: message_image_unlocks; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.message_image_unlocks (id, "messageId", "userId", "creditsSpent", "transactionId", "unlockedAt", "imageUrl") FROM stdin;
\.


--
-- Data for Name: message_unlocks; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.message_unlocks (id, "messageId", "userId", "creditsSpent", "transactionId", "unlockedAt") FROM stdin;
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.messages (id, "conversationId", "senderId", text, read, "createdAt", "isLocked", price, "imagePublicId", "imageUrl") FROM stdin;
d44344ff-3f3b-480c-9915-6670f905d64d	e4295fad-0be9-403a-a84f-6c9bc007eb18	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Hola	f	2026-07-22 01:38:05.877	f	\N	\N	\N
7590cc71-afef-434b-b10e-fd98705672bd	f064b47c-3d01-4cc2-90ca-f262d5926277	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Ola	f	2026-07-22 01:38:14.106	f	\N	\N	\N
fbe3c562-272d-4c87-9ccf-106047df1876	671953e7-c197-4c70-9dd0-afff4d41030d	c1d487fe-ca5d-4d9f-9bf7-5b85c3b96121	hola	t	2026-07-21 15:08:45.019	f	\N	\N	\N
9ac5343d-1624-40b6-929a-f0f232aed6a1	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Holaaa	t	2026-07-22 01:36:56.342	f	\N	\N	\N
c403e08a-2dac-44aa-aa4a-b2f65cdf1ad3	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Bb	t	2026-07-22 01:36:58.026	f	\N	\N	\N
b40dd506-d1a9-4c5e-8591-a7e242777565	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Que haces	t	2026-07-22 01:37:01.014	f	\N	\N	\N
8d0079bb-6d4c-489c-a110-3a213a6cb17d	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	??	t	2026-07-22 01:37:15.007	f	\N	\N	\N
84ef20d3-ae66-46af-9496-9322a95e0c0d	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	Hola	t	2026-07-22 01:42:23.77	f	\N	\N	\N
9328394c-d44b-43d6-9cd4-ac64bb61e8fa	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	Nada y tu	t	2026-07-22 01:42:34.703	f	\N	\N	\N
6d3847a3-1e74-43d2-822f-1ecbb81c75e9	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Aquiii	t	2026-07-22 01:42:39.616	f	\N	\N	\N
5ffb3f72-ab5f-4300-9a93-d404d2028d78	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Echada	t	2026-07-22 01:42:42.612	f	\N	\N	\N
157c8fb5-ff72-45a4-83c7-72bcd411cad9	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Que quieres hacer	t	2026-07-22 01:42:50.523	f	\N	\N	\N
b7dc70fa-9c14-4aba-bd9e-d913886d5d44	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Venezuela	t	2026-07-22 01:43:02.076	f	\N	\N	\N
b958c12a-a78f-4862-a4b6-cf75dba2510f	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Y tu	t	2026-07-22 01:43:05.659	f	\N	\N	\N
2899d57e-1ac2-409c-8e08-28f30db44182	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Venezuela	t	2026-07-22 01:43:22.839	f	\N	\N	\N
a31b52d5-8d52-4cbb-a195-29e6da5d8d93	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Allá en que parte de peru	t	2026-07-22 01:43:29.624	f	\N	\N	\N
8416c527-4a1a-488b-bc17-12914d6960b7	9a329172-91af-43a1-8849-13f92bfab3bc	3a144e76-42a6-4a5f-b1e6-bac39df8c8a0	Hola	f	2026-07-21 05:28:54.178	f	\N	\N	\N
f2567e37-56e7-43c1-9d4d-a5f0f854cae9	1d2cbadd-0f91-4a87-9f70-a076cc80fc19	3a144e76-42a6-4a5f-b1e6-bac39df8c8a0	Hooa	f	2026-07-21 07:14:27.402	f	\N	\N	\N
bc076125-66f3-41e6-91a7-09254dbde856	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Alla	t	2026-07-22 01:43:52.08	f	\N	\N	\N
0e4504ec-502e-4ddd-8524-ccb5e41e950a	8ac4adfe-6973-4ecd-9a8d-e091bd5f2585	3a144e76-42a6-4a5f-b1e6-bac39df8c8a0	Hola	f	2026-07-21 07:15:16.227	f	\N	\N	\N
338e917b-167a-42e4-a918-eae36d6d5544	8ac4adfe-6973-4ecd-9a8d-e091bd5f2585	3a144e76-42a6-4a5f-b1e6-bac39df8c8a0	Hol	f	2026-07-21 07:15:19.775	f	\N	\N	\N
f79347cb-5e95-46c2-918d-1967f1768835	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Y como eres	t	2026-07-22 01:44:09.812	f	\N	\N	\N
b0010529-82bc-489c-a5a5-ed18f88c3f90	762cf99d-76ab-4f45-b281-85988947453c	9c6ea184-db3d-471f-b8bf-a55877ee1ca7	Hola preciosa	t	2026-07-21 04:36:55.366	f	\N	\N	\N
26c806c0-1029-4976-a5c1-bd3f7259106a	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	De donde eres	t	2026-07-22 01:42:53.567	f	\N	\N	\N
edb8b4ec-1992-4f9d-afa8-2ddce60fbaf6	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	Y donde te encuentres bb	t	2026-07-22 01:43:14.79	f	\N	\N	\N
e35f5e9f-66af-42e8-8955-47ed45046974	762cf99d-76ab-4f45-b281-85988947453c	9c6ea184-db3d-471f-b8bf-a55877ee1ca7	Hola preciosa	t	2026-07-21 04:37:08.159	f	\N	\N	\N
a4895dcd-71f9-4720-b9cd-ec9602896f8b	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	Yo de Perú	t	2026-07-22 01:43:20.102	f	\N	\N	\N
b093e53a-b9b6-4a08-b242-208033572402	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	Moyobamba-	t	2026-07-22 01:43:48.268	f	\N	\N	\N
915e4321-2dae-4881-b4d3-99adcf9ec4e3	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	M	t	2026-07-22 01:44:36.928	f	\N	\N	\N
e32244ad-8faf-4fc7-98c0-c67523ca8ecf	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	Como hací	t	2026-07-22 01:44:54.53	f	\N	\N	\N
8050eefb-2bfc-4061-83b6-9163deaae5dd	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Me gustaría verte	t	2026-07-22 01:45:04.157	f	\N	\N	\N
0ace7d82-050e-456a-b0ba-6ef9ca503ddb	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Kieres verme	t	2026-07-22 01:45:17.413	f	\N	\N	\N
f1667cba-486e-4774-b089-5ad196d51702	762cf99d-76ab-4f45-b281-85988947453c	9c6ea184-db3d-471f-b8bf-a55877ee1ca7	Hola	t	2026-07-21 04:38:10.252	f	\N	\N	\N
3cd8f1eb-7fba-4828-8479-8e7d50525226	f064b47c-3d01-4cc2-90ca-f262d5926277	8eefeb9e-8d9e-4278-b904-778e5727cfb9	Hola	t	2026-07-21 05:05:31.227	f	\N	\N	\N
6bae0cfd-ae51-4a95-a314-4bdadf7d2cb0	f064b47c-3d01-4cc2-90ca-f262d5926277	8eefeb9e-8d9e-4278-b904-778e5727cfb9	Hola bb	t	2026-07-21 05:06:07.102	f	\N	\N	\N
ff9e9578-b69e-4bc3-ad65-1767e2b32ebd	f064b47c-3d01-4cc2-90ca-f262d5926277	8eefeb9e-8d9e-4278-b904-778e5727cfb9	Hola	t	2026-07-21 05:06:30.196	f	\N	\N	\N
5e9956f4-0e43-4bb8-92c1-ef30da6298a0	e4295fad-0be9-403a-a84f-6c9bc007eb18	3a144e76-42a6-4a5f-b1e6-bac39df8c8a0	Hola	t	2026-07-21 05:27:15.499	f	\N	\N	\N
8733314e-41a3-4be9-a347-a16e525cc1ea	e4295fad-0be9-403a-a84f-6c9bc007eb18	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Ola	f	2026-07-21 20:15:29.992	f	\N	\N	\N
41777de9-4814-4c72-bab8-26a332feb81b	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	Hola	t	2026-07-22 01:36:36.957	f	\N	\N	\N
9c772779-d01f-4d70-bbef-afc1a0ea6607	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Ahí arriba hya una camara	t	2026-07-22 01:45:37.203	f	\N	\N	\N
7f20d8fb-d815-417b-82bd-543013e701db	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Ha click ahi	t	2026-07-22 01:45:42.205	f	\N	\N	\N
8aad4fb1-a236-484b-aba8-c86d2b7152cb	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	Cuando vienes q Perú	t	2026-07-22 01:45:02.597	f	\N	\N	\N
36920cb8-c620-49ed-869f-f328cf87dcdf	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	Si	t	2026-07-22 01:45:26.553	f	\N	\N	\N
7feae2af-3af2-4dfb-97a5-63f618611848	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	No se puede	t	2026-07-22 01:46:14.98	f	\N	\N	\N
9c504363-726c-4aa9-979b-c7de8969d0c3	2fd09a30-1484-475e-b1df-7b1aa04924c1	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	Hola	f	2026-07-22 01:46:48.021	f	\N	\N	\N
473f2f6c-eb61-47de-a214-b538f1899785	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Sii claro si se puede	t	2026-07-22 01:46:48.124	f	\N	\N	\N
d0f81456-cb78-4c85-bb16-bcaaa61ac0bc	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Debes recargar	t	2026-07-22 01:46:53.305	f	\N	\N	\N
91e9d5f7-8ccc-4300-a4d3-d0671b3d25b0	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	No tengo con q soy menor todavía	t	2026-07-22 01:47:18.452	f	\N	\N	\N
2def7e80-0e55-47de-ba53-671639628b0f	dc3e4123-e803-4f06-bc1c-24525e1b3a94	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Alla	t	2026-07-22 01:47:33.408	f	\N	\N	\N
67ac1df0-8693-4809-b729-9c0bbe918f4f	dc3e4123-e803-4f06-bc1c-24525e1b3a94	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	Si ps	t	2026-07-22 01:48:02.872	f	\N	\N	\N
474a70d3-b5b4-468b-a19f-61837f9ab14b	e7d56591-a11d-4cfb-b3fc-d33192cdb252	63e172c7-36e6-4c68-a980-fccc0bdece37	Hola linda	f	2026-07-22 03:03:30.208	f	\N	\N	\N
170fabd0-0520-400d-b484-48d6e0f8f9e1	5d8146bd-1b20-402b-b3c2-b83426d53f12	63e172c7-36e6-4c68-a980-fccc0bdece37	Hola linda	f	2026-07-22 03:04:32.958	f	\N	\N	\N
7142abdd-63b9-40e3-a689-bf9030703fbe	5d8146bd-1b20-402b-b3c2-b83426d53f12	63e172c7-36e6-4c68-a980-fccc0bdece37	De que lugar eres linda	f	2026-07-22 03:05:26.185	f	\N	\N	\N
050132ff-7420-468e-8185-0c1a25d8f47f	36509c89-12c4-4980-b1cc-9862e1a4db75	63e172c7-36e6-4c68-a980-fccc0bdece37	Hola linda	f	2026-07-22 03:06:12.491	f	\N	\N	\N
8b5bbe52-cb1a-4f91-9dce-ec8edd7ce775	2a67cda2-ab29-4b44-a769-789770edca1a	63e172c7-36e6-4c68-a980-fccc0bdece37	Hola	t	2026-07-22 03:00:24.636	f	\N	\N	\N
9a46e053-2698-4f81-b34c-8a855b10b10e	2a67cda2-ab29-4b44-a769-789770edca1a	63e172c7-36e6-4c68-a980-fccc0bdece37	Linda	t	2026-07-22 03:00:31.881	f	\N	\N	\N
eedac65d-6de4-48bb-acc2-8e9a9a07f21d	2a67cda2-ab29-4b44-a769-789770edca1a	63e172c7-36e6-4c68-a980-fccc0bdece37	Hola linda🥰	t	2026-07-22 03:01:09.638	f	\N	\N	\N
1e33c12e-52fb-4473-934f-766c28f77fbd	2a67cda2-ab29-4b44-a769-789770edca1a	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Hola bb	f	2026-07-22 03:06:18.811	f	\N	\N	\N
9ad540b5-b999-4040-abb7-63ec6ed29549	ade07b31-7a4c-42e4-ad10-230ed94aaab9	63e172c7-36e6-4c68-a980-fccc0bdece37	Hola linda	f	2026-07-22 03:06:41.542	f	\N	\N	\N
500a4b3b-3feb-4032-893f-7b2225afea12	2a67cda2-ab29-4b44-a769-789770edca1a	bac87303-3c5f-4c06-aa9d-c2013ceeef53	Que más pues	f	2026-07-22 03:07:55.322	f	\N	\N	\N
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.packages (id, name, credits, price, "isActive", "createdAt", "updatedAt") FROM stdin;
e9de0b53-8e7b-432e-8bb0-87489a27017a	Navidad	500	500.00	t	2026-03-21 19:04:11.217	2026-04-05 13:45:01.605
671670da-aa08-41f2-9fdc-fe408630cebe	Paquete inicial 	10	10.00	t	2026-03-29 02:54:18.368	2026-04-05 13:45:12.879
41fd4605-896e-4e63-a37d-df4b58d90f6f	Bronce	50	50.00	t	2026-04-06 15:04:04.642	2026-04-06 15:04:04.642
e39aeeca-aabf-40b6-aac4-429348919a92	Otoño	30	30.00	t	2026-04-06 19:01:40.771	2026-04-06 19:01:40.771
04423807-aaca-41e6-a305-66499af7ebf3	Platinium	100	100.00	t	2026-03-21 19:03:32.313	2026-04-06 19:02:26.124
17b2810a-310a-4391-b764-a7ceb8de256b	Premium	200	200.00	t	2026-03-21 19:03:49.612	2026-04-06 19:02:44.279
01266b84-0479-49ab-bb22-2ae0276aeebf	Cash	25	25.00	t	2026-04-06 19:03:14.325	2026-04-06 19:03:14.325
a5d24fd7-9212-499d-9174-8e9d3a1b01e7	test	4	4.00	t	2026-04-27 03:54:29.658	2026-04-27 03:54:29.658
\.


--
-- Data for Name: payment_methods; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.payment_methods (id, type, "bankName", "accountName", "accountNumber", "qrImageUrl", "qrPublicId", "isActive", "createdAt", "updatedAt", "logoPublicId", "logoUrl") FROM stdin;
7d119657-89eb-4565-ad8b-1c9452a0bdf0	TRANSFERENCIA	Banco Unión	Pachamama S.R.L.	1000000123	\N	\N	t	2026-03-21 18:52:35.13	2026-03-21 18:52:35.13	publictranferecianID	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1774037652/20_dise%C3%B1os_en_los_que_queda_patente_que_menos_es_m%C3%A1s_-_Cultura_Inquieta_k1pylb.jpg
3ba5b97f-1f37-4c33-a0b7-1111333a61fe	QR	Banco Unión	Pachamama S.R.L.	\N	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1774028822/Cod8go_se_seguridad_bjgwyn.jpg	pachamama/qr_pago	t	2026-03-21 18:52:35.13	2026-03-21 18:52:35.13	QRlogoID	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1774037631/QR_Code_Stickers_-_Free_Shipping_zgm8re.jpg
97b1877c-13b1-4e50-b3a7-cce1d155cbc5	TRANSFERENCIA	Banco Prueba	Pachamama QA	1234567890	\N	\N	t	2026-04-04 01:45:37.741	2026-04-04 01:45:37.741	\N	https://dummyimage.com/200x200/a11b1b/ffffff.png&text=BANK
\.


--
-- Data for Name: saved_anfitrionas; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.saved_anfitrionas (id, "userId", "anfitrionaId", "createdAt") FROM stdin;
4d189eca-9c59-4cc7-9756-db1256878c91	ae043ef6-64d1-4cdd-aead-cfaac366d79b	6f9dd63d-2ffa-4634-a840-0617804df6b7	2026-04-07 12:02:56.206
d61e9398-4c08-4946-9d2b-699e30e3b6d6	5398b688-8844-424f-bc48-74b7cf60d774	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-04-16 04:21:29.94
be964c91-8a21-491c-b3f5-76dbc690bbe9	5398b688-8844-424f-bc48-74b7cf60d774	6f5b20d3-fb68-475a-b304-7aa067456fe5	2026-04-16 04:21:39.231
0f9140c4-ddc3-45db-b39a-f98fb3a45a08	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-05-27 08:41:16.867
69e7e6c5-7f2f-42c8-ae12-0c816a89cdb2	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	81a45612-532a-459c-890c-55d6d3391455	2026-05-27 08:41:24.765
602fe16f-248f-4fd5-8ef7-525fc8e68655	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	dd0257c2-4f37-4b20-b336-b13494e0ba74	2026-07-11 13:57:31.241
4adb9907-3e3d-4ca4-b055-5f5c8d3ba6b7	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-07-11 14:51:47.185
\.


--
-- Data for Name: service_prices; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.service_prices (id, "profileId", "serviceType", price, "createdAt", "updatedAt") FROM stdin;
88a9567e-bf2b-4569-81b2-36d014171ffd	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	CALL	5	2026-03-21 19:13:01.503	2026-03-21 21:08:27.441
d0ddada8-c6a5-4e7f-889d-b26b947af0f3	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	VIDEO_CALL	10	2026-03-21 19:13:01.509	2026-03-21 21:08:27.444
83ba1a87-37ca-4e7c-9a50-79d838d86a53	c6bd5135-723a-48ab-bb9b-8f8bc7301ce3	MESSAGE	3	2026-03-21 19:13:01.508	2026-03-21 21:08:27.446
217f9e13-c001-4b34-b988-5b0320e44f13	0fdb71dd-796c-48a0-bbec-e78dee2afa84	MESSAGE	1	2026-03-31 03:59:02.865	2026-03-31 03:59:02.865
f97eef05-0605-4ae9-b4c9-c252c1ddfb34	0fdb71dd-796c-48a0-bbec-e78dee2afa84	VIDEO_CALL	10	2026-03-31 03:59:03.075	2026-03-31 03:59:03.075
847b384b-94ae-43cd-817c-cc079fa16f25	0fdb71dd-796c-48a0-bbec-e78dee2afa84	CALL	5	2026-03-31 03:59:03.085	2026-03-31 03:59:03.085
f16601bc-cc74-468f-9c9d-4a84d6515b06	b946a33e-2ba4-4526-82df-4b44026a7500	MESSAGE	5	2026-04-01 03:30:13.96	2026-04-01 03:30:13.96
6904cbfa-3ada-4d17-b5c2-ce2704d7a716	b946a33e-2ba4-4526-82df-4b44026a7500	VIDEO_CALL	15	2026-04-01 03:30:14.193	2026-04-01 03:30:14.193
e9b2b0e1-cf2c-4db6-bef4-fba5b07d95b5	b946a33e-2ba4-4526-82df-4b44026a7500	CALL	5	2026-04-01 03:30:14.207	2026-04-01 03:30:14.207
06071598-ce64-4516-9139-ac395e512385	d8f29236-4a06-4ebb-a9f8-423876fe579b	MESSAGE	10	2026-04-05 17:43:17.673	2026-04-05 17:43:17.673
fe09fe41-5d83-4e80-95cf-dbe524ecbcb4	d8f29236-4a06-4ebb-a9f8-423876fe579b	VIDEO_CALL	20	2026-04-05 17:43:17.943	2026-04-05 17:43:17.943
bdca91bd-e844-4e92-838a-af52f1a0bafc	858f43c5-4b7d-43a8-a79d-92732698fe31	MESSAGE	1	2026-03-31 03:03:15.858	2026-04-05 01:39:10.736
d8ce0064-ae18-4e58-a138-eafde9ae52be	858f43c5-4b7d-43a8-a79d-92732698fe31	VIDEO_CALL	20	2026-03-31 03:03:16.201	2026-04-05 01:39:11.028
a612085c-8758-427b-b641-cb10602b2628	858f43c5-4b7d-43a8-a79d-92732698fe31	CALL	10	2026-03-31 03:03:16.19	2026-04-05 01:39:11.038
74063bd0-9b07-4ad8-b7e4-4fcc1f0cf940	d8f29236-4a06-4ebb-a9f8-423876fe579b	CALL	10	2026-04-05 17:43:17.955	2026-04-05 17:43:17.955
e42013c0-a2df-492c-be00-348358449ebe	58c26008-8639-4374-aa26-8ca3f75856aa	VIDEO_CALL	10	2026-04-04 03:03:46.488	2026-05-14 01:38:56.867
f5e18411-ed95-4b06-8699-16e6a56b70c2	9f1b2121-6ed7-48d1-a320-ea48c0f416db	VIDEO_CALL	9	2026-03-31 12:14:58.294	2026-07-02 11:23:54.623
2b195054-80aa-4433-afd0-73a2d80a369c	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	VIDEO_CALL	10	2026-04-05 07:19:03.727	2026-07-18 02:40:41.076
6ef1bce4-7d98-4e0d-99e8-15b4bb9a7666	58c26008-8639-4374-aa26-8ca3f75856aa	MESSAGE_SEND	0	2026-04-06 01:54:59.571	2026-05-14 01:38:56.473
6192c79b-a6b7-4019-8476-611e41fe627c	bc7feebc-ebb0-4109-a89f-e661c241b148	MESSAGE_SEND	4	2026-04-06 22:15:57.451	2026-04-07 22:18:02.105
d17fa3c9-dbc7-469d-8b8d-25e191f5cea5	bc7feebc-ebb0-4109-a89f-e661c241b148	CALL	8	2026-04-05 03:53:28.596	2026-04-07 22:18:02.398
976064c8-b5b9-40cb-aef7-d52215092b6c	bc7feebc-ebb0-4109-a89f-e661c241b148	MESSAGE	10	2026-04-05 03:53:28.28	2026-04-07 22:18:02.411
dcee12d7-5ae2-4f56-84a6-392e8176474a	58c26008-8639-4374-aa26-8ca3f75856aa	CALL	5	2026-04-04 03:03:46.488	2026-05-14 01:38:56.863
2cb23be8-f83f-4f3f-8bee-a4c66c3ea9e4	9f1b2121-6ed7-48d1-a320-ea48c0f416db	CALL	8	2026-03-31 12:14:58.304	2026-07-02 11:23:54.649
e98edeaf-6915-4991-8d0b-7258ddf22529	12f7b8d1-cf0c-47dd-a5db-6d36a02cb3d5	MESSAGE_SEND	0.5	2026-04-09 21:23:58.309	2026-04-09 21:23:58.309
e1af83a3-2d10-4e29-a6bf-130fcaf19822	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	MESSAGE	5	2026-04-05 07:19:03.464	2026-07-18 02:40:41.443
97b8472c-b6d1-4434-a54e-43b8e017c5b7	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	CALL	5	2026-04-05 07:19:03.716	2026-07-18 02:40:41.437
c0e9f3b1-b816-4346-ae66-c31b70af7a98	9f1b2121-6ed7-48d1-a320-ea48c0f416db	MESSAGE	4	2026-03-31 12:14:58.042	2026-07-02 11:23:54.643
7496ff80-2752-46f1-836b-97c15b8f1689	7683de0a-a380-4be2-a89a-a51b36ad118e	MESSAGE_SEND	5	2026-04-06 19:44:45.476	2026-04-06 20:51:56.859
2a91aaca-0343-443b-8c3d-366918a330d9	7683de0a-a380-4be2-a89a-a51b36ad118e	CALL	10	2026-03-31 06:22:43.564	2026-04-06 20:51:57.182
07091a4b-ac72-4cfb-b179-e1eb09c83654	7683de0a-a380-4be2-a89a-a51b36ad118e	MESSAGE	10	2026-03-31 06:22:43.216	2026-04-06 20:51:57.196
da993239-628f-49dc-b6b3-cf3d4091e624	58c26008-8639-4374-aa26-8ca3f75856aa	MESSAGE	5	2026-04-04 03:03:46.488	2026-05-14 01:38:56.865
63a08fa2-5f20-4dc2-b950-5b6067278713	5a46d608-6458-4ae5-ab32-afc0b456dd79	MESSAGE	5	2026-04-05 04:35:24.059	2026-05-16 05:04:11.191
d2a791ab-a890-47d6-9adb-3df1a473f7aa	af0d09d6-891f-429e-b0d7-46cec713c93e	CALL	5	2026-03-31 03:15:15.903	2026-05-27 09:28:55.256
427bc2f6-9597-4141-b230-7c6809220c5b	6e72aec2-dff0-4b66-b031-99acde32af39	CALL	5	2026-04-05 05:08:47.368	2026-04-11 02:54:24.396
7e5840e2-dc9e-4611-94f6-a8d270ad020a	6e72aec2-dff0-4b66-b031-99acde32af39	MESSAGE	5	2026-04-05 05:08:47.043	2026-04-11 02:54:24.396
cbdbdf09-9e52-4b6f-85e0-11f40edbc17f	7683de0a-a380-4be2-a89a-a51b36ad118e	VIDEO_CALL	10	2026-03-31 06:22:43.551	2026-04-06 20:51:57.199
593ec35f-33be-4a0d-bd72-a4bc297997eb	7c050f65-3601-4ab3-8a6f-2279e4f01bf3	MESSAGE_SEND	0.5	2026-04-10 21:53:30.057	2026-04-10 21:53:30.057
2e9e3557-2a22-4190-a7d4-bd5e3f648506	7c050f65-3601-4ab3-8a6f-2279e4f01bf3	VIDEO_CALL	800	2026-04-10 21:53:30.257	2026-04-10 21:53:30.257
dda762ee-7ea0-41f1-b644-f1f2035155bf	bc7feebc-ebb0-4109-a89f-e661c241b148	VIDEO_CALL	10	2026-04-05 03:53:28.606	2026-04-07 22:18:02.414
90dceef0-f1db-4664-a944-c1d754755a06	71b5cf85-eef6-43e5-a180-2c28ce937b54	MESSAGE	5	2026-04-08 06:04:44.527	2026-04-08 06:04:44.527
63fa81e8-6035-423f-8c0e-52dd803d9feb	8ebe3560-3215-4b5d-8d00-040942f57465	MESSAGE_SEND	2	2026-04-06 21:10:47.012	2026-04-06 21:10:47.012
31af7b15-9ede-415e-99c5-6f7557c123c2	8ebe3560-3215-4b5d-8d00-040942f57465	CALL	20	2026-04-06 21:10:47.016	2026-04-06 21:10:47.016
e6a32f68-23bd-42a7-a83f-455283076741	8ebe3560-3215-4b5d-8d00-040942f57465	VIDEO_CALL	40	2026-04-06 21:10:47.024	2026-04-06 21:10:47.024
91a47f5e-a634-4669-8ecf-cb7d1ce21215	8ebe3560-3215-4b5d-8d00-040942f57465	MESSAGE	10	2026-04-06 21:10:47.026	2026-04-06 21:10:47.026
451ac024-1dbf-4bc4-9ba0-37c75a31e20e	12f7b8d1-cf0c-47dd-a5db-6d36a02cb3d5	MESSAGE	5	2026-04-09 21:23:58.575	2026-04-09 21:23:58.575
720e39eb-1a05-4da4-bd26-d94522d10d3d	12f7b8d1-cf0c-47dd-a5db-6d36a02cb3d5	VIDEO_CALL	10	2026-04-09 21:23:58.593	2026-04-09 21:23:58.593
4a680f43-7993-4d9c-bb81-d8827aa91386	71b5cf85-eef6-43e5-a180-2c28ce937b54	MESSAGE_SEND	0.5	2026-04-08 06:04:44.824	2026-04-08 06:04:44.824
502150eb-0d3f-4e47-8085-c90515ce9e52	71b5cf85-eef6-43e5-a180-2c28ce937b54	CALL	4	2026-04-08 06:04:44.83	2026-04-08 06:04:44.83
7b8541d5-5528-46a2-8fa2-4e2b0a022fe8	71b5cf85-eef6-43e5-a180-2c28ce937b54	VIDEO_CALL	10	2026-04-08 06:04:44.84	2026-04-08 06:04:44.84
1a5aba19-7ecd-4c21-96e8-bf0dc4fd3f36	12f7b8d1-cf0c-47dd-a5db-6d36a02cb3d5	CALL	8	2026-04-09 21:23:58.592	2026-04-09 21:23:58.592
76e0295c-b4f2-4185-891e-ec0616683ef3	af0d09d6-891f-429e-b0d7-46cec713c93e	VIDEO_CALL	8	2026-03-31 03:15:15.917	2026-05-27 09:28:55.274
fb4cf7eb-973d-4c4c-940b-59b0267195c4	9f1b2121-6ed7-48d1-a320-ea48c0f416db	MESSAGE_SEND	0	2026-04-06 18:54:53.945	2026-07-02 11:23:54.371
8770124e-3454-4d3c-bd8d-182cb3827ef7	7c050f65-3601-4ab3-8a6f-2279e4f01bf3	MESSAGE	4	2026-04-10 21:53:30.274	2026-04-10 21:53:30.274
1822df13-e42c-4bf5-9622-dc6c6e746a81	7c050f65-3601-4ab3-8a6f-2279e4f01bf3	CALL	500	2026-04-10 21:53:30.275	2026-04-10 21:53:30.275
7f40d832-93fa-475f-9912-7b6718711c77	5a46d608-6458-4ae5-ab32-afc0b456dd79	VIDEO_CALL	8	2026-04-05 04:35:24.398	2026-05-16 05:04:11.21
05ad0b6e-6eb9-41a9-8ee5-7d3f0d0a5c85	a3e7cb5b-c1d6-4eed-b5d5-fa7183dc603c	MESSAGE_SEND	0	2026-04-07 02:32:50.714	2026-07-18 02:40:41.424
68cf3ab4-df4c-4107-96a7-a5149b43334f	2e6bef9d-4934-4ce1-8ff8-0560e2dc048d	VIDEO_CALL	15	2026-05-16 01:47:30.273	2026-05-16 04:22:38.33
74f9de12-070d-4fd8-b9e8-5dd4adc88880	2e6bef9d-4934-4ce1-8ff8-0560e2dc048d	MESSAGE	18	2026-05-16 04:22:38.335	2026-05-16 04:22:38.335
a8c25e5e-24cd-44c0-b5a9-828c81cf04e1	89021f50-7097-4ed7-ba0d-29de9acfb743	MESSAGE_SEND	0	2026-05-03 07:16:25.903	2026-05-16 05:01:52.384
7399ff76-a381-47ca-9913-457d427433c1	6c85dc06-f2e9-4dc1-bcc5-6f2df559f290	MESSAGE_SEND	0.5	2026-04-11 00:36:33.544	2026-04-11 02:09:28.763
8381158c-5cd2-4fb7-9edc-33e076838ebe	6c85dc06-f2e9-4dc1-bcc5-6f2df559f290	MESSAGE	4	2026-04-11 00:36:33.743	2026-04-11 02:09:28.957
0032c09c-f7b8-4a55-bfdc-e2d29924bed3	6c85dc06-f2e9-4dc1-bcc5-6f2df559f290	VIDEO_CALL	15	2026-04-11 00:36:33.746	2026-04-11 02:09:28.959
ccdbac63-55c0-4c1a-a7a8-1b93d81ff400	6c85dc06-f2e9-4dc1-bcc5-6f2df559f290	CALL	8	2026-04-11 00:36:33.728	2026-04-11 02:09:28.961
27a5f14a-fe90-448f-a526-81a368237bf6	6e72aec2-dff0-4b66-b031-99acde32af39	MESSAGE_SEND	0.5	2026-04-11 02:54:23.861	2026-04-11 02:54:23.861
78c7ea47-5b39-40d7-82f1-8cc2c5449103	6e72aec2-dff0-4b66-b031-99acde32af39	VIDEO_CALL	8	2026-04-05 05:08:47.371	2026-04-11 02:54:24.398
3c8eaa28-657a-460e-b4d3-ddfa6e6426b0	206fc757-97fd-4e31-81fd-8e68b7733d95	MESSAGE	10	2026-05-04 06:49:11.148	2026-05-04 06:49:11.148
624e2bf4-a83d-4dd1-bb9e-dc82867f301a	206fc757-97fd-4e31-81fd-8e68b7733d95	CALL	12	2026-05-04 06:49:11.442	2026-05-04 06:49:11.442
690e0819-59c7-46bc-8b6f-4aff8cc5ca28	206fc757-97fd-4e31-81fd-8e68b7733d95	VIDEO_CALL	15	2026-05-04 06:49:11.452	2026-05-04 06:49:11.452
87f82783-8e93-4924-b160-6a529bee15a6	89021f50-7097-4ed7-ba0d-29de9acfb743	CALL	10	2026-05-03 07:16:26.242	2026-05-16 05:01:52.742
6d7d54f9-9662-4cdd-bcd8-8b2202a9c914	89021f50-7097-4ed7-ba0d-29de9acfb743	VIDEO_CALL	15	2026-05-03 07:16:26.261	2026-05-16 05:01:52.743
565cf1ba-a4a7-4afa-a52f-4a1c0e75d91c	89021f50-7097-4ed7-ba0d-29de9acfb743	MESSAGE	20	2026-05-03 07:16:26.257	2026-05-16 05:01:52.745
216eaa4b-35b2-4088-9d00-cee2281fd727	5a46d608-6458-4ae5-ab32-afc0b456dd79	MESSAGE_SEND	0	2026-04-11 02:08:28.795	2026-05-16 05:04:10.916
27bc6652-42fa-4748-ab80-0bebccbec094	493b6556-86fc-4da4-b036-141bf92c1c10	MESSAGE_SEND	1.5	2026-05-03 17:45:13.005	2026-05-04 19:58:55.2
1b2693eb-08ca-4d42-b2a1-3cb852306341	493b6556-86fc-4da4-b036-141bf92c1c10	CALL	2.5	2026-05-03 17:45:13.026	2026-05-04 19:58:55.526
a3514740-e49e-48a1-bd14-6e7ddfaf6071	493b6556-86fc-4da4-b036-141bf92c1c10	MESSAGE	3	2026-05-03 17:45:12.498	2026-05-04 19:58:55.539
09e18f04-118a-4632-bef7-b53ca15f5535	493b6556-86fc-4da4-b036-141bf92c1c10	VIDEO_CALL	4	2026-05-03 17:45:13.027	2026-05-04 19:58:55.542
eee47e4d-9d05-49a4-9f6c-1710b7467549	251daae3-0255-4334-a530-b02a59a578d3	CALL	5	2026-05-11 20:25:06.346	2026-05-11 20:35:24.028
fc615b40-d05f-4685-a9f0-d3534a7d782d	251daae3-0255-4334-a530-b02a59a578d3	MESSAGE	2	2026-05-11 20:25:05.322	2026-05-11 20:35:24.032
b732dc6f-760b-4206-be6e-914654fb2a3f	251daae3-0255-4334-a530-b02a59a578d3	MESSAGE_SEND	1	2026-05-11 20:25:06.344	2026-05-11 20:35:24.035
f9179e7b-56b0-4869-9306-cbed5c57c25e	251daae3-0255-4334-a530-b02a59a578d3	VIDEO_CALL	10	2026-05-11 20:25:06.348	2026-05-11 20:35:24.039
f6d54fe4-a5ee-48e0-9272-0a385f0b1424	5a46d608-6458-4ae5-ab32-afc0b456dd79	CALL	4	2026-04-05 04:35:24.412	2026-05-16 05:04:11.207
28e27e06-1b75-49a5-9f84-f8181122e13d	af0d09d6-891f-429e-b0d7-46cec713c93e	MESSAGE_SEND	0	2026-04-11 03:01:28.687	2026-05-27 09:28:54.942
2ed04286-2a41-47a9-8447-113222be065d	af0d09d6-891f-429e-b0d7-46cec713c93e	MESSAGE	5	2026-03-31 03:15:15.557	2026-05-27 09:28:55.272
6823cf4d-99b6-4cba-9c06-0ab6fed7b3b3	1d9fb2e9-90a5-4154-aa1f-8b823309554c	CALL	12	2026-07-08 00:36:31.21	2026-07-11 17:51:35.074
eeaecf92-783a-4487-bf0a-bf195a9f6f55	2e6bef9d-4934-4ce1-8ff8-0560e2dc048d	MESSAGE_SEND	0	2026-05-16 01:47:30.271	2026-05-16 04:22:38.037
1a9ebd54-6be2-4f08-b22b-bf98f4001594	2e6bef9d-4934-4ce1-8ff8-0560e2dc048d	CALL	8	2026-05-16 01:47:30.291	2026-05-16 04:22:38.313
0cd61749-de51-4db1-ac96-d9587bf1bb9b	1d9fb2e9-90a5-4154-aa1f-8b823309554c	VIDEO_CALL	5	2026-07-08 00:37:05.716	2026-07-11 17:51:35.515
6ad450f8-d9be-45db-850d-47702c280651	c7cc225e-3a86-4a63-b72c-c352cea9d0af	MESSAGE	5	2026-05-30 22:45:34.455	2026-05-30 22:54:58.274
4c90b885-8608-4cce-a21f-abe759683d19	c7cc225e-3a86-4a63-b72c-c352cea9d0af	VIDEO_CALL	1	2026-05-30 22:45:34.723	2026-05-30 22:54:58.542
fe29f2b5-fd9b-496b-8af6-c54d5cd89908	c7cc225e-3a86-4a63-b72c-c352cea9d0af	CALL	8	2026-05-30 22:45:34.733	2026-05-30 22:54:58.553
418ff088-8400-40f0-8fd4-b581dce6a501	793eff2c-99ec-4316-bbf5-3149af1487b8	MESSAGE	5	2026-06-04 06:13:27.23	2026-06-04 06:13:27.23
293c6961-9e9c-4c46-9f4a-c1e647647c0f	793eff2c-99ec-4316-bbf5-3149af1487b8	VIDEO_CALL	8	2026-06-04 06:13:27.575	2026-06-04 06:13:27.575
3523d4dd-b072-40c5-9608-94fa24cd2bf1	793eff2c-99ec-4316-bbf5-3149af1487b8	CALL	5	2026-06-04 06:13:27.586	2026-06-04 06:13:27.586
db1b643f-73cb-4e10-beba-41b84f6280e0	0a354ef6-1664-4df0-82d6-bdaca769dd43	MESSAGE	1	2026-06-18 03:23:09.542	2026-06-18 03:23:09.542
ecb95c92-1ac1-4475-acbd-096081833912	0a354ef6-1664-4df0-82d6-bdaca769dd43	MESSAGE_SEND	1	2026-06-18 03:23:09.539	2026-06-18 03:23:09.539
2dea181f-f5fe-4a69-89c9-4d718751566f	0a354ef6-1664-4df0-82d6-bdaca769dd43	CALL	3	2026-06-18 03:23:09.616	2026-06-18 03:23:09.616
1412b75e-40b0-4e79-a12f-354044133595	0a354ef6-1664-4df0-82d6-bdaca769dd43	VIDEO_CALL	4	2026-06-18 03:23:09.757	2026-06-18 03:23:09.757
3f7ec3b7-aeb3-4db2-8adb-608a06755940	a1c9542f-aee8-44be-b313-627df56c5c8e	CALL	5	2026-07-16 05:03:09.491	2026-07-16 05:03:40.539
682e5401-3889-404e-aaa4-63a5d13b6e62	7a3e2e94-7fbb-4360-89b4-8e6db6dbc9ab	MESSAGE_SEND	10	2026-07-21 01:29:03.222	2026-07-21 01:29:03.222
58a7f7ef-235e-454f-9ef9-8427718a0150	a1c9542f-aee8-44be-b313-627df56c5c8e	VIDEO_CALL	10	2026-07-16 05:03:09.512	2026-07-16 05:03:40.554
3eafa016-a802-4608-89c3-ed8f58711b94	d4e97725-b786-488c-ba76-09e80afced1a	MESSAGE_SEND	0	2026-07-16 06:00:04.155	2026-07-16 06:00:04.155
acbb883d-fcaf-4cda-b0d1-1f0579069715	1d9fb2e9-90a5-4154-aa1f-8b823309554c	MESSAGE_SEND	2	2026-07-08 00:37:28.906	2026-07-11 17:51:34.164
fddbb089-95a5-4825-83f3-c1dadea769f6	1d9fb2e9-90a5-4154-aa1f-8b823309554c	MESSAGE	3	2026-07-08 00:37:29.832	2026-07-11 17:51:34.632
460c70ce-f1f0-4b92-8c77-963195b71580	7a3e2e94-7fbb-4360-89b4-8e6db6dbc9ab	CALL	10	2026-07-21 01:29:03.666	2026-07-21 01:29:03.666
3f7c2fbf-8ec1-471d-8f05-8f4a8f74421c	d4e97725-b786-488c-ba76-09e80afced1a	CALL	5	2026-07-16 06:00:04.402	2026-07-16 06:00:04.402
d424b8f3-83f9-459b-9b06-d529cba7b366	a1c9542f-aee8-44be-b313-627df56c5c8e	MESSAGE_SEND	0	2026-07-16 05:03:09.18	2026-07-16 05:03:40.201
3733c614-6ece-4c75-953a-fbb50c87fc75	a1c9542f-aee8-44be-b313-627df56c5c8e	MESSAGE	10	2026-07-16 05:03:09.508	2026-07-16 05:03:40.537
e2fd83ba-e309-47df-a078-fd64873eb16d	d4e97725-b786-488c-ba76-09e80afced1a	MESSAGE	20	2026-07-16 06:00:04.406	2026-07-16 06:00:04.406
b2ed18dd-d58c-4dcb-b5fc-b35a3f15bbcd	d4e97725-b786-488c-ba76-09e80afced1a	VIDEO_CALL	10	2026-07-16 06:00:04.42	2026-07-16 06:00:04.42
3ff6bc27-aeb9-4b4a-8dd2-8f730388de4b	8382db93-444d-41ab-b4e0-b3f6fc0ab632	MESSAGE	3	2026-07-18 01:54:39.795	2026-07-18 01:54:39.795
57c98609-0a96-4ad8-8c28-b04304739ab9	8382db93-444d-41ab-b4e0-b3f6fc0ab632	CALL	3	2026-07-18 01:54:40.359	2026-07-18 01:54:40.359
8d577639-7368-4fc8-bee0-62ef1c80096d	8382db93-444d-41ab-b4e0-b3f6fc0ab632	VIDEO_CALL	5	2026-07-18 01:54:40.601	2026-07-18 01:54:40.601
f0302699-c6ee-414f-bc4f-3a81dead3704	8382db93-444d-41ab-b4e0-b3f6fc0ab632	MESSAGE_SEND	2	2026-07-18 01:54:40.843	2026-07-18 01:54:40.843
4a460e8d-29b5-4cba-9811-00b5cf532f8d	7a3e2e94-7fbb-4360-89b4-8e6db6dbc9ab	VIDEO_CALL	8	2026-07-21 01:29:04.111	2026-07-21 01:29:04.111
\.


--
-- Data for Name: social_networks; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.social_networks (id, name, icon, "iconPublicId", "createdAt", "updatedAt") FROM stdin;
07340b7f-659f-429e-9e01-d14ecc5ea9b3	TikTok	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1783526370/7a51c73a80a48c70d1549745eeb6ff22-removebg-preview_tt9rkx.png	https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/tiktok.png	2026-07-08 03:14:28.499	2026-07-08 03:14:28.499
17894517-b737-4cef-b7ac-0b6a1607282c	Telegram	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1783526370/7e6b3649b5c0d0a2f783df498a092a59-removebg-preview_lvzzqh.png	https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/telegram.png	2026-07-08 03:14:30.199	2026-07-08 03:14:30.199
517d30f5-1249-4e2c-89a8-76851bf648ef	Instagram	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1783526371/b68b7453dc531b458c022a819332f30c-removebg-preview_a8btpc.png	https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/instagram.png	2026-07-08 03:14:28.277	2026-07-08 03:14:28.277
56fda5fb-d658-477b-92a6-96433d7b78b5	YouTube	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1783526370/e56a3afa75be353374807212663c312b-removebg-preview_z6rvap.png	https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/youtube.png	2026-07-08 03:14:29.136	2026-07-08 03:14:29.136
5de4c5b0-df30-45ef-bd38-f3983d0fce0d	Twitter	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1783526370/bc8a485bca32c52159fef7dfb093588e-removebg-preview_slylpb.png	https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/twitter.png	2026-07-08 03:14:28.711	2026-07-08 03:14:28.711
adf96712-1a61-42d2-8fd3-faa68ec86142	Facebook	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1783526370/59a8db60be7d4ff2f8b9ff17936da66b-removebg-preview_pbvtjw.png	https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/facebook.png	2026-07-08 03:14:28.923	2026-07-08 03:14:28.923
c0d8c0b1-959e-4799-9ae2-24f85740a6db	WhatsApp	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1783526371/5216499f3137ba1f69694d5b7b9f549a-removebg-preview_sxnv51.png	https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/whatsapp.png	2026-07-08 03:14:29.987	2026-07-08 03:14:29.987
c363628b-56c0-4a8a-9f5d-3535c29a08c8	LinkedIn	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1783526370/b75f8e245c82e19b83fe26538771a783-removebg-preview_xruk4r.png	https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/linkedin.png	2026-07-08 03:14:29.775	2026-07-08 03:14:29.775
cdda26e6-420a-4efb-9208-1c31be5a82eb	Snapchat	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1783526370/faf0f3f22503f89d3c7de4ca13eaf0bf-removebg-preview_wql7vv.png	https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/snapchat.png	2026-07-08 03:14:29.561	2026-07-08 03:14:29.561
2c2d5676-0377-4fd1-92b4-de56e9ac1ef9	Twitch	https://res.cloudinary.com/dcyx3nqj5/image/upload/v1783526370/7b424c3d8025ef383e930e7c39422933-removebg-preview_aiwnie.png	https://res.cloudinary.com/dh2ytqnwm/image/upload/v1720000000/social-icons/twitch.png	2026-07-08 03:14:29.349	2026-07-08 03:14:29.349
\.


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.transactions (id, "walletId", "depositRequestId", amount, type, description, "createdAt") FROM stdin;
2a47c23d-e0dc-4478-ae77-8f258a94d0c3	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-03-21 19:15:23.591
d51a71e9-931f-4919-9238-4f5663f4efc0	36a1e380-00d2-4bd7-821b-95823c86efef	\N	2.00	EARNING	{"service":"Imagen Premium","clientUserId":"d436d124-4693-409a-8eaa-b49416703f76"}	2026-03-21 21:12:08.117
120bb2bd-3be8-4a50-b36a-087182ed193d	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Imagen Premium","clientUserId":"d436d124-4693-409a-8eaa-b49416703f76"}	2026-03-21 21:12:32.315
bd4defe2-9b2e-4372-841a-2492ea4795a4	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-03-21 21:17:41.535
d9ffdd8c-4b38-4128-b0cf-3f71b3a55f43	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-03-21 21:22:28.807
68a61fce-b727-4b7f-8519-6af61e9ed132	fa39581d-8edf-471f-8eab-5b13ff902474	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-03-22 10:35:55.339
e0cc0bbc-5410-4b06-a7c3-4e70c831350c	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-03-22 10:35:55.341
436fe5c3-263c-4b18-8ad6-18b298c4a38a	fa39581d-8edf-471f-8eab-5b13ff902474	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-03-22 10:37:03.119
eccd40ca-e25b-447c-b154-ab69678acabd	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-03-22 10:37:03.121
651e3013-eb17-4d6c-bc57-ab216a708a7b	fa39581d-8edf-471f-8eab-5b13ff902474	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-03-22 10:41:42.456
bb4f8130-03eb-4f84-afd4-cd6a270b25b1	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-03-22 10:41:42.457
ecb715f2-d4c4-4893-8455-dff3d6c97a2f	fa39581d-8edf-471f-8eab-5b13ff902474	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-03-22 10:43:53.515
73ee0670-6031-47e0-930c-14868ed7ffd6	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-03-22 10:43:53.516
a13a32e1-90e7-4fd1-a2ec-f7e29aeb870b	fa39581d-8edf-471f-8eab-5b13ff902474	\N	10.00	CALL_PAYMENT	Llamada de voz · 2 min	2026-03-22 10:48:55.949
ff2e6b0b-0c91-478e-bd1b-1b9c62df9cd6	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Llamada de voz","minutes":2}	2026-03-22 10:48:55.951
5d2c90b0-8e11-45d0-806a-e296e942126d	fa39581d-8edf-471f-8eab-5b13ff902474	\N	2.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-03-22 11:28:58.265
22f35297-3d02-4661-8604-efa990f06cb3	36a1e380-00d2-4bd7-821b-95823c86efef	\N	2.00	EARNING	{"service":"Imagen Premium","clientUserId":"304884e0-e87c-44b3-a135-525fcc3b24d6"}	2026-03-22 11:28:58.266
74a79a13-0f64-4146-9711-2623a4c88a27	fa39581d-8edf-471f-8eab-5b13ff902474	\N	10.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-03-22 11:29:01.342
f5ca37ff-5ead-417e-bb6b-6cc34f9b84fe	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Imagen Premium","clientUserId":"304884e0-e87c-44b3-a135-525fcc3b24d6"}	2026-03-22 11:29:01.343
8cf0608f-b89b-4077-b7d6-f93a38fa200f	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-03-22 12:10:39.763
dd140a59-1a5f-4da5-938c-e7541fc2f46b	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Video llamada","minutes":1}	2026-03-22 12:11:21.888
2a748339-5146-41d8-af58-3be7866e87d6	fa39581d-8edf-471f-8eab-5b13ff902474	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-03-22 12:13:32.867
3231cabd-11c4-4c63-b73d-b06c31b42cc4	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-03-22 12:13:32.868
9f7447eb-962b-4c88-b8b9-1a19a9134576	fa39581d-8edf-471f-8eab-5b13ff902474	\N	70.00	CALL_PAYMENT	Video llamada · 7 min	2026-03-22 12:19:58.618
4c362ae0-5e4a-4fb2-a360-d7457d045a20	36a1e380-00d2-4bd7-821b-95823c86efef	\N	70.00	EARNING	{"service":"Video llamada","minutes":7}	2026-03-22 12:19:58.619
57a9e6bc-05d2-4727-8b87-29c8634f9f2a	fa39581d-8edf-471f-8eab-5b13ff902474	\N	10.00	CALL_PAYMENT	Llamada de voz · 2 min	2026-03-22 23:10:35.187
e3164b0b-a8e7-4824-be68-ce851fae5e9d	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Llamada de voz","minutes":2}	2026-03-22 23:10:35.189
f077c1f3-8fc1-453f-8bd8-b8f197da15a3	fa39581d-8edf-471f-8eab-5b13ff902474	\N	40.00	CALL_PAYMENT	Video llamada · 4 min	2026-03-22 23:14:17.155
af0f9a89-77ae-4203-b39e-8d4af377010e	36a1e380-00d2-4bd7-821b-95823c86efef	\N	40.00	EARNING	{"service":"Video llamada","minutes":4}	2026-03-22 23:14:17.156
2b3e4095-b798-4287-8d7b-9d8b756ffab7	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-03-23 01:53:12.286
eb57878c-0574-4e2b-902c-79aab5bee62f	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Video llamada","minutes":1}	2026-03-23 01:54:14.25
3ddcd0dc-a8d6-4e2c-ada7-4d3589de547a	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Video llamada","minutes":1}	2026-03-23 03:07:42.541
a4e87e83-fb85-49ee-9d56-8ed5d8635f40	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Video llamada","minutes":1}	2026-03-23 03:40:40.82
b8a0db0b-10f1-472d-a7d4-33bb51fc0297	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Imagen Premium","clientUserId":"d436d124-4693-409a-8eaa-b49416703f76"}	2026-03-23 12:51:06.621
9b256e70-987b-454e-94dd-4b0932bd693b	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-03-23 12:54:58.996
16f59274-bf04-4137-99e1-0a0c9f5c64a4	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Video llamada","minutes":2}	2026-03-24 06:56:06.635
1261410f-8d73-453c-aa78-79ad8ed5d6e6	36a1e380-00d2-4bd7-821b-95823c86efef	\N	50.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:10:10.228
a82c86f8-333d-4ea6-9672-e6ecc5465696	36a1e380-00d2-4bd7-821b-95823c86efef	\N	50.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:30:30.626
14c6f25e-0cdf-4c5b-989a-a49e9e41f50b	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:31:07.668
82b8141a-d5a6-4459-a7db-da03c343f471	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:31:19.526
07a316f7-38e0-4c90-b4f1-b29b00750981	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:31:29.251
74248d77-3c98-4d01-ab99-cbdc7bf91a81	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:31:40.2
c1cd2603-321a-48f6-8181-5de6d780d153	36a1e380-00d2-4bd7-821b-95823c86efef	\N	12.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:31:51.48
420d4c68-b841-4e1a-892b-b8814aa55fb3	36a1e380-00d2-4bd7-821b-95823c86efef	\N	13.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:32:00.369
83a96db0-ea33-4352-b5ce-5a511e03bb9c	36a1e380-00d2-4bd7-821b-95823c86efef	\N	13.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:32:08.899
4aa3e609-84e0-48b1-bdb5-9d89be79cb6c	36a1e380-00d2-4bd7-821b-95823c86efef	\N	14.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:32:19.16
e79ae954-a1bc-476e-9eea-a252a05ece66	36a1e380-00d2-4bd7-821b-95823c86efef	\N	15.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:32:28.401
04852330-7360-44db-aa99-8d1cbe45291d	36a1e380-00d2-4bd7-821b-95823c86efef	\N	16.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:32:56.031
fc1f7656-7d86-43b2-9b78-6086f4cc90aa	36a1e380-00d2-4bd7-821b-95823c86efef	\N	17.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:33:06.135
b0d9d26d-8fc1-4946-8240-1a01b7fe9883	36a1e380-00d2-4bd7-821b-95823c86efef	\N	18.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-26 14:33:14.891
d919a79e-d68f-48b9-b3db-ebddbe106c4a	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	WITHDRAWAL	Retiro aprobado	2026-03-27 15:35:30.074
7eea7653-7c1e-4baa-9db9-c35adeef98ee	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-27 15:40:53.378
70fb9c98-d972-4587-8532-d3291eb6834f	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	WITHDRAWAL	Retiro aprobado	2026-03-27 15:43:23.244
0cb7af25-54c8-45a1-8945-cf2e17f858bc	36a1e380-00d2-4bd7-821b-95823c86efef	\N	2.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-03-27 15:46:00.059
2568be22-43cc-4c50-bc82-d1086e7f6d49	36a1e380-00d2-4bd7-821b-95823c86efef	\N	2.00	WITHDRAWAL	Retiro aprobado	2026-03-27 15:48:01.558
f42193b2-eac6-45aa-bd88-09ede774a90e	36a1e380-00d2-4bd7-821b-95823c86efef	\N	15.00	WITHDRAWAL	Devolución por retiro rechazado	2026-03-27 15:17:42.881
b208f955-126a-41e6-b60c-0fcaa852bad6	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	WITHDRAWAL	Retiro aprobado	2026-03-27 16:05:02.422
4e1ae3f4-2fcb-4b14-b278-995086872c40	36a1e380-00d2-4bd7-821b-95823c86efef	\N	16.00	WITHDRAWAL	Devolución por retiro rechazado	2026-03-27 16:08:38.732
4e20c20a-ede3-4539-ad55-50d0e7f85aa2	36a1e380-00d2-4bd7-821b-95823c86efef	\N	13.00	WITHDRAWAL	Devolución por retiro rechazado	2026-03-27 16:14:04.014
96bf42ee-f9a6-431d-b801-cdc7e9ab5df8	36a1e380-00d2-4bd7-821b-95823c86efef	\N	50.00	WITHDRAWAL	Devolución por retiro rechazado	2026-03-27 16:22:33.505
7b155e76-44a8-4b42-9315-f3656dac2406	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	WITHDRAWAL	Retiro aprobado	2026-03-28 03:49:28.904
2364c2cb-d276-45a9-9dee-713cb2400afc	36a1e380-00d2-4bd7-821b-95823c86efef	\N	15.00	WITHDRAWAL	Devolución por retiro rechazado	2026-03-28 04:27:35.216
066b8f74-9e42-4aca-99f5-120c7ea824a5	36a1e380-00d2-4bd7-821b-95823c86efef	\N	14.00	WITHDRAWAL	Retiro aprobado	2026-03-28 04:29:36.169
11236681-5a3d-4768-a782-36ae9c08cf82	36a1e380-00d2-4bd7-821b-95823c86efef	\N	2.00	WITHDRAWAL	Retiro aprobado	2026-03-28 14:37:04.773
f2adba14-f9fa-47da-8af3-5300d167d79c	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	WITHDRAWAL	Retiro aprobado	2026-03-28 15:14:06.776
5ed6275a-0f76-4314-95d6-9c935d2cfd6c	36a1e380-00d2-4bd7-821b-95823c86efef	\N	18.00	WITHDRAWAL	Devolución por retiro rechazado	2026-03-28 15:14:37.749
41db2e65-4a49-4820-9faf-8495d28e6b97	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	WITHDRAWAL	Retiro aprobado	2026-03-28 23:22:20.692
9313a171-a3c8-4283-8872-a20c58d9ee93	36a1e380-00d2-4bd7-821b-95823c86efef	\N	17.00	WITHDRAWAL	Devolución por retiro rechazado	2026-04-02 00:19:03.077
c33ec050-f24a-4d52-a15b-ae74dc35b6ff	36a1e380-00d2-4bd7-821b-95823c86efef	\N	16.00	WITHDRAWAL	Devolución por retiro rechazado	2026-04-02 00:21:28.94
877f585e-d2fa-4058-8137-7483710b0c3b	36a1e380-00d2-4bd7-821b-95823c86efef	\N	13.00	WITHDRAWAL	Devolución por retiro rechazado	2026-04-02 00:25:11.979
646b1f0d-c6c9-43b9-b785-a5a9050f0e6f	36a1e380-00d2-4bd7-821b-95823c86efef	\N	13.00	WITHDRAWAL	Devolución por retiro rechazado	2026-04-02 00:28:44.405
06000b36-1ad4-4f30-b492-babdb90696ef	36a1e380-00d2-4bd7-821b-95823c86efef	\N	12.00	WITHDRAWAL	Devolución por retiro rechazado	2026-04-02 00:40:06.157
df6e34a8-8d8b-492b-b201-b6f14701f546	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	WITHDRAWAL	Devolución por retiro rechazado	2026-04-02 00:44:27.068
6948d7fd-a732-4615-8cc7-56e14fd366e5	36a1e380-00d2-4bd7-821b-95823c86efef	\N	50.00	WITHDRAWAL	Devolución por retiro rechazado	2026-04-02 02:57:04.128
908d32b8-a52c-40c4-84e0-56b1ebfed857	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-02 23:42:04.869
0d24aa70-470a-449a-b5df-c31ade34b167	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Llamada de voz","minutes":2}	2026-04-02 23:43:32.364
a199b58a-911b-4d8d-bccd-b7cf2b9d9e96	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Paredes"}	2026-04-03 00:15:32.95
ea3d5313-f0e4-4054-87ce-c261764451b1	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Paredes"}	2026-04-03 00:16:02.659
d996588b-8855-4c11-b206-0f807a1a83e6	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"usuario1"}	2026-04-03 00:17:01.129
94141791-39a9-4651-91de-e9b1bf929276	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-03 00:28:40.192
bef1138e-369c-460e-8fca-73ea9386d078	5d68e083-119d-4f3f-bda5-7930d8e6e1bd	\N	20.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-03 02:39:51.313
dab3bcdf-298e-4fcd-9014-9307615bc223	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Imagen Premium","clientUserId":"2e0740ed-8b4b-4f38-8c94-25812aff3cdf"}	2026-04-03 02:39:51.315
574b7efb-20b6-4051-a655-236c7f729909	5d68e083-119d-4f3f-bda5-7930d8e6e1bd	\N	2.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-03 02:39:59.421
d7244e2a-7d5b-4c17-a02a-fac896d6ecfe	36a1e380-00d2-4bd7-821b-95823c86efef	\N	2.00	EARNING	{"service":"Imagen Premium","clientUserId":"2e0740ed-8b4b-4f38-8c94-25812aff3cdf"}	2026-04-03 02:39:59.423
fe5f44af-db15-4cc2-9b35-dd69dc114ab0	fa39581d-8edf-471f-8eab-5b13ff902474	407c3a33-dc95-497d-bd51-f1a0990d0af1	100.00	DEPOSIT	Recarga Flow: 100 creditos - Paquete inicial 	2026-04-03 12:44:16.004
6f33ad5c-e3da-4b13-8b83-6efeda7e812b	fa39581d-8edf-471f-8eab-5b13ff902474	d5163677-f342-40e2-8165-30af85dd54e0	500.00	DEPOSIT	Recarga Flow: 500 creditos - Navidad	2026-04-03 13:14:13.781
6a9491ac-9fb5-40df-83ed-24238c0d52ba	fa39581d-8edf-471f-8eab-5b13ff902474	67771959-6593-4e79-b9a2-0af0b43a8efa	100.00	DEPOSIT	Recarga Flow: 100 creditos - Paquete inicial 	2026-04-03 19:43:03.494
1c4937b6-5e97-43b3-97d7-c17208f6f5f6	c088f4ab-0de5-46a9-ab66-6e3e43719f88	eaf01ee4-b343-438a-befd-38705c537a5e	50.00	DEPOSIT	Recarga de prueba aprobada (seed)	2026-04-04 01:45:39.696
46f783d0-622f-4be3-9d78-1ed108c274c3	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 13:03:25.985
b34b6c00-d484-4d05-b503-612529177721	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	1.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 13:03:26.411
5eaf86e8-c869-489e-87f1-6a0b7508a61e	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	10.00	CALL_PAYMENT	Llamada de voz · 2 min	2026-04-04 14:33:03
4c6584ff-6df8-4a9d-808d-d7ff73e85f42	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Llamada de voz","minutes":2}	2026-04-04 14:33:03.455
1ffac8f8-6470-4d16-bad5-e3c3c38abeea	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-04 14:36:57.494
3b284d11-fdb2-444c-ad06-bf2210884dfb	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-04 14:36:57.964
20170823-5e2d-49ef-af07-309694f9273f	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-04 14:40:24.876
8ff4591c-946c-42c0-bf4d-6f06ccd469f4	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-04 14:40:25.344
3a099c30-bfc4-426c-9ed9-d336f6de1125	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-04 14:44:16.638
202e2ce6-a647-43a8-a636-f586a3aaa4e3	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-04 14:44:17.118
5172f133-adff-4da8-be9e-a7f447c4795e	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	10.00	CALL_PAYMENT	Llamada de voz · 2 min	2026-04-04 14:46:03.017
87206f12-fc78-4c08-9de6-a7fb18563fe0	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Llamada de voz","minutes":2}	2026-04-04 14:46:03.484
5e84b494-6de6-49ad-8aa6-2af36c3c0795	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-04 14:49:14.251
734f1144-38e1-4863-8999-a7c25cd86567	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-04 14:49:14.737
5ff2e8c9-4389-46d9-adf2-95afb8a42a42	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-04 14:50:03.199
cf5e4bbf-7faa-472f-9e2a-c6c8bf68af48	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-04 14:50:03.669
07a54a61-e0ba-4097-b49f-f37f5f3fc45c	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-04 14:56:31.326
3e734620-d97b-45f2-abe3-c761cbb84073	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-04 14:56:31.792
e0c79414-28e2-4ed3-b972-8278df5f6ecf	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-04 14:59:53.091
4c7f0d80-6c29-44e8-9509-71ca50547336	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-04 14:59:53.556
efefaa4a-33aa-4065-9806-817c04cdb5a2	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	10.00	CALL_PAYMENT	Llamada de voz · 2 min	2026-04-04 15:01:14.612
f6530cc3-29f1-46cd-b2ed-00d09c545e1b	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Llamada de voz","minutes":2}	2026-04-04 15:01:15.078
74112bb8-a639-4606-ae27-caa1ba75ad70	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	15.00	CALL_PAYMENT	Llamada de voz · 3 min	2026-04-04 15:27:22.842
20460d16-cb5e-41fe-9cb7-6f3ad75fe73a	36a1e380-00d2-4bd7-821b-95823c86efef	\N	15.00	EARNING	{"service":"Llamada de voz","minutes":3}	2026-04-04 15:27:23.314
599b28ff-2401-492d-b2fc-68089d92c1c8	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 15:31:01.703
6afe0424-6762-4071-b7cc-4e2d61448fe8	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-04 15:31:02.169
c540046a-ce8b-43be-8cd3-70128a571a67	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-04 15:31:49.802
318fe302-eb5f-4672-b949-1e3024153e15	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-04 15:31:50.281
718066cb-8d44-4667-9a0a-0934bc9be4ba	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	15.00	CALL_PAYMENT	Llamada de voz · 3 min	2026-04-04 15:34:48.776
2f0b72c1-ef39-4274-97a7-0399d01579b2	36a1e380-00d2-4bd7-821b-95823c86efef	\N	15.00	EARNING	{"service":"Llamada de voz","minutes":3}	2026-04-04 15:34:49.244
dffe2f0d-0638-44d4-87ef-fcf5532aaad1	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	WITHDRAWAL	Devolución por retiro rechazado	2026-04-04 15:57:00.18
26d04160-9a34-406c-8f62-81a01dc5b68e	36a1e380-00d2-4bd7-821b-95823c86efef	\N	50.00	WITHDRAWAL	Retiro aprobado	2026-04-04 15:58:04.842
a74faff0-dad5-4cbd-a2bf-9a62d54525ef	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 15:59:34.452
db7d2a0c-f31d-4e7c-b22c-d3a5d8354c82	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-04 15:59:34.923
ec65fe01-cc44-4349-b666-43cfe71f032f	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 16:03:05.278
f465bf12-ee39-466d-a1a2-b48722b5eced	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-04 16:03:05.739
5b1e3d86-5a9b-4eb9-b081-68ffecd10821	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 16:09:45.667
24a30c99-b66d-41d0-a3ad-25cef505aaef	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-04 16:09:46.143
ea91725c-8287-439b-ab9e-efca5f976a77	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 16:10:04.963
b7f7055e-f1e1-43b5-aaae-2f536980f05e	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-04 16:10:05.442
31cd25e5-653b-4a0a-8672-a8911a6a88b3	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 16:10:52.642
16521652-e74a-4cd5-bbf0-9e61d19f1d6a	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-04 16:10:53.106
2be0e4e0-d0c7-4dbe-aa8d-a1eda3a0a1f7	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 16:12:47.239
971423b0-1bde-46e2-9cf2-a4b5d09ac715	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-04 16:12:47.709
e488b405-f05f-415d-a714-13477e0571dd	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 16:14:57.019
55b7a232-8ba0-4b09-919c-2b31c766f9d2	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-04 16:14:57.498
c2374a6d-0c9c-41c7-b7aa-aec0c210b096	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 16:15:19.745
0e0107e5-df4b-4e1d-9772-74da5e55633d	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-04 16:15:20.222
b4225197-2cc3-4c88-a02e-59bb4c7d00a5	36a1e380-00d2-4bd7-821b-95823c86efef	\N	50.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-04-04 16:17:25.666
93f030aa-613e-457d-bad1-8788cde3be56	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-04-04 16:17:48.76
1ff431ac-4da8-455e-b63c-96a990c8c28e	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-04-04 16:18:08.721
aa4fc207-12ac-4b3a-a0d4-dd7d82fe9631	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-04-04 16:18:22.474
4ee3fdf3-4eb0-4909-bb7f-0025e7cfcf4a	36a1e380-00d2-4bd7-821b-95823c86efef	\N	15.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-04-04 16:18:37.021
790b9e98-9cdc-4cc9-a960-f467a5fe98f7	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 16:18:58.899
1daf1ce1-d2a2-410d-8964-49838e8644b7	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-04 16:18:59.375
ed80eacb-8490-4d37-b0ef-33a13eaf14a4	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	20.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-04 16:20:21.761
219c7981-c387-4d7d-a8ea-751db7d8a522	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-04 16:20:22.216
d5c3d059-2194-4deb-bc19-9ed32e7e167e	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	2.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-04 16:20:32.56
a51b194a-8c43-406a-8afd-7167b2dc9825	36a1e380-00d2-4bd7-821b-95823c86efef	\N	2.00	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-04 16:20:33.015
fcf29241-3724-4978-9fdf-5f998711cfa8	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	10.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-04 16:27:59.269
ca18f1a2-acd6-4a4d-9d65-0265864884cf	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-04 16:27:59.738
59e005b1-e7be-425b-9e8a-c6c983ad2a37	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	11.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-04 16:29:53.027
17768526-c60a-4156-b3a3-e3d16931d618	36a1e380-00d2-4bd7-821b-95823c86efef	\N	11.00	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-04 16:29:53.506
34577238-c715-4f66-9f76-29a78843c36e	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	15.00	CALL_PAYMENT	Llamada de voz · 3 min	2026-04-04 16:33:21.587
1a21bc58-dbc4-4e87-95ff-54a3c8b9a1ba	36a1e380-00d2-4bd7-821b-95823c86efef	\N	15.00	EARNING	{"service":"Llamada de voz","minutes":3}	2026-04-04 16:33:22.049
54703055-5513-4c7a-9bf2-41ced8c5c3f4	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 16:46:46.406
4b189491-bfb7-4230-b4ca-085059885916	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-04 16:46:46.872
1df3e8c4-2af4-40bd-a7c0-97989c25c73b	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 16:47:16.019
853db553-a84a-4306-9669-f1b1e3bd6f31	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-04 16:47:16.488
e1df696b-6776-4c49-a3fd-a6f079a9b798	36a1e380-00d2-4bd7-821b-95823c86efef	\N	50.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-04-04 16:54:13.482
5e5e94fb-6670-4c70-82e2-8a3a2991eca6	36a1e380-00d2-4bd7-821b-95823c86efef	\N	12.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-04-04 16:54:47.084
e8ed2e19-b2ca-4d6f-a115-ba9a5de2bd0f	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-04-04 16:56:15.286
fe5a5480-de1b-499a-ace7-ea73ee80f0d5	36a1e380-00d2-4bd7-821b-95823c86efef	\N	25.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-04-04 16:56:33.494
c367b9e7-56a9-4501-9066-8bc0be0da876	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 17:25:48.732
4608b684-4c8c-438c-b886-319185cd7aab	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	1.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 17:25:49.159
be9ee5e4-45aa-47f6-b484-e91693cc3845	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 17:31:18.761
7c9bc140-9a36-40e4-9a22-c8327a75570f	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	1.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 17:31:19.189
0fd24a7a-f189-45cf-932b-6fac18ff2ec2	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	6.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 17:32:10.732
c6206b32-48e4-4fdd-bdb1-ac7514ea28c4	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 17:32:11.161
ae5ca2e3-1cdf-46d5-8fb9-c58d1f63d825	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 17:32:11.591
2c53b6d0-c547-42b5-81eb-d13fccd81795	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	6.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 17:45:30.405
65b00bb7-0840-4377-b3b8-0812d35be628	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 17:45:30.854
10db628f-649f-429b-b6d0-c8713bbf13c3	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 17:45:31.29
9ba95b03-2f47-4cfa-9840-139652bd2e2c	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	6.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 18:44:32.001
604893a5-f6f5-4af8-974b-c5ba68c26e98	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 18:44:32.444
57ac572f-ffb3-42f2-9154-a2ad9160d2e0	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 18:44:32.885
99cf6cad-a436-4fb7-a9c5-cea4ffb0a77b	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	6.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 18:54:51.397
638ee2b1-1c3d-45e7-b3d5-def66b552dae	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 18:54:51.835
d54c1153-e8c5-4d3b-ae0a-5423c6320b8b	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 18:54:52.275
badb9bbd-4d8f-4b89-8fe3-337bfbadf2ae	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	6.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 18:55:32.601
381f271e-30ae-482b-9648-c42d2ec88675	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 18:55:33.038
b7647466-bd0d-4443-b9d7-4a3e3ab256d4	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 18:55:33.475
1d67306b-19b9-4649-b627-8574bdfc805a	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	6.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 18:56:15.713
8996d5cf-4fc7-4b59-9e41-a9bdcd46356e	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 18:56:16.158
0a4a4102-f914-4de9-a52d-c76315962dd5	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 18:56:16.596
ac8bf865-bc34-46ee-aeed-58b544e8d915	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Llamada de voz · 2 min	2026-04-04 19:08:04.276
a0e24d05-8aec-4ad7-950a-10e6f1da0b75	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":2}	2026-04-04 19:08:04.728
971fa492-0afa-40c2-a535-8f39055b2580	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Llamada de voz","minutes":2}	2026-04-04 19:08:05.178
35ec52ce-d892-4958-bd6e-d08ebea13a4f	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-04 19:15:27.285
79067171-c36f-4056-b6a7-85647e9db7b9	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	2.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-04 19:15:27.754
34d28d94-3f7c-42ce-be56-93ad1743a60a	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-04-04 19:15:28.227
31abfa78-6054-481e-857f-7bcf4d7bf354	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-04 19:21:59.261
fc04685d-abc4-4b09-95e0-f836717a479b	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-04 19:21:59.733
25ff747b-ade7-4810-813a-9cbfd0b4bab5	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-04 19:22:00.197
b37fcbbd-2d84-4dd7-b48c-ddc5d6dfa01d	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-04 19:22:39.084
74e0be5f-50aa-4ad2-8aa5-26fc3140f54e	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-04 19:22:39.521
66d77bdd-8c4c-42c8-af70-f44637532c67	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-04 19:22:39.951
d982ace0-bfc8-4618-a366-6fac3359d03a	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	6.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 20:10:39.789
9a64cb24-4efd-4ccb-83f2-f97a4c4f5650	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 20:10:39.793
4f7f9aca-118e-45ea-ab7c-aa2206e792f5	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 20:10:39.797
c26a8556-04ed-4c63-a8fc-8e366417c53d	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	6.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 20:10:50.199
f9525ad0-075f-48b4-940e-99003d7904f9	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 20:10:50.201
579d0ee4-bd53-4b1d-8e9a-e986cf7ac732	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 20:10:50.202
70199670-78bb-4a71-bfa6-8ee8b70f1e5e	675c9683-fc46-4019-a68b-8954ee27d03a	\N	10.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-04 21:04:02.012
25e68a92-ff0c-4847-81ee-509014db5cae	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Imagen Premium","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-04 21:04:02.488
4a63ed06-833a-47e0-914a-fd21a13996ef	675c9683-fc46-4019-a68b-8954ee27d03a	\N	11.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-04 21:04:12.31
2902ae36-503c-4399-8bb4-ed520fc5b95d	36a1e380-00d2-4bd7-821b-95823c86efef	\N	11.00	EARNING	{"service":"Imagen Premium","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-04 21:04:12.789
ade3ee6c-1a77-4ad5-a63e-4be35a6c7ce3	675c9683-fc46-4019-a68b-8954ee27d03a	\N	10.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-04 21:04:45.788
9507aaba-dc4e-4fa0-b739-cb1aa769b631	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Imagen Premium","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-04 21:04:46.276
e21e646b-0785-431e-a61a-62cdcda1e833	675c9683-fc46-4019-a68b-8954ee27d03a	\N	20.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-04 21:05:19.507
9ce2844c-3ae2-47ab-b3bf-84dc4d087b76	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Imagen Premium","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-04 21:05:19.977
e3b065e4-e25a-43f1-8517-7b7da14b19b7	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 22:07:34.697
48d795bd-0752-4a31-b2ad-497bb25a215a	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 22:07:34.699
a668fd49-88a5-4f4e-b18c-0229df24db2c	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 22:07:34.7
700491ed-130d-4138-89d0-bf6d5ba1bccd	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-04 22:18:31.686
06b48056-35d0-47eb-b927-02abc53a5451	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 22:18:31.687
10105396-6ff1-4c2e-a544-278b1376254f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-04 22:18:31.689
51ba6866-cb6b-4d1f-8fb0-84cf202d39f3	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Llamada de voz · 2 min	2026-04-04 22:20:27.071
6caaba52-aae1-4805-baac-4502b3c72b7c	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":2}	2026-04-04 22:20:27.073
f59b1449-cba6-4965-8bf7-f3a79d61dc20	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Llamada de voz","minutes":2}	2026-04-04 22:20:27.074
9fbbf4c8-e858-4bdb-8045-b7c8240a779b	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-05 00:02:12.994
e31699f3-6938-40e2-8980-eb91fdb03f6d	644deaae-3377-4848-a531-d4ead554803b	\N	2.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-05 00:02:12.996
65265fa7-6495-472e-865c-ac06d69c6b80	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-04-05 00:02:12.997
0b371601-711a-4612-b3fd-765d9a15cf28	fa39581d-8edf-471f-8eab-5b13ff902474	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-05 00:12:26.005
097a9c85-f804-41d4-8382-4ee310f2128c	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jaime"}	2026-04-05 00:12:26.006
52824b40-6606-47cb-b522-5edc2660011f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jaime"}	2026-04-05 00:12:26.008
e9695eb8-efcb-442b-8c1b-59b076d3bcdf	a5348a04-e289-4334-a8d7-4e80bb0a68ce	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 02:19:33.528
9d8dbd8d-3194-4eff-beb1-cb17cad57cf7	9d693796-cee9-43e6-842e-3f527eef4f11	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 03:19:02.709
1ae9f6e9-b595-4623-a268-773dce4106a8	5d68e083-119d-4f3f-bda5-7930d8e6e1bd	\N	7.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-05 04:04:55.947
b6832555-78d2-446f-8eb8-561567e804ce	408a8064-9ec9-416b-85ef-5f3c13271918	\N	3.50	EARNING	{"service":"Video llamada","minutes":1}	2026-04-05 04:04:55.949
c0eed436-e513-446a-a6f9-6323dacb3091	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.50	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-05 04:04:55.951
b8945dea-d239-41cf-a7b4-98bb9ef8b6eb	5d68e083-119d-4f3f-bda5-7930d8e6e1bd	\N	20.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-05 04:19:04.633
ef8304d8-0f0b-4631-81c9-07f6085ec552	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	10.00	EARNING	{"service":"Imagen Premium","clientUserId":"2e0740ed-8b4b-4f38-8c94-25812aff3cdf"}	2026-04-05 04:19:04.635
fc20c86a-4598-4a9c-aa0f-bc453d2ced44	925dc47b-91c6-4a44-9233-de139f77a62d	\N	10.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"2e0740ed-8b4b-4f38-8c94-25812aff3cdf"}	2026-04-05 04:19:04.636
951c059b-334f-4f84-b442-c6e6efb341a5	8463f9db-5f2b-4d53-9617-69beb1cc6817	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 06:38:49.619
e40e3ed8-e02e-4212-9482-21aa916d7fdb	380b54b9-5a70-4804-8c8b-1913590b0ab9	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 06:42:52.108
92092715-81b5-4dfa-8e4c-557e5b432219	69ae77b7-521a-4136-86a3-c42c58240802	5991a81c-f1ff-4508-9cf6-50bc4cd4f991	500.00	DEPOSIT	Recarga Flow: 500 creditos - Navidad	2026-04-05 06:56:33.501
f77e7747-74f4-4523-b4fa-6f7e7e36582c	69ae77b7-521a-4136-86a3-c42c58240802	\N	8.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-05 07:09:35.828
08cc1081-9930-43b4-b63a-3e8dddf1fe15	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	4.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-05 07:09:35.829
1c61cf8a-a255-461b-8800-13af9950b87b	925dc47b-91c6-4a44-9233-de139f77a62d	\N	4.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-05 07:09:35.831
361aabff-88ca-4df3-910b-ea66281f1551	69ae77b7-521a-4136-86a3-c42c58240802	\N	16.00	CALL_PAYMENT	Video llamada · 2 min	2026-04-05 07:15:23.822
46baafcc-31b5-43bd-8532-9d7effafd0b9	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	8.00	EARNING	{"service":"Video llamada","minutes":2}	2026-04-05 07:15:23.824
fb14aeab-b176-42a2-baab-3f43b08907d0	925dc47b-91c6-4a44-9233-de139f77a62d	\N	8.00	EARNING	{"service":"Comisión Video llamada","minutes":2}	2026-04-05 07:15:23.825
afc0c504-8113-43a4-9da0-843b7e1ae03f	69ae77b7-521a-4136-86a3-c42c58240802	\N	8.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-05 07:17:44.413
a67f4391-983c-47c0-a347-ed1787a768f2	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	4.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-05 07:17:44.415
4bfdb3ca-c47e-40f3-8e11-f922dd12fdf8	925dc47b-91c6-4a44-9233-de139f77a62d	\N	4.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-05 07:17:44.415
0c921e66-dfba-484e-b125-a1e6dbe2cce6	69ae77b7-521a-4136-86a3-c42c58240802	\N	16.00	CALL_PAYMENT	Video llamada · 2 min	2026-04-05 07:21:14.686
dd9ceaca-3600-4674-ae1c-a915ed91e3ba	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	8.00	EARNING	{"service":"Video llamada","minutes":2}	2026-04-05 07:21:14.687
6efa2239-706c-48f1-b02d-49cd5103fb86	925dc47b-91c6-4a44-9233-de139f77a62d	\N	8.00	EARNING	{"service":"Comisión Video llamada","minutes":2}	2026-04-05 07:21:14.689
a16ad166-ca22-43fb-80f3-870392fc44a9	69ae77b7-521a-4136-86a3-c42c58240802	\N	8.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-05 07:25:09.601
ce1641b4-a694-45da-acd9-f4747f9adb87	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	4.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-05 07:25:09.603
a732234a-5186-4df3-a426-f3acfb9219fd	925dc47b-91c6-4a44-9233-de139f77a62d	\N	4.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-05 07:25:09.603
8acb1700-7c8d-430d-a084-905ad7753a74	69ae77b7-521a-4136-86a3-c42c58240802	\N	24.00	CALL_PAYMENT	Video llamada · 3 min	2026-04-05 07:28:12.343
22557e29-d3e4-4669-b691-6d47cb4807e8	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	12.00	EARNING	{"service":"Video llamada","minutes":3}	2026-04-05 07:28:12.344
a690c014-bd8f-48ca-aa18-5b84bd706f26	925dc47b-91c6-4a44-9233-de139f77a62d	\N	12.00	EARNING	{"service":"Comisión Video llamada","minutes":3}	2026-04-05 07:28:12.345
d4ae2f4a-9935-4938-bf16-625b0eada078	69ae77b7-521a-4136-86a3-c42c58240802	\N	20.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-05 08:12:52.265
7d9ed0e0-61ef-440b-953f-640c2e8bc2a8	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	10.00	EARNING	{"service":"Imagen Premium","clientUserId":"9f83b658-6493-4a6a-931e-ccb6b8b7cad2"}	2026-04-05 08:12:52.267
6cd483f6-2329-4317-b9a7-91732e7ed194	925dc47b-91c6-4a44-9233-de139f77a62d	\N	10.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"9f83b658-6493-4a6a-931e-ccb6b8b7cad2"}	2026-04-05 08:12:52.269
bea4ad16-e9ed-4349-877a-fd3bac469a8e	69ae77b7-521a-4136-86a3-c42c58240802	\N	5.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-05 08:18:16.221
c587dea6-65f8-435e-8ae0-44515028f6c2	78c1e70c-69c7-4888-825b-4a2283697e00	\N	2.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jose"}	2026-04-05 08:18:16.223
9bde4a04-08c2-4ba5-adda-d2ca532db4ef	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jose"}	2026-04-05 08:18:16.223
349da4d3-22e1-407a-aeec-a8583c643a6c	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	60.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-04-05 08:43:23.498
ee201ea9-2f43-4e1e-9492-9d95088b50e6	e75a7f2f-acb3-459b-b7f6-b85c26a46529	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 12:50:35.99
3c22df0f-3f83-4ab4-99b9-11651df46ea2	553e0acf-d2f2-4e4d-a52f-1630fda4d226	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 13:21:15.927
a92ce0c2-93b7-4d65-a350-a5ade14d67af	489dab60-91ba-4d3f-b4b1-f917bf02dac8	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 17:49:11.966
522bf0c6-9c03-480d-b005-f0e7bdb66dc5	8d6d5e60-9a68-4813-832b-fd313b8d617a	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 18:54:54.474
001448e4-6f63-4af9-9bbd-deb48332ad6b	1743ab85-2b5f-4329-a6d3-ec908cee578a	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 19:18:04.038
4851498d-7b26-4bc2-9d7c-c9dfc20d486b	553e0acf-d2f2-4e4d-a52f-1630fda4d226	70836388-6fc4-494d-bfef-748ea4e42612	10.00	DEPOSIT	Recarga Flow: 10 creditos - Paquete inicial 	2026-04-05 19:34:16.383
11f6fe72-9f41-41ba-bf35-c9c74e18ca8f	553e0acf-d2f2-4e4d-a52f-1630fda4d226	\N	5.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-05 19:34:44.605
4389edce-7b38-44f4-9b14-4b9669af7300	78c1e70c-69c7-4888-825b-4a2283697e00	\N	2.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Alejandro  Perez"}	2026-04-05 19:34:44.606
60191f16-a5c4-4f5f-b31f-47ddc6cfc74a	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Alejandro  Perez"}	2026-04-05 19:34:44.608
82adc916-f408-4fc4-98c7-a3a6ccdd5359	553e0acf-d2f2-4e4d-a52f-1630fda4d226	\N	5.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-05 19:35:49.414
29a1ba5e-acdc-415b-90c0-9ca0fc9a9bcb	78c1e70c-69c7-4888-825b-4a2283697e00	\N	2.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Alejandro  Perez"}	2026-04-05 19:35:49.416
0013cecb-62d5-49b1-844a-7e6d49d83987	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Alejandro  Perez"}	2026-04-05 19:35:49.417
b1927a82-8043-4634-8423-b495828a661b	9f484004-a622-4a9a-bc11-8df10ffc0630	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 19:56:12.553
74834221-e141-4b30-bc88-744a37c045f9	73346749-a989-45dd-8cbd-d35c40ea850f	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 20:33:49.169
c1315859-5df6-45d3-8aaf-4180a5594bc1	06ba9870-cb5c-48dd-9e6a-af1170c0edbf	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 22:02:17.182
b9abd03f-4ac4-4221-8644-df8ec73d91a4	69ae77b7-521a-4136-86a3-c42c58240802	\N	39.50	CALL_PAYMENT	Video llamada · 6 min	2026-04-05 22:13:06.015
a61969a2-0bc8-4a5b-b198-bf9c4bced713	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	19.75	EARNING	{"service":"Video llamada","minutes":6}	2026-04-05 22:13:06.016
0a9770a6-0d17-4d10-8127-e2c42bb5085b	925dc47b-91c6-4a44-9233-de139f77a62d	\N	19.75	EARNING	{"service":"Comisión Video llamada","minutes":6}	2026-04-05 22:13:06.017
6c653358-ad01-494a-9e67-01f7898219fc	e237a3d5-93b4-4995-aa98-ad9927d0097e	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-05 22:51:46.116
a1d346c8-4705-445d-b951-2c7a53f09674	c8cc103f-6304-4fd7-a6e2-ca55b03e854f	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 01:30:04.019
58f9d994-118f-4e73-84ee-0b52881e3775	4684deb9-2d8d-4a06-8faa-12b9cc256597	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 01:34:56.231
d5bc40ff-9aec-48cd-85ce-5c312e1497f3	a0828f1c-d870-4b36-bc56-726d8f1539d6	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 01:44:40.278
652431e5-11e2-4f83-8b68-21a24328c53a	11bd09eb-ec41-42ef-b469-1469460178af	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 01:44:50.729
50371088-6b57-43b4-ade3-537438f85617	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 01:57:07.831
20e16daa-801d-4171-9611-524bb3c9618d	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 01:57:08.271
8f54be37-ed3f-49d3-84fa-3a583eb40723	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 01:57:08.718
18079455-9141-413e-a406-7b2d6432198e	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 01:58:36.086
89e4d461-1a04-41ee-80b3-ca52f118d77b	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 01:58:36.531
5028dddc-1839-4eaf-84b6-fbc890bec804	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 01:58:37.403
d1e97238-fac3-46b5-9336-37977c6c5e08	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 01:58:53.64
12694d05-bade-4905-90e3-2e7df1820c1b	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 01:58:54.084
da1632ff-2716-488b-9b81-b04de43f398d	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 01:58:54.526
23c4a0e6-6226-449f-8211-5cfd19cdd651	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 02:00:11.41
1d7c8aae-3d61-4667-875a-45c4269f961c	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 02:00:11.858
dc60684a-20ab-4733-87d1-544db51de332	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 02:00:12.302
82feb446-a397-4fd5-9e77-139cdcc5aa12	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	6.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-06 02:00:45.778
b4f44874-38c4-4056-9d55-fcd9c3eac66a	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-06 02:00:46.417
cecd3517-b9ae-4b1f-81f2-2e5fd0ff0bfc	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-06 02:00:46.877
fec85d16-0d1e-4f8e-9f0a-2d0fd9bee282	23b692b1-ac02-4d2f-8b9c-7030e62f3d24	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 02:31:25.348
bfa4fd2c-25cc-42a8-98d5-c5300a6fdcaf	3437c737-74ad-491e-bd62-5a6056e8b6c3	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 02:42:54.62
59c8dc07-c30f-4114-a700-2ae459602ba9	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 03:39:52.007
2085af3f-d388-47f1-be01-cd28b59581ef	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 03:39:52.454
8454839a-bea9-443e-9d00-2aedcc27047f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 03:39:52.904
c5fe089a-e404-4ddf-a2b8-9952a1c50caa	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 03:40:13.827
7abefe62-5f64-47c4-abaa-fc616466c558	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 03:40:14.264
389fee57-eddb-41b2-844a-c00b8752f637	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 03:40:14.704
19906c27-86be-4592-8289-393e052554db	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 03:40:44.878
9c4bdf6d-28d4-4650-8a93-2e500f309c57	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 03:40:45.324
21883042-7048-4924-a59c-1491d0fe1e94	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 03:40:45.764
45983393-9c90-4a89-b857-180d29723054	1a3afd77-acec-4b85-8000-7cf1dc34fe56	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 04:49:48.19
d2922ed4-5d86-4144-b84c-39f7ec370617	989d03e9-a8cd-4002-b2b1-34f536e5df71	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 05:31:32.237
ad953b7e-3fc6-4aec-bc9c-a71d83c217bf	a4489c5a-2eea-4488-844d-234d3672b84e	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 05:56:14.498
42903af4-d512-4cf7-90e2-5d66ebf87e91	989d03e9-a8cd-4002-b2b1-34f536e5df71	\N	10.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-06 05:59:37.104
fac0a3d1-b4ac-4ea3-a115-c09239740255	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	5.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Alfredo  Arevalo "}	2026-04-06 05:59:37.105
66c1c1ab-4915-4e68-9e8d-facdaf62e92d	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Alfredo  Arevalo "}	2026-04-06 05:59:37.107
f871c3df-6886-4fd3-a756-a050f49ae347	989d03e9-a8cd-4002-b2b1-34f536e5df71	\N	10.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-06 05:59:43.207
a600ed15-c189-49e6-83df-8c314fddad6c	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	5.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Alfredo  Arevalo "}	2026-04-06 05:59:43.208
3b638cff-180d-4ac7-9d0c-5bb285d4fe89	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Alfredo  Arevalo "}	2026-04-06 05:59:43.209
226383ab-a1e0-49eb-ab28-54b88d5917f5	dee1213d-c2c5-48f3-97a0-813e65841d9e	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 06:03:04.364
745e999a-8c8e-4649-ab33-1ddb46ca8d1a	4e378183-31e1-4ad4-8e60-c8e50dee53b8	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 06:48:13.905
205c7757-71e1-49d7-b4e3-e3cfb3343c14	ba4ca5d5-a56c-4b81-8482-cfe8e49067d8	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 06:59:08.766
eeaa650e-eb22-45a6-adac-6ec7a1e78653	ed3896e5-cd8c-4839-84f0-c9c8d1d98143	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 09:59:00.841
c1bf88f7-737c-4831-9f0b-a9faf11c8d95	042aafc9-f3a0-47b1-aaaa-c77d9f1dfab1	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 11:21:24.07
848f1ffd-0545-428f-b596-dccdb11eb26b	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 13:25:59.6
61add7ae-02f0-4a39-a405-d478cdc2583d	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 13:25:59.618
35712c7a-6e46-48eb-8c4c-03a21e7a7162	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 13:25:59.624
8d7a4d21-9fb0-4530-ae4a-2c338caf80e0	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 13:29:43.608
f5b1356c-9981-4eae-9c5c-888e403de6e3	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 13:29:43.61
f276cf98-f27c-4f03-8a3c-32bfa9921191	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 13:29:43.611
95619d91-d73b-4c95-a297-4554e247388a	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 13:38:19.742
b9da8f71-99c0-4c9f-b830-3cc16c8bbd3c	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 13:38:19.744
f7a5d940-79f5-4950-bb92-b617b55ad228	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 13:38:19.746
919cb22d-c3bc-424a-aa5e-61c58f28c032	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 13:46:40.363
08d428e4-3c26-4da0-b89a-6e83db484022	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 13:46:40.365
560f41c2-eedc-4973-80d6-12072c4e0ab8	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 13:46:40.366
f2dca321-b3cc-4a94-b56b-7bf7e66e68e7	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 13:46:46.029
8ad71f4e-1b98-47d1-aa7d-65b66e638ba3	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 13:46:46.03
9f48c33c-394e-46b5-8b3b-890f09e2b35e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 13:46:46.032
bb63c1f0-0274-48f4-bd13-0f2ebc84de94	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 13:48:02.805
1d555765-60d1-4acf-b710-f6e7b8fb2546	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 13:48:02.806
c8b836aa-2b0d-4dc5-8c0c-dc99861b2255	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 13:48:02.807
d3c0d34f-a573-426a-86f6-1fb0790a5ff0	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 13:48:04.358
1b4ce66d-8954-4113-bd87-590384aed45b	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 13:48:04.359
5226d7aa-6256-4fc3-beea-9ad8efea62b0	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 13:48:04.36
554a5929-ed59-4fae-b3d0-4725e74d5615	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 13:48:06.497
6228caa1-55cc-447a-bae9-ef847e7f9354	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 13:48:06.498
49b0f8a6-caa3-4fdc-819b-ef637739b6f1	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 13:48:06.499
53ef711d-67f8-47e5-a10d-dccca42062a7	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 13:49:23.007
fa8aac23-5a97-4ba8-8172-504d54efc452	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 13:49:23.008
db15c0cf-79d6-479e-b6b8-a75598d8f003	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 13:49:23.009
d59d1754-6c4e-4da0-89fe-329a7e3bc1f8	f7345e7a-bb6f-45c2-88c6-d2b9ff667f36	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 14:31:13.429
29d9b206-7355-4e4b-bc98-88722f3a5158	bd55d9d8-60d7-4787-b3a8-076d0a71a288	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 14:37:51.119
8b0711f2-7c3a-472a-91ce-aad08c86c72f	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 14:38:22.566
5e17e099-f046-45e5-9945-dc6d0f625a07	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 14:38:22.569
9fbd6e71-436a-4af7-96e5-2bb73de7e6f9	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 14:38:22.57
e30c0094-9fb1-443e-b85b-68a135f4f81c	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	5.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-06 15:18:37.864
256a65f3-a157-444f-8ebe-9e9afe40d841	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	2.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-06 15:18:37.866
d292de2a-a00d-4dd1-a36c-81db7ecb7a33	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-06 15:18:37.867
d18082ce-3d93-4125-8585-4da1bd9ec273	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 15:18:55.314
68f7ce6e-a700-45da-bc10-3de083189328	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-06 15:18:55.315
a885e960-c0a2-4063-8246-64b8a47c7f83	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-06 15:18:55.316
6ebd40d3-9c60-4b77-a5a6-a719365ec12d	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Llamada de voz · 2 min	2026-04-06 15:20:38.13
6e1c51ba-656f-4eb5-ba4d-bc72e81cad4d	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":2}	2026-04-06 15:20:38.131
cd59ca4c-8fdb-449c-93b4-741ef34af678	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Llamada de voz","minutes":2}	2026-04-06 15:20:38.132
09191891-3320-4302-a0fb-a710d9004d0f	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	30.00	CALL_PAYMENT	Video llamada · 3 min	2026-04-06 15:24:23.966
121bd532-eb0a-4773-9cd4-be47cf89a9e3	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	15.00	EARNING	{"service":"Video llamada","minutes":3}	2026-04-06 15:24:23.967
d0aaf177-d927-456b-b183-bae56306f7ef	925dc47b-91c6-4a44-9233-de139f77a62d	\N	15.00	EARNING	{"service":"Comisión Video llamada","minutes":3}	2026-04-06 15:24:23.968
97982b30-17f4-4648-8b76-dc30f40915aa	a5348a04-e289-4334-a8d7-4e80bb0a68ce	\N	2.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-06 15:33:53.24
cdaa4169-cb5c-4055-8159-5d2c27f3f29f	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	1.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-06 15:33:53.246
9b1411ae-15de-4848-b25b-d805010b0d5e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-04-06 15:33:53.248
154acc18-d112-4478-9a4d-c837bdc450a1	d13f5051-0ed1-438d-87ea-919135386b99	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 17:52:40.618
099924db-a227-4635-afcf-6b8949a9848b	a12b5008-e2b1-4b62-bfe3-1d47a1b5a032	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 20:09:59.701
c109159b-1d8f-42cc-b4eb-4f025ba079b0	b6f3f06b-792b-41ce-8f3b-425d91e5d04e	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 20:13:49.981
d73e998e-79e7-4c42-8b79-77ee4f4730e0	a5e5ec20-47d0-43c8-a620-35a93ea87f23	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 20:21:31.572
7843d2cb-0dc8-4c8d-9cde-198f178e8eee	3a93055c-62ad-474a-8389-1eddff361dce	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 20:36:26.227
5abf12a5-1c71-4531-b7a4-42c486a59da1	c7e3f538-c232-42c2-a8a2-5826bb7609e9	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 20:39:51.557
41f1c2d7-7549-405f-85a8-c345a2a7f352	9b7d7f18-80bd-424d-a825-0edcd142f8ed	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 21:01:21.235
0c4591c9-a981-4235-b11e-3b0fd9e1d98f	e3d22455-283a-47e3-9ab8-9515fde743fa	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 21:02:02.109
ef7bc8e8-8f9b-462a-aefd-b036885d2ea9	32917572-29e7-4406-bb24-de044538dd15	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 21:27:26.764
8c93f647-4425-468a-9a85-bcf25a3c5bfd	b4a76143-1e84-4b04-bc5b-8e4bb35819c1	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 21:50:37.913
31af09ed-fb85-49b0-a75e-1dcc8114a804	c4185f4e-c2ac-46e4-b03d-38e6d4066069	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 21:53:22.336
40937ac7-b5c9-4153-848e-720ec4d4309a	f15b5111-2e0f-487d-9514-a3e61c157138	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 21:53:51.037
cb89bbcd-9bb7-44b4-9789-7c5cf6d21448	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:18:47.02
878e7646-8140-4013-b597-76abf4599b7b	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:18:47.021
395d9e00-d6ce-4b81-9741-290a6c952276	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:18:47.022
4fe639a1-0f60-430d-861c-b52968cc2087	675c9683-fc46-4019-a68b-8954ee27d03a	\N	40.00	SUBSCRIPTION	Suscripción mensual a anfitriona	2026-04-06 22:27:25.376
91a32705-1195-4199-a972-3a79cffc1b35	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 22:27:25.858
d8b2fec8-e522-416c-9e3a-d9edb8a1b4ba	925dc47b-91c6-4a44-9233-de139f77a62d	\N	20.00	EARNING	{"service":"Comisión Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 22:27:26.34
90a8021d-164e-452d-a92e-1d6185b6a460	f15b5111-2e0f-487d-9514-a3e61c157138	ef9fa127-09ef-4927-aa19-d9904d5fbdd7	10.00	DEPOSIT	Recarga Flow: 10 creditos - Paquete inicial 	2026-04-06 22:27:56.399
baac0221-253d-4501-b393-8c858eb74290	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:30:34.482
f9984c36-abf6-4930-a9b9-3cde4fd99dd3	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:30:34.483
3ec67009-0b46-42f3-8a0b-ffdca299988a	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:30:34.484
0a3436bc-154c-4f15-9479-a300e87c016b	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:30:45.691
743fc8c3-c1d7-4299-a5a4-8b715829a83e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:30:45.692
5944aa80-cf8e-4d08-a78a-0b6263476691	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:30:45.692
236a844a-d458-480e-a7bb-211c6edc0f09	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:31:21.399
5f1e6ac0-6ede-4ea0-99b4-7c049c9fd008	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:31:21.4
5994debd-3237-4a49-aadf-39ac2255f303	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:31:21.401
8b80adf7-3cc7-489d-88ca-3d61aff4bb2b	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:31:41.948
04f7f475-443f-423e-9b02-c351cd6408a4	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:31:41.949
61917eaa-0132-4618-a37c-a42871894f42	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:31:41.95
2c6953e5-543e-4e9c-abcb-5cce9a51e4c5	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:31:51.023
cd391ea9-1add-4d6f-a1f7-80189bdc3753	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:31:51.024
2b8c5e07-1a13-423f-9187-f6a3294b6ed4	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:31:51.025
b16ce710-52ff-4306-a22c-b4c2e94bc92b	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:32:59.395
e5de6b74-f678-4eaa-a4b9-6fcde1eaf181	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:32:59.397
827648bc-8a29-446e-bdd7-9c70dbbfd6e7	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:32:59.398
e292c187-c615-4c6d-860c-06e35c74d97e	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:33:12.854
1bf48327-1add-43ce-8c5a-4db40c0c7e05	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:33:12.856
7ee0ca47-64a2-4c60-804b-936584b1ec66	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:33:12.861
e3a8dbfa-528d-48e9-84ef-e8e7310985d9	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:33:49.237
37e13259-bba2-47ed-8e5d-e94bd68bf031	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:33:49.238
a3eb7e54-67fb-4daa-a2c5-35c133cd6770	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:33:49.239
d37be016-2432-4a26-9191-5579b01a1ea7	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:34:06.241
f797ab1b-3a71-4e48-8eaa-44de92d3c761	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:34:06.242
d4cb9321-5592-47ee-b949-33fba7026fe3	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:34:06.244
d6b421e6-5670-4e98-b908-b1c4d73f9aa7	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:34:27.051
68181359-beeb-4f63-b357-b8753ed22b91	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:34:27.052
75e568a1-396c-457d-8a24-2a3d5391d638	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:34:27.053
bf346293-605b-438d-ac82-761118c65bb4	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:34:51.319
80a83113-f38c-4681-9c4d-9134b838c3b5	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:34:51.32
5012067b-7257-4fba-af07-91517606279c	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:34:51.321
f99172c9-3277-497b-8090-7ee7e1222070	f15b5111-2e0f-487d-9514-a3e61c157138	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-06 22:36:23.251
af4069b9-65ff-4de0-9cc9-43f23f4e7528	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:36:23.252
d61feee8-4fda-475c-823f-714a6d0cf6a5	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Silver  Vargas Meléndez "}	2026-04-06 22:36:23.253
3e388536-8d49-430c-8e66-e38a81a22938	f15b5111-2e0f-487d-9514-a3e61c157138	\N	4.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-06 22:36:24.169
cc7e985f-b488-4f83-8672-7f5e33ea46f3	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	2.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-06 22:36:24.17
f10afa57-8a51-4154-8ed5-c180a5b07ffb	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-06 22:36:24.171
c30a889e-f887-4960-b277-6b21fdd6dca7	a8988279-9f63-42df-9834-3834454b963c	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 22:37:45.663
39888b40-395d-4b66-8103-472b37817c6e	675c9683-fc46-4019-a68b-8954ee27d03a	\N	40.00	SUBSCRIPTION	Suscripción mensual a anfitriona	2026-04-06 22:40:24.369
49ba4416-aaf6-41bd-83e5-4892f2cd59c6	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 22:40:24.833
bab59067-e162-4ae5-8d2a-2feedd52adbc	925dc47b-91c6-4a44-9233-de139f77a62d	\N	20.00	EARNING	{"service":"Comisión Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 22:40:25.316
96adedca-13bf-4d90-8cad-23f99be7c420	675c9683-fc46-4019-a68b-8954ee27d03a	\N	40.00	SUBSCRIPTION	Suscripción mensual a anfitriona	2026-04-06 22:44:22.298
3e87a25e-3d62-4143-84fc-ce856cf22ed9	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 22:44:22.769
92df0584-d49d-4589-973e-752fa84e8c0d	925dc47b-91c6-4a44-9233-de139f77a62d	\N	20.00	EARNING	{"service":"Comisión Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 22:44:23.255
109b4d0a-aca6-4a8c-b185-395405ed3234	675c9683-fc46-4019-a68b-8954ee27d03a	\N	40.00	SUBSCRIPTION	Suscripción mensual a anfitriona	2026-04-06 22:52:00.9
94c1862a-9ae8-454f-9ab6-fa9f30e6ae24	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 22:52:01.384
6e6ef433-23fa-4cb7-b944-d84ebaefd631	925dc47b-91c6-4a44-9233-de139f77a62d	\N	20.00	EARNING	{"service":"Comisión Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 22:52:01.873
6429320a-deee-4446-9cf1-ab0fbe561d8d	675c9683-fc46-4019-a68b-8954ee27d03a	\N	40.00	SUBSCRIPTION	Suscripción mensual a anfitriona	2026-04-06 23:20:53.415
d6e0f6f2-7153-4eae-ade0-4c7ec52f1799	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 23:20:53.888
994ed32c-d065-424f-a6e6-ce114f6b8045	925dc47b-91c6-4a44-9233-de139f77a62d	\N	20.00	EARNING	{"service":"Comisión Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 23:20:54.375
48ed9fca-0bb1-4b4d-8c28-4257bbed89e6	675c9683-fc46-4019-a68b-8954ee27d03a	\N	40.00	SUBSCRIPTION	Suscripción mensual a anfitriona	2026-04-06 23:21:57.416
7a92233f-9cd1-46c0-af93-1a213221b69d	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 23:21:57.895
0346fb17-40a5-476d-a4f5-da05ba31524e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	20.00	EARNING	{"service":"Comisión Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 23:21:58.378
d84683c6-8afc-40dd-a873-18e26d66dde0	675c9683-fc46-4019-a68b-8954ee27d03a	\N	40.00	SUBSCRIPTION	Suscripción mensual a anfitriona	2026-04-06 23:23:27.681
6dfc7cdf-c28e-4ec4-accf-bc1fb956fb26	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 23:23:28.156
eadaf564-8372-4bf2-ac07-7024ed55d886	925dc47b-91c6-4a44-9233-de139f77a62d	\N	20.00	EARNING	{"service":"Comisión Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 23:23:28.638
cdfa62a9-b1d7-46a8-9959-bb123e7123e7	f273ac62-17ae-4ffd-9814-a2ad903a0f84	\N	20.00	DEPOSIT	Regalo de bienvenida - 20 créditos	2026-04-06 23:24:20.126
a7390080-735d-4fbf-88eb-3e3bd7daf650	675c9683-fc46-4019-a68b-8954ee27d03a	\N	40.00	SUBSCRIPTION	Suscripción mensual a anfitriona	2026-04-06 23:37:09.262
a6eff7b4-121c-4c21-bb5a-d68026626869	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 23:37:09.737
645ac042-d9d7-45f6-b905-57dea8329ab1	925dc47b-91c6-4a44-9233-de139f77a62d	\N	20.00	EARNING	{"service":"Comisión Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 23:37:10.214
0598a84f-d2b8-49d7-9a32-2e5dda80821e	675c9683-fc46-4019-a68b-8954ee27d03a	\N	40.00	SUBSCRIPTION	Suscripción mensual a anfitriona	2026-04-06 23:38:08.065
bc1e2d51-dd31-4ca8-8264-586b1239bb9d	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	EARNING	{"service":"Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 23:38:08.532
96dc9cc6-d003-4ad9-acc3-945eb0254428	925dc47b-91c6-4a44-9233-de139f77a62d	\N	20.00	EARNING	{"service":"Comisión Suscripción","clientUserId":"b6e54a63-4b05-46e5-8586-5f307f47006b"}	2026-04-06 23:38:09.01
8a33c18d-de4d-42fc-b508-6d695f145444	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Llamada de voz · 2 min	2026-04-06 23:58:39.626
f521ef06-9111-4110-9cd6-e9f9c196c047	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Llamada de voz","minutes":2}	2026-04-06 23:58:39.628
c70e2242-9601-400a-b54a-050bcbf31561	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Llamada de voz","minutes":2}	2026-04-06 23:58:39.63
d6456c9f-9e1a-47da-a478-31555fe58cd7	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-06 23:59:48.841
bb0b4231-b551-4140-a560-e4f8db898180	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-06 23:59:48.845
97cf810d-4fc2-42f7-8f9c-65fcc420f1a2	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-06 23:59:48.847
de5bddda-c7a6-4659-a219-de46d51d32e8	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-07 00:04:07.232
a6ed7eed-ed04-469c-8995-c706f4419c91	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-07 00:04:07.234
58e499e9-578b-44f7-b2fb-9d0e149fb4ea	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-07 00:04:07.235
d8365884-8216-4cb5-9908-06ad26491324	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-07 00:06:50.84
90bd6431-8117-40dc-9675-6897852d505e	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-07 00:06:50.841
015c79f4-9658-4cac-b185-be83a848d4d7	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-07 00:06:50.842
786917c2-e468-47a7-9efb-e42cc56af350	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	20.00	CALL_PAYMENT	Video llamada · 2 min	2026-04-07 00:09:28.973
fb302c07-7473-4f54-8f82-655629e6cfd9	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	10.00	EARNING	{"service":"Video llamada","minutes":2}	2026-04-07 00:09:28.975
07e66f02-285b-48fb-aa41-0170abfe850a	925dc47b-91c6-4a44-9233-de139f77a62d	\N	10.00	EARNING	{"service":"Comisión Video llamada","minutes":2}	2026-04-07 00:09:28.976
1bdf0546-f81c-4f49-afa4-398d868e10cb	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-07 00:12:34.44
6c251e62-39f9-488f-9726-cdc6b7e75d52	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-07 00:12:34.442
ac41d78c-6a95-4407-a24d-06ea3309f4ad	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-07 00:12:34.443
115cf7a2-8570-48aa-89ea-c4f37bebecfc	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-07 00:14:44.288
68557023-f6c3-46d5-8376-5e74a44c5161	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-07 00:14:44.289
96682f7e-7dc7-4984-8e6e-28c720e94647	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-07 00:14:44.29
96119fb7-abb0-44a2-9b7b-ffa73f370049	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	20.00	CALL_PAYMENT	Video llamada · 2 min	2026-04-07 00:16:42.366
89b83bdd-4e2a-42bc-861d-7cbb80257007	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	10.00	EARNING	{"service":"Video llamada","minutes":2}	2026-04-07 00:16:42.369
3ff283a1-7200-4640-ade9-08cad6e989f2	925dc47b-91c6-4a44-9233-de139f77a62d	\N	10.00	EARNING	{"service":"Comisión Video llamada","minutes":2}	2026-04-07 00:16:42.371
44151a5a-b5b2-4962-80ae-04c1f60560bf	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-07 00:18:12.262
5642f6d1-8d1d-49b7-8a74-8dab076b3dd5	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-07 00:18:12.264
a710f7f0-2610-4243-8974-5b7709c93e00	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-07 00:18:12.265
16fbdc4e-4d74-436f-b316-199fc1e7ea38	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-07 00:21:10.655
73b7f36f-3b61-465a-946a-7a147766332b	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-07 00:21:10.656
ae9c6647-3728-4de3-80b7-40bdfaf5f232	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-07 00:21:10.657
ed9b96fe-21c3-4fc9-ade7-a124dd36c774	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-07 00:23:06.864
b36e5ff0-7c49-4613-8f00-9d1991cb2364	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-07 00:23:06.866
ea117089-72c4-4da0-b1a2-9523728bc92f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-07 00:23:06.867
d45a91bd-16b9-44a4-bca8-c7753e9c6b89	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-07 00:23:24.896
2a3c8604-d31c-48b0-aa11-2a70e72462bb	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-07 00:23:24.899
ea9baa0c-ccb0-4d24-97a9-52b517b179aa	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-07 00:23:24.901
d2c77ab3-5d4f-41fe-b0a0-e98339a42282	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-07 00:24:05.64
277a4b2d-74d8-408f-9348-49f3b00baef1	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	2.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-07 00:24:05.642
8afdeeb4-03a7-4505-8494-4d3358767502	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-04-07 00:24:05.642
0a3d77fa-0997-4d6c-b0e0-ad29f0e5d8f3	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	50.00	SUBSCRIPTION	Suscripción mensual a anfitriona	2026-04-07 00:29:41.116
89bd93e2-57d2-4cb6-afa0-0b076e938d0a	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	25.00	EARNING	{"service":"Suscripción","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-04-07 00:29:41.118
b5557865-5fca-4b75-b158-74f923c33e08	925dc47b-91c6-4a44-9233-de139f77a62d	\N	25.00	EARNING	{"service":"Comisión Suscripción","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-04-07 00:29:41.118
39c1ceb5-52c0-47a8-a9ca-3dea78bf0918	9294d853-38ff-4244-8911-aba002f981cb	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 02:53:17.692
be92ad9e-9b41-4d44-9b34-cb49dcf38c41	31b2d11a-e69b-4659-a2a5-304a094f9908	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 02:53:35.887
11814ee4-38ca-45b0-a579-215954cb99d6	d07ac447-434c-41d7-bb76-b58820d7d07a	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 03:44:23.957
39e85719-ad13-470b-8111-3fd2a4582703	fa39581d-8edf-471f-8eab-5b13ff902474	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-07 04:04:02.905
65b9004d-fbc0-4150-90e6-9d07722fed5c	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	2.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-07 04:04:02.907
0f55f360-cf0b-46ef-a6fd-4a351e101b8e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-04-07 04:04:02.908
c259dc92-09df-41dd-9869-a10b75ed06f5	fa39581d-8edf-471f-8eab-5b13ff902474	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-04-07 04:04:29.205
31a97b17-9409-4795-a1ca-72e4840d72b2	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	2.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-04-07 04:04:29.206
1fbaa495-8446-47f6-9cc2-6ac24ca47a10	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-04-07 04:04:29.207
ede3b1ef-0af1-431a-a70c-4c17a4d0e2ee	fa39581d-8edf-471f-8eab-5b13ff902474	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-04-07 04:05:14.124
1fda0112-8510-46d9-878a-9ee99ad87c79	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-04-07 04:05:14.126
98d0d1c2-f7ea-4ec3-aa85-c2ed0cbc9a52	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-04-07 04:05:14.126
5b1d1448-7d7f-4d37-80f7-1c964ac8de77	fa39581d-8edf-471f-8eab-5b13ff902474	\N	20.00	CALL_PAYMENT	Video llamada · 2 min	2026-04-07 04:06:33.005
1d6df30e-60fb-4009-aaa6-c4e1f8c8dc8a	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	10.00	EARNING	{"service":"Video llamada","minutes":2}	2026-04-07 04:06:33.007
ad4cf66a-e590-4cc0-a9db-158c01c70b74	925dc47b-91c6-4a44-9233-de139f77a62d	\N	10.00	EARNING	{"service":"Comisión Video llamada","minutes":2}	2026-04-07 04:06:33.008
74a07274-3a62-4cbf-8bf1-03e565e09b10	46828d1e-e9b7-4d62-a925-de185db5beed	5dc9facf-a48c-49ad-b7d4-48bf1e664714	10.00	DEPOSIT	Recarga Flow: 10 creditos - Paquete inicial 	2026-04-07 04:19:01.52
55208f93-acc8-463e-a1a0-4f2c7ecc603c	46828d1e-e9b7-4d62-a925-de185db5beed	593bdd33-e9fd-40d7-aedf-21800cec38ae	10.00	DEPOSIT	Recarga Flow: 10 creditos - Paquete inicial 	2026-04-07 04:23:50.251
68baea9d-62be-4b8f-8a64-e05dbf891b4d	a645f363-38fb-49ba-b5f1-b1cd4215bf2b	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 04:47:57.819
281e050e-1555-4123-9df1-a1dca6bd2b80	c5a95e53-6e4f-45b6-b708-0068a0cdfe45	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 05:15:48.783
2baea68f-2994-4655-8a82-981ac7742a89	abe83234-5fc6-4216-be92-adb5468ac6af	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 05:21:36.357
5eea6758-4264-413f-803a-f0b00a0e9442	aa551991-363b-4318-8b1d-84268dcddf49	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 05:40:33.412
245943c8-476f-408a-90d6-23e9784954c6	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 07:53:56.442
d3f29f7b-8d38-4a4e-9bb0-a880b7c5d762	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-07 08:01:34.988
fed91a1d-582d-4941-b80a-6e40f9ca584c	0f662fd9-a2c3-4b35-9059-426730ed8778	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Andre Mori"}	2026-04-07 08:01:34.99
891a87d1-f6b2-4947-b971-9fbdb7f12d62	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Andre Mori"}	2026-04-07 08:01:34.991
c19eb136-9a3b-47bc-98cb-ed8a7c4577bf	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-07 08:02:12.766
48be1b3f-1352-4e1b-868f-dddf086dfa06	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Andre Mori"}	2026-04-07 08:02:12.767
acf55009-baba-4f1b-9b5b-6b3470ee5d8e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Andre Mori"}	2026-04-07 08:02:12.769
0e964b6e-ae80-4cc0-91ae-72769df0efd0	85d6b707-4506-4422-a9b7-63f3e7b33b76	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 08:35:35.065
efcf570e-d6b7-4fd7-b329-493da6e12a8d	6c004f7a-e6ea-41a4-8248-4245f84a994e	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 09:59:24.349
eb5c9e6b-ffbf-49d6-9b0c-3cb3e41d3d23	0b47883f-5066-42a1-93b8-23023a552b94	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 11:00:48.522
4a10c0f3-c6be-42c1-87de-e02cae83b927	96459afd-6889-41c7-8557-0484f1a5e3f2	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 12:38:56.948
f2f2ad43-594d-422d-83e4-d83b72489e6c	85d6b707-4506-4422-a9b7-63f3e7b33b76	bfd10b1e-eb59-4094-acd8-1da9e7e8479f	10.00	DEPOSIT	Recarga Flow: 10 creditos - Paquete inicial 	2026-04-07 12:47:07.052
901dc53a-e172-4c5d-a3be-968a40a49343	85d6b707-4506-4422-a9b7-63f3e7b33b76	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-07 12:56:13.162
c3cb0501-6ef2-4cfa-8028-3ce342b4eabe	0f662fd9-a2c3-4b35-9059-426730ed8778	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Artemiio Pizango Huainacari "}	2026-04-07 12:56:13.164
3a9b156b-969c-4bce-b1af-b797f91e11e8	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Artemiio Pizango Huainacari "}	2026-04-07 12:56:13.165
e7ae2c62-0868-4b30-8c52-bbd2b3b565cb	c2d91a5b-1510-4177-bcef-01c1d220cda5	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 16:01:35.87
eb99250d-1a91-4f01-bc39-9d95ed8be9ad	5e1aa818-5a1a-4a86-8111-51fc57c4ce0d	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 16:33:38.686
c473ad7a-7f77-4656-a875-168a78a3d713	94f45a5c-2539-4176-85b8-6aa9a92f0f7a	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 19:25:43.779
0a1ecb65-8525-479a-9b8b-756de5ee5f42	da151330-81c7-4046-9fc3-257b22854007	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 20:08:39.244
b73cdc4b-97e5-415a-b4d3-068b5abab6aa	8fbe5f1b-b92a-4b5a-969f-ff0442f8a149	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-07 21:13:09.711
6fd7413b-8b62-4947-b67a-29335ad8bf54	8fbe5f1b-b92a-4b5a-969f-ff0442f8a149	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-07 21:36:56.673
5af1dd6d-e752-443c-b976-e064563d67ac	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Alfonso Malca Miranda"}	2026-04-07 21:36:56.676
2e49150d-e4b4-42e0-9120-325941ebef97	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Alfonso Malca Miranda"}	2026-04-07 21:36:56.677
53b0d7c6-6dda-4afa-afea-1d033847e176	8fbe5f1b-b92a-4b5a-969f-ff0442f8a149	\N	6.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-07 21:41:49.178
43e38337-97f7-4285-80a3-0b59eded64dd	408a8064-9ec9-416b-85ef-5f3c13271918	\N	3.00	EARNING	{"service":"Mensaje recibido","clientName":"Alfonso Malca Miranda"}	2026-04-07 21:41:49.179
8f6b5459-7b0d-4930-8910-c68bd9df5d7b	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.00	EARNING	{"service":"Comisión mensaje","clientName":"Alfonso Malca Miranda"}	2026-04-07 21:41:49.18
51ff741b-2e31-4f01-8de4-cae9632301f7	8fbe5f1b-b92a-4b5a-969f-ff0442f8a149	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-07 21:44:10.565
7edbf7ba-30ac-4041-bc92-2abf4bc18d28	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Alfonso Malca Miranda"}	2026-04-07 21:44:10.566
743ee4c8-1662-4963-9f22-798d792ef367	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Alfonso Malca Miranda"}	2026-04-07 21:44:10.566
e304b98f-d57d-4f2f-ab05-f8f684b72051	8fbe5f1b-b92a-4b5a-969f-ff0442f8a149	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-07 21:44:17.488
d06167a9-0c6b-4a4d-b3ea-a725cf92e042	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Alfonso Malca Miranda"}	2026-04-07 21:44:17.491
3e852cdf-88de-425b-9bee-852c534cd235	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Alfonso Malca Miranda"}	2026-04-07 21:44:17.492
ad41afa9-7cb3-4968-a464-beae69f205b2	43120521-45bb-40e5-984b-980886f893e4	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-08 00:04:01.275
90ef667f-f11c-4d94-9e27-c4c9f21a8145	a6c4f51d-8f49-4518-806d-eb89008afe31	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-08 00:39:03.544
e4ec863b-827d-4483-b80c-922f9343aaba	e0954f81-5373-429d-b9bc-b543f277aa81	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-08 00:50:24.236
6e480d8a-047a-4e93-9981-a2bcb5724e94	96b3816c-1db6-425c-90ae-5feab98021b0	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-08 01:02:32.111
2c349353-07b0-4fba-9503-b75023f2f2a1	5d68e083-119d-4f3f-bda5-7930d8e6e1bd	\N	4.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 01:46:50.985
cd0244e4-91df-421c-821e-f3f88e7e07e1	408a8064-9ec9-416b-85ef-5f3c13271918	\N	2.00	EARNING	{"service":"Mensaje recibido","clientName":"César"}	2026-04-08 01:46:50.987
2442024f-736e-4567-a7a7-00edd033a5ca	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión mensaje","clientName":"César"}	2026-04-08 01:46:50.988
1290a8f1-32c7-43f7-930e-6c8b3918c6bc	5d68e083-119d-4f3f-bda5-7930d8e6e1bd	\N	4.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 01:53:13.557
6d9eacdc-5cd5-4983-8f3a-7bb1f854e74d	408a8064-9ec9-416b-85ef-5f3c13271918	\N	2.00	EARNING	{"service":"Mensaje recibido","clientName":"César"}	2026-04-08 01:53:13.559
033fc4d7-28a3-4690-be53-54519d594244	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión mensaje","clientName":"César"}	2026-04-08 01:53:13.56
2cffe55b-67ec-403b-a09c-daf524dadc69	5d68e083-119d-4f3f-bda5-7930d8e6e1bd	\N	4.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 01:53:20.968
7596a780-6475-4d89-aa0a-1fa800596b72	408a8064-9ec9-416b-85ef-5f3c13271918	\N	2.00	EARNING	{"service":"Mensaje recibido","clientName":"César"}	2026-04-08 01:53:20.969
e4e87cee-eab8-4733-8d35-adf79f6880f8	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión mensaje","clientName":"César"}	2026-04-08 01:53:20.969
87dc6bb1-ecea-40ae-8a46-31065903b95b	5d68e083-119d-4f3f-bda5-7930d8e6e1bd	\N	4.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 01:53:23.101
45cdfad9-c5f8-43e2-904a-e412f2a617e7	408a8064-9ec9-416b-85ef-5f3c13271918	\N	2.00	EARNING	{"service":"Mensaje recibido","clientName":"César"}	2026-04-08 01:53:23.102
1eb81a7d-448c-468e-a72e-1dc039e73682	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión mensaje","clientName":"César"}	2026-04-08 01:53:23.103
a641b86b-3c27-4c2c-83ce-fa1fb44c78f4	0388a266-c7a8-4bcd-87e6-63c5624dae97	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-08 02:14:52.835
a0164607-5715-434e-9eeb-0d68f8b50eb7	8fbe5f1b-b92a-4b5a-969f-ff0442f8a149	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 02:44:13.071
e47f4a59-60c5-4260-befe-e91a756f233d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Alfonso Malca Miranda"}	2026-04-08 02:44:13.072
66063125-4d8e-4c4e-ac01-eec69a47866d	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Alfonso Malca Miranda"}	2026-04-08 02:44:13.074
ee79e77f-e6f8-4191-9382-0a84d5fd09c5	8fbe5f1b-b92a-4b5a-969f-ff0442f8a149	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 02:44:59.477
8f8f0500-3fb0-4cc6-ae09-0e1482e943d2	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Alfonso Malca Miranda"}	2026-04-08 02:44:59.479
660904e8-0570-4a95-a605-c56f02919cdf	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Alfonso Malca Miranda"}	2026-04-08 02:44:59.479
05b1c667-6a22-42c8-b801-96e182677bc1	8fbe5f1b-b92a-4b5a-969f-ff0442f8a149	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 02:46:05.867
4cbebdc8-d531-418c-b9a0-9796ec2cfbe3	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Alfonso Malca Miranda"}	2026-04-08 02:46:05.868
1bed48e6-321e-4f84-acb3-a763881831fd	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Alfonso Malca Miranda"}	2026-04-08 02:46:05.869
dddcca9f-44de-4adc-ae01-4d04f2469305	8fbe5f1b-b92a-4b5a-969f-ff0442f8a149	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 02:47:27.898
4b681678-9ad4-422f-a339-7c09c9a3aaf9	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Alfonso Malca Miranda"}	2026-04-08 02:47:27.907
ab7c0d60-f1c6-4693-b98a-2b55e3765208	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Alfonso Malca Miranda"}	2026-04-08 02:47:27.915
b57b1e45-13d7-4bd0-8eb9-6946a19616bc	8fbe5f1b-b92a-4b5a-969f-ff0442f8a149	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 02:48:05.557
23e5e49d-ce10-4873-8307-c25e59246620	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Alfonso Malca Miranda"}	2026-04-08 02:48:05.558
ab089e3c-ce98-4e8d-9112-0a2436569acc	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Alfonso Malca Miranda"}	2026-04-08 02:48:05.559
19284d2d-f2ec-402f-bc54-5a681ded72ee	304cc6b2-29d1-4d0b-8b93-5b82e4149f18	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-08 03:27:54.104
90b86ddc-6f73-47ec-8bb3-ea660b535cbc	046a2be3-c30d-4361-8278-ceda22bbaa73	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-08 04:11:46.443
b766c1c9-7cd0-4052-9906-985c18a3efa9	de8ceed7-9651-416f-8053-f14018b77ce0	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-08 04:18:49.726
9edd69ae-1684-447d-bd3e-b318bc3efcce	f8efac7f-ddac-491f-8758-4a7981a95608	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-08 04:21:45.44
87cd2bdf-a1ec-4c1f-9637-5f95f9995012	36a1e380-00d2-4bd7-821b-95823c86efef	\N	25.00	WITHDRAWAL	Devolución por retiro rechazado	2026-04-08 05:15:29.782
0ac81544-c661-4dad-831e-5f06c3315120	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 05:15:55.849
ec38dd5d-9af0-4457-aae5-889e27cdb47f	0f662fd9-a2c3-4b35-9059-426730ed8778	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Andre Mori"}	2026-04-08 05:15:55.851
f48b7adf-b272-4115-9e48-603995acfc03	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Andre Mori"}	2026-04-08 05:15:55.851
ed940a03-b4b6-435e-8a06-2a5ba77d90d6	36a1e380-00d2-4bd7-821b-95823c86efef	\N	20.00	WITHDRAWAL	Retiro aprobado	2026-04-08 05:16:07.904
891c9839-5aef-4fc1-a5a3-f9b950f4839c	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 05:16:19.958
ddb120a8-9945-49fd-955d-7e05888e604f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Andre Mori"}	2026-04-08 05:16:19.96
08ec4fc7-c6ab-49f1-a746-ef9ed603d923	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Andre Mori"}	2026-04-08 05:16:19.961
4c081cc1-997a-4a43-a186-b65ce8f98aa1	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 05:17:53.04
507e6f66-b9fb-42ed-9707-61e109ac4450	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Andre Mori"}	2026-04-08 05:17:53.043
86e5c41c-e133-4603-b409-653dc75d2144	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Andre Mori"}	2026-04-08 05:17:53.043
e676f29b-8ce9-42ca-969f-da835ee1da02	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 05:18:11.687
5db67b07-eb27-4473-96bd-2485bc9405bd	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Andre Mori"}	2026-04-08 05:18:11.689
5fa1a633-d80a-42b6-9b02-b53eaab2fd3a	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Andre Mori"}	2026-04-08 05:18:11.689
c7423e0d-d0dd-4c25-82c5-dd30ca7be275	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 05:18:54.864
dd2ac580-b7ed-43f5-8b6a-a2f569c433a6	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Andre Mori"}	2026-04-08 05:18:54.865
c78f7474-6d93-478f-969a-751ae946af0b	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Andre Mori"}	2026-04-08 05:18:54.865
5c73a5a8-f830-42d4-8c69-b76e1ae05be9	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 05:18:59.878
6fc30286-4fe2-4be0-92d9-1ec8db6ea374	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Andre Mori"}	2026-04-08 05:18:59.879
6e6fbf15-0fcb-46ac-a8e8-3de9bdccdf86	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Andre Mori"}	2026-04-08 05:18:59.88
841c4c46-8d51-4f03-ac47-4aeb6c838250	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 05:19:32.525
d6d70ffb-a74e-446a-a988-ecca9dd1ca69	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Andre Mori"}	2026-04-08 05:19:32.527
39adc654-f3f5-40a9-a702-4a6bf64235ff	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Andre Mori"}	2026-04-08 05:19:32.529
83e88e9d-1eba-49aa-ad99-b185e89b1536	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 05:40:51.693
52c66ab7-7c6c-4b9a-93fb-67f433288801	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Andre Mori"}	2026-04-08 05:40:51.696
aa251a76-1fc7-4c8e-b666-0115115af90a	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Andre Mori"}	2026-04-08 05:40:51.697
f598752c-9346-4049-9d45-8d2a978d815c	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 05:40:53.635
cfd3d5b2-778d-40fd-81bc-d6ca30ae2e58	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Andre Mori"}	2026-04-08 05:40:53.637
7ddee0f9-8860-4783-85f3-5cc302b8d069	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Andre Mori"}	2026-04-08 05:40:53.638
635b4ef5-c9e4-4518-a589-9d45fc76b444	b90f229d-bcdf-4f16-ac20-e8c863470e6c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-08 05:45:58.242
bd841578-39e5-4fbc-9187-0307840f083a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Andre Mori"}	2026-04-08 05:45:58.246
3a27fc17-6776-47e8-8800-f01a9a558504	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Andre Mori"}	2026-04-08 05:45:58.247
5976ff6c-6037-4c66-9523-74a14d25e499	f57ba6ab-b2b6-4812-aead-3980807f8585	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-08 12:25:30.917
0d8ea9c8-ad5f-4510-8b25-be654ad925db	addd66da-5723-4339-8cf3-94e90821135b	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-08 16:56:27.109
d12328e9-5777-4035-863d-8d459cf0fc71	fd7d5615-1f04-4423-975d-ef297f14f2f7	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-08 23:28:27.759
fac35065-1f62-41c9-b437-809774f5f1b3	e8c7be9e-7887-40d9-8c70-70b2a3ba7b36	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-09 02:33:20.392
2234ae64-4b6e-4a15-895b-ee26027a918d	347aea1b-57ed-46a4-94d1-0c5193de8e48	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-09 09:03:05.635
edeb40de-d7c2-4ac5-b6e6-b0abef2d63ee	a59b1ffc-de01-43d2-8584-fe5806ec6c04	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-09 20:12:20.241
1921eb7c-7515-4958-a4e4-10e76f6098a1	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	39.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-04-09 21:38:46.644
c8153368-c59c-49ac-919b-fa372d6e3de9	afcdf53c-0d28-479b-8692-1db874838577	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-10 00:18:46.469
df92655e-fa4a-4d04-b2a5-ea7651b3c28d	afcdf53c-0d28-479b-8692-1db874838577	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-10 00:25:02.454
d558f565-05ee-43bb-8c43-398ac06657b3	4b52debf-3f19-4f2b-bf92-a24247dfa383	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Bryan Nylo"}	2026-04-10 00:25:02.456
8b4d2661-64d5-4a19-a511-0f645a7cc5eb	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Bryan Nylo"}	2026-04-10 00:25:02.456
8c4a1107-fe4c-4241-a018-dcd6361beadb	afcdf53c-0d28-479b-8692-1db874838577	\N	4.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-10 00:27:28.748
0e0f0b98-d7ea-4dd4-950b-75ce74427771	408a8064-9ec9-416b-85ef-5f3c13271918	\N	2.00	EARNING	{"service":"Mensaje recibido","clientName":"Bryan Nylo"}	2026-04-10 00:27:28.749
23638f8b-2962-4629-9b5a-24e0eea733e9	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión mensaje","clientName":"Bryan Nylo"}	2026-04-10 00:27:28.751
28ee8ee9-a95d-4b3a-8033-03d992cd55f5	395f8bc2-f2c5-4649-a454-28a4b678d7f2	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-10 03:05:16.87
ae9649dd-b3ee-4f92-a67d-bce65b67b4df	9432f502-88fe-4edb-b7ee-65d9d1a56dba	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-10 09:51:57.026
a838ebb0-24a9-4d74-8fbd-94a67c393229	19801a2a-f7b4-4cd8-a674-1adcbadc4308	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-10 14:43:57.578
daae6859-d0ef-4208-804e-cd351ec17c42	42e7cb3b-e651-403f-8625-8df09064cbaf	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-10 18:26:31.336
a9e14d0c-e860-44f9-b952-3a92e9399b66	25ae882f-cc22-4056-a3e9-c7314d1972a5	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-10 19:39:12.462
7c57e1dc-a385-4bdb-a6e5-e97303e3fb4d	25ae882f-cc22-4056-a3e9-c7314d1972a5	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-10 19:46:25.917
f978f7aa-4b8b-4a91-bc85-86d020a79f74	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Mari Goshi"}	2026-04-10 19:46:25.919
31fbad09-8fd2-4335-8bdb-3f71223a4e82	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Mari Goshi"}	2026-04-10 19:46:25.921
7856dc3e-c265-427f-8b97-8e87776fea6e	25ae882f-cc22-4056-a3e9-c7314d1972a5	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-10 19:47:43.518
faf36c4d-a029-4964-b35b-bbcafed8ab49	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Mari Goshi"}	2026-04-10 19:47:43.52
fb03e1a9-d532-42ae-b7e9-ba2e63058023	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Mari Goshi"}	2026-04-10 19:47:43.521
0099ab13-d46e-4326-9860-8966d78ddede	25ae882f-cc22-4056-a3e9-c7314d1972a5	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-10 19:49:33.757
d4a25a10-8e8f-40b8-86b8-94788b82dbd3	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Mari Goshi"}	2026-04-10 19:49:33.759
647708a7-480a-435a-be8d-0b8c0fcbd76b	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Mari Goshi"}	2026-04-10 19:49:33.76
1d17e639-3a4d-473d-9e35-ff9bba44aecd	25ae882f-cc22-4056-a3e9-c7314d1972a5	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-10 19:49:39.254
ef59ad8e-27eb-48dc-a3fb-e944193a432f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Mari Goshi"}	2026-04-10 19:49:39.255
8bb67542-aeb7-45fc-9b08-1dddbf48026d	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Mari Goshi"}	2026-04-10 19:49:39.256
b34968c8-28d0-48b9-815c-a30e7969d395	25ae882f-cc22-4056-a3e9-c7314d1972a5	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-10 19:50:43.997
c7cf20ba-d18c-4267-b95f-68ef3ed75b60	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Mari Goshi"}	2026-04-10 19:50:43.999
5bb4ff92-b740-4575-b8c8-86771f7f182d	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Mari Goshi"}	2026-04-10 19:50:44
00a21c54-7a0a-4b09-b3e5-4d7f356391ab	25ae882f-cc22-4056-a3e9-c7314d1972a5	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-10 19:50:49.743
ead89590-88b0-44ed-80ce-5b39382fb4e1	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Mari Goshi"}	2026-04-10 19:50:49.744
a72339b1-ffea-417b-9720-0badf908e5c6	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Mari Goshi"}	2026-04-10 19:50:49.744
5fb56bc4-f092-448c-9775-4d98665e73b6	25ae882f-cc22-4056-a3e9-c7314d1972a5	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-10 19:51:26.119
8124aab4-98b5-43f1-a99d-560790333c5b	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Mari Goshi"}	2026-04-10 19:51:26.123
ba9b8f3c-3012-4c9b-9591-b5e4a1c425f6	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Mari Goshi"}	2026-04-10 19:51:26.124
a6d80346-eefc-48e9-b426-f8b2c58be523	25ae882f-cc22-4056-a3e9-c7314d1972a5	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-10 19:51:49.416
7cdd43b7-56de-4dac-a80e-cd810d15510f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Mari Goshi"}	2026-04-10 19:51:49.417
36fd5230-a4df-47a6-a509-473c7b059212	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Mari Goshi"}	2026-04-10 19:51:49.418
f66b1bc5-558a-4eb0-ab3f-c9baa49a4053	f5fb1632-d665-4d19-9759-e792df1be642	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-10 19:59:00.786
e9f04b53-6703-4ccd-81df-39be38f98a78	25ae882f-cc22-4056-a3e9-c7314d1972a5	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-10 20:35:50.413
e7bb13d5-1ccb-41b4-aa4f-fd21e36b4ef3	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Mari Goshi"}	2026-04-10 20:35:50.414
c7467196-8d5a-4017-aba2-da5d7e205a62	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Mari Goshi"}	2026-04-10 20:35:50.415
e0c6bc4b-17f2-4d8e-98ce-f5ca8d0eb91b	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-10 22:50:20.134
d5f7b29d-b423-40b8-9f78-f58e18684f9a	44d0411e-7350-4122-a7cb-3262e14b2a26	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-04-10 22:50:20.135
d500842f-66ee-48b9-90fd-80dfe1d79e23	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Francisco"}	2026-04-10 22:50:20.136
328c2ce7-d771-4b2d-8164-241243fd254a	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-11 00:41:18.217
c0403c52-937d-4e4b-a152-4bf1b9814a7c	6b846412-dac0-4f2d-b760-bd82290d6420	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-04-11 00:41:18.218
03ffad89-bdab-49ba-9e4d-46f292224701	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Francisco"}	2026-04-11 00:41:18.22
58126f36-0820-4b47-92b0-06be4a59da05	2b2b78f6-7512-4550-bd64-967b27be6dfa	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 01:30:58.387
e6958ca8-4d07-4981-ad10-485d81b3471b	3ad9de31-376c-4d5c-bc90-7194de10ae85	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 02:27:51.689
8f6c629d-0597-4b8d-b514-3da020615b91	6f6ea973-a372-451a-a4bc-0da894e38878	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 03:03:26.289
6c4ff789-4057-4f46-9295-00376f4b1182	3aa72531-fa59-4f81-9154-ce637b34e0f0	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 03:17:54.098
6f0de5ae-2485-4925-aeff-63f9a9d34199	796df305-f00c-4451-bc59-3d0996cd861a	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 03:56:02.213
b97ead43-c644-42c7-b822-5047b24b82dc	1fb05900-f200-46e4-9947-69cac7fe2b47	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 04:00:22.944
63f4de3a-a8f6-4051-ba68-35d2d9e476f5	6b4cc5e7-c0cc-47c7-a2bc-32ec41e78299	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 04:27:08.932
6449ef1f-c663-48de-bb4d-0296361ebae0	5a6d7abe-1d44-4890-bf13-2d8aedfe07fa	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 05:29:22.26
7d24e5c9-1db4-4738-82af-5750e89ceef7	2f9d1318-190c-4524-8689-23c048e9db13	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 05:32:26.257
d4dcd41a-8f2f-42ac-9127-108f8e97767d	7335ba10-39fb-43d9-95dd-959b7b615afa	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 05:50:35.782
c2abb963-e138-4051-990a-34c664ddc947	4d865210-fc4d-4553-ba4e-1dc3df419b62	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 06:47:26.763
b933df7d-ccdc-4460-b0d7-cf5b71fb6bc8	3ed2f911-8d4c-4275-95d1-1e958f68efa7	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 11:28:07.409
82e43eff-fb12-4da8-8e78-172f4d5b1542	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-11 12:47:09.627
d97fa396-41eb-40a3-af70-7f151ca3209d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-11 12:47:09.628
73c216ef-4b64-4a44-a6b4-4b838c925b17	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-11 12:47:09.629
88217b1a-fac5-4629-bd02-f29b855ebed3	322f0c53-d630-4058-91a1-f2dc2e54fae0	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-11 16:59:10.66
2d1eb690-f224-474b-b9f4-6448503cc17c	7b5e7dc7-4b5c-4113-84bd-d27e29ede744	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-12 02:08:24.556
347660f7-acf3-4a9c-a2b0-dd92ebfeefca	30fff396-418d-4e9a-807d-586f9cc5be6b	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-12 02:28:44.71
230cb42f-0688-4725-aa5e-849a496c31e7	e3c1a016-cb88-473e-88f2-09e274fcd35a	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-12 02:43:14.779
ad20da80-fcec-4882-8005-a13fc314adcd	1b249206-d738-4a8b-a801-bd4aad067389	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-12 02:45:09.567
26299e75-cad0-48f8-97b0-b4e03a6c9ebb	452b9989-7986-4ca6-bbe2-2252a63f7f85	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-12 02:59:29.162
b5996ae2-71ae-42c8-be9e-1ff32902c2f5	2ee37c0d-682a-4b2a-b732-1adfeff32b57	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-12 03:13:17.739
649cf882-25d3-4da3-9ca7-13687edd28bb	8973792f-06d4-4002-b85a-3d362510d4d3	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-12 04:13:37.868
02cad153-ff64-424d-8c6d-5cae8751ef4b	c3fae8af-f487-4e8f-b33b-132258791a41	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-12 06:07:40.676
19e78df9-4fac-4f55-96af-8aa0cfba1364	785a7697-b20a-443b-a993-fcb7f7e49aa3	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-12 11:17:48.08
e9c3e994-cf91-4900-8e35-208d742ef1e8	c9a290c4-8ac3-4ea9-b854-339644b79e70	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-12 11:24:14.124
54657c8e-ac8a-4062-8367-7fa498f6df0b	559f5f41-4a9b-469d-b5f9-f3800eb3cef0	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-12 14:35:05.699
e145dfe7-4658-47ef-af25-f45592bcdd7e	22971249-5bfd-405a-9e1e-afbedcaea4a8	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-12 19:29:39.204
09eaa0b1-b135-41e8-bf26-e5c8dabc1e42	6056daf2-0299-4fa3-8836-20e302d15989	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-13 23:12:51.348
6ca2d9e5-ac0b-4aba-90da-be76b1cd411c	e8e058c8-fe97-43ab-995f-9d88f0e84ebb	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-15 02:25:28.647
fa9e9126-8c9b-4f75-ba4f-fdd813f3429e	cf77f061-082f-476b-bb9f-378454d6ffa1	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-15 09:20:26.716
3cb6878c-42d5-4d1e-a1fa-b6d83467dd29	fc85ea8a-ada9-469f-b394-0390403badee	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-15 23:47:09.449
e69b6629-79a7-4b96-933f-0d7b05446396	17b0bb98-f3ec-486a-83ce-0dccb66169ef	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-16 04:17:24.837
f397a9f8-50a5-4821-be04-d431b2742746	17b0bb98-f3ec-486a-83ce-0dccb66169ef	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-16 04:17:47.509
80bf9345-1509-49e6-9451-cb15014ed22e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Yammir"}	2026-04-16 04:17:47.514
eeb70f08-7cd8-41bc-aa8f-17a5b067d6d0	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Yammir"}	2026-04-16 04:17:47.516
b7bd1d1f-0990-42fe-95a8-2ae7efe7371d	c1cff427-557b-409a-9a14-dd9a359a601f	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-16 19:25:29.031
c36b4e11-75de-4636-9537-faefd4c16570	7d7c8757-da85-4356-ad9f-0a748eb57681	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-17 21:55:34.733
e81fc6c7-d7a5-4415-8dbc-3f0eed2e9d6d	f9b3937f-8f67-4ca8-a903-37d14eb0713f	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-18 00:45:12.736
092396c4-a371-4b12-963b-a06c3cc5d3ad	6422b606-aa59-443e-b674-b04c212f3856	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-18 07:14:26.961
bd17da25-fc3c-4a01-b0ca-5f39c77e7d2b	65154f0b-41a0-4dc4-999b-eba1bdaba0fd	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-18 20:23:40.086
a88eee0a-0075-4ad7-b0d0-a4f33b476f4f	905ca705-e1ee-448e-9387-788ce154fc04	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-20 09:42:30.731
d8bde9ea-b2e2-4513-a91a-1bf4b55737cc	32971f14-ac14-4663-8ab4-28f7a77cbd78	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-21 02:22:56.96
c7559663-8d90-4ee8-ab5a-9efcfaf121ca	76165246-7076-4944-84f1-339159a79df6	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-21 04:57:19.457
70b680c9-7c03-4af0-a8db-8e80122bf932	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	6.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-22 03:41:11.415
a9fc87a1-f607-42c0-828d-d7cc35091c25	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-22 03:41:11.866
e621eec4-134f-4c6f-a908-bec28df3e416	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-22 03:41:12.315
b582052d-931c-43b9-894e-54fe03488ebe	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	7.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-22 03:43:17.684
7fb6a8ee-5be6-4f3f-a3f2-637a574bd495	36a1e380-00d2-4bd7-821b-95823c86efef	\N	3.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-22 03:43:18.142
2cf78c76-19ef-46c9-b36f-110f4115ca82	925dc47b-91c6-4a44-9233-de139f77a62d	\N	3.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-22 03:43:18.601
d05b0ba1-6f30-4ce6-9f3c-9b41db5f8ae5	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-22 04:06:49.708
a817ccb3-2dcc-4b6a-99e6-03847aeb6240	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-22 04:06:50.164
ba21ce98-142f-4265-8eeb-52507d93ebc5	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-22 04:06:50.62
fc574f44-7d13-430f-9bce-277b55a835c6	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	4.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 04:07:06.363
28cba06c-8615-4793-b1ba-b58c326504f7	36a1e380-00d2-4bd7-821b-95823c86efef	\N	4.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 04:07:06.814
da59a7e6-5809-43f1-947a-fcc0b5638be8	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	11.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 04:13:28.024
0cc21797-2273-4db0-9b5f-ea302bb7ae95	36a1e380-00d2-4bd7-821b-95823c86efef	\N	11.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 04:13:28.492
5806dee9-8157-4fc9-9dd4-37a4081f46e4	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	13.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 04:21:40.364
9c068e25-a837-4290-86dc-71bb12e76e22	36a1e380-00d2-4bd7-821b-95823c86efef	\N	13.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 04:21:40.841
67e7639c-36f7-4f9d-8b7d-785848338907	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	13.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 04:30:42.619
c0c73248-174f-494c-9129-5941bba67a21	36a1e380-00d2-4bd7-821b-95823c86efef	\N	13.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 04:30:43.075
c2176af2-ec0c-4bdb-a189-3c3b723daef1	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	10.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 04:34:05.987
e52e4a7e-7d6b-4398-9eed-9f801f7fd3de	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 04:34:06.445
8f9c098b-0093-4b50-a4a9-dd5bbaf47f46	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	12.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 04:35:40.246
f5d14ed1-9d8f-4908-96ed-685a7946e993	36a1e380-00d2-4bd7-821b-95823c86efef	\N	12.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 04:35:40.706
3a25b633-c100-4997-85aa-74340e6cfe2c	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-22 04:36:29.6
b7983ec4-0300-4203-b268-92fd7636176b	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-22 04:36:30.056
2c8eb430-3cbb-487c-9b3d-863f7c4db7a6	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-22 04:36:30.514
b811b0bc-71d5-4bfd-904f-3c15bc6e3087	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	10.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 04:37:55.763
234fc247-3f24-4e41-b073-3489180d2e01	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 04:37:56.224
14ab1d9c-e722-47fd-a17a-0eceadd9659f	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	12.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 04:41:39.129
af20d08f-babb-4a57-9fc9-8c565d9479c5	36a1e380-00d2-4bd7-821b-95823c86efef	\N	12.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 04:41:39.581
4c2f9e37-df3f-4fbf-a8ba-9e8f13555217	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	1.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 04:43:28.549
5c54bf85-de1f-4bc7-820e-0b31fd44924d	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 04:43:29.021
46a4916a-7b5b-4769-b267-72f3768fc581	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	1.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 04:51:27.546
78759b6e-c419-4ca3-b65b-0e78dadd2f51	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 04:51:28
aab678cd-aa5e-44b8-b9bd-ebe65454383a	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	1.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 04:57:02.494
b8e5d4fd-449c-49df-942d-59dd8c8fc441	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 04:57:02.957
9a625a99-257d-49b0-8b7a-12ffa2e07771	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	1.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 05:06:09.06
463e772a-29ad-4d38-8e9c-9beca68a59ca	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 05:06:09.518
4b509d37-c54c-4d8d-b61a-ceeac17644fe	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	1.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 05:11:36.269
589beefe-b85c-456e-a872-626675a67989	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 05:11:36.723
9b1315bd-3ebd-40b1-a4fb-2da509dc4029	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-22 05:13:42.09
00de5c75-c6ae-4fa7-819a-c676e31916ea	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-22 05:13:42.545
b0b8500e-89be-494b-8c9a-2e4e204c67f9	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-22 05:13:42.997
19b0269b-7400-46ed-921b-ad01bcd79b95	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	5.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 05:17:18.778
d08dece4-c531-4604-9590-01f6ffd1cfd0	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 05:17:19.236
fc5f7265-f761-403f-b135-afca7c3e9df7	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	1.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 05:19:45.038
e3ca03b2-d8ee-4ef1-bfc5-97fc1bdef15d	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 05:19:45.498
cc294f7a-5efb-4363-92b4-1b7c0ef70209	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	5.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 05:21:25.551
65f9b0c0-73fa-4b10-9c9b-fcd2fcf1af34	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 05:21:26.005
5c93145b-83a0-461f-8a98-45a241be3253	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	2.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 05:28:48.976
0bb3ec96-ddf5-42b3-9f4b-885335901859	36a1e380-00d2-4bd7-821b-95823c86efef	\N	2.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 05:28:49.436
4bd897f8-ccd7-477f-a739-d7c3a5838cfc	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-22 05:38:27.607
fab91ce4-553e-446f-bacf-a43845acb373	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-22 05:38:28.06
5b6273ea-c1d3-4f8b-9b0d-b61afc39eefc	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-22 05:38:28.515
00dfe720-a6a0-4e6a-9eb2-f5490ba906ef	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	5.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 05:39:51.603
24f407cd-6187-48c4-9f98-af3609a30da6	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 05:39:52.058
6a04e277-40f1-4a3b-8277-9b43127cf9ff	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	6.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 05:42:04.037
6bacbdc6-76e7-4908-a7dc-7e126f36f3e0	36a1e380-00d2-4bd7-821b-95823c86efef	\N	6.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 05:42:04.487
880cee56-f6be-495d-ae37-6e8d6e463b83	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	5.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 05:55:49.86
07bfd757-fd4b-478d-be4d-0ec3e1cb04a4	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 05:55:50.345
80a7c23e-0325-4244-a40d-8f7a8095b1d1	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	10.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-22 06:00:49.887
b9b516bf-616f-4329-a032-e84ded183a19	36a1e380-00d2-4bd7-821b-95823c86efef	\N	10.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-22 06:00:50.34
8b7523f6-f835-4ce4-a86f-7cad740799a8	fc71e9fc-4e90-4e8d-a4a2-8ebc1b817971	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-22 15:47:36.712
0cc26ce3-4244-4b96-93e1-9a0d1bfa22ec	9343ec66-a1eb-4917-a3f7-8e40fe1700db	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-22 20:35:31.49
7509e053-3144-458e-a554-2653fcb4d213	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-23 20:43:34.843
f4414b30-1ded-4583-8e85-44cf32f715dd	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-23 20:43:35.294
64c8abff-a0ee-481e-9d08-4568fe36b8d2	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-23 20:43:35.758
cd6da20e-fd2e-4b95-844d-50b9a1e22221	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-23 20:44:27.553
5e007d05-f041-4c29-8870-39821a80d8c7	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-23 20:44:27.997
23ad0d64-92f9-40f6-b2a0-f03ce0b04052	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-23 20:44:28.443
725f8dce-a162-44ba-9353-5469c3f4390f	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	12.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-24 01:42:58.06
943d24b8-9ebb-4263-aa84-a3a29a468ae2	36a1e380-00d2-4bd7-821b-95823c86efef	\N	12.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-24 01:42:58.52
bb30c995-ddbf-4d7e-9d77-0ce14b18c479	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	10.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-24 03:30:30.983
4a37f312-d1d4-41c0-90be-ee710960eb3f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	5.00	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-24 03:30:31.446
6f76eddd-81f9-49e3-93f1-0f1ac55ed2a9	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-24 03:30:31.907
af13593a-7286-484e-8887-5318778003e8	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	12.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-24 03:47:21.03
806db510-71b7-41cc-bcab-36706d9099aa	36a1e380-00d2-4bd7-821b-95823c86efef	\N	6.00	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-24 03:47:21.495
4dff6e91-0902-4f6b-a7ed-1f3c5e84ba71	925dc47b-91c6-4a44-9233-de139f77a62d	\N	6.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-24 03:47:21.957
0e33d449-2819-449b-8995-e599543d6ae9	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	10.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-24 04:00:47.688
db0f1197-a49f-4176-a3ae-31deb1ba4884	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-24 04:00:48.16
dfc35282-6352-4b7f-82e1-a26916bf03d9	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-24 04:00:48.633
b6e35abc-15a4-4caf-a8ef-152fbe767609	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	12.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-24 04:01:28.146
718f4a0b-8870-4277-8230-24480fc81a89	36a1e380-00d2-4bd7-821b-95823c86efef	\N	6.00	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-24 04:01:28.606
55e2d307-0f97-49ce-9fd5-eecf6e53fc7c	925dc47b-91c6-4a44-9233-de139f77a62d	\N	6.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-24 04:01:29.067
c6cda0e6-63f0-4a01-ad18-8f6c2e522613	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	10.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-24 04:03:12.56
0ba1afd0-b46d-4d15-bd9f-97692570efcc	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-24 04:03:13.024
fa8d48d4-5acc-4df5-b8b6-8b37479bc332	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-24 04:03:13.483
62a8ca2c-bbfa-4e1e-8549-1cc1f64893b8	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-24 14:10:08.434
a7a4338c-b678-41cc-b6a5-1e7caf4aa6ff	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-24 14:10:08.897
0c90c372-ff00-4285-bc85-6255aafdfdd5	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-24 14:10:09.447
6141c049-c1b4-4d82-b290-121f0f4cf661	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-24 15:16:32.321
09fa6f0f-57ee-40d3-8ec6-a1963f68d574	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-24 15:16:32.853
5d5b5010-eab9-4b4a-a0dc-f16f70fab903	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-24 15:16:33.447
57809116-a99f-40a9-b122-fd9943d1a637	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-24 15:16:41.127
f72298c1-31a7-4f78-90f5-e5f8ef7149f8	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-24 15:16:41.743
3631300a-1eb7-4d10-9b2c-bb6140687616	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-24 15:16:42.254
bce9917b-eaa1-478b-8c06-8a7f625c5067	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-24 15:16:48.501
0be1264e-3f91-4450-87e5-3265bc77eed3	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-24 15:16:48.955
64bd2da6-f35d-4409-b4a0-1ad82ff7fe24	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-24 15:16:49.525
6091c8fd-d973-44c4-bc11-0173125cd062	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	0.10	MESSAGE_SEND	Costo por enviar mensaje	2026-04-24 15:19:21.079
574cddd4-d327-48c2-a3f8-6c5a480dcfd9	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.05	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-04-24 15:19:21.59
fa9dfcc7-841e-4fb5-9765-93f993477b65	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.05	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-04-24 15:19:22.116
cda3bb08-b824-4a72-b63b-52784f1320a1	fa39581d-8edf-471f-8eab-5b13ff902474	\N	1.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-25 01:21:51.803
262ac428-f3e9-4f51-b17c-78f6cf4b8d52	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jaime"}	2026-04-25 01:21:51.805
2107f1a2-c980-45ea-a315-6f93ae7a104c	3f1f2ece-b8e2-40fd-a084-a93649602e22	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-25 17:34:52.408
e2b9f0b4-d7af-4e64-a136-f2e4849d0d55	9595ad2a-6303-4b1e-a40e-f7f5311096c4	f35eb513-c110-493c-9cb2-ee26abb997d8	10.00	DEPOSIT	Recarga PayPal: 10 créditos - Paquete inicial 	2026-04-26 00:33:10.409
f8389ecb-edeb-41dc-a29c-6115df86f691	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	12.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-26 00:51:37.412
d986509a-55fe-4d20-8e35-f692e5a88a82	36a1e380-00d2-4bd7-821b-95823c86efef	\N	6.00	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-26 00:51:37.414
cf1b0b70-1b73-4ef4-8199-5946584eeeab	925dc47b-91c6-4a44-9233-de139f77a62d	\N	6.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-26 00:51:37.416
4aa48048-9a70-4c42-8546-5a4aab62aff5	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	2.30	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-26 03:27:05.951
cfafbdb7-0b95-4204-a8bf-59f72e0bc131	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.15	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhoel"}	2026-04-26 03:27:06.374
0bd2aebf-4702-47d4-b5d5-dbd28f76f5b5	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.15	EARNING	{"service":"Comisión Imagen de chat","clientName":"Jhoel"}	2026-04-26 03:27:06.793
1706dab2-78df-4bc3-824f-abe95a433572	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-26 03:28:11.452
0876d5d2-6191-443e-974b-8dbf5db884be	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-26 03:28:11.901
c3c7dc2a-863a-44d5-8bf5-12759a2b9899	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-26 03:28:12.352
b09df131-adf9-4b70-aec5-c8e895277154	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-26 03:28:31.688
a29c9912-3d6e-44e3-9869-e52547a819a5	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-26 03:28:32.11
d25bcff0-f292-48f1-83a8-27e3eb274354	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhoel"}	2026-04-26 03:28:32.533
8903cdac-54db-4b8e-9402-1816db4661d4	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	12.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-26 03:29:22.221
d8c87d4a-6cc1-4b6b-ba4b-1f4e7f104852	36a1e380-00d2-4bd7-821b-95823c86efef	\N	6.00	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-26 03:29:22.655
0ba2b838-7fbf-4bf6-a8df-1b0c6323aba5	925dc47b-91c6-4a44-9233-de139f77a62d	\N	6.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-26 03:29:23.088
69c586ff-05a8-45e0-b230-66fbb120bbf1	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	3.40	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-26 03:29:32.453
dd6f5f0c-9f92-4299-943a-e560131997e8	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.70	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-26 03:29:32.895
419e27af-bf53-478f-a47d-b0c347b20541	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.70	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-26 03:29:33.335
1b282b6c-1334-421c-a1bf-fa3449d9fa08	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	2.60	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-26 03:30:31.838
a5fb7009-d775-4117-a012-a8c114004df5	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.30	EARNING	{"service":"Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-26 03:30:32.276
539f97be-92d9-468e-b771-896145224c09	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.30	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-26 03:30:32.713
19354fde-8b62-417a-9533-ca82490c0da2	0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	\N	60.60	SUBSCRIPTION	Suscripción mensual a anfitriona	2026-04-26 03:48:23.071
3b5bc6aa-9026-4816-9d3b-c66684992e65	36a1e380-00d2-4bd7-821b-95823c86efef	\N	30.30	EARNING	{"service":"Suscripción","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-26 03:48:23.509
615cf540-4634-4e5b-a446-5599b3b034e5	925dc47b-91c6-4a44-9233-de139f77a62d	\N	30.30	EARNING	{"service":"Comisión Suscripción","clientUserId":"9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316"}	2026-04-26 03:48:23.945
0ac231a4-b0d9-4f58-8487-aa90a427d976	9d69ecb9-2e65-4fa0-9cbe-12ad7a322269	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-26 23:11:37.789
fec640bd-7b3c-4fe1-b48e-1263bdb43203	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	5.00	DEPOSIT	Recarga Binance: 5 créditos - test	2026-04-27 01:09:15.241
9acb41ed-0804-4298-8531-8c4b23c169b5	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	5.00	DEPOSIT	Recarga Binance: 5 créditos - test	2026-04-27 02:01:22.637
58e4f4b3-91e8-49b2-9e9b-50d8a46eab6e	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	2.50	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-04-27 02:55:45.391
1dd78ff8-89ce-41e3-b59e-a2e8ada79639	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.25	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhaseft"}	2026-04-27 02:55:45.859
0af81cbd-0aec-4aef-a341-5b192b419048	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.25	EARNING	{"service":"Comisión Imagen de chat","clientName":"Jhaseft"}	2026-04-27 02:55:46.307
381791ed-2ce2-42f4-b1de-b531772ec297	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	3.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-04-27 02:57:32.623
55d478e0-d5f5-4854-8144-2d597da4b97b	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-27 02:57:33.057
4ee241db-4f0c-47ed-b17e-86cba6fbc0f3	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-04-27 02:57:33.488
c8c7515b-d2e0-40ef-aee0-646b3cc60bc1	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	3.40	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-04-27 02:58:46.604
01ff5079-ad4b-4a2b-b187-6ad6401d0d2d	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.70	EARNING	{"service":"Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-04-27 02:58:47.043
c4337c60-890c-49a7-a89a-dfb5e37561af	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.70	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-04-27 02:58:47.482
c1fcff37-6b90-4deb-ac9d-0243d9ec6493	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	60.60	SUBSCRIPTION	Suscripción mensual a anfitriona	2026-04-27 02:59:44.564
f0d4cd6e-c5c9-4717-a97a-e94a6834d095	36a1e380-00d2-4bd7-821b-95823c86efef	\N	30.30	EARNING	{"service":"Suscripción","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-04-27 02:59:44.993
eb13557a-3a90-4647-abe3-059f67bc2752	925dc47b-91c6-4a44-9233-de139f77a62d	\N	30.30	EARNING	{"service":"Comisión Suscripción","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-04-27 02:59:45.421
607a6fe6-0739-4193-95db-8517045939a0	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	4.00	DEPOSIT	Recarga Binance: 4 créditos - test	2026-04-27 04:04:40.583
a3df9a48-7cfb-4795-a23b-ba9164611d26	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	4.00	DEPOSIT	Recarga Binance: 4 créditos - test	2026-04-27 04:14:02.597
ef6a804e-a09a-4a08-80f1-897908b143c9	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	4.00	DEPOSIT	Recarga Binance: 4 créditos - test	2026-04-27 12:59:55.787
97cf4e04-d830-42a4-8f48-225e97ae74b3	85cdede2-1628-413f-aabe-bfb541512a62	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-28 21:04:58.509
4e3ccafc-eb2e-4493-9d33-f4a73289dd02	93905e6b-6f55-4b97-8028-21c01a2ab250	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-29 00:53:00.68
8fd03a0f-11c6-4c86-9785-21571142fd55	cef12e4f-4618-426a-9101-1dae63e5a042	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-04-30 00:03:56.234
f8dff204-cb74-4b98-a1d0-3b348cb4489a	afcdf53c-0d28-479b-8692-1db874838577	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-30 05:31:01.748
fbb0d774-a5b3-40c1-8ab1-6c11eb6e2319	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Bryan Nylo"}	2026-04-30 05:31:01.751
a3bc1a34-ae8a-4b6d-88c5-b8be8d30ce09	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Bryan Nylo"}	2026-04-30 05:31:01.753
20efcf0b-5047-4e47-aa05-3441ce29bdfe	afcdf53c-0d28-479b-8692-1db874838577	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-30 05:31:19.852
bb42394d-b8eb-4485-894a-8508bc94f5a4	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Bryan Nylo"}	2026-04-30 05:31:19.854
d304bcf2-8106-41ca-b1ce-d258b2eb0e41	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Bryan Nylo"}	2026-04-30 05:31:19.855
e83f4f71-d43a-4e09-ad1a-b0ef92f891e4	afcdf53c-0d28-479b-8692-1db874838577	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-30 05:31:25.219
ab365fc5-ebbb-4212-ad1b-ac96942f6b9c	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Bryan Nylo"}	2026-04-30 05:31:25.221
72f8bcbf-4e95-47d2-8414-a0837c4c4c2e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Bryan Nylo"}	2026-04-30 05:31:25.221
0c80e421-ed58-4d4d-80ec-f2af15a2881b	afcdf53c-0d28-479b-8692-1db874838577	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-30 05:31:59.155
061e6589-019f-4a97-b51c-623b52235f0a	78c1e70c-69c7-4888-825b-4a2283697e00	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Bryan Nylo"}	2026-04-30 05:31:59.157
050dbe8f-253d-4e93-aa6a-01c3e04bca00	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Bryan Nylo"}	2026-04-30 05:31:59.158
a188b41d-1981-4396-815f-f9e4f6c0aa4e	afcdf53c-0d28-479b-8692-1db874838577	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-30 05:32:25.578
e651b698-ebd1-4ea7-a945-107b1fcba2a9	4b52debf-3f19-4f2b-bf92-a24247dfa383	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Bryan Nylo"}	2026-04-30 05:32:25.58
bf35ecd8-8360-4ba3-864c-159cade39157	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Bryan Nylo"}	2026-04-30 05:32:25.581
e631926d-9ac6-4606-a6d8-f838ea6eabbf	afcdf53c-0d28-479b-8692-1db874838577	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-04-30 05:35:34.889
fa6bb1fd-d3e9-4ced-8a8d-75d124200ab3	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Bryan Nylo"}	2026-04-30 05:35:34.891
b9bedb62-9463-4d01-b1e9-832968f675c5	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Bryan Nylo"}	2026-04-30 05:35:34.892
a5e08996-667e-4447-8698-52b40bdb9135	afcdf53c-0d28-479b-8692-1db874838577	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-04-30 05:36:29.589
11fa8243-2544-44c0-864d-5ea6de5536c8	0f662fd9-a2c3-4b35-9059-426730ed8778	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Bryan Nylo"}	2026-04-30 05:36:29.591
c32c2c36-b4ad-49c0-afcd-95a8fcf33221	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Bryan Nylo"}	2026-04-30 05:36:29.592
9dfe1e75-844c-476c-ad45-3a42a620068c	9eb2f922-eabe-4c87-8cfc-c6f9b754e896	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-02 01:31:19.681
49deed87-b17e-4757-9797-5ab5385272b6	4982df1d-ea7b-45aa-957a-7ea77a84c055	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-03 01:38:04.917
ae1da138-7731-4d17-8331-b20f929e84e4	b1636ac2-8d45-4595-880c-9cd14d8cf18d	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-03 10:39:11.912
3bf0031e-6ba1-4d3c-b82f-e3b3b7b0da9f	44849973-050e-45a2-b418-01afaf92d5a0	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-03 17:22:26.727
4cf8f56d-86b2-44b2-b3f7-57360dcf3b04	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 04:34:24.703
c1f3e7ac-c503-436b-a08b-6013013baa6b	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 04:35:36.332
8438c007-3c28-4483-9c55-b612a3a87d71	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Claudio Ignacio"}	2026-05-04 04:35:36.334
ef92888a-5500-43d4-895a-bad44ca5caae	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Claudio Ignacio"}	2026-05-04 04:35:36.335
053329f3-4242-4c0e-a6eb-ef3d70afbc84	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 04:36:18.968
45e3ff03-e739-4544-8053-12c64a05f1f8	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Claudio Ignacio"}	2026-05-04 04:36:18.97
2a9c446a-bbc3-4829-b03d-db8c7eecab62	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Claudio Ignacio"}	2026-05-04 04:36:18.971
32e745a3-5c4a-40ae-ac4d-3bd42c145281	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 04:37:32.049
d298cb06-23a5-4aba-bca6-c5fb4277e379	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Claudio Ignacio"}	2026-05-04 04:37:32.05
0b5190ee-5a3f-4d4d-8a67-24895804d5b5	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Claudio Ignacio"}	2026-05-04 04:37:32.052
7ea24c9e-9064-4e8d-85f2-81600d40e4fc	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 04:38:01.956
ed34fc7e-ca63-4878-b79e-478477e91270	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Claudio Ignacio"}	2026-05-04 04:38:01.957
4a67b630-6a0a-4072-86bf-0856ea38ab46	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Claudio Ignacio"}	2026-05-04 04:38:01.958
ecdad2b6-1261-49e3-8adf-1a1de8876d9b	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 04:47:29.084
ec33250f-af51-41df-8ba8-2f5c8384d85f	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Claudio Ignacio"}	2026-05-04 04:47:29.085
fe6e50cb-781d-419a-9457-6fe90201573c	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Claudio Ignacio"}	2026-05-04 04:47:29.086
0c75f518-de30-4927-aeb8-40c6ab10b42c	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 04:47:37.721
2ffde6ac-d85b-4068-96c9-fd8b052bdfa6	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Claudio Ignacio"}	2026-05-04 04:47:37.722
77142597-c7b5-48d1-ab0e-3355ef16a022	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Claudio Ignacio"}	2026-05-04 04:47:37.723
e2fc1486-bbf1-458c-ac02-ae4ffb0b3a4e	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 04:47:43.786
a5e5906c-7d25-41b7-ba39-9ef47342ae62	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Claudio Ignacio"}	2026-05-04 04:47:43.787
84b2aad0-83f3-4f3a-89a4-a43a683a4edd	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Claudio Ignacio"}	2026-05-04 04:47:43.787
bbf82836-2394-43d1-beba-b27e15c217ad	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 04:48:31.397
5bcdefc7-df0d-47c1-9251-aa0297903895	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Claudio Ignacio"}	2026-05-04 04:48:31.399
fa395569-9fff-4473-bd85-78947bd1a3aa	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Claudio Ignacio"}	2026-05-04 04:48:31.402
a7e3dcfd-6458-4cc0-8d83-2813cb40c0df	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 04:49:08.051
8dd4f1fd-b402-42de-b976-df20260b3925	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Claudio Ignacio"}	2026-05-04 04:49:08.053
82e68177-7b26-45e1-852a-f5855be32cae	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Claudio Ignacio"}	2026-05-04 04:49:08.054
276c7c0c-1e33-476f-9deb-3452d3d47e56	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 04:49:12.721
25bc8411-f8be-4379-ace3-f940b96f4c13	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Claudio Ignacio"}	2026-05-04 04:49:12.722
90b68719-02da-496b-94c9-6c58870f1490	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Claudio Ignacio"}	2026-05-04 04:49:12.723
31e0801e-7714-4b09-9543-29a6320a0999	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 04:54:58.373
557a6a1a-5be7-4c19-9e87-a8c28eecebbd	d6fc81a9-9805-483b-b305-f7e7c7ac613a	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Claudio Ignacio"}	2026-05-04 04:54:58.375
dbe6a251-0d2b-41fb-a741-4e0803fdfe50	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Claudio Ignacio"}	2026-05-04 04:54:58.376
8eeb6994-cf78-422d-810f-7c2b7e05f584	f2232ad0-5aef-4ad8-9350-c1c2fe9feade	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 04:55:36.248
dc16b3c6-c5f9-48bd-a4a5-e79f4a076609	4b52debf-3f19-4f2b-bf92-a24247dfa383	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Claudio Ignacio"}	2026-05-04 04:55:36.25
82cb9e58-cbc2-40aa-ac98-0a91168ba249	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Claudio Ignacio"}	2026-05-04 04:55:36.251
739f57ae-40f9-4054-b9fa-20080da204d7	2a7f047f-2fe4-413d-b9d7-8ad2af7b4a23	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 09:18:00.273
f21aa591-e763-40de-8ecd-0630964f8489	2d3be2bc-79b9-40c0-bd15-098b5b858452	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 09:23:22.553
3029c495-2069-466d-992e-d3783719ccec	cab1a5bd-ecbd-404b-9047-c9c88bf0ce06	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 10:22:08.889
ccac5c24-15f6-41eb-9590-261bebb2919e	350fb062-7ac0-4b90-9314-eb46acb8230b	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 10:23:03.039
b6e42b42-5381-43a7-9461-0f5e0fa8265f	02e98952-4dbd-4f44-a970-34470e78d7a2	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 10:33:57.071
c05034d7-5d95-4879-b42a-59dd4b4c855c	27b448d2-f4ab-4cd8-b4bd-570c66de2407	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 11:22:27.071
48d3bd4d-a9aa-4840-b12f-e4853d983d0d	73728b85-71cc-4181-8da9-87e4ed8100c2	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 12:27:20.916
5f8906c0-29c5-4bf5-bccb-a95e7c0a0754	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-04 12:29:26.365
e44c5ee8-5250-4486-9ab2-774462625dae	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-04 12:29:26.368
d33d405a-bd0b-4129-9e7f-33375a753e65	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Francisco"}	2026-05-04 12:29:26.369
84d15933-41cf-4276-90f7-df2c2fae1cd8	0625411e-3dd7-4a5b-94f9-9d308c6cd183	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 12:40:10.934
4f4ef8f1-0314-4f49-ab38-869c0a094c48	f0dbcbc2-bb40-41f2-affe-a45a7653ee16	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 12:55:59.886
eb95a335-7cb7-4088-8a97-8bdc87278c89	5e60c948-4504-45ba-aff4-e277d7ece479	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 14:21:27.808
c5b45dc1-def7-4d4c-8101-6c22c3b7ab5f	fe8437b7-fa63-48ef-9937-ff59806a26aa	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 14:40:50.069
fa25c161-083d-43aa-977c-eac9a183423e	72e11a49-52f2-47c8-8b81-0b9e81aaab91	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 15:27:42.513
14dff6f8-7375-495b-83a3-a812d6b02810	3b7630c2-1b3c-463d-911e-b93793fecb29	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 17:11:49.269
67e6acb2-8a13-41c0-8552-da65cae06488	38f4d3d0-8d69-4837-89ba-f4681c2d81a4	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 17:41:24.121
698d7a7e-2afc-489a-aa29-59adeb3d7464	4d3b20bb-76fa-4678-9cc4-78d7f339445d	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 17:44:33.78
cfca3092-0179-4b79-bd3d-18bebf0e5f2e	22a5f861-7f80-4829-872b-cbc608353a8f	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 17:52:05.134
1b2ae8da-5591-4a06-bc17-1ed6495c13be	5317b5b5-f2f2-447b-9447-32203b5df347	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 19:41:38.038
aa0f5005-ad4e-41d4-b95e-41a0f08401bb	b97654f8-9829-4a98-a715-5b43d528501e	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 20:02:38.73
5ab12520-e104-4034-9594-da497fb3e97b	51273683-6f72-4375-88cd-34b981cff3b0	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-04 20:17:01.776
b6f2a2a1-1f7a-4533-8446-a43a92accb42	f809df63-275b-4f69-8853-027f51570348	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-06 04:35:42.342
b59bc3e5-b351-41d3-b978-5d0f5a298e0c	f809df63-275b-4f69-8853-027f51570348	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-06 04:39:05.323
5edf50dd-f362-4003-b2a2-679934abe218	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:39:05.324
f4a036d0-3a37-4ff7-a84b-b1dbc168b893	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:39:05.326
aa7740f0-4e1f-4ccc-a261-82fc0d1dd4b5	f809df63-275b-4f69-8853-027f51570348	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-06 04:47:22.325
e6d93611-d586-411a-8d9f-6bfa522dc368	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:47:22.327
616dabbc-e88b-44ab-b12b-439447d52581	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:47:22.328
61a71af2-31d8-49fc-a1c3-1e7f70dd1f32	f809df63-275b-4f69-8853-027f51570348	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-06 04:47:49.141
1a8f21ca-d8bb-48e8-b69e-7a42eb561e22	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:47:49.143
32fd5f9d-06e9-4a1f-b92a-27568ff8384f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:47:49.144
26ac4b5c-9ec0-4d08-ad3d-c65f9a421ad9	f809df63-275b-4f69-8853-027f51570348	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-06 04:48:20.984
091d9c8a-e2ee-44c9-8386-286b95cbc558	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:48:20.985
d47c69d8-7961-4d09-8860-b7513e79256f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:48:20.985
7513a49c-56d4-4e86-9d98-9c1184d8d95c	f809df63-275b-4f69-8853-027f51570348	\N	4.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-05-06 04:48:53.339
3ff76bce-e29f-4e7a-ac69-bf362ab06c66	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	2.00	EARNING	{"service":"Mensaje Bloqueado","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:48:53.341
e7f64669-42ec-4175-842f-6b2812864d8f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:48:53.342
59d8d33e-33bf-4441-bc33-8d464d9a9da3	f809df63-275b-4f69-8853-027f51570348	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-06 04:49:17.737
c35b58c0-d4c6-4165-b0e9-a8170c7916df	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:49:17.738
9bfd0935-7048-4337-848f-69d6ba8338b8	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:49:17.739
6b3747a1-d2b8-46d1-99d1-4811aa5368bb	f809df63-275b-4f69-8853-027f51570348	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-06 04:50:02.326
73c284f5-590c-407d-b89a-dd5eb9851847	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:50:02.327
cf4fb2b3-5335-40ae-a3ae-ac5975fc9abe	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:50:02.328
a79a29a1-bae8-4e8f-bee6-1c95c075c574	f809df63-275b-4f69-8853-027f51570348	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-06 04:50:34.129
e53714ea-2379-4e36-9d50-aa07f76b640c	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:50:34.13
8098049e-9f1c-4e29-be85-cf70240c8aa1	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:50:34.131
7ee05d75-d8b9-4343-89c0-ddb7a9ae4a29	f809df63-275b-4f69-8853-027f51570348	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-06 04:53:38.311
b46cb615-3e94-45a7-929a-7906bfb923d8	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:53:38.313
3fe477d1-7aea-41af-b122-a207ac16253c	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:53:38.314
87e28ef1-3739-4db1-8a63-fb5485ea3962	f809df63-275b-4f69-8853-027f51570348	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-06 04:53:44.65
708db219-1541-4ad4-8767-641bcbb02f66	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:53:44.652
041519a9-2f62-405b-9b77-9e3a861a70e6	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:53:44.652
86975016-5c65-49e3-93a8-8af6d2980921	f809df63-275b-4f69-8853-027f51570348	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-06 04:53:53.51
32c484a7-ff56-4f83-8a24-10f0eafd5e2e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:53:53.511
5e511f8d-962e-4b40-848c-a50e5004045b	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:53:53.511
4e589b37-849c-4c26-a92d-fa2183e959e7	f809df63-275b-4f69-8853-027f51570348	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-06 04:54:19.18
03f3b945-1266-4cde-ba67-8d5283f4a328	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:54:19.181
8eb8efa9-0132-489c-9f90-e6c61a077033	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:54:19.182
57235486-9919-42ef-ab46-7adb86f23e1e	f809df63-275b-4f69-8853-027f51570348	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-06 04:54:35.139
8fa104e3-f351-4d9c-8fa4-b17f4ae49ad5	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:54:35.139
5c3a8788-8286-4759-88b6-83336f340b0f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Stiven  Castillo huayamí "}	2026-05-06 04:54:35.14
7f05f0e5-663b-417b-85c3-69e1bc38704f	d537345a-587d-4205-be89-78e2ff36f818	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-07 01:03:01.194
390c5a65-444f-4147-abff-0fa3c1f765cc	b10f243a-49ac-4eeb-b7fa-bbc90c8472e1	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-07 12:25:48.938
5f23d955-01e6-40ad-83a5-de8dc421eaab	b10f243a-49ac-4eeb-b7fa-bbc90c8472e1	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-07 12:26:39.946
d48a6008-af70-4db1-91d2-060fc2d3a4ee	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Pedro"}	2026-05-07 12:26:39.949
e02e9ffd-6a51-46a5-905d-0eb94e3083a2	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Pedro"}	2026-05-07 12:26:39.952
348aff5c-ca19-4f46-b621-127e36c8af00	95e03774-4c9a-4672-a0f7-cac1b7ca99c2	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 07:06:52.713
94c15791-6d37-4050-b43b-44ef6976c058	47f686d0-0a5b-46c7-9233-d8b8d7c893b2	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 09:50:04.05
4e7b66bc-f06e-43cb-9b9c-afbe190ac228	c3bde088-c244-45fe-a6c9-56720a26f698	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 10:13:52.36
f9cff316-327a-45f8-a1dc-8edb797f8e2a	d8eefdfe-1492-4694-91e4-b8d06a3b7681	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 10:16:08.409
e5b33ae4-2d4f-4fae-9862-55fd2e1a7514	2675fcdd-1a43-45e1-ae71-931bff04b532	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 10:25:53.196
2563617a-2a01-4876-bf07-ef5178191f0e	989a3745-c34d-41b2-94b0-68bd8ac641d8	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 11:28:39.196
3674887f-5e2e-4955-b2bf-6f47d1afeaa1	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-08 11:38:11.707
10dbdf1c-d915-426d-80fa-59293e3955df	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-08 11:38:11.709
b6c68fb1-99f8-48f1-b29e-cd9b2ddd6307	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Francisco"}	2026-05-08 11:38:11.71
6937d5fb-9fab-42e8-9322-0c053b383197	b81eb303-54ac-4906-a0cd-4b473bff9fc5	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 11:45:16.76
973e395e-1268-4999-9366-d1b444698fce	8696ba1e-eefc-40cc-aee7-e28618358b11	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 13:42:13.384
a244129f-ab5b-46eb-b307-68d8f3611eb5	c28b7df3-4124-4d35-92a4-fa3dda64e987	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 13:59:00.213
0825dc8d-7e3e-488d-8c9a-c4e2526b036a	2ce32a5b-9b98-4323-ac4b-e8e0420f228e	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 14:06:09.13
a79340a0-591b-4355-a27a-ef2c0eac0c66	9ad9fdd1-cc1c-4207-a23a-97f2e35920f7	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 14:41:55.558
a46c1c53-a70f-498b-81cb-03af8c111b94	3e769054-9bc2-407b-8fae-178772a6ed17	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 14:48:19.369
fc5a3ae6-cd96-4343-adab-7930760f8e4e	66e62bc1-b4f4-45d7-8c0a-668e72cfb076	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 14:50:59.125
43516140-33c0-409b-830d-ced6f9625e39	0132b524-ef91-46e2-8511-7774ff3a3136	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 15:08:20.173
f135dc42-1e05-4eea-a987-cc31b5fff4c1	e9421675-c800-46d6-96a7-32e63d08c740	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 15:21:20.997
29667abb-2ac9-4827-8e9c-550705cdd1d8	2f50129f-b320-4f6e-b556-1999bab4958e	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 15:51:31.251
cfad5d2a-53b8-472c-890b-09bbf7542fd7	8394b52b-c320-44d6-9978-0ff2f4c2d363	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 16:34:50.884
9e88b9c5-5e0c-485a-8478-64c2a25d5b3f	013d1c86-5c5f-4116-9a77-a48b602f95ec	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 17:26:59.897
c3b64949-aff2-40e4-927f-f4cff55f8313	e0e269d4-d442-495f-928f-d6cc6229dc3b	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 17:32:48.225
f605663e-f524-49d4-9689-b420067194bd	b2880a36-9586-4d70-a943-ad9b3d4c109e	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 18:02:26.711
ff01801f-9f1f-4e13-8e33-b485750cbc1e	715bda40-2016-458d-a33c-0378f48d9651	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 18:10:33.511
bfef961f-6868-4ca5-a7fa-f058910e91da	65508e76-9565-420d-a23e-fe7c6bf89728	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 18:12:43.891
8b926427-6e7c-47b6-add5-a2e67d1a796a	10ca55ff-2bd8-42d6-b6ad-8bd661da1901	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 18:39:06.067
b3a17f9b-15ef-48eb-b507-6230a232f3c2	1acea10f-5597-4b14-b762-9049f1c76a5c	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 18:51:09.87
6ab36cf4-537f-49ed-8e6e-76d1e61fe475	cd0d7d84-8b93-46d2-b5fb-48f896ba0dba	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 19:35:16.282
7c076892-5fa5-4d3a-aa66-5da23dfd5086	55f6ccab-db6c-4e92-a60d-e40a6ba7cdc6	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 20:11:19.564
2b8b1d1c-ccd6-4ec1-8fcd-f83daae49500	c9cf469e-d763-4a54-be1d-2067c6289335	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 20:20:21.239
fbda6fd0-35d0-4523-aae9-09846894388e	ee4456b2-a3c8-4034-8bed-23f693a35dc0	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 20:44:55.729
c64ec840-1d30-493e-aa1c-1a7d259a2138	53fd50c9-9f94-44f0-99a5-e136b8ccffac	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-08 20:58:40.539
7587e94f-503d-4de6-a467-4e160ac43904	50d67188-43f1-4655-885d-d89a57b2aab9	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-10 04:11:24.627
6e1e85ae-3320-4ce6-b2db-f9bfe0350c5f	ff2c099b-6b9c-4133-9207-fcc068c01dd4	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-10 05:06:41.992
fb73be51-85b7-46a0-8cdb-dd9273cc71f2	ff2c099b-6b9c-4133-9207-fcc068c01dd4	8890f0eb-0f41-4af0-9acc-b83329ae99b3	10.00	DEPOSIT	Recarga Flow: 10 creditos - Paquete inicial 	2026-05-10 05:09:05.779
1b6c61b9-0b3a-42e0-bcea-a06389f61fcd	d28e6f57-17fa-40c2-8c4d-ccc3dc125b1d	\N	300.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-05-11 20:37:20.455
fd6c72fd-1aae-458e-a457-455ec9a50acb	0486dc35-ab49-4c28-baee-33d5f1268350	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-12 19:51:58.23
96a901b0-8c3d-481e-be7b-e6dc37177ea7	69ae77b7-521a-4136-86a3-c42c58240802	c75f9845-1c72-4351-8e40-14f1fec73ce3	50.00	DEPOSIT	Recarga Flow: 50 creditos - Bronce	2026-05-13 02:33:27.966
19e9f6bb-aeb6-4d79-b072-717be004d326	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 02:37:45.705
e1a32e2b-d483-434e-a520-54a4dc82cd75	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 02:37:45.708
62a918c8-0b8d-4c5d-b79f-beecdeba2e01	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 02:37:45.709
bddde0bd-ea82-41a2-9bd0-426bec7956fd	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 02:40:23.771
58923f95-e4d1-45ae-bc23-e027d1c94ceb	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 02:40:23.773
cea804c3-4290-4f11-a2f7-36e9d8d813e9	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 02:40:23.774
53439fc9-0013-4d68-a021-6374ec07ea5e	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 02:56:44.312
6e872716-55de-43d9-a686-55715edc715a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 02:56:44.314
0028887e-9193-4077-bbbd-cf2fb7cd8a1a	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 02:56:44.315
07992254-7dfa-46cd-8b65-75ddef897219	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 03:17:53.577
50ab36e5-5f53-4407-922c-77316f4ac372	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 03:17:53.579
dd6ae9a2-8b80-47fe-9f9d-a3704da6a73e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 03:17:53.58
6647e359-1b2e-4221-8f0c-1f4f200b5899	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 03:18:28.935
e99e3e36-1601-4f4f-9fb1-ff9c7dc1afcf	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 03:18:28.943
ee07e9f4-394d-48f8-9f33-2fd687e83d04	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 03:18:28.948
fc8d55a5-2f19-4e5c-b10f-e7cce34924fd	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 03:40:17.774
08523ef9-1032-45e0-bec4-16b4e8969573	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 03:40:17.775
8d8515da-c893-4c2e-b3e4-373de3793539	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 03:40:17.776
d6c6b1c3-99dd-4915-968b-ebab7091ae06	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 03:41:03.032
0e469ec7-8698-42c0-a1e8-98915a6e9e6c	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 03:41:03.033
996660ad-553e-46f8-8459-7f3c28bc386e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 03:41:03.034
a9972dca-02d6-4bfa-9718-7215e8fcb479	13b61e92-6a92-4cea-b7f3-757a1165a237	\N	10.00	DEPOSIT	Regalo de bienvenida - 10 créditos	2026-05-13 03:50:10.149
2d7aba81-b1bf-4e61-8aa5-6847050574f6	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 04:25:36.161
c75f0dcd-f170-41e5-ad25-c98ccfc45c22	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 04:25:36.164
b8af6580-12db-4ac7-b29e-17af27b18e9a	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 04:25:36.165
3ce3de9d-dff9-47ab-a640-63c46bf7a59e	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 04:34:39.919
c030786b-66b3-4941-bdd6-f2698ede1154	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 04:34:39.922
a74e939c-3e61-4742-9142-31f28b814d03	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 04:34:39.923
491d0b05-83c9-46c7-89e5-5e9268636efa	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 04:40:45.02
cb187cee-c52e-4f37-8576-12b44e92d2f0	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 04:40:45.022
66609a44-a6c6-4150-9acf-5ca16f05ec2e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 04:40:45.023
599e6c6b-40ff-450f-9892-e36b266ad943	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 04:40:50.169
0ff03c3e-2890-4d2a-8a6f-590415d83226	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 04:40:50.169
8480a384-8e0a-4a6b-8e93-aab2dd9ae2f9	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 04:40:50.17
8a79e8ec-1b18-45cc-83b7-c271db3cde16	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 04:45:46.751
278c5bc1-55ec-44b1-8949-92424f928a60	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 04:45:46.753
070684b2-2dcc-446c-b3f4-9890af07e52a	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 04:45:46.754
f2b62a8e-c96a-40f1-8bc4-33a593c1e607	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 12:36:32.918
e4fdcab2-a35a-48c0-8bcf-089608bd0eb8	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-13 12:36:32.921
09b28cd0-4a72-4b74-bd81-b749022ee02b	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-13 12:36:32.924
6af74946-501e-45a7-8c1b-adaeef077f55	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-05-13 12:39:58.498
762a92b9-c511-4a42-a5ee-0578c715f3f5	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	5.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhaseft"}	2026-05-13 12:39:58.501
26c5d1d5-7a06-409c-bd8f-21c1dc182719	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Imagen de chat","clientName":"Jhaseft"}	2026-05-13 12:39:58.502
f806ed9e-45ca-4cca-b017-9fe8082b29bf	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	5.00	MESSAGE_UNLOCK	Desbloqueo de mensaje	2026-05-13 12:40:25.7
378a10fe-adf3-462b-a6d9-af9831deab66	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	2.50	EARNING	{"service":"Mensaje Bloqueado","clientName":"Jhaseft"}	2026-05-13 12:40:25.702
e3679772-de01-4509-a099-09f5ef3b9626	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Mensaje Bloqueado","clientName":"Jhaseft"}	2026-05-13 12:40:25.703
fbf398fd-5d4b-4166-a102-4b66ac1d1484	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	20.00	CHAT_IMAGE_UNLOCK	Desbloqueo de imagen de chat	2026-05-13 12:40:45.288
0e6e40c4-9018-454d-a899-2a4e2e65be08	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	10.00	EARNING	{"service":"Imagen de chat desbloqueada","clientName":"Jhaseft"}	2026-05-13 12:40:45.289
1087e471-5b68-4518-aa5e-c9b791530a9f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	10.00	EARNING	{"service":"Comisión Imagen de chat","clientName":"Jhaseft"}	2026-05-13 12:40:45.29
25e8b12a-00d6-47c4-8c47-56a24f0f50d3	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 22:50:31.325
25e638a9-b2d9-42ae-8f25-b757d11a1e84	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-13 22:50:31.329
69a7cd59-9ebf-484f-bd6c-ece1716d3938	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Francisco"}	2026-05-13 22:50:31.33
99a750f0-9181-4e70-91fc-8470d08f936b	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 22:51:09.466
c91b821a-8cb9-4fe9-aadc-f26ca41e22b1	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-13 22:51:09.467
71014ba9-e54f-4eab-8ffd-eff5ce976bf0	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Francisco"}	2026-05-13 22:51:09.469
dd9ddfac-6ff7-40ba-a4c3-b5d717b1df2e	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-13 22:51:32.014
d7d6de7e-6e47-4bdb-aae7-3da77d4811cd	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-13 22:51:32.016
be35ff07-0f87-4a75-8018-14d204957066	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Francisco"}	2026-05-13 22:51:32.017
83520d66-fa29-4c69-bf2e-a26fda9bb59e	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:48:31.93
0756e6ed-2ab5-4de3-a16e-f7645e4ba93b	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:48:31.933
85967e9e-facc-4425-a3d3-e9df3426f1e4	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:52:07.777
e84b2f62-e87a-4b34-90a1-3dbd11b15469	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:52:07.778
1b99dd8c-2e06-4cb7-8235-baf68cdb530a	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-15 18:52:07.779
98941850-107e-4694-96e7-a0dd213ecae8	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:53:39.091
165c983b-5313-43c9-af2e-0467457a350f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:53:39.093
e63bc792-1dab-4c5f-bceb-a43555fb4afa	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-15 18:53:39.094
5cfe2194-8d19-4a22-82fa-f5fa94171625	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:53:47.846
2804e52e-9848-4643-b16f-7dc042f0d5c2	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:53:47.847
da0f6476-3e0d-4345-97c3-6b8fd642a66b	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-15 18:53:47.848
4684cc66-2b79-49ac-8a6c-a28de23a7470	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:53:51.75
93380543-eeb5-4353-812a-53c0305e3ef8	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:53:51.752
08ab7396-c665-4804-8eb8-002b470f7542	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-15 18:53:51.753
eab25ace-2ab6-48a8-8734-b8d7506b6be5	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:53:54.333
b6a99c25-dfa4-41c6-b4f2-ad474d6f07a5	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:53:54.334
d1e12020-44e2-4a1e-994a-ef1f4d9b4342	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-15 18:53:54.336
b2ca9419-f472-4e7b-bd3a-67dc4fb25807	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:54:20.559
22079fc3-d391-41e0-ac58-dd7a0d885917	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:54:20.561
21ca0e41-f66c-4279-aa57-72832606c085	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-15 18:54:20.561
6b9764b9-c162-49b8-8400-08e0a3e23800	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:54:54.243
0f922b0e-aac5-47ee-b693-4cef88df36fd	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:54:54.244
d43d1f95-808c-4626-b9b4-a9b20ff10c25	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-15 18:54:54.245
94a766a6-9c8a-4d66-a102-f69a35785184	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:55:08.254
b1f189f6-0b5d-4eb4-9084-f5c60ef08961	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:55:08.258
82c8e08d-e7fe-47c4-8026-c1ddef0f105a	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Jose"}	2026-05-15 18:55:08.259
8c2a66aa-c4f6-4315-a5e7-0a69399f8f3e	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:55:58.306
23a29fea-f579-49ce-a911-fb04d6474066	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:55:58.308
894fb3b2-b797-49de-bde6-ed9834d6a35c	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:57:01.939
7dc7c0c4-3e0d-4995-8a8c-1f9f55d2878a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:57:01.941
b0aa7e8f-e92a-4e76-b3e0-add6d7a3a37f	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:58:30.71
a60bb16d-7e77-472f-a5dd-01a6ea8ac51c	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:58:30.712
a4b4eb7b-ca40-4feb-a1b1-722a8a797fa4	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:58:32.913
138670c6-5ff3-4638-8ae6-2d6a51756b15	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:58:32.913
151174da-f0e1-496c-b7b3-6d10ef1e1fd5	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:58:34.022
5179bd16-6f39-4cc1-a0a2-0b345e6ad3b6	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:58:34.023
48452541-f989-463c-b829-bb251083eaf2	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:59:20.062
fa993f0c-4c98-42b5-b1b5-9ba6d0c7113b	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:59:20.063
dd975ad7-bc40-4164-add4-acd7106ea12b	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:59:40.025
d055d482-0a43-4e9c-b283-720523564a1d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:59:40.027
37001c76-e7cf-47fa-b941-6141717c215c	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:59:53.885
7e65593b-0db4-4566-bd1d-f52e7a815843	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:59:53.886
92fa740e-29cb-4a34-93be-8483b934af9c	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 18:59:59.294
959b7fe4-a210-4fc6-b035-8c7f3c77feab	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 18:59:59.295
77248a15-bfda-4a1f-9999-c2ac032c5c00	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 19:00:10.232
8f70b2c8-cbf3-437b-bf3a-81169124aa06	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 19:00:10.234
ec50c323-7075-4229-b53d-e0e9c03f5243	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 19:00:17.074
890e1a05-b089-43b0-a367-7dedf4840af2	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 19:00:17.075
6e31d83e-09db-422c-a59a-5e1805db313e	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 19:00:20.765
b1f44df8-52fe-437a-b07f-579cd1d7f465	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 19:00:20.765
b08910b9-462d-4498-aad6-7ffab8a1c5a4	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 19:00:21.84
2029b0dd-9c39-46de-a4eb-56d20f590a5b	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 19:00:21.841
be1ec6cf-33ae-4416-9cff-bba43138f7c4	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 19:00:25.13
1b9f274d-ef2b-4ef8-8cac-79fdfa78dafa	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 19:00:25.131
88ab551d-b4b7-47f1-9878-956b2b6a86a9	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 19:40:05.885
07b61c8a-cfa7-48cd-9e0a-405fe5db9ee2	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-15 19:40:05.887
c0e49f4f-aa24-44b9-924b-81e6ce86101f	f70f19fa-0536-49a4-acbd-9ece582b8e8d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 21:37:41.833
80e98697-4b23-4816-ab63-974edcdc36de	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Enrique"}	2026-05-15 21:37:41.834
e1f67867-6faf-4392-b47d-43f258d0fe1a	f70f19fa-0536-49a4-acbd-9ece582b8e8d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 21:39:31.218
a0ebdb17-49e6-4182-8ecf-d7324e177586	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Enrique"}	2026-05-15 21:39:31.22
30db7ebb-fd15-4c8a-8d15-dd9d7f91adbd	f70f19fa-0536-49a4-acbd-9ece582b8e8d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 21:39:48.616
b96c5103-8eaa-4a0d-bc65-b39195b0bd3e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Enrique"}	2026-05-15 21:39:48.617
1f1c2258-5d15-4383-832e-99ffba59d9c0	f70f19fa-0536-49a4-acbd-9ece582b8e8d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 21:40:28.931
ab93dbd4-d638-485c-b69c-2fe8ba3ddbf7	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Enrique"}	2026-05-15 21:40:28.933
1b5b8be2-08d1-4aa6-b632-bf0e5fabd71c	f70f19fa-0536-49a4-acbd-9ece582b8e8d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 21:41:15.597
14543160-0ddd-4578-bc86-75694007c0a7	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Enrique"}	2026-05-15 21:41:15.598
cae010e1-39c3-458c-819c-63c27451f174	f70f19fa-0536-49a4-acbd-9ece582b8e8d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 21:41:54.406
771eb252-4baa-442a-b3e3-fbd7068ad72f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Enrique"}	2026-05-15 21:41:54.407
2577eaa6-39e0-4bcc-84f9-4b20cc7a4177	f70f19fa-0536-49a4-acbd-9ece582b8e8d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 21:42:12.874
13212309-f3ec-4b69-84b9-68e1eae2bd95	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Enrique"}	2026-05-15 21:42:12.876
a3a67548-2195-4535-b196-386114e2d04e	f70f19fa-0536-49a4-acbd-9ece582b8e8d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 21:43:30.345
f4515d3f-e4bb-40b6-87f0-040c431c5d4a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Enrique"}	2026-05-15 21:43:30.347
74f33bf3-df20-4e52-acbf-dfada848d577	f70f19fa-0536-49a4-acbd-9ece582b8e8d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 21:45:16.791
79b74cba-13d6-41cb-a376-b4183fc913f6	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Enrique"}	2026-05-15 21:45:16.793
d183ed26-a79f-4025-bb6a-77f5c7be7b19	f70f19fa-0536-49a4-acbd-9ece582b8e8d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 21:45:36.771
1a44c994-be3b-424b-b022-01011097d37b	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Enrique"}	2026-05-15 21:45:36.773
5e636056-593b-4c52-aa61-f542caa6bb6f	f70f19fa-0536-49a4-acbd-9ece582b8e8d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-15 21:45:55.356
9b1ebf20-93e3-46e6-b6cc-f46bce4583b2	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Enrique"}	2026-05-15 21:45:55.358
31d26926-0ff6-4ab9-9049-16141a31e83e	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:27:37.115
761d020f-fbc1-4aff-a7d4-3a43dfa75ae6	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:27:37.118
aed42a53-bed6-4273-beb0-d94273f5d4ce	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:32:32.314
0f40551e-6730-4125-9ebb-0e7b6e351f9f	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:32:32.316
10f801f0-3898-4de7-811d-196daf044e95	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:32:54.35
d432277c-2fbe-4caf-b5ed-6666ce7042d1	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:32:54.351
9be2bb7a-5ee9-4e5e-b1c7-9aaa05d9f18d	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:33:15.171
d4f7cd78-bd69-452f-8644-7c186be6b2d2	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:33:15.173
ac213f60-412a-4c75-9594-c28cdc6f5e99	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:33:18.04
d0406e48-778c-4686-96ae-fd937c8ea074	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:33:18.041
4b951e45-9ed7-4865-97f5-1f17ecb38875	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:33:42.889
760daee2-e676-4ca8-8926-d26311b8a5dc	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:33:42.891
042d3f25-6a5c-4eaa-a3fb-00b762c97fe3	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:33:49.633
7f1c3cd5-9e51-4661-878b-e66d313ce230	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:33:49.634
52524041-7acc-449f-a374-e7e22c8000c4	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:34:59.339
09f0cf46-45a8-4c21-a693-6ad1bcf49695	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:34:59.34
569166d7-a6c9-40a3-8937-6ccc5b0ef050	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:35:11.326
81cdaaa8-95bf-4245-ad73-556c5b53a471	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:35:11.328
45ab68db-8bce-4d3c-9875-fc3f178bf849	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:35:24.655
12dba386-6c01-44a0-a433-d38135b45bf6	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:35:24.658
3e88be65-5575-43f8-8fe0-2dcc8e2d53ab	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:35:40.254
76a52583-0b78-4795-beff-43af9ea13cc0	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:35:40.255
2d18edc7-300b-4671-bcd7-e184f20fe7f9	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:36:02.803
61be985d-b851-4c73-a591-d7d2aa3c63c0	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:36:02.805
c86df40f-bbeb-4dc8-92b9-c713c5e81ef3	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:37:22.301
936eb20b-ec45-46ed-ab6f-6627c89ea116	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:37:22.302
826cfb20-bc4e-4270-a2f7-c7cfcb81805a	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:37:25.861
68662597-cd73-467c-a54b-83aaa5bb5f08	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:37:25.863
2eab8f3d-db19-4746-9392-c435c3e3df0b	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:38:35.056
b3ff1ec2-b03d-46d8-bf14-f0b40852d489	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:38:35.058
38d03cee-6d89-45a2-b748-e2e57c18cdf4	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:38:43.82
f0f4aec6-96f4-44a1-8ce6-3280af9489a1	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:38:43.821
95461330-0cf3-4c40-b2e2-debabdd05cff	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:41:55.869
5568a5a2-a77b-41e8-ae07-4476ad48d570	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:41:55.871
ef2d79e1-c38a-4c14-8f19-d2530b248398	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:42:02.492
aabcb02f-e7af-46d1-8494-0ea6587d71a3	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:42:02.493
fa88a44c-93d6-4ef6-8930-eb13dfafffdb	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:43:47.242
affbd9a3-8e2f-4a5a-927c-966820a66a4b	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:43:47.243
bd29b8d5-8d08-440a-aaff-09b9cd18bd85	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:45:13.804
63a16f44-b27a-43dd-92d3-05f6c04713f7	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-16 02:45:13.806
b551a70b-5bd5-424d-9713-3e25015be262	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:45:31.92
4e0bce06-26c4-4a9c-a81a-b4d3171ceb9f	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-16 02:45:31.923
d3052f8c-0ee5-4967-a15b-dbcbb3f1074a	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:46:35.555
d5add71e-7756-45f2-ba20-51a01184edc8	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-16 02:46:35.556
f5dffce4-819e-4e35-becc-c60997cc3580	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:47:07.513
d9d4a046-044d-40a5-8b6f-e32081e8787f	44d0411e-7350-4122-a7cb-3262e14b2a26	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-16 02:47:07.515
7b8cbdaa-511b-4b97-afdb-dfe28bff38ed	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Francisco"}	2026-05-16 02:47:07.516
4e336762-ecc9-4005-9fd0-28502381a532	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:47:55.173
6f73c3a3-37f3-461f-aa45-d564e4b0fad1	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-16 02:47:55.174
a7e4749c-0457-44ce-8674-9dabbfa8cf89	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:48:21.649
1a9ea380-af1e-4c3e-8f4b-b529604f0c1d	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-16 02:48:21.65
9df42d73-1971-498a-be6b-4d79bfad33a3	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:48:31.914
7ad685d4-b8b3-4547-8d15-8bc83abe6ce6	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-16 02:48:31.916
15021cb1-c204-4e56-a698-d68d1f836a93	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:48:50.27
7a0f39d7-0b1e-4cfb-b0cf-8502642c401d	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-16 02:48:50.271
dd34f4cc-e03c-42b3-996e-2820a2ed9b6a	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:49:10.643
9184b4bf-2a55-483f-922d-b5ca04d3a49c	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-16 02:49:10.644
0abd2e3a-acf1-40f7-ab49-2cd469343b18	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:49:25.903
7591f979-512e-43d3-8108-2b62015f052c	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-16 02:49:25.904
737073e2-fd33-4e8b-b940-e81403d2790f	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:49:34.678
05842f10-20f6-4dea-9f59-3458a0aa262d	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-16 02:49:34.679
06cf91f7-8d5e-40a6-8ae3-a461cec5112d	46828d1e-e9b7-4d62-a925-de185db5beed	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:49:46.376
46c8dca1-7f37-43a0-9c76-07542c0a8b83	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Francisco"}	2026-05-16 02:49:46.377
64e1cbbc-13ab-4fb7-9e15-22d4c92bfe33	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:51:17.278
ddb6b98c-bc02-4216-829f-7f714478082c	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:51:17.28
c4c773ed-219d-4478-a3a4-c053c1a916bf	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:51:47.504
df86adcd-3e9e-40c9-8a0d-7e5e2c25313e	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:51:47.505
18215988-9efe-43cc-8dfd-0d01abc527b4	69ae77b7-521a-4136-86a3-c42c58240802	\N	15.00	CALL_PAYMENT	Video llamada · 1 min	2026-05-16 02:53:42.226
272fde7e-736a-4177-a6c1-fe3f7afd7570	61afee71-c9c7-4aee-8504-9283cb18e738	\N	7.50	EARNING	{"service":"Video llamada","minutes":1}	2026-05-16 02:53:42.227
8231d9c2-a8e3-40b8-9a94-db02de0fea16	925dc47b-91c6-4a44-9233-de139f77a62d	\N	7.50	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-05-16 02:53:42.228
7ce9ef77-0b40-486b-b6cb-5288f80d154a	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:53:53.178
46eed4c4-0512-4233-8eb9-8d7a61c41f09	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:53:53.179
47c7d0ab-f71a-40d4-8850-dae39586d9df	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:53:54.292
afd65cd6-52d8-47ff-b3a1-65e128ba9a03	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:53:54.293
a49a9cd0-7b95-4fee-bd9c-ded7515d9559	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:54:33.953
62704d53-767a-447e-ba51-1395999fe26f	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:54:33.955
85b29758-e75f-4e87-a720-638b3331d6c9	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:55:39.835
189442a5-3622-41aa-95a5-91e48b2eee69	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:55:39.836
24d88bbe-c416-47d8-a340-f52b472b2172	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 02:59:04.209
a4b6fdf5-c2e8-4900-9ea5-61fb542667a5	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 02:59:04.21
b085d2bf-266e-41ce-a1a5-7629c82a9cf9	46828d1e-e9b7-4d62-a925-de185db5beed	\N	1.00	CALL_PAYMENT	Video llamada · 1 min	2026-05-16 03:00:40.403
c336d7bd-7c49-4fb7-a5f3-be2aca492aea	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.50	EARNING	{"service":"Video llamada","minutes":1}	2026-05-16 03:00:40.405
f9aac964-f8b8-42f8-94a0-c69e6a0aa53e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-05-16 03:00:40.406
019955a8-827e-41d3-a2a1-135a197140da	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:44:14.239
b0821d22-fd52-4f57-86cc-f7b3d5f62a5d	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:44:14.24
207a439f-72dd-42d2-932a-a8ae88064d9c	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:44:15.802
68c7b8c3-f728-4c5a-8359-825f21f06284	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:44:15.803
c3072fbb-9e8e-45c3-8b06-f675b293efdc	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:44:17.629
edf4fcaf-e4e1-47df-ad3e-c10825a9cc8f	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:44:17.63
65a64fca-edd7-4c32-a7c2-8738c5cbfdd3	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:45:11.342
1e2db0b0-d9f3-4982-905b-cde2bd0198b8	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:45:11.344
13060f5e-3824-409f-a730-42544c4563c5	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:45:15.892
2566076f-ec60-4940-af79-e4b61f21b853	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:45:15.893
9edae72c-1103-4506-97fe-c95e5258c3a0	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:45:19.284
429e387f-24c1-4411-9555-67156ef79c82	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:45:19.285
f736c7cd-172b-4746-958d-a3fced3c8304	69ae77b7-521a-4136-86a3-c42c58240802	\N	15.00	CALL_PAYMENT	Video llamada · 1 min	2026-05-16 03:46:53.093
3b452d97-7cef-4dd3-8358-a3bab19158b8	61afee71-c9c7-4aee-8504-9283cb18e738	\N	7.50	EARNING	{"service":"Video llamada","minutes":1}	2026-05-16 03:46:53.095
b0d48881-26c9-4a6c-883b-0dfd69888fc3	925dc47b-91c6-4a44-9233-de139f77a62d	\N	7.50	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-05-16 03:46:53.095
945132c2-09d6-4f02-a233-7374185ab7c8	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:47:05.004
2f411ce4-86e2-44ef-920b-f1864c486cac	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:47:05.005
e7b74462-9b0c-4fc0-8f66-c0219b4f5808	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:47:09.33
47a69f0b-36b9-4427-8c06-b3698bd65add	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:47:09.332
b67de2ff-42fe-43e6-acc0-c04e6b4274a7	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:47:15.416
f6833723-7c3f-4f15-a420-37d25830991c	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:47:15.417
7c943674-af84-4745-90e5-554149225c6a	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:47:40.438
ab961a6f-a641-4e07-83ee-f41298ab6516	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:47:40.44
acb6fbde-ffb7-49de-80ea-72c71a6a44d2	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:47:43.581
6d7a2ee6-1cf9-498a-95e7-8e18fee7dd70	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:47:43.582
6586731d-a92c-4b73-b362-6fc87b48f39b	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:48:15.342
f1dae83a-f75e-47a0-9b4a-1265abf70714	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:48:15.342
4836a0e3-ed9a-4ed0-a7a0-62056454cb5a	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:48:22.028
5332eefd-f2e1-4cdb-b1f7-d236442df850	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:48:22.028
090c544f-6f11-413b-a486-50ec0c36e4c5	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 03:50:14.981
8b8971eb-afdf-48cb-829b-452b0ea2d019	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-16 03:50:14.982
f61bc76e-f9c5-48cc-8700-cf40ade5ca64	02eb5957-7267-4748-b226-ba853e4cb4c1	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-16 04:38:53.363
cf31d0f2-dbc2-414c-8df4-b10c4fe3a17c	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Wildoro"}	2026-05-16 04:38:53.364
4bffec76-98ed-41cf-ae97-2deb46ecdb56	259f93c2-0f18-466a-b54f-7c6b19685733	\N	5.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-05-17 01:02:53.147
add0bc54-8e08-43d6-9ed2-be73c30f8410	36a1e380-00d2-4bd7-821b-95823c86efef	\N	2.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-05-17 01:02:53.15
4b7f1195-7dfe-4de5-a77a-f889d685586f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-05-17 01:02:53.151
be252775-17cb-4215-ac0a-0271522c0fe7	259f93c2-0f18-466a-b54f-7c6b19685733	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-05-17 01:03:50.326
e68ee9d0-a654-4c07-815f-ca5f0430fce9	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-05-17 01:03:50.328
fe7c3c8f-faba-43d5-880a-6c90606c0ee3	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-05-17 01:03:50.329
9dd816b8-368b-4749-bcf8-5fac9a38694b	259f93c2-0f18-466a-b54f-7c6b19685733	\N	10.00	CALL_PAYMENT	Video llamada · 1 min	2026-05-17 01:06:05.158
68c153b3-6a2a-4242-9963-02f1bce735f8	36a1e380-00d2-4bd7-821b-95823c86efef	\N	5.00	EARNING	{"service":"Video llamada","minutes":1}	2026-05-17 01:06:05.16
72d003eb-4e5b-4504-8709-0adc3213f232	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-05-17 01:06:05.161
23e5ad47-bdc7-4f16-981d-41d9f973d190	259f93c2-0f18-466a-b54f-7c6b19685733	\N	2.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-05-17 01:10:27.525
bf6c6782-170b-4c91-8843-52514776d738	36a1e380-00d2-4bd7-821b-95823c86efef	\N	1.00	EARNING	{"service":"Imagen Premium","clientUserId":"8378d82d-b63f-49d5-8856-f515f0e2ccd4"}	2026-05-17 01:10:27.526
727b9c6d-e381-4156-984b-141493f01abf	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"8378d82d-b63f-49d5-8856-f515f0e2ccd4"}	2026-05-17 01:10:27.527
c788a241-dc57-4d69-b81a-125e8e131851	b6075930-69c8-48e6-a521-91b3f870a7bc	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-17 22:49:36.281
9dfc77cf-7935-473a-ae4c-c738bfbbe64f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-05-17 22:49:36.284
32037d63-30a0-4c6c-86e2-983a210edccf	02eb5957-7267-4748-b226-ba853e4cb4c1	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-18 19:51:07.786
b8237605-f7b6-46dc-85cc-e8608ef48f49	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Wildoro"}	2026-05-18 19:51:07.789
dbf54814-5127-4912-a983-701c3afb538c	02eb5957-7267-4748-b226-ba853e4cb4c1	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-18 19:53:15.299
6b8d5efd-c5ee-410c-82e3-8bd8b54cfcc6	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Wildoro"}	2026-05-18 19:53:15.301
34afc4d2-bf23-4939-ab05-4f4dcfc7aa2a	c088f4ab-0de5-46a9-ab66-6e3e43719f88	\N	1000.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-05-22 17:02:57.965
6e0b4183-3e1c-4467-8ce3-b2c04d3bd31f	65fd5f11-0797-42f7-a46b-172a64901dc6	\N	500.00	EARNING	{"service":"Imagen Premium","clientUserId":"4e7e7405-7841-436d-a277-55b2d8c4299e"}	2026-05-22 17:02:58.418
83969707-eb1f-4a56-8bfe-c1ba963b5d77	925dc47b-91c6-4a44-9233-de139f77a62d	\N	500.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"4e7e7405-7841-436d-a277-55b2d8c4299e"}	2026-05-22 17:02:58.883
f3e6d06d-abe8-46c3-9569-1374b72b8a44	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	25.00	REFERRAL_CREATOR_REWARD	{"service":"Comision por referido de creador","referredCreatorId":"b8f63138-a5ba-4b5c-b25c-ffd88ec1386b","sourceType":"EARNING","sourceEarningTransactionId":"6e0b4183-3e1c-4467-8ce3-b2c04d3bd31f","purchaseCreatorId":"b8f63138-a5ba-4b5c-b25c-ffd88ec1386b"}	2026-05-22 17:03:01.998
48cf39a1-eaaf-405c-a0f8-a9b2fde972bf	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:32:06.308
762b0930-c739-4eb6-96c0-e8910390a1d1	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:32:06.312
fbc496b9-b283-486e-9e84-381d16a9d0a4	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:32:20.171
d8baa7cd-2c0f-4caf-9758-af8a7cfc4762	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:32:20.173
2143f1e9-8ac8-4b91-963a-aba43ccad06f	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:32:55.634
831dbede-c20f-4864-9b9a-3cf3befc6fb5	78c1e70c-69c7-4888-825b-4a2283697e00	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:32:55.635
6e49e1d8-7d1f-4402-9234-857527300e86	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:34:27.353
c95d93a1-ce1e-4797-9251-986eb15b306d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:34:27.356
81b25418-af24-454a-aa9b-2e83c1b7b8aa	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:34:36.468
667716b2-1a8d-4f00-9105-1e101ecd6b0a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:34:36.469
6b333192-1aab-422f-b256-f0e617ca4243	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:35:16.946
8c26b996-b0a8-438e-b4aa-814954e32fde	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:35:16.948
d8a3497b-3e1f-4f61-8185-a809fa3c3bdd	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:35:21.915
94c10035-f014-4144-8685-0482aea33d98	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:35:21.916
3da59501-4fb4-410c-8fdf-1c7181fe9ef9	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:36:21.121
73dfa410-98c9-4208-b1cc-1710570335aa	d6fc81a9-9805-483b-b305-f7e7c7ac613a	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:36:21.122
e5718459-ac06-4029-8311-7875d9db5c23	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:36:25.943
b4f5fb02-e07c-4255-87e1-f7aae701bdbd	d6fc81a9-9805-483b-b305-f7e7c7ac613a	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:36:25.944
fe5b6f20-b153-4f5e-a95a-0fdb6cbdcc57	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:38:46.068
8be205ea-26d0-4d47-9cd9-407ab9905290	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:38:46.069
a5c3eb5d-879e-440c-9045-4a63be670c8f	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:38:52.831
fc72a1a0-ce60-497d-94c0-161bf0d0fb7d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:38:52.833
0b4493f2-cd89-4692-ad46-df9f0b79c3d4	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:39:02.213
9aeb94a5-4728-450c-b5fe-20b0d9c1e56d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:39:02.214
07a72cb6-913a-4212-ae03-ed6aea1032e4	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:39:11.26
7b4ea7d7-ee01-466d-bc4e-e5947d3a83b7	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:39:11.262
1a0773d3-553c-4d7a-8abe-efdaa70c5963	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:39:34.817
1c5f87f2-1137-479e-b62c-89d479cd8658	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:39:34.818
82a2a95d-78ff-4847-9354-abb244fd7218	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:39:40.008
6b6b72eb-87e1-4c75-9d49-8ade92434488	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:39:40.009
26692737-f416-458a-849e-51bdead91c78	7b4fd1eb-d25a-45da-ac05-59caba51649c	97337b2e-106f-45bc-869c-4a821af5b95a	10.00	DEPOSIT	Recarga Flow: 10 creditos - Paquete inicial 	2026-05-27 08:50:02.746
898d2214-fa9c-4433-8af9-db47f5327b53	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:50:23.491
a7a21532-e62c-45c0-83f0-9d1b08659fbf	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:50:23.493
027d299e-2d92-40e9-aa33-e7b8b1c6b060	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:50:47.559
7724e2e0-59d9-4769-9b95-6e5766d6f797	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:50:47.56
9dfaaa3b-efba-409b-854e-19d1188a102c	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:50:49.624
749dc9b6-b108-4208-b381-cfac8ad5e150	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:50:49.625
47a61bcf-6aff-4052-b3a3-71c4f18d2c7b	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:53:03.577
71045cf5-9c0c-4227-b5a7-6e428e7cc258	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:53:03.578
863a6c13-2d44-431f-ac47-af682808456c	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 08:53:10.73
a222662d-8345-41b8-8bc3-dec66e0401e7	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 08:53:10.731
2c18fb7e-a662-4c54-b3b5-0d9f3b001a52	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 09:03:19.94
0fb9a2d0-e11d-428c-ae3d-2ec9fecc4421	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 09:03:19.941
32eb9d57-8b05-41ae-b9a4-7c111e34605e	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 09:10:10.175
82deb502-7f68-4d2e-b305-d468e6404d5e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 09:10:10.177
ad98e0b1-c886-4fdf-8b27-f9011ac58bc6	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 09:11:02.963
ee95c9e9-ee9e-4113-9f16-72e54b7ac40d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 09:11:02.965
24f4709e-5874-440e-bb63-4b8384fd6bbd	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	8.00	CALL_PAYMENT	Video llamada · 1 min	2026-05-27 09:24:27.339
314e2fd6-cc5a-4b12-9175-54b607ba0b1e	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	4.00	EARNING	{"service":"Video llamada","minutes":1}	2026-05-27 09:24:27.342
48ddf0a7-9b32-47bc-9175-a8616051dbb7	925dc47b-91c6-4a44-9233-de139f77a62d	\N	4.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-05-27 09:24:27.343
27958ff0-74f1-4dd5-b2c6-8b9957022a03	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 09:24:49.554
d75f0f13-685d-467b-babd-d70ced2ff4a3	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 09:24:49.555
bb6cf708-9069-4366-a273-c828011008ec	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 09:25:29.488
462826d5-dab1-4082-90dc-5fa7c5fd6a63	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 09:25:29.489
350c6064-270b-4685-b6fc-77d437c6b475	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Carlos"}	2026-05-27 09:25:29.491
5770371a-7daf-4a34-a76c-bf0c70c9856c	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 09:25:34.396
c5b5a160-a1f2-45b0-a4d5-d3e41c2b8cd3	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 09:25:34.397
a04d7178-8a55-4ba9-9677-15f1d83bc240	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Carlos"}	2026-05-27 09:25:34.399
f97c9040-5b05-473f-86c9-21903a5729b2	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 09:25:54.252
eabefe56-567f-477d-b4ee-e386be4e14dc	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 09:25:54.254
b4e100d2-32f3-410b-9c00-ab1f5abd5261	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Carlos"}	2026-05-27 09:25:54.255
0951a047-d8ad-431c-8945-d4eb81cfe3b0	7b4fd1eb-d25a-45da-ac05-59caba51649c	\N	0.50	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 09:26:04.581
7f67ce9a-b328-4b21-9378-310d19fede0e	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.25	EARNING	{"service":"Mensaje recibido","clientName":"Carlos"}	2026-05-27 09:26:04.582
dfa9dd33-085e-4a52-9006-de038c410859	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.25	EARNING	{"service":"Comisión mensaje","clientName":"Carlos"}	2026-05-27 09:26:04.583
a0af8c44-4a5c-4d21-8a8c-c0055fcfa173	57217e23-c622-462c-b159-124104e893d3	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 13:05:21.107
e287865b-51f8-49f3-836d-5de7f07d3268	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Darwin"}	2026-05-27 13:05:21.109
57351198-a977-4cad-ae92-eea339ffbe0e	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:36:08.723
72d745e4-5098-4acf-9e88-8cb10bd0dab4	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:36:08.726
d9d27f10-738b-45e1-80c8-a89613bcee7d	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:36:42.815
548f5585-8b51-464d-b0e2-6ca0f2d2fb2b	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:36:42.817
f2c3f761-6812-4f15-aa26-746b2a622301	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:37:04.922
334816c7-146b-4bd6-b4ec-6d6178f05171	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:37:04.924
5d4d21ac-031e-4fe6-b4cd-a0cffa337a02	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:37:11.744
ad37430e-0da4-418d-a282-b3fcd603eb2a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:37:11.746
84247486-156c-489a-a4bf-ede290b12497	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:37:31.859
c23e9148-1eef-4dbf-ab97-896d85d93d3a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:37:31.861
19592df6-856f-4b81-81fc-58f4257f921f	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:37:35.916
9d847914-3e36-4030-9ae5-ce9c6f959cf5	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:37:35.917
59779602-639c-401a-9424-5c608ef8cc43	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:38:29.691
1f3df752-4f09-48d1-aa05-469c4cee7eab	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:38:29.692
347b3036-288a-470e-955c-17145ea7c14a	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:39:19.601
1ee5df0d-2bed-4335-82b3-5062103d966e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:39:19.603
e48a46c2-121c-4326-ae5e-d4b2792202fa	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:39:39.625
36b6a370-6224-431e-b723-cbb91b95db2a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:39:39.627
98bc2107-a9b2-4779-b88e-a250ccaa730f	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:39:43.609
8077ca3b-42ef-4d7c-9128-e80915174ff3	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:39:43.61
9d7c4fc6-7894-4069-948f-1e0f38d7379d	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:40:44.152
33d0333b-94e8-455e-8932-18e91183d359	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:40:44.153
d7bcf268-22df-4cd8-8279-db881b66a7d4	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:40:56.064
117e55f3-4ea1-4717-8424-454237ce200b	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:40:56.066
f42a8ad5-623d-4b11-905c-8c89c4d4afd5	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:41:07.631
45d22023-a29d-446e-8611-fe464b4a5b2f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:41:07.632
bd13df05-c7dc-4930-b401-dd71dd39e186	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:41:17.911
1a4f9be6-71e7-445f-aed4-27717a039a0c	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:41:17.912
1bafa8d4-bb56-409f-9d03-6b6d99e1e098	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:41:35.883
bda61e5b-15b5-433d-8cf3-58171dc98e2f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:41:35.884
6af2de27-e90f-4c0c-8692-832cc868b13e	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:42:23.791
e1350402-fba3-4ac9-b66f-b32c1b5a31a1	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:42:23.793
e892bdf7-ac49-4eab-90e2-9a046f647e63	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:42:32.891
6a4b6329-8afe-4dfd-b5cb-749a53ee8fd9	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:42:32.892
ccbd12dc-2bff-4f2f-82f5-33a23f5de836	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:42:36.962
7e189f5b-b010-43d8-90ea-042ce0cc8da5	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:42:36.963
20f56e5a-e00f-4612-ba97-9e67fff939dd	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:43:38.261
20f8f290-6b0b-48c7-a976-cc436c4b086e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:43:38.262
da1edfdc-bfb0-47bb-89a4-40564bd966bf	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:43:41.203
c001a0f6-93be-4941-8299-657079feca3f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:43:41.204
bbb53cf0-dfd6-42e1-9a19-b384cc0b9f13	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:44:58.243
95eab7db-7d84-4c10-9aa8-c9b04f447b95	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:44:58.245
536a611f-85f3-4576-9f28-948c82816180	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:45:13.087
e3347e77-4c40-448b-b0f5-14d2b3da9210	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:45:13.088
5ef49406-b528-4499-9756-705c1ba85dfa	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:46:10.168
ee484ba7-c79e-4f94-957e-1b25005c93ea	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:46:10.169
bff7ae00-a52e-4ad8-9aa6-8ae4640021c2	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:47:24.038
fe186802-22ab-4a2e-a9b5-90df3c34c408	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:47:24.04
1cf3c535-02fd-4066-867d-018fa0ca5502	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:48:33.077
3bfaadcd-ac5d-4f6c-a598-c919fc5da453	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:48:33.079
6edbaf23-1d59-4005-9b94-62787b2250e8	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:48:41.696
9aef5641-1b48-4efb-9357-76208103acf0	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:48:41.697
be5d40be-3e76-46ca-b01e-7a053d3ae434	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-27 19:53:07.006
f1b8a3a3-768f-44cc-a3ee-781bbdb86b20	61afee71-c9c7-4aee-8504-9283cb18e738	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-27 19:53:07.008
1e7ad7d8-52e0-4070-b9f9-5e96c3d68202	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:12:04.517
e5a417e8-dfd3-4a53-b0a9-f6b653487d9a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:12:04.522
36c3a5d0-d108-4f9c-81ca-7e5265e80804	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:12:39.935
9ed1e381-914e-45f4-9be1-053c4e9bf9de	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:12:39.936
1ade21de-ada2-463e-807d-387348347530	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:13:02.654
ef2f1c08-fbfc-4a89-975d-f5ac535ba48d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:13:02.655
bcc4bfea-59f6-402e-bf0c-07584298349f	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:13:53.938
c6a82dff-b11e-4f12-be5c-9a04148023fd	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:13:53.939
93d7796b-70b6-4aba-8020-e881564963c5	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:14:22.215
b64fdb5f-72fe-4b34-bb1b-8e213cf88d7d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:14:22.216
c487bb27-0388-4433-8635-9cd19f6c30f3	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:15:54.679
5cce4e76-2633-47b0-8c37-5eaf56af3840	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:15:54.68
df7435f8-2cc0-4877-9322-5075962c92a4	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:16:36.899
1c191846-7920-4fd1-a2ed-dc4584cbe6e9	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:16:36.901
8e05cc32-382e-466b-9c4e-2722c3a96ad4	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:16:46.591
39233052-3d7e-4a10-bcdc-7fa476db6881	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:16:46.591
c4382b82-1da7-4772-8567-d190b6d7187c	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:17:17.055
25ef1672-3ca6-40cf-af65-3b8d63a6b4a4	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:17:17.056
54feb414-2b7d-4a2e-9a36-745dc21f4898	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:17:23.279
439c17ea-23a2-4e81-9d5c-f577ccc3cede	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:17:23.28
414bd241-5594-4b2a-a4e3-2cdaa9061fa2	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:18:10.275
83c9ac14-b0ec-4107-b795-859a6c8e39b0	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:18:10.276
89748110-71d1-4ef6-b993-69b57262fce4	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:18:20.363
c4aba76f-c136-475b-aa69-3ef9b0c8a968	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:18:20.365
05aaba23-f0da-481a-afc7-6bba4b7ab18a	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:18:28.989
aeaf40b7-da50-4f5e-9d55-91d7843bab07	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:18:28.99
3499983c-ef7e-4ef8-819a-fbfcfe806099	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:18:50.362
ffb6aabe-539f-442f-831b-82460ff3831a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:18:50.363
826e6fd3-f5dd-4c24-906d-83bbbdbdb661	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:19:11.419
d0c7807b-1a20-460e-9e0b-36491ec7b693	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:19:11.42
1c0661b3-a31e-444b-8287-99b6055aeff6	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:19:25.643
98d51b0b-d7df-407b-b72f-8364d0d6968d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:19:25.644
0d6c175a-b207-46c8-9508-22d4d33786c9	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:19:37.315
f1d89dea-6003-40b9-99bb-b6c3f194f866	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:19:37.316
c50666ba-781e-414b-bf5b-ef0bf78f8c59	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:19:55.832
1bb32dd3-ed3f-4072-bbc2-1c4c81c031b3	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:19:55.835
38ae0720-c30a-450e-9117-627abd893790	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 01:22:25.988
8d519bc7-bedb-4d22-bf9c-ef2cfef11dda	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 01:22:25.99
2005947f-8a3d-4f23-9017-e33ce1dda368	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 03:51:01.643
5ecd8af8-38db-4408-b897-dbc765abebd5	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 03:51:01.648
c1535440-7384-4475-8d17-f8801032a50d	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 03:52:50.155
45cd17aa-2321-4871-9cca-0e8538d5586f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 03:52:50.156
8a26aacd-2338-4e3b-b52c-2299c76b18cd	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 03:53:56.687
1273ca60-e15f-470b-8767-e70aed7f1fe7	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 03:53:56.689
a8391c66-1510-4b28-be85-d65d45340eae	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 03:53:59.184
490b03ba-e7cd-4beb-852a-6b1c573d0cbf	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 03:53:59.185
54f721bd-0d4e-4c93-803d-285d657c5828	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 03:56:19.719
5ac4409d-f4f2-43e1-b833-50baf50bd92e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 03:56:19.722
7b85e527-6612-49ac-9b87-09d5fd33d1ea	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 04:06:19.651
4c71433e-4686-4a55-b595-e40e4adedfbc	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 04:06:19.653
e1011c89-b1a1-4393-bec8-ddec9b356a86	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 04:06:25.46
3fdf3470-f1d4-43cb-ba0c-490860e82d98	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 04:06:25.461
584a2e43-49a5-40da-a462-c8a7024ce79a	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 04:11:33.576
0c818a75-1014-47b2-a308-51b307d06add	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 04:11:33.577
05b87f41-02c6-4679-a025-b2e36e4cca12	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 04:11:47.263
af51d6c5-0060-47ed-adef-2fb6cbe46753	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 04:11:47.265
174eedc5-d4ed-4008-8a1b-d3141b4d9799	6da4826d-7bf6-4478-93c8-4a16ce88ae12	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-28 04:15:43.396
b1297f51-696f-43a6-8b7e-5fdeb602510e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Antoni Tuanama"}	2026-05-28 04:15:43.397
9dcdd552-d18a-44ba-be1c-985a21e8bcca	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-29 19:20:32.281
b961c5ff-f099-47cb-ace0-3106b2dd0ee8	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-29 19:20:32.285
529b5eab-12c2-4255-acdc-c0bb5a00e623	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-29 19:22:39.157
4782cb60-0e01-4b89-8674-c64ca2167df6	78c1e70c-69c7-4888-825b-4a2283697e00	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-29 19:22:39.159
8c5d38c2-a80f-4160-8a11-54c172dbb2f8	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:36:21.852
30de413c-51ca-48e0-a291-c0eafea759aa	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:36:21.854
f87d1c07-aebc-4148-a056-714bcd329b5e	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:36:24.25
2277967b-9176-4caa-943f-61f7dc0c0d01	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:36:24.252
97300188-2b7a-4935-beb4-0b14bae22b6c	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:37:39.223
6f41f534-c6ed-4d5c-9632-e3866ac534a1	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:37:39.224
e6b3c272-ad95-4237-8149-8aba7c678e2a	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:38:27.072
1e357e4c-4b32-4ec2-8c61-acfdad812f16	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:38:27.075
13e878f4-0a15-41d3-bcc7-f8a86879fc72	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:39:17.29
b8abc3ae-7c8d-46fd-a562-19d42e99e84d	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:39:17.291
b365ae52-03aa-4b84-a339-52cda50ab843	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:39:30.679
6003c42e-ce7a-4212-8e5f-fbe523289acb	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:39:30.68
491a33a9-0b7d-47cd-8296-9590bb0e9326	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:43:11.488
fef77202-875d-40cd-acd5-55f4c71548da	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:43:11.49
722ba38d-50e5-46ca-9f3e-439516edeb3e	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:49:39.373
f15dbc3a-c9cf-4997-8ab2-3dc78d35ab62	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:49:39.375
6df7c8e8-d08d-4449-a244-4e8b66afc97c	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:50:10.902
bab976bd-4295-4230-927a-69e700336b5f	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:50:10.903
03b7392a-2bda-4915-8a93-63056bb88ae3	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:50:25.479
ed28568a-4245-4955-96ad-6505f69b7183	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:50:25.48
513d267b-97b1-408c-837c-d6b96f73f355	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:51:01.064
a7fea8a0-da23-407f-8707-81a9ae5e4453	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:51:01.065
68d912df-fbd5-450e-8a87-de4218d0ac05	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:51:03.18
29603639-91ab-4b56-8477-7012b6956ef6	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:51:03.181
ad894683-4999-4a32-82b7-1dd011bcdb32	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:52:19.492
79481c6a-e2f4-409f-a698-a80fad23c49a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:52:19.494
0b1cfec6-37b3-4d99-bb44-fe38552b55eb	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:52:23.177
a4b82ee5-d951-4881-8210-e09f3650b9cd	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:52:23.178
8734782e-7a91-457a-b02f-ba8bcbc01c6e	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:56:00.992
e3afe71c-a26d-46b2-9255-0d28fd3d0417	78c1e70c-69c7-4888-825b-4a2283697e00	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:56:00.994
a84f1243-66b9-4a43-973c-a9fe833f116f	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 00:59:19.318
e5e292bf-bf23-491e-a062-c4d17d06aa88	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 00:59:19.321
6dce8050-c7fe-4456-a245-fd211a3f4a1e	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 10:38:24.888
35683601-29bb-4b8f-8a84-a6bcb0ebee74	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 10:38:24.891
e9f8cdd7-5dc5-4fb2-8213-66f7c6c8c64a	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 10:38:27.305
929f42b3-4de8-43eb-851f-d902ede6bfc4	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 10:38:27.306
bf702f10-b18d-455b-a2c6-a5a537c05c81	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 10:38:47.027
4cdfb599-bba0-4c43-8578-2d2eabdc6d13	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 10:38:47.03
d1a941f7-c188-4250-8865-02f7152dd7be	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 10:39:07.367
6eb2a337-5d7c-4b4b-879d-f82d869d2fd3	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 10:39:07.368
0174a0ea-68bd-4dad-9e49-4429cdf995bf	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 10:39:56.136
de5db6cc-a452-4517-8ba4-2c9d0ff5bf37	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 10:39:56.138
f87931c3-599b-4f98-a6f7-0ba9cf858f82	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 10:42:40.644
07ed3cd8-a2e4-412d-9722-0d69ecd43caa	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 10:42:40.645
b463f754-9153-4655-b4da-aeffd9e0e972	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 10:43:06.831
c71ae743-72d5-4455-a56b-ccc05046f933	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 10:43:06.832
21f1c92f-3644-4255-9187-67bde0f7aee6	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 10:44:00.027
3fa678b8-8aed-4596-a616-775567c41c6a	d6fc81a9-9805-483b-b305-f7e7c7ac613a	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 10:44:00.036
0d6e3649-d8c3-48ea-8049-069c882e5ff6	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 10:53:15.619
aa6f890f-a329-4a1d-afd7-166e74f4922d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 10:53:15.621
0da56f69-a4ea-47e3-b132-d8172aa9bdaa	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 10:53:30.154
9ca99167-b94b-4793-b22e-26587cf95ce8	d6fc81a9-9805-483b-b305-f7e7c7ac613a	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 10:53:30.156
3c422b13-e1ef-4269-a320-b44568917d1e	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-30 17:36:46.708
f7d79248-44df-41b8-a895-6c5fd539d53f	d6fc81a9-9805-483b-b305-f7e7c7ac613a	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-05-30 17:36:46.712
57aad369-9f57-4f93-beb3-6ab2123bc6bc	46828d1e-e9b7-4d62-a925-de185db5beed	b611dac2-1328-45e0-93f6-09f112d01853	10.00	DEPOSIT	Recarga Flow: 10 creditos - Paquete inicial 	2026-05-30 22:57:49.029
97d6905a-cda4-4c8b-be84-9671bd091e68	46828d1e-e9b7-4d62-a925-de185db5beed	\N	1.00	CALL_PAYMENT	Video llamada · 1 min	2026-05-30 23:00:12.18
d0fae70c-4236-4126-9e9c-9e90414e67f2	153edde1-3570-41ec-ac7a-cac818a6dd63	\N	0.50	EARNING	{"service":"Video llamada","minutes":1}	2026-05-30 23:00:12.181
82c2939c-33c2-43c5-a47c-21c0f1d932c3	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-05-30 23:00:12.182
18d3c8e8-e1e3-4bda-9326-d6fa921c7555	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:34:03.206
41e8f0d5-21bf-4ee3-9462-fa8b3d3d2f53	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:34:03.208
357120a7-b424-4b0f-8704-7e929ecc4bbf	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:35:45.692
825c0051-4c08-4e0f-a904-106f81b9589c	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:35:45.693
6b2e92fa-d7b2-41bf-afb5-30dd1ef7c2a3	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:36:09.605
9deec4ed-35c7-4ad3-933f-ce6b0e108a9a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:36:09.607
6050a2a3-dd09-4afb-aa2f-e8e20bd00278	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:40:26.564
f98a12f2-a04c-43d6-adf8-033122dadd6d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:40:26.566
80c1ff09-2418-4538-8746-a97a9bade574	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:40:32.324
074246ef-7080-49b0-9fe3-568019c33f5d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:40:32.326
a10d2d22-940c-4bc7-b4ee-b47fcf541bbc	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:40:58.848
0a4f1959-ac7b-48b8-acdb-ba1f900b6930	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:40:58.849
0a4ec25c-6d9e-4336-8616-9f5c038e08c0	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:41:08.843
fc9fa112-1084-43fc-9281-f65beccb846f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:41:08.845
2026336f-acea-4155-a5d9-3cdddf10710e	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:41:22.29
34eb2489-9422-4039-bab9-9d11e32f8f7a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:41:22.292
b52ad163-22be-4b20-a2a6-a1e02b640b17	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:41:28.96
21d8e819-841c-4b9f-a7bb-2acb780996e7	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:41:28.961
397c16e8-36ef-4e2e-9ec4-5a63bb0e5305	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:41:35.655
bcc64352-53af-4e83-9a5c-bec55ab6e55c	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:41:35.655
dcb6a5e6-99d1-4fce-9801-f405f73823a4	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:41:43.505
88d446bc-3862-46e5-be66-eff117ad97a4	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:41:43.506
f2145911-dca7-435e-a279-26ef4fabad0f	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:41:54.209
1bae2c9f-b97b-4e6c-bcff-ff9efce18ffb	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:41:54.21
c565a1e2-a0e8-4090-b3e5-6db4c5904532	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:42:01.53
d67c03c3-4586-4523-a259-dce0602eee3e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:42:01.532
2e118b0d-0738-4d6b-933b-8af94628d8c3	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:48:47.35
11811195-bcaa-4500-bc49-23262fb7ac05	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:48:47.353
1a2bd68f-fb0e-4ee3-ae55-092cb7f534f6	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:49:16.617
144021d0-c489-44ae-8fcf-4ee3bbedb52e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:49:16.618
6461cb75-9f38-45c3-a99f-ae04d6dbade1	f36ee4d2-d7db-47ed-9271-29682696b8c7	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-05-31 04:49:48.956
100a8a53-ec0f-4a21-bfd6-0aba400e74ed	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Junior"}	2026-05-31 04:49:48.957
25ea9cb3-3a8f-4aa6-a94e-b5c9f942e8ab	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-01 17:33:14.643
5e6d9ed0-31c3-499e-81b8-ef61ac4e4a88	d6fc81a9-9805-483b-b305-f7e7c7ac613a	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-06-01 17:33:14.646
53288516-474a-4fb8-9a74-374533f01915	d76a4120-edf5-4759-9fc6-16c9b2a6a02c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-01 17:33:25.498
1f6fe1ed-cf46-47c3-b121-eca3ca5753bb	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Trigozo"}	2026-06-01 17:33:25.499
593bd5c6-aa47-4833-aff6-0280f0b5102e	debbceb6-c52f-47de-9ca1-01ff234aabc4	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-07 11:49:33.183
f99b56f0-c089-4290-9166-278e9961ca51	78c1e70c-69c7-4888-825b-4a2283697e00	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Franklin ticliahuanca"}	2026-06-07 11:49:33.188
08828460-4472-4ed6-a1a3-2072935581a7	debbceb6-c52f-47de-9ca1-01ff234aabc4	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-07 11:49:39.293
6b031483-5725-41e0-a419-c22d9e3e4265	78c1e70c-69c7-4888-825b-4a2283697e00	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Franklin ticliahuanca"}	2026-06-07 11:49:39.295
0a0ac28e-eb61-4678-9e8b-a76fdbade766	6cfbec0b-5c31-41ac-90fd-b7187a54c395	\N	3.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-06-18 03:23:46.336
644f9c9f-ffe5-4299-b332-f8becee7f104	370113b5-f9c5-497f-8977-5190daa99e50	\N	1.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-06-18 03:23:46.825
9eecef06-e2cb-490e-8f45-3938e8cfa05c	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-06-18 03:23:47.307
0e52dde6-2f16-4fc8-9cbf-333cf2f8cce4	6cfbec0b-5c31-41ac-90fd-b7187a54c395	\N	4.00	CALL_PAYMENT	Video llamada · 1 min	2026-06-18 03:24:15.571
04917cf2-6c94-472f-8dd2-b39e39da4ae5	370113b5-f9c5-497f-8977-5190daa99e50	\N	2.00	EARNING	{"service":"Video llamada","minutes":1}	2026-06-18 03:24:16.073
976489a9-cb6a-43a2-8fad-ade41153da01	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-06-18 03:24:16.571
e06927f1-62a5-4480-ad88-26a79d9f849b	6cfbec0b-5c31-41ac-90fd-b7187a54c395	\N	3.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-06-18 03:25:46.21
3db2fa73-e741-477b-8fd3-ef6e59024896	370113b5-f9c5-497f-8977-5190daa99e50	\N	1.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-06-18 03:25:46.723
ebfa5d09-226a-4027-8f70-d0283c96e17f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-06-18 03:25:47.233
b8997978-a9bf-463b-b4ac-f039c5a6df8b	6cfbec0b-5c31-41ac-90fd-b7187a54c395	\N	3.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-06-18 03:26:28.129
97948d06-cc22-42f0-b3c8-c92156e41706	370113b5-f9c5-497f-8977-5190daa99e50	\N	1.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-06-18 03:26:28.623
35512cb1-ab36-4fe8-b5a2-b231fd4696e7	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-06-18 03:26:29.116
f16d9ae7-d4d9-4676-97ae-1fab7b58fc68	6cfbec0b-5c31-41ac-90fd-b7187a54c395	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-18 03:27:26.143
1dc9bdd2-707d-4064-841b-428c9f19dffd	370113b5-f9c5-497f-8977-5190daa99e50	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhoel P"}	2026-06-18 03:27:26.629
0a81a021-f674-4451-ad2c-874d34a673b4	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhoel P"}	2026-06-18 03:27:27.115
c90976e6-3a71-49f0-9d42-babf0119eeb0	6cfbec0b-5c31-41ac-90fd-b7187a54c395	\N	3.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-06-18 03:28:18.891
e65e6534-4b64-438d-a00a-8ec3c50cdaa5	370113b5-f9c5-497f-8977-5190daa99e50	\N	1.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-06-18 03:28:19.375
7e03debe-5cdd-40b6-ba52-a3c1aa7e8768	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-06-18 03:28:19.859
9b5dbcc1-2d65-4ca6-9233-6ea434d044dd	6cfbec0b-5c31-41ac-90fd-b7187a54c395	\N	3.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-06-19 00:14:21.454
4b13e2d6-f2d5-4b55-a7e9-c51f1aa24dc8	370113b5-f9c5-497f-8977-5190daa99e50	\N	1.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-06-19 00:14:21.457
ae06f041-4ae4-4578-91b8-5c0123a3f25c	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-06-19 00:14:21.459
6d19879d-a755-4547-a0f6-96422343c438	6cfbec0b-5c31-41ac-90fd-b7187a54c395	\N	4.00	CALL_PAYMENT	Video llamada · 1 min	2026-06-19 00:15:11.992
f9af661a-1dbc-4ef3-ae4e-8b94b38ae5a2	370113b5-f9c5-497f-8977-5190daa99e50	\N	2.00	EARNING	{"service":"Video llamada","minutes":1}	2026-06-19 00:15:11.994
96f83160-3dbd-4822-99ad-c37f9b4ad07c	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-06-19 00:15:11.995
8c2b10e6-a84b-4ea9-a063-e464aa0aaa46	6cfbec0b-5c31-41ac-90fd-b7187a54c395	\N	4.00	CALL_PAYMENT	Video llamada · 1 min	2026-06-19 00:15:45.832
9e1908cc-4871-4194-ba1d-fcc0c686c310	370113b5-f9c5-497f-8977-5190daa99e50	\N	2.00	EARNING	{"service":"Video llamada","minutes":1}	2026-06-19 00:15:45.834
bbd2f3c9-0f6b-43e2-9e67-cd8657133bea	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-06-19 00:15:45.835
b472e8d8-f3f2-4e5e-bb41-91694efb18f3	6cfbec0b-5c31-41ac-90fd-b7187a54c395	\N	4.00	CALL_PAYMENT	Video llamada · 1 min	2026-06-19 00:16:02.391
54801147-b42e-40d2-938d-27b7399f8b43	370113b5-f9c5-497f-8977-5190daa99e50	\N	2.00	EARNING	{"service":"Video llamada","minutes":1}	2026-06-19 00:16:02.392
c631d759-4a19-4e33-9cdb-ad08d5c66e7e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-06-19 00:16:02.393
880e81f7-73bf-43b5-a6cb-a9333350b64d	6cfbec0b-5c31-41ac-90fd-b7187a54c395	\N	4.00	CALL_PAYMENT	Video llamada · 1 min	2026-06-19 00:16:36.733
4347e0d4-d2d9-428b-ac18-50efe1cc309c	370113b5-f9c5-497f-8977-5190daa99e50	\N	2.00	EARNING	{"service":"Video llamada","minutes":1}	2026-06-19 00:16:36.735
dd6ce6d6-e83b-49b6-acad-d237763a8bc2	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-06-19 00:16:36.735
0a1e487f-6ca1-47d4-b62b-d60e09f4258d	14a1a6cb-fa62-494a-9b09-0747af11b118	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-20 05:18:11.909
03da50bb-be69-47e7-855e-01f3b14f5b10	d6fc81a9-9805-483b-b305-f7e7c7ac613a	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Angel Mendoza alejos"}	2026-06-20 05:18:11.914
275c5c7e-1407-4298-bb45-7b76b753118b	73346749-a989-45dd-8cbd-d35c40ea850f	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-21 20:22:01.885
1e29e2f8-4d6d-48e0-81c0-a0ed66fcdf8a	d6fc81a9-9805-483b-b305-f7e7c7ac613a	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Tonny Melendez"}	2026-06-21 20:22:01.888
299fa836-25c8-487d-aeab-f91f925bbe7c	73346749-a989-45dd-8cbd-d35c40ea850f	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-21 20:26:04.876
20415909-190c-492c-8444-d42032b48753	0f662fd9-a2c3-4b35-9059-426730ed8778	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Tonny Melendez"}	2026-06-21 20:26:04.878
91d1a743-b91c-43f7-aeb2-bc4e6ef9c920	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Tonny Melendez"}	2026-06-21 20:26:04.879
a3b5a633-2b43-478d-9f43-b52ee0a4342d	d1c75dab-c26f-48c6-b72f-ca56ab8e5800	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-22 07:59:00.422
45a0ae3c-670c-4fa8-a2db-57af15e38e60	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Kaiser Machuca"}	2026-06-22 07:59:00.428
ceae79a9-740a-49ab-afb0-6769d68f4cb8	d1c75dab-c26f-48c6-b72f-ca56ab8e5800	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-22 08:20:22.682
5044656c-4aca-4893-bc39-8e9c363d1c68	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Kaiser Machuca"}	2026-06-22 08:20:22.684
82609f3f-e52b-4b73-aa7e-9c7b1e40c2c6	d1c75dab-c26f-48c6-b72f-ca56ab8e5800	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-22 08:28:38.57
d25be9bd-950c-45dc-b4a6-567042f52d4d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Kaiser Machuca"}	2026-06-22 08:28:38.572
dc093486-d416-4aee-bb9f-860c4545f8dd	d1c75dab-c26f-48c6-b72f-ca56ab8e5800	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-22 08:29:32.174
1f225d41-540c-4c66-a82d-41ddf339e8a0	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Kaiser Machuca"}	2026-06-22 08:29:32.176
7b850379-66fb-4042-95f7-6db81835d34b	d1c75dab-c26f-48c6-b72f-ca56ab8e5800	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-22 08:30:05.774
e569e5f7-532d-4669-b1c4-7f8461ef55d1	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Kaiser Machuca"}	2026-06-22 08:30:05.776
783dc2b6-658f-4cd1-8d33-8c1e827a509c	d1c75dab-c26f-48c6-b72f-ca56ab8e5800	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-22 08:30:50.818
2183c75d-0a83-40c7-83a5-d7488873fefc	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Kaiser Machuca"}	2026-06-22 08:30:50.82
e5a23aeb-7a9a-43d5-8f2a-3ad7297c7f27	d1c75dab-c26f-48c6-b72f-ca56ab8e5800	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-22 08:32:03.829
f9fefa99-8627-4794-9a71-6ede98d58d02	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Kaiser Machuca"}	2026-06-22 08:32:03.83
45f0d071-e0a1-4295-b449-a25117941962	d1c75dab-c26f-48c6-b72f-ca56ab8e5800	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-22 08:36:04.925
4633c291-1a4b-4f65-a39b-5a8c4e7db09e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Kaiser Machuca"}	2026-06-22 08:36:04.926
d6cf94ee-3cdf-4c01-8fb1-ecf2b1b7c488	d1c75dab-c26f-48c6-b72f-ca56ab8e5800	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-22 09:00:05.358
dad1af7f-d0b6-4471-9ed1-4c31318952a3	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Kaiser Machuca"}	2026-06-22 09:00:05.36
8965f8b0-7369-4a28-a71a-dfe45093a375	d1c75dab-c26f-48c6-b72f-ca56ab8e5800	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-22 09:04:57.22
551fd285-d965-40bd-b2bf-2d485b4ef4ec	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Kaiser Machuca"}	2026-06-22 09:04:57.223
420095bf-3413-4a8b-b03b-b196a8e44b57	b10f243a-49ac-4eeb-b7fa-bbc90c8472e1	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-22 12:19:44.419
3c0433ab-66f9-4a06-ba4f-6b3b37181ba1	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Pedro"}	2026-06-22 12:19:44.423
059b8589-5c08-429f-9f1f-fdb8c7f049a8	b10f243a-49ac-4eeb-b7fa-bbc90c8472e1	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-22 12:27:26.061
a3c416d5-5d70-4c74-966c-a29122757fa6	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Pedro"}	2026-06-22 12:27:26.063
09e5afbc-c660-4bbc-9730-797c6f6b7399	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-23 10:43:06.869
9b0d2883-e3c8-468e-b7a5-3df36fc3dc5a	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-23 10:43:06.872
70e0e3d4-efcc-44a8-829f-7f9b2e482e7a	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-23 10:53:45.89
6114b291-0a03-4b8b-bf86-03f3bb748f1e	d6fc81a9-9805-483b-b305-f7e7c7ac613a	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-23 10:53:45.893
45d62142-a304-491c-9631-4feb06b8bbd1	73346749-a989-45dd-8cbd-d35c40ea850f	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-24 04:43:04.574
cedf0d18-0f8c-4ca8-bd68-45f17407816c	0f662fd9-a2c3-4b35-9059-426730ed8778	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Tonny Melendez"}	2026-06-24 04:43:04.581
0699b4a0-5383-4004-8a7f-39dae58bde4e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Tonny Melendez"}	2026-06-24 04:43:04.583
b6b311d1-5ec3-4e53-96be-788ad7c2b793	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-24 10:25:54.029
5cd5d837-b9ad-4ce8-abd7-3a7a59901eba	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-24 10:25:54.04
7d9f4304-48a6-4b64-9e09-bb8b4e652fd0	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-24 10:26:37.224
dff187ac-7515-47bd-b948-eb0f866a7fae	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-24 10:26:37.226
30d01cd1-69e0-4820-8684-9f15220e5839	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-24 10:26:39.351
59713ae8-c3ed-46b7-9db9-df48fdc1cc9d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-24 10:26:39.353
f1e6adb9-1df2-43ff-94dc-81deb3db12b9	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-24 10:27:56.197
c1e4f9d2-0f5c-48da-b3e6-30ee6c758b50	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-24 10:27:56.2
98c321e2-8164-4bee-81d6-f4124a7b0400	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-24 10:29:23.702
a2b9250e-94d4-4492-b26f-19aeab06633c	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-24 10:29:23.704
53daf3fe-4808-4241-b358-084439d114c4	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-24 10:46:51.369
38f1f6c3-7d5e-4a23-a52c-752596f278b9	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-24 10:46:51.372
ba35c4c4-18f4-41c9-a3bf-4a31f260e800	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-24 10:46:53.767
587d7169-03df-43d2-8a73-367493cde366	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-24 10:46:53.768
b98e3fbf-e96e-4821-b406-b01d43946451	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-24 10:48:06.528
7270b68f-19b0-4ac2-9510-674c6068adc9	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-24 10:48:06.53
e08284ff-ceca-43dc-b4b4-b036ccc2c213	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-24 10:48:08.508
7add0195-7ccc-481c-8247-15b6e38e51c7	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-24 10:48:08.509
4319bb9f-f283-488e-b95d-608d5ed5b508	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-24 10:49:19.084
ce5586ab-b071-4457-97bf-e134da470fa7	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-24 10:49:19.087
d9caacc9-c9ad-43d4-8fdf-0896a4910dad	08795492-f4a8-4827-8261-01d9dfa8601d	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-06-24 10:50:34.325
5ab86a84-75b8-4d1d-95e2-3fc227f88576	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"El Ppi"}	2026-06-24 10:50:34.326
8e150d5d-c15b-4a97-b339-9f8be3ecd4d4	f7285756-9a3b-4c27-9c28-e35327ce702a	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-05 02:05:21.482
4cce7f08-6312-415a-82ee-43e2e2ee08e5	d6fc81a9-9805-483b-b305-f7e7c7ac613a	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jerlicksson"}	2026-07-05 02:05:21.488
3c38e9d9-5eab-4d5e-9158-bdc0d1f86cc2	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	15.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-07-11 14:48:02.894
1ca5d110-7dca-4f00-9ae1-ea3694f3c745	b4fb8296-2a1b-49d6-ac70-8abb876e8d06	\N	7.50	EARNING	{"service":"Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 14:48:03.532
48032b95-7b34-4ffe-bb86-fea06ed060c5	925dc47b-91c6-4a44-9233-de139f77a62d	\N	7.50	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 14:48:04.117
c5d20dec-dc7b-4623-b4e2-ee227fbf7cd9	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	5.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-07-11 14:48:49.132
25b76c9a-2dc6-4411-9336-fb0656a08c38	d402737b-e875-4b00-b970-97d45bdb7308	\N	2.50	EARNING	{"service":"Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 14:48:49.566
fc141e76-57eb-429e-b185-c17a75687974	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 14:48:50
f759131a-4943-405d-866e-0d5b053aa314	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	5.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-07-11 14:48:53.978
b6c237e4-bdf2-4214-92ea-3078da245985	d402737b-e875-4b00-b970-97d45bdb7308	\N	2.50	EARNING	{"service":"Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 14:48:54.412
cca360b0-0f8d-4241-9d61-cbf7de6ab113	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 14:48:54.845
086a6a7b-3e91-43f1-9276-12b4fefe55aa	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	10.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-07-11 14:48:55.275
9e0bd868-d91f-42ba-8f51-488f7157bf17	d402737b-e875-4b00-b970-97d45bdb7308	\N	5.00	EARNING	{"service":"Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 14:48:55.717
d1c2ef76-2ea4-48ea-a3f8-857c5862a44a	925dc47b-91c6-4a44-9233-de139f77a62d	\N	5.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 14:48:56.168
4abf5e0b-a24a-4fb0-92a6-026d8c9cf072	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	5.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-07-11 14:48:56.607
5727133f-69c0-496c-b160-fbe8b08ce88d	d402737b-e875-4b00-b970-97d45bdb7308	\N	2.50	EARNING	{"service":"Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 14:48:57.061
a3cb89c2-ea23-44aa-9d0d-79fa27fe4509	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 14:48:57.506
79327936-c6ea-4049-93fc-4b24255ed5a1	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	2.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-07-11 14:48:57.959
0e2a051e-c66e-4267-b9c2-cfded9b46663	d402737b-e875-4b00-b970-97d45bdb7308	\N	1.00	EARNING	{"service":"Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 14:48:58.407
0d822e3b-f5a7-4b1b-a8e2-da4e48c9ac43	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 14:48:58.955
eb1cd1e9-88cb-43f6-b9a7-6858b92c6527	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-11 15:08:28.551
88b1770a-fe8d-4461-a8f2-848b4a290279	d402737b-e875-4b00-b970-97d45bdb7308	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-07-11 15:08:29.083
b4f992c9-ce1e-44bc-bdac-5161e8041ea7	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-07-11 15:08:29.704
383177bb-b1dc-41f5-b16c-4f5490b286a3	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-11 15:08:37.255
13412d9e-f780-4896-ac2a-d8007d923b74	d402737b-e875-4b00-b970-97d45bdb7308	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-07-11 15:08:37.848
923b890f-1163-4a23-b577-f52a63493e4b	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-07-11 15:08:38.415
7e2d9ee4-96e5-4654-93a9-25cc30ceff18	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-11 15:23:25.465
7f80f6dc-0a5f-4a68-8e7b-0f72a616d6ae	d402737b-e875-4b00-b970-97d45bdb7308	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-07-11 15:23:25.467
28499dec-6b10-43d9-a712-331ce2dfed2e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-07-11 15:23:25.468
f081b256-e267-4078-944d-cde573c3beff	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	15.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-07-11 15:25:13.746
3228979c-d028-4726-9539-efd0b88b2e4a	0f662fd9-a2c3-4b35-9059-426730ed8778	\N	7.50	EARNING	{"service":"Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 15:25:13.747
78f3e8d0-a983-4c28-b462-6feb97602bd4	925dc47b-91c6-4a44-9233-de139f77a62d	\N	7.50	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"c6c9f4d8-c7db-401d-b15f-f9509a8089a2"}	2026-07-11 15:25:13.749
edada9e5-8704-43e4-88db-16eb4096d30f	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-13 00:50:42.785
6e373064-7d08-4ec1-a12d-80e865b8269a	370113b5-f9c5-497f-8977-5190daa99e50	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-07-13 00:50:42.787
595fcee0-6cf8-4a71-aa93-90e42f7e79a7	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-07-13 00:50:42.789
5e5af192-859d-4eab-9850-ec739bab82f5	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-13 00:50:52.319
44d333d0-5912-400f-bbca-b48311ee685e	370113b5-f9c5-497f-8977-5190daa99e50	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-07-13 00:50:52.321
ccc81ecb-4148-40c6-afe5-d0cb6466778f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-07-13 00:50:52.322
d885fd21-94d3-42f7-8927-c3571f69dc54	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-13 00:51:01.17
5fb60540-befe-4051-b184-a2dc3d27dd4f	370113b5-f9c5-497f-8977-5190daa99e50	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-07-13 00:51:01.172
ff4e3906-3d25-445c-b8cf-0c3dc34bee43	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-07-13 00:51:01.173
a3b17f74-0021-4fb9-a397-12103a2d210e	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-13 00:51:21.678
51407428-2951-4ad1-b262-393a4f5c792a	370113b5-f9c5-497f-8977-5190daa99e50	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-07-13 00:51:21.679
29488fc7-b8ec-4773-94ff-10e9c7a620fb	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-07-13 00:51:21.68
55a5e895-bf5a-4005-904d-bb666acf8b98	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	3.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-07-13 01:58:10.499
5eae1a17-98ed-4efd-971e-20a5c8d3332c	370113b5-f9c5-497f-8977-5190daa99e50	\N	1.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-07-13 01:58:10.942
2f7dbb64-a7bf-463e-a2fe-8601ea5861b2	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-07-13 01:58:11.389
ac1fd102-75bd-42df-88dd-4a57f840a0e1	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	4.00	CALL_PAYMENT	Video llamada · 1 min	2026-07-13 01:59:23.56
b792114e-8cff-487a-9720-15ca3daeda31	370113b5-f9c5-497f-8977-5190daa99e50	\N	2.00	EARNING	{"service":"Video llamada","minutes":1}	2026-07-13 01:59:23.987
6898cd5c-99fe-4e69-a024-8b31a00db9c7	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-07-13 01:59:24.416
178d0c29-8244-440f-9f2a-59a199b9d7ef	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	3.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-07-13 02:03:19.693
0feb2f28-49eb-4429-8d15-f00e6e458a43	370113b5-f9c5-497f-8977-5190daa99e50	\N	1.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-07-13 02:03:19.694
d960fdda-1cac-4cda-a867-942a21adee1c	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-07-13 02:03:19.695
9dc5baf2-9539-4e6b-87d6-f02ee9027002	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	4.00	CALL_PAYMENT	Video llamada · 1 min	2026-07-13 02:04:17.548
ca7a554e-5355-4844-83d8-46c00cb158a4	370113b5-f9c5-497f-8977-5190daa99e50	\N	2.00	EARNING	{"service":"Video llamada","minutes":1}	2026-07-13 02:04:17.55
e0dc46f0-3a6f-4d12-bb76-cabf9e0b0450	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-07-13 02:04:17.551
263d1323-5b90-4ab8-996c-3acf06db8cb8	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	3.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-07-13 02:29:38.473
1226423a-3c83-459b-82f4-5cd98ef8c876	370113b5-f9c5-497f-8977-5190daa99e50	\N	1.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-07-13 02:29:38.476
45d7fcb5-efa9-411a-b603-336353924363	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-07-13 02:29:38.478
e12873af-6efd-46c0-b2c9-cd67f0430227	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-13 02:30:11.496
67cc33e8-7ba0-4e1f-acce-003400de51e9	370113b5-f9c5-497f-8977-5190daa99e50	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-07-13 02:30:11.498
75d376c8-99a4-43d0-b508-8b18f5ad7cf8	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-07-13 02:30:11.499
8298f1ee-0def-4075-976a-af4188ce9717	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-13 02:30:15.136
9be91668-6cba-43a1-8421-27a567e438e3	370113b5-f9c5-497f-8977-5190daa99e50	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-07-13 02:30:15.137
680edd1a-1855-4ab3-a024-d0322ab9609b	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-07-13 02:30:15.138
af199856-e85e-4f33-a719-36e4a9578e22	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	3.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-07-13 02:36:57.769
b6db420f-01b6-41d7-8931-edeb4039ca6b	370113b5-f9c5-497f-8977-5190daa99e50	\N	1.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-07-13 02:36:57.771
b3b0cea5-8316-4df3-a125-a419e5fe6029	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-07-13 02:36:57.772
0866f1d2-5d38-4db0-a438-7f552079168e	d402737b-e875-4b00-b970-97d45bdb7308	\N	500.00	EARNING	Ajuste manual: abono de 500 creditos	2026-07-13 22:36:59.049
4508f044-d882-40a1-bb66-23d86159558b	d402737b-e875-4b00-b970-97d45bdb7308	\N	200.00	WITHDRAWAL	{"reason":"Solicitud de retiro"}	2026-07-13 22:43:10.115
4fb49946-8196-431c-b80a-289882825870	fa39581d-8edf-471f-8eab-5b13ff902474	\N	8.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-07-14 00:37:54.933
da9c90ab-9d2e-42c6-8442-3458cb30ba6f	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	4.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-07-14 00:37:54.935
101c36d7-d948-4d01-868b-8a7df1b24492	925dc47b-91c6-4a44-9233-de139f77a62d	\N	4.00	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-07-14 00:37:54.938
e8a4e235-15dd-41f2-934e-b7646c859f69	fa39581d-8edf-471f-8eab-5b13ff902474	\N	18.00	CALL_PAYMENT	Video llamada · 2 min	2026-07-14 00:40:09.826
1581cc37-02b4-4051-877e-bf639554846d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	9.00	EARNING	{"service":"Video llamada","minutes":2}	2026-07-14 00:40:09.828
cfcadbcc-b1c6-45d8-bdf3-99866d4b4926	925dc47b-91c6-4a44-9233-de139f77a62d	\N	9.00	EARNING	{"service":"Comisión Video llamada","minutes":2}	2026-07-14 00:40:09.829
79c88223-4879-4d4f-ad61-4435718e5b93	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	500.00	DEPOSIT	Ajuste manual: abono de 500 creditos	2026-07-14 04:26:28.255
a656dcf7-486f-44a3-9b2f-2caf88710ae9	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-14 04:26:51.161
013fb7a6-7ff9-41f1-804d-7463f30b7811	d402737b-e875-4b00-b970-97d45bdb7308	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Juanito Lopes Arazaka"}	2026-07-14 04:26:51.608
ee056f9f-466f-4995-8474-047d5c6bcc4e	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Juanito Lopes Arazaka"}	2026-07-14 04:26:52.052
77cb6228-580f-4e1e-8edb-111c7d94cec5	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-14 04:27:35.499
993435d8-648e-496f-a596-0e53d922391f	d402737b-e875-4b00-b970-97d45bdb7308	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Juanito Lopes Arazaka"}	2026-07-14 04:27:35.94
a0457132-0ae4-4083-adbe-bd978f296e97	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Juanito Lopes Arazaka"}	2026-07-14 04:27:36.381
02713653-e1a7-4597-ad8f-999231ea64ce	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-14 04:42:49.629
9805945a-6330-42d3-91ca-443a4d0ab2a2	d402737b-e875-4b00-b970-97d45bdb7308	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Juanito Lopes Arazaka"}	2026-07-14 04:42:49.632
4e3d6a27-980b-4214-99bc-d1d213289219	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Juanito Lopes Arazaka"}	2026-07-14 04:42:49.633
988059d1-c07f-4b6a-988c-bbbe37e2ff05	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-14 04:44:10.505
1b67227e-4656-49ad-a9c0-7ea4038b420e	d402737b-e875-4b00-b970-97d45bdb7308	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Juanito Lopes Arazaka"}	2026-07-14 04:44:10.507
24c6f756-6106-49fb-8873-6516dcb6c16d	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Juanito Lopes Arazaka"}	2026-07-14 04:44:10.508
e6a27ece-625f-4be9-a281-c3a0f085b68f	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-14 04:45:56.149
2deaeb5e-c18a-4268-8ce5-ac8d368c5170	d402737b-e875-4b00-b970-97d45bdb7308	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Juanito Lopes Arazaka"}	2026-07-14 04:45:56.152
6a7389c2-4343-44bd-b8f3-c1a8f91286f4	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Juanito Lopes Arazaka"}	2026-07-14 04:45:56.153
99a8b25e-a447-4de0-9bcb-fb1391cc554b	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	12.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-07-14 04:48:55.886
e6a79579-2473-45ff-b693-4375cc88f955	d402737b-e875-4b00-b970-97d45bdb7308	\N	6.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-07-14 04:48:55.889
3c3a85b9-bf3a-4117-88d4-c68f55a2660f	925dc47b-91c6-4a44-9233-de139f77a62d	\N	6.00	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-07-14 04:48:55.89
f2974a61-0563-44c0-83ce-2b66ea0a5c3d	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	12.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-07-14 04:58:51.218
20172cdd-d171-43e3-b20d-e56a4eb54da9	d402737b-e875-4b00-b970-97d45bdb7308	\N	6.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-07-14 04:58:51.223
c91a787b-41ab-4db1-b43a-5c69abe59091	925dc47b-91c6-4a44-9233-de139f77a62d	\N	6.00	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-07-14 04:58:51.226
8c0363b1-4d99-492c-b5e1-6546cc8d2bf6	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	12.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-07-14 04:59:20.108
8587d911-33f6-4b63-9f15-4cb63514d478	d402737b-e875-4b00-b970-97d45bdb7308	\N	6.00	EARNING	{"service":"Llamada de voz","minutes":1}	2026-07-14 04:59:20.11
e9a4ef25-5b68-4b6c-868f-2bcdc184f064	925dc47b-91c6-4a44-9233-de139f77a62d	\N	6.00	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-07-14 04:59:20.111
52525226-e41b-464b-aa30-06f30fca7124	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	5.00	CALL_PAYMENT	Video llamada · 1 min	2026-07-14 05:00:16.699
47f8ced8-af64-4c09-816b-3178e398ddd8	d402737b-e875-4b00-b970-97d45bdb7308	\N	2.50	EARNING	{"service":"Video llamada","minutes":1}	2026-07-14 05:00:16.7
d5520db5-7447-465a-8791-b7e56970ea52	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.50	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-07-14 05:00:16.701
b0214e08-6cdb-46cd-8ded-bc95797f6ccf	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	2.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-14 05:12:17.145
a71af8f0-b072-4df4-acb7-ab976cd53c77	d402737b-e875-4b00-b970-97d45bdb7308	\N	1.00	EARNING	{"service":"Mensaje recibido","clientName":"Juanito Lopes Arazaka"}	2026-07-14 05:12:17.147
87a09723-8a0f-440f-926f-31360e407af4	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.00	EARNING	{"service":"Comisión mensaje","clientName":"Juanito Lopes Arazaka"}	2026-07-14 05:12:17.149
d01a0088-60f3-4ac9-887a-5cb333a55744	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	15.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-07-14 05:19:00.799
ccc22d3b-b975-4821-8218-d224818796c5	b4fb8296-2a1b-49d6-ac70-8abb876e8d06	\N	7.50	EARNING	{"service":"Imagen Premium","clientUserId":"4215b759-9065-4de2-8d20-6397fffac991"}	2026-07-14 05:19:00.803
4e8afdec-c148-4b34-8461-a389b12176f0	925dc47b-91c6-4a44-9233-de139f77a62d	\N	7.50	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"4215b759-9065-4de2-8d20-6397fffac991"}	2026-07-14 05:19:00.804
78b8c86b-e998-49b9-9cef-5cdbfea698c3	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	15.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-07-14 05:19:23.704
3129afba-bf95-4f69-b2aa-aed13a941cf3	0f662fd9-a2c3-4b35-9059-426730ed8778	\N	7.50	EARNING	{"service":"Imagen Premium","clientUserId":"4215b759-9065-4de2-8d20-6397fffac991"}	2026-07-14 05:19:23.706
b8a7d168-4da4-4b48-90b1-ffc0ca4a741c	925dc47b-91c6-4a44-9233-de139f77a62d	\N	7.50	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"4215b759-9065-4de2-8d20-6397fffac991"}	2026-07-14 05:19:23.708
480f48f9-8e33-4849-830b-0dac6bc1299a	2d7f1591-8c54-4b99-a09f-829d33daef81	\N	15.00	IMAGE_UNLOCK	Desbloqueo de imagen premium	2026-07-14 05:19:40.446
921a3461-af8a-46d1-a261-024cc1d76dfa	0f662fd9-a2c3-4b35-9059-426730ed8778	\N	7.50	EARNING	{"service":"Imagen Premium","clientUserId":"4215b759-9065-4de2-8d20-6397fffac991"}	2026-07-14 05:19:40.447
5d4d9010-80f1-4151-8d0a-435d623cd615	925dc47b-91c6-4a44-9233-de139f77a62d	\N	7.50	EARNING	{"service":"Comisión Imagen Premium","clientUserId":"4215b759-9065-4de2-8d20-6397fffac991"}	2026-07-14 05:19:40.449
0ac57362-5490-480a-a646-1247d3d09147	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-14 14:38:54.07
94dacbd7-4ab8-4238-aff5-00beaca3ffa9	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-07-14 14:38:54.077
199c67ef-f6dd-4e86-abde-075190959c61	69ae77b7-521a-4136-86a3-c42c58240802	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-14 14:41:12.563
0bea34f1-b8e0-47f9-b078-d670e5089e23	a98ef5ca-8868-422a-8317-b8a570f0b5fb	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Jose"}	2026-07-14 14:41:12.566
35891676-5bfc-47bd-a114-c7a280f3c9a4	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-14 15:42:01.53
936c9e1b-013a-4cd9-b8b9-23864805e4ee	370113b5-f9c5-497f-8977-5190daa99e50	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-07-14 15:42:01.535
b76364e2-d8c0-4a56-870b-6f092792b017	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-07-14 15:42:01.541
b06b5f32-f900-451f-877b-5241f28a9929	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	3.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-07-14 15:43:57.53
d229d5d2-7238-4ce2-a80a-a26829143c6b	370113b5-f9c5-497f-8977-5190daa99e50	\N	1.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-07-14 15:43:57.532
2dc95b20-f8be-45a4-97ff-2ce17d81d521	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-07-14 15:43:57.534
63d9c236-c403-449e-9592-6a3b78d42499	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	4.00	CALL_PAYMENT	Video llamada · 1 min	2026-07-14 15:44:41.3
de7b25ae-0a0b-4642-b23d-5fbb306c39ef	370113b5-f9c5-497f-8977-5190daa99e50	\N	2.00	EARNING	{"service":"Video llamada","minutes":1}	2026-07-14 15:44:41.302
29b0acb8-14f8-427f-96b9-ea6786332b23	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-07-14 15:44:41.303
04d9d15b-7a21-4a07-b882-b9a066ed8ace	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-14 15:47:37.486
fd112200-c3fa-41e6-aad1-7918c6793cdc	370113b5-f9c5-497f-8977-5190daa99e50	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-07-14 15:47:37.499
b7e738d4-b976-4fe5-89c4-ce1daecaacf3	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-07-14 15:47:37.502
d3cd16d3-2505-46d2-b547-319f50a4eb4b	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	1.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-14 15:54:04.939
e776f152-71a9-4641-adbb-c1d79e75adbf	370113b5-f9c5-497f-8977-5190daa99e50	\N	0.50	EARNING	{"service":"Mensaje recibido","clientName":"Jhaseft"}	2026-07-14 15:54:04.941
afd4a41c-1ee6-4389-91f5-c6df41fb93dc	925dc47b-91c6-4a44-9233-de139f77a62d	\N	0.50	EARNING	{"service":"Comisión mensaje","clientName":"Jhaseft"}	2026-07-14 15:54:04.943
99d46da4-6e20-4d0d-979d-8562fffb546c	fa39581d-8edf-471f-8eab-5b13ff902474	\N	4.00	CALL_PAYMENT	Video llamada · 1 min	2026-07-14 16:04:35.794
eb384f97-50ab-4b12-9868-471d97e62c15	370113b5-f9c5-497f-8977-5190daa99e50	\N	2.00	EARNING	{"service":"Video llamada","minutes":1}	2026-07-14 16:04:35.797
c6c75cbb-3519-44d5-8954-63c621c4900b	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-07-14 16:04:35.798
4222fdbd-a236-4e3e-8093-6bd0ed8384a3	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	4.00	CALL_PAYMENT	Video llamada · 1 min	2026-07-14 16:06:55.934
321835e8-871d-4e79-89c6-d0a6ac95dfc6	370113b5-f9c5-497f-8977-5190daa99e50	\N	2.00	EARNING	{"service":"Video llamada","minutes":1}	2026-07-14 16:06:55.94
24fb244a-d549-4f2c-89e4-71cb788dda58	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-07-14 16:06:55.941
d50dad1b-f2a3-4edb-b770-91c41f2b8f13	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	4.00	CALL_PAYMENT	Video llamada · 1 min	2026-07-14 16:07:17.75
5bd53df5-a93f-429b-8316-d9b972318566	370113b5-f9c5-497f-8977-5190daa99e50	\N	2.00	EARNING	{"service":"Video llamada","minutes":1}	2026-07-14 16:07:17.751
d3931c0f-e6b2-4ee1-b142-72eb1079b2b7	925dc47b-91c6-4a44-9233-de139f77a62d	\N	2.00	EARNING	{"service":"Comisión Video llamada","minutes":1}	2026-07-14 16:07:17.752
efb3333b-50f9-40d4-bd67-bfe322b3bbca	9595ad2a-6303-4b1e-a40e-f7f5311096c4	\N	3.00	CALL_PAYMENT	Llamada de voz · 1 min	2026-07-14 16:07:54.639
1f3a4f6c-f031-4459-ae2c-a9222490a4bc	370113b5-f9c5-497f-8977-5190daa99e50	\N	1.50	EARNING	{"service":"Llamada de voz","minutes":1}	2026-07-14 16:07:54.642
2487b640-7b2b-4902-ad2d-3e9583bb3981	925dc47b-91c6-4a44-9233-de139f77a62d	\N	1.50	EARNING	{"service":"Comisión Llamada de voz","minutes":1}	2026-07-14 16:07:54.643
9e45a985-3a01-44d6-a220-d5959531cc9a	237deee9-1080-4eb8-af13-36c4dab4d240	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-15 06:18:32.7
59cb44eb-306e-46cb-8e19-edef8c301e31	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Pachamama 2025"}	2026-07-15 06:18:32.704
9989b8a5-1054-403d-a097-ef9498f53fd4	237deee9-1080-4eb8-af13-36c4dab4d240	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-15 06:18:34.909
02d2c998-c20a-432f-b173-eaa71123e1b8	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Pachamama 2025"}	2026-07-15 06:18:34.91
263bb2f9-422c-4e19-a78d-e8ba88fc835d	07dcb8be-87e3-4a7b-b697-937e9e48a819	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-15 06:28:20.97
53a09396-9251-4ab2-bab1-0a4d41ff7106	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Ornella perez"}	2026-07-15 06:28:20.972
591a8873-785d-459b-b15d-ec75ea9ea445	7bbae033-8471-4208-8438-ff4e67686453	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-17 22:31:42.12
439a4b55-7312-4580-91f5-56c02fa7f053	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Ornella Perez"}	2026-07-17 22:31:42.124
c5992f5e-f0f4-4ff0-b210-d41b24403d09	7bbae033-8471-4208-8438-ff4e67686453	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-17 22:32:04.544
b2a15ee5-6bfc-4121-835b-a81d0d777c5a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Ornella Perez"}	2026-07-17 22:32:04.546
7daef20b-c4b6-43ac-8204-9b918601e6ba	04c1bbc5-2649-4bad-9477-16573dd6d795	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-18 02:40:49.884
e8b6b532-f9dd-4c27-9abb-640a6f6e2f01	4b52debf-3f19-4f2b-bf92-a24247dfa383	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Daiary mía Fernanda"}	2026-07-18 02:40:49.887
e0163a73-dace-4f95-94b6-094951333c49	04c1bbc5-2649-4bad-9477-16573dd6d795	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-18 02:41:21.535
08ab8717-12c6-4e20-952c-91c63affece1	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Daiary mía Fernanda"}	2026-07-18 02:41:21.536
0ecc50c0-8a3c-41bf-9dd6-4fd36a15bbad	c81c2e98-98bd-4489-a841-4d1bc4a8ad88	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-18 17:58:04.18
2f3cde22-58a0-4691-a150-47b1ee0fc4d6	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Luisa PereZ"}	2026-07-18 17:58:04.184
607765c6-0071-40cc-8c17-4239e744a54d	0df302d6-5538-4965-bd18-1bca98a0a369	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-19 02:11:42.874
59da9374-c53f-4d4d-9443-d235ea11bbdf	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Susej Arucano"}	2026-07-19 02:11:42.877
c9943081-cff7-4cd4-a1dd-ad3f5d80a1ea	64320730-2779-49ae-92e7-e6314f8a33bc	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-20 22:49:39.672
4464d1a7-9e5c-4b84-9974-76e6e41065b8	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Super Vip2025"}	2026-07-20 22:49:39.675
4f60e210-53bd-43aa-aba9-3bba5a343d2e	94e492e4-cd32-4208-82ff-43012f035d4c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-21 04:36:55.358
3b0749ce-cbbf-4cc3-9d35-cb348642a042	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Keyner Tineo quispe"}	2026-07-21 04:36:55.361
2995ed6a-0115-4cd1-8ec8-c6e3132fc50f	94e492e4-cd32-4208-82ff-43012f035d4c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-21 04:37:08.154
c0d3e7dd-c0c5-4b12-9d55-0afe8837ab9a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Keyner Tineo quispe"}	2026-07-21 04:37:08.156
edf4c3bd-d6cf-4c10-985e-69d10e8ff352	94e492e4-cd32-4208-82ff-43012f035d4c	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-21 04:38:10.246
cb3ec7e5-124f-442e-a75e-6dc7603b8ddd	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Keyner Tineo quispe"}	2026-07-21 04:38:10.249
d9096aaa-52e7-4328-8309-b284704e9684	87356618-dae9-4161-b1e5-a4a3e8276db5	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-21 05:05:31.218
eec5ef50-7dba-46b2-86a9-89766c37f6c4	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Aldair"}	2026-07-21 05:05:31.222
7b725528-a6b9-4454-b525-da0105ce7c95	87356618-dae9-4161-b1e5-a4a3e8276db5	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-21 05:06:07.097
0838ec89-8da1-49c7-a4de-23875d9581b5	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Aldair"}	2026-07-21 05:06:07.099
918f452a-7b00-4939-877e-6c55c3230893	87356618-dae9-4161-b1e5-a4a3e8276db5	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-21 05:06:30.191
392b124b-14c8-4215-a248-f41b970d7ca6	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Aldair"}	2026-07-21 05:06:30.193
621bbd65-ec62-4a14-a7e2-2cbcedff705e	7d5c84c4-68c9-4a4c-87af-c3479991ec46	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-21 05:27:15.494
27c1b5c0-d910-4b59-80e0-0e2adabfba4a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Max Murrieta"}	2026-07-21 05:27:15.497
07ded526-792b-4ddd-ae4e-deb1853b79f0	7d5c84c4-68c9-4a4c-87af-c3479991ec46	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-21 05:28:54.172
b327e6ff-cf69-4656-8c4d-bde7487ec76d	4b52debf-3f19-4f2b-bf92-a24247dfa383	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Max Murrieta"}	2026-07-21 05:28:54.174
e4c14010-2a38-4d5a-9861-6f00f0df3e32	1f777b18-665d-4762-97c5-bd6eeebbf76b	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-21 15:08:45.002
4e659c6b-7a9c-4bd4-9f9d-27c8b6b4ba7d	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Pachamama Bar"}	2026-07-21 15:08:45.015
dc1c5647-78c8-4153-b960-7e14ca3315b9	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:36:36.951
5a850c2e-ee07-4f0e-bd98-4a49511a179e	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:36:36.954
233e7fed-8a72-46f8-b18a-e102ed5d799d	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:42:23.764
8ef5204e-06b2-4e12-9df5-10be66e41e3b	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:42:23.767
10b19a2f-faa5-4d53-aeaa-082c5a0cbfe6	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:42:34.699
f25b23d7-3e3b-4161-aa8a-ea2d697a80ae	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:42:34.7
1e94b8ec-b254-46fa-be52-f2994835c613	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:42:53.563
c3715733-3744-474a-a7d2-1f30cbcb6fef	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:42:53.564
84bfd1ef-0d54-4789-9634-9f5f3164c357	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:43:14.787
7c149e5b-e63b-4e40-a635-25e893138fed	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:43:14.788
1af1f1bd-4f21-4cb3-a651-7ff307fdacda	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:43:20.097
2d79d98b-f8eb-4c72-8bfe-190f1ad9e5f8	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:43:20.099
f92067bd-5c39-46f9-97d2-e45d8d2815b9	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:43:48.264
da8a369e-8fff-4bc1-a9a1-f88001acf03a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:43:48.266
68ce255a-55b0-43fd-b284-28691c46036c	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:44:36.92
65428920-d3ce-4a9b-bd07-987cd70eebe1	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:44:36.924
72a6e4ec-2d91-4970-97ad-b416aff57bf7	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:44:54.526
484b7221-d17e-4f44-9df0-92f876884ccc	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:44:54.527
5b77ab04-431f-40e7-a44b-d8a104f991ae	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:45:02.594
4b9f494b-4fd8-4a53-8649-2f997156926a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:45:02.595
2eeef2a4-865a-4fb0-9c9b-7beac3546720	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:45:26.55
20a84b49-2323-4351-984b-59f351fe08f4	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:45:26.551
688ef43b-0f95-4e29-80bd-e4b625f90db7	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:46:14.976
3bec5410-f386-4588-8710-5f9cf3f25dba	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:46:14.978
b1feaf1b-c103-45a6-9efa-7d9aa583db43	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:46:48.018
515853f3-69ed-467c-a55d-3d68622f0c0c	4b52debf-3f19-4f2b-bf92-a24247dfa383	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:46:48.019
2036bdbe-a8c0-41c7-a398-0bb9772d02eb	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:47:18.449
de0ce8e8-7f03-4086-803a-1e1f3e6a8b64	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:47:18.45
27802cc1-aa02-438b-95ce-3f458024065a	9bd720ad-e2ff-456b-956c-2938c71d8c14	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 01:48:02.869
404d9359-a972-4862-94cd-e1807be1788b	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Dilber Vela"}	2026-07-22 01:48:02.87
569cc49c-8159-40ad-8316-c3e8c7ab6686	09db833f-46c0-4fbe-a4d1-2b88e0d75c88	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 03:00:24.628
07dc8c53-7ad6-47f7-8a55-6001068680ff	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Nixson Adelkis Gaona Guerrero"}	2026-07-22 03:00:24.632
c041e7f4-5b5e-4576-8ad9-afa70cd35616	09db833f-46c0-4fbe-a4d1-2b88e0d75c88	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 03:00:31.877
2209cffe-ea7f-4cca-8ffb-fd4e3d43c61a	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Nixson Adelkis Gaona Guerrero"}	2026-07-22 03:00:31.878
f928613f-d222-4e45-800c-c9c2b383e0b3	09db833f-46c0-4fbe-a4d1-2b88e0d75c88	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 03:01:09.633
f533f1b9-e2bc-4082-a4eb-bff0c84c0aea	021c01e5-7b04-4f90-ad4f-776081e1bcae	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Nixson Adelkis Gaona Guerrero"}	2026-07-22 03:01:09.634
3b1b3e58-0b50-4821-bce4-2416d0b6930a	09db833f-46c0-4fbe-a4d1-2b88e0d75c88	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 03:04:32.953
ce616155-ee88-4e43-bf02-42e67ca926ff	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Nixson Adelkis Gaona Guerrero"}	2026-07-22 03:04:32.955
5a9269f9-897e-4a92-a5f7-e365a1c66211	09db833f-46c0-4fbe-a4d1-2b88e0d75c88	\N	0.00	MESSAGE_SEND	Costo por enviar mensaje	2026-07-22 03:05:26.181
beb2841b-3068-49d1-9b9f-c642f8399edf	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	\N	0.00	EARNING	{"service":"Mensaje recibido","clientName":"Nixson Adelkis Gaona Guerrero"}	2026-07-22 03:05:26.183
\.


--
-- Data for Name: user_profile; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.user_profile (id, "userId", "userName", bio, "avatarUrl", "avatarPublicId", "createdAt", "updatedAt") FROM stdin;
b1c72ff4-facc-43a5-b52b-6946b4b29903	52c1851b-d920-4c8c-8c81-d23099affa0a	Paredes	\N	\N	\N	2026-03-21 18:58:11.413	2026-03-21 18:58:11.413
4f6b7d7e-76e7-4779-83b9-c9e037831051	304884e0-e87c-44b3-a135-525fcc3b24d6	Jaime	\N	\N	\N	2026-03-22 09:59:42.901	2026-03-22 09:59:42.901
65aec61b-96f2-4395-92b7-7d922cbdab88	bce4910d-68ac-43d9-88d5-e9a76a648ed3	Nayely	\N	\N	\N	2026-03-29 01:24:36.171	2026-03-29 01:24:36.171
f5081ac8-5dda-4c3f-91a7-68bf074d7e6c	ed917127-6f95-432e-aed5-7c4a8cf4157f	Francisco	\N	\N	\N	2026-03-29 03:22:48.903	2026-03-29 03:22:48.903
111afb6e-50c4-4553-866d-ab684f71c42f	fc5201a4-0e4f-40fa-a957-766a4bdfe40c	Jorge 	\N	\N	\N	2026-03-31 18:36:50.574	2026-03-31 18:36:50.574
367086f7-8a49-4427-ba23-920ded7c8afb	ae043ef6-64d1-4cdd-aead-cfaac366d79b	Jhonny	\N	\N	\N	2026-03-31 19:19:24.691	2026-03-31 19:19:24.691
6476e8a2-4079-471a-a4d5-5ec4618a2deb	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	Jose	\N	\N	\N	2026-03-31 19:29:12.247	2026-03-31 19:29:12.247
83c6cfc1-4bbf-429d-976c-f16db52d0bb1	2e0740ed-8b4b-4f38-8c94-25812aff3cdf	César	\N	\N	\N	2026-03-31 20:28:47.971	2026-03-31 20:28:47.971
58b98f77-65c4-466d-9796-4c74f432dcce	d832267c-c7e2-403e-85b1-78bb34a68493	Piero	\N	\N	\N	2026-03-31 22:28:25.889	2026-03-31 22:28:25.889
1f627d9d-a99e-452b-8218-164bf0bf0726	81a59313-a192-44e6-9532-da180367abf0	Jac Jeyse	\N	\N	\N	2026-04-01 08:25:21.183	2026-04-01 08:25:21.183
c33b867f-62eb-46e7-96d4-f842add3a329	cadca8ec-879f-4f06-9295-1a9731149965	Sofi	\N	\N	\N	2026-04-04 03:03:42.953	2026-04-04 03:03:42.953
ef372a2d-2da6-4edf-8476-d55bd7d6b649	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	Jhaseft	\N	\N	\N	2026-04-04 12:53:32.44	2026-04-04 12:53:32.44
f74a99ef-4531-44b7-8afd-b15da045b2aa	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	Jhoel	\N	\N	\N	2026-04-04 14:28:24.353	2026-04-04 14:28:24.353
8cf03e58-c679-4190-a892-fc1aba3f95e7	b6e54a63-4b05-46e5-8586-5f307f47006b	Paredes	\N	\N	\N	2026-04-04 17:12:51.603	2026-04-04 17:12:51.603
a61551c3-81b0-4388-84c4-869069ffe264	8b4647cf-a910-4878-9a1d-6849a7c8af42	Juan	\N	\N	\N	2026-04-04 17:36:58.391	2026-04-04 17:36:58.391
32f797cd-907f-49e5-8230-9a90fc8df744	818ce99c-0c46-4ccf-a372-6c809194c562	Carlos Raúl 	\N	\N	\N	2026-04-05 00:48:03.841	2026-04-05 00:48:03.841
81240fbe-bd61-445b-b14b-99e00cc0fdf1	2a051152-23c8-4597-a95a-cfbb96105715	Josue	\N	\N	\N	2026-04-05 01:02:12.442	2026-04-05 01:02:12.442
1710ed29-0f83-487e-8da1-79f53e71a81b	dec3b28d-030e-49f1-af9b-441d3188a3a7	Joel	\N	\N	\N	2026-04-05 02:19:33.528	2026-04-05 02:19:33.528
730db2d5-547b-45cb-8211-c29f30626664	ada1e029-08db-472b-851e-5f1265a66fc5	Duverly 	\N	\N	\N	2026-04-05 03:19:02.709	2026-04-05 03:19:02.709
c5690b1d-780b-452c-8cdf-97a60c789640	04273fa9-2979-4a3c-81e7-f8d17b3c2d4a	Amilquer Gabriel	\N	\N	\N	2026-04-05 06:38:49.619	2026-04-05 06:38:49.619
38f9b8bb-f224-445f-9539-c40ecf656ebc	8ad7a76f-ab75-4097-b92a-b07653454207	Ali	\N	\N	\N	2026-04-05 06:42:52.108	2026-04-05 06:42:52.108
498edd0d-cc14-4e00-99da-add8941432f2	eac25be7-9bea-446f-8546-ae3f5b312d71	Marioxy	\N	\N	\N	2026-04-05 12:50:35.99	2026-04-05 12:50:35.99
cecd397d-4794-487f-8728-424936a967db	599864fe-f89b-4445-8b25-7da50697043b	Alejandro 	\N	\N	\N	2026-04-05 13:21:15.927	2026-04-05 13:21:15.927
a7d8d722-7534-41c8-9909-e83b9341b2df	c2e6c369-0649-46e8-a0e2-b888d83d131f	Erick Javier	\N	\N	\N	2026-04-05 17:49:11.966	2026-04-05 17:49:11.966
1b746b06-c00b-40bb-8f62-e13edfc97a3a	42da48c6-0a1b-4783-98e6-8457d0fc8f7d	Jhan pier 	\N	\N	\N	2026-04-05 18:54:54.474	2026-04-05 18:54:54.474
f7bc3d9b-d1ce-4efe-b99c-5d47f3e2bbd5	ed57ec95-8351-4367-8d45-f4b91911a099	Jhon	\N	\N	\N	2026-04-05 19:18:04.038	2026-04-05 19:18:04.038
1c5c5d67-c475-4a59-bce9-d0ae1622439d	3f3ef803-d6af-45a6-84f4-2d22d89390dd	Jhon	\N	\N	\N	2026-04-05 19:56:12.553	2026-04-05 19:56:12.553
b05b2f84-9d8c-4a74-8d39-59cf0d4a0771	c66c79d2-b59e-41c3-aef0-ec1ce54c77d3	Tonny	\N	\N	\N	2026-04-05 20:33:49.169	2026-04-05 20:33:49.169
e783006a-0723-4ef5-a6fb-be63e598aba8	a652dbc4-c42b-4f12-92bb-40ad705f0614	WENINGER	\N	\N	\N	2026-04-05 22:02:17.182	2026-04-05 22:02:17.182
03f9c1b8-835d-4758-9a70-2fb54f87ecc2	e66556cc-de35-467c-bffb-2bb10f08adef	Jonas 	\N	\N	\N	2026-04-05 22:51:46.116	2026-04-05 22:51:46.116
7a254061-9c9a-43ae-bfae-772ef165386d	1da91f79-a244-4896-a7d7-08e15a34564b	Denis 	\N	\N	\N	2026-04-06 01:30:04.019	2026-04-06 01:30:04.019
ad37468c-d2ac-4ca9-95fa-3071d43449fa	8f36a80a-9e9c-4bc9-8603-72b22ae3c5f7	William	\N	\N	\N	2026-04-06 01:34:56.231	2026-04-06 01:34:56.231
f89e5ec3-9078-4500-8aa4-5ed00d711776	d620ed02-c818-4d04-be91-d6814a76c7f3	Guudo 	\N	\N	\N	2026-04-06 01:44:40.278	2026-04-06 01:44:40.278
53778caf-b43a-441b-a5c9-281b05a82515	0f618476-9f1f-40d6-8e89-3f8e2554af13	Frey	\N	\N	\N	2026-04-06 01:44:50.729	2026-04-06 01:44:50.729
ada44347-e5e6-4ffa-8136-562d04197729	9b580b58-46f3-4a8e-9319-7f3752ef92e2	Sandro	\N	\N	\N	2026-04-06 02:31:25.348	2026-04-06 02:31:25.348
8b17bca1-e9ed-4d24-9ff0-a3eeefe1db90	a0275649-e6f1-48d5-9774-de80f2dcfd06	Eliadito	\N	\N	\N	2026-04-06 02:42:54.62	2026-04-06 02:42:54.62
cc57a6f8-6ccc-44cc-aca7-6ba96a186507	70eaa20c-9ea3-4368-865b-e82cc82efa23	Yohan	\N	\N	\N	2026-04-06 04:49:48.19	2026-04-06 04:49:48.19
a241ff06-c9fd-41f9-b24a-f7231813078f	197e5a03-33be-498e-bf56-3943cdcebaac	Alfredo 	\N	\N	\N	2026-04-06 05:31:32.237	2026-04-06 05:31:32.237
bafba5f3-5822-4e31-8be1-e8d78f6316fe	e59bf2b9-b176-4799-8e53-4132c7b4a82e	Gema carlos	\N	\N	\N	2026-04-06 05:56:14.498	2026-04-06 05:56:14.498
32434389-c8ae-4fdc-923b-cbfd0c4aa2cf	fe63bb9a-4219-4da1-bf8f-c52412f6e801	Wylfredy 	\N	\N	\N	2026-04-06 06:03:04.364	2026-04-06 06:03:04.364
15de9fc4-9ba6-4107-9b57-455a7dfbd52f	5b861f19-1c5a-47c6-a9a1-b4fc35eda3c6	Eduardo 	\N	\N	\N	2026-04-06 06:48:13.905	2026-04-06 06:48:13.905
693c796c-2697-4f8e-856d-8b24787a386c	8a76fc2a-6f8c-4264-89bd-9827763d0bdf	Halbert 	\N	\N	\N	2026-04-06 06:59:08.766	2026-04-06 06:59:08.766
93e6f57f-bb52-4711-9448-5acc95e62338	867a333a-9f97-4133-8a15-ba350f41a16f	Lalosd	\N	\N	\N	2026-04-06 09:59:00.841	2026-04-06 09:59:00.841
a77c0822-d31b-4013-9c05-a80c6569cb55	56bc08e8-a2dd-4a71-b14b-6ea3daa38d69	Eddy	\N	\N	\N	2026-04-06 11:21:24.07	2026-04-06 11:21:24.07
f8e953f9-b0cf-4086-896e-148c4303a090	f0dd8dc7-f8a8-4e9e-9652-fece4fe389c3	Heineken 	\N	\N	\N	2026-04-06 14:31:13.429	2026-04-06 14:31:13.429
45963980-564b-42d0-8282-580d1762a599	e4264309-988e-468b-9f8b-868b750e973b	Yadiel	\N	\N	\N	2026-04-06 14:37:51.119	2026-04-06 14:37:51.119
5bbf6544-034c-4cdc-97fa-64b25d09ed61	fa4d11c0-b6a4-43db-81e9-2a0b247af9ef	Rossel Edilberto	\N	\N	\N	2026-04-06 17:52:40.618	2026-04-06 17:52:40.618
7687b4ea-4c7d-4f2c-8658-98eef30a3c54	d2c48c15-9d40-47e7-ba16-12cb5d2ee4ca	Juan	\N	\N	\N	2026-04-06 20:09:59.701	2026-04-06 20:09:59.701
866dbc3f-0436-4d0b-9d04-ea98f86c6db2	59b401d0-9e20-4ada-82f4-ed81872c43d7	Miguel 	\N	\N	\N	2026-04-06 20:13:49.981	2026-04-06 20:13:49.981
b90b78e9-fb2f-414d-bb1d-bc1ad5cca92b	26e11e57-9d55-4cbf-aed1-40adc9f3f410	PEDRO	\N	\N	\N	2026-04-06 20:21:31.572	2026-04-06 20:21:31.572
fd17f679-879f-4cf6-9769-300984173bd0	72ebb69d-756a-4924-8a1e-80d5b794c07b	Carlos	\N	\N	\N	2026-04-06 20:36:26.227	2026-04-06 20:36:26.227
0b0dc202-f125-4c56-8900-b0e39c054236	954d4a1a-0d08-48de-813d-f5665b5968a8	Ney	\N	\N	\N	2026-04-06 20:39:51.557	2026-04-06 20:39:51.557
a3d81d78-0fa1-4618-8bf9-a3dfd5a75ea2	17996dbb-d4ba-4bef-b265-115cb4a281aa	Yuder	\N	\N	\N	2026-04-06 21:01:21.235	2026-04-06 21:01:21.235
c8f57371-637e-4490-b2e9-68214d1e0579	d3e37a3c-cc4d-4857-9d41-ecbaaa00d6bd	Roland 	\N	\N	\N	2026-04-06 21:02:02.109	2026-04-06 21:02:02.109
9390fbbe-8a66-4d71-849f-7ed9aaf4c0f6	1d005ba4-b597-475f-964d-90ad921e9020	Juanito	\N	\N	\N	2026-04-06 21:27:26.764	2026-04-06 21:27:26.764
6158a5fd-7885-4097-b63b-1cb54de9d52f	04331537-fef9-439a-ab3e-c9ffbe3c2db4	Jhon Ander 	\N	\N	\N	2026-04-06 21:50:37.913	2026-04-06 21:50:37.913
24abb8b1-31d3-43ec-a1b7-a975cef2532b	03daa672-341a-4cce-91ab-81f3159a7036	Piero Antonio	\N	\N	\N	2026-04-06 21:53:22.336	2026-04-06 21:53:22.336
a4502445-fc13-4a88-8ecf-ffb37d6e6501	36df8ef2-4651-426d-ba5f-a3edc5984168	Silver 	\N	\N	\N	2026-04-06 21:53:51.037	2026-04-06 21:53:51.037
e8fdf8e6-680e-4965-853e-19e58a459bab	ab44e481-2f7a-49ea-91f0-16be463368ec	Abraham	\N	\N	\N	2026-04-06 22:37:45.663	2026-04-06 22:37:45.663
308fa302-a6c8-41db-8317-58daa88609c3	5e935756-3dc8-42e8-b732-ac2b40b5c053	Angel	\N	\N	\N	2026-04-06 23:24:20.126	2026-04-06 23:24:20.126
5773e0a1-cbce-41e4-81d0-ba735828bce6	6976b2a1-97f6-48c8-8411-b4207c2f440a	Edwin Fernando	\N	\N	\N	2026-04-07 02:53:17.692	2026-04-07 02:53:17.692
ddc7f17a-7210-49c5-9277-383235bdeb63	71406cb8-fd46-4cae-bf3c-bfef2cbd50a0	Roger	\N	\N	\N	2026-04-07 02:53:35.887	2026-04-07 02:53:35.887
01ec0da5-4a2a-4b6a-838d-478bf0656fd3	8ac6615a-71e9-48ec-910b-244b661d4950	Jose 	\N	\N	\N	2026-04-07 03:44:23.957	2026-04-07 03:44:23.957
587a58fc-47df-40a2-ab5c-e260ba57a1f7	068de07b-6b37-4f64-9586-fb4196271108	Elmer 	\N	\N	\N	2026-04-07 04:47:57.819	2026-04-07 04:47:57.819
73f1c19f-d4ea-440c-ad23-c635963e5c93	66d5c599-eca6-4dd4-80a9-ba19de3f0e22	Jean	\N	\N	\N	2026-04-07 05:15:48.783	2026-04-07 05:15:48.783
68c19b88-5032-473e-8aef-9e363fefc7b7	b20f5b97-e85a-46e0-a77e-7839a7c5641f	Brahyam	\N	\N	\N	2026-04-07 05:21:36.357	2026-04-07 05:21:36.357
84e9ef24-bd41-4c2a-8dc7-611d7415121b	93586e5a-4fd0-4bd2-9287-fa4f308af08b	Flavio	\N	\N	\N	2026-04-07 05:40:33.412	2026-04-07 05:40:33.412
be9591bb-c766-4d96-801c-a90dde00e3ad	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	Andre	\N	\N	\N	2026-04-07 07:53:56.442	2026-04-07 07:53:56.442
4f222a1f-865d-4736-9e95-e1450fe7d1df	1b80ea97-9a78-4674-804f-39ef05924c67	Artemiio	\N	\N	\N	2026-04-07 08:35:35.065	2026-04-07 08:35:35.065
084798cf-d3b6-4ec6-914f-ffa76aa7d413	360a68ea-671e-492e-b56f-05b2000e671f	Jose luis	\N	\N	\N	2026-04-07 09:59:24.349	2026-04-07 09:59:24.349
d810ffba-43af-427c-8f2b-f34b674e6c2e	d2a7dadb-154c-442e-9806-bb52e9e380f1	Edu	\N	\N	\N	2026-04-07 11:00:48.522	2026-04-07 11:00:48.522
e5b9ffd5-faf5-4141-9589-ad0d766ca5e2	5643cd07-a7d4-478b-b66a-964dece5ad4f	Frank 	\N	\N	\N	2026-04-07 12:38:56.948	2026-04-07 12:38:56.948
1960dd11-9460-4599-ac5c-d2413b9f873b	8f939ead-58b8-4491-9485-1b885ad125b4	Jhon	\N	\N	\N	2026-04-07 16:01:35.87	2026-04-07 16:01:35.87
6807fa8c-1e0b-4dd7-87ee-3ece6a0bc320	1a689cb0-82e8-4344-87e3-82044bd26ee5	Jhon	\N	\N	\N	2026-04-07 16:33:38.686	2026-04-07 16:33:38.686
e3f1e749-7d50-4293-8a41-2673ac79d158	b2351447-b63a-4e96-ab43-092fb29b8b06	Saul efrain	\N	\N	\N	2026-04-07 19:25:43.779	2026-04-07 19:25:43.779
6efe900c-7611-404b-8df1-48654f7a61b5	225a5f55-64fd-4ac1-8eb3-3d24fe0811c6	Roni	\N	\N	\N	2026-04-07 20:08:39.244	2026-04-07 20:08:39.244
80bade49-2729-4720-9669-ba74cb18e350	0d6251c4-0c8d-47e1-871f-d7446ce48732	Alfonso	\N	\N	\N	2026-04-07 21:13:09.711	2026-04-07 21:13:09.711
366ab450-c394-464f-a947-70514fbfd9e8	6aea1710-2fa4-4f91-9516-365e823a32d4	Aler	\N	\N	\N	2026-04-08 00:04:01.275	2026-04-08 00:04:01.275
339c086b-ba88-4296-9385-d98a57cd7819	9cfad3d0-e269-4d5e-adb2-1d745ab9d571	Jean	\N	\N	\N	2026-04-08 00:39:03.544	2026-04-08 00:39:03.544
bc0b566e-2532-457b-8af7-9253261e50fb	178ced85-ad0e-4ba4-9cd7-27020fbd3777	Pedro 	\N	\N	\N	2026-04-08 00:50:24.236	2026-04-08 00:50:24.236
e1666b34-c07e-458b-900a-4876647459c8	169ae99c-219b-42dd-9089-3e58391b41be	Omar	\N	\N	\N	2026-04-08 01:02:32.111	2026-04-08 01:02:32.111
3197a5f2-d6e5-4511-ba66-b09c1006d81b	5a131531-7b19-4198-838d-eadbbd87d2bd	Jamil	\N	\N	\N	2026-04-08 02:14:52.835	2026-04-08 02:14:52.835
887b7850-581c-4ccd-86ee-168fe0aea5eb	b843e168-1f1c-419d-b9b7-eefc7f7dc435	Leodan 	\N	\N	\N	2026-04-08 03:27:54.104	2026-04-08 03:27:54.104
b0a6d994-b551-48cc-9986-eb64e48c2cee	30fba7af-7a9a-498d-b253-b9a14c17dae4	Martin	\N	\N	\N	2026-04-08 04:11:46.443	2026-04-08 04:11:46.443
c0df7cda-4306-442b-97fc-4c2bbd8abd73	9327dc29-688e-483c-a262-1fe1c180361b	Cesar	\N	\N	\N	2026-04-08 04:18:49.726	2026-04-08 04:18:49.726
7961f34d-f8f7-4b1d-b98d-e912a308583d	d217a78d-603e-4ea9-82af-657d3cee1827	Rafael 	\N	\N	\N	2026-04-08 04:21:45.44	2026-04-08 04:21:45.44
f188203f-fc32-464a-8d07-681edbde23a8	f5dafb55-6ad4-43f9-a8e2-8d2f29560c2a	Wender 	\N	\N	\N	2026-04-08 12:25:30.917	2026-04-08 12:25:30.917
71537b07-97fd-4572-89e0-bd1d6b48df86	30a3bae8-ee22-47df-aa5f-c50c2a90e629	Anderson	\N	\N	\N	2026-04-08 16:56:27.109	2026-04-08 16:56:27.109
62ac2349-ed08-4b55-aba3-f0e4e738e3e5	69d3d892-68a5-45df-82a6-58a6ad40cb89	Jose	\N	\N	\N	2026-04-08 23:28:27.759	2026-04-08 23:28:27.759
15a5bbf2-588e-4e77-834f-eb4c86fb663e	81c8998a-a498-40ad-8c01-bb0825873033	Caleb 	\N	\N	\N	2026-04-09 02:33:20.392	2026-04-09 02:33:20.392
c9432aa6-0201-4583-b126-8a0a7e0bcf21	b2a44427-6ffb-4e4d-830b-714c80517b18	Danilo 	\N	\N	\N	2026-04-09 09:03:05.635	2026-04-09 09:03:05.635
f4fe4fd6-f5ea-4b06-8309-78e946d10252	e082d771-fb3c-41e8-805f-052e544edcc6	Alexis	\N	\N	\N	2026-04-09 20:12:20.241	2026-04-09 20:12:20.241
1a476e63-aa00-4467-bcdc-4f51e148a981	41e81b4b-c22c-40a2-9176-2546ccae0163	Bryan	\N	\N	\N	2026-04-10 00:18:46.469	2026-04-10 00:18:46.469
b4f83562-4a54-4b92-b874-3f36fccda8a1	906f801f-ad3d-44c7-9bb2-887351e8355b	Daniel	\N	\N	\N	2026-04-10 03:05:16.87	2026-04-10 03:05:16.87
b60057c5-49d6-4f69-b3ec-e62b26d6a8e4	7fcb3884-c6b7-4320-b363-e1cefcd41878	Erik 	\N	\N	\N	2026-04-10 09:51:57.026	2026-04-10 09:51:57.026
6b53a29d-07e4-4d37-8ddf-a2c821c8cd38	1fb7991b-f01b-4132-8731-f6331aa2cb43	Johan	\N	\N	\N	2026-04-10 14:43:57.578	2026-04-10 14:43:57.578
d805c385-20f6-4367-9c87-c5b30235bd0c	5004709f-d63e-4e19-88e0-a888aa06482d	Ivanna 	\N	\N	\N	2026-04-10 18:26:31.336	2026-04-10 18:26:31.336
314f3fcf-1e31-4764-b7e9-ef3febaff9b8	a28528b4-e871-4137-a29b-b39f512397a6	Mari	\N	\N	\N	2026-04-10 19:39:12.462	2026-04-10 19:39:12.462
da803d02-3f3b-4d6e-96af-5c3307075bfd	d1feff79-fbc1-4252-8f1e-0c9e58e7d531	Marili	\N	\N	\N	2026-04-10 19:59:00.786	2026-04-10 19:59:00.786
f077851a-a264-4afb-88d0-6cfe6f160828	36e462f3-a9c2-4837-b8ac-481293147bae	Salomé 	\N	\N	\N	2026-04-11 01:30:58.387	2026-04-11 01:30:58.387
89fa9040-31bf-48ce-8ff3-21a9f15aad97	2456172b-6d96-4f6a-87be-dc9ff922f955	Miguel 	\N	\N	\N	2026-04-11 02:27:51.689	2026-04-11 02:27:51.689
f59a4728-6cf5-4cb5-a600-80d4ceb88675	f853fc56-f829-484d-812c-ed35a46950c9	Roberto	\N	\N	\N	2026-04-11 03:03:26.289	2026-04-11 03:03:26.289
f7cf32bb-7c47-4dfb-9469-be7c219368ba	43747451-b9a7-4d8c-83a9-f6340bdc6c5c	Neider 	\N	\N	\N	2026-04-11 03:17:54.098	2026-04-11 03:17:54.098
91f2d990-c28a-4b8f-8370-4171a3ce8f9d	c1c9af7f-cbd3-4e91-87e9-2d233baf7ad6	Taineys 	\N	\N	\N	2026-04-11 03:56:02.213	2026-04-11 03:56:02.213
67efbac3-471b-44e5-bf05-8fc2d9067616	7669d18c-044c-4528-9acd-be58bd8bb137	Angie Paola	\N	\N	\N	2026-04-11 04:00:22.944	2026-04-11 04:00:22.944
b86ce10d-b22e-4ad5-80b3-7a1d14775b25	b8875411-fa9d-4256-b7e0-6a725a3f1436	Hugo	\N	\N	\N	2026-04-11 04:27:08.932	2026-04-11 04:27:08.932
9aee7a0d-b0b7-4039-9de7-9e53aedf1a83	50f22bbe-f8c5-440f-bbd4-9d39b2a25275	Deibis 	\N	\N	\N	2026-04-11 05:29:22.26	2026-04-11 05:29:22.26
e03bbf89-834e-487c-929d-dc833e0dcc92	740b94fc-cba0-44c8-8169-1f4c239f26fe	Cristian jose	\N	\N	\N	2026-04-11 05:32:26.257	2026-04-11 05:32:26.257
f743612a-cc15-4261-817b-4a6998e53b8e	b475ab92-5be8-43e6-8091-633218517683	Deyber 	\N	\N	\N	2026-04-11 05:50:35.782	2026-04-11 05:50:35.782
049e7ef1-6d4f-4ba4-b4ba-086c7bea7cb1	2d91f582-36cd-4e9e-8224-cc02977a53c4	Juan	\N	\N	\N	2026-04-11 06:47:26.763	2026-04-11 06:47:26.763
701d46e1-8e05-4c68-bc23-84ecd29951d9	f7e40bd8-6bb0-455b-8000-85847525a2df	Jimmy 	\N	\N	\N	2026-04-11 11:28:07.409	2026-04-11 11:28:07.409
cda9ec46-ada2-4910-872f-6ade00465871	3aadf9c4-2722-4419-82f2-74d00e6441e4	Hurrem 	\N	\N	\N	2026-04-11 16:59:10.66	2026-04-11 16:59:10.66
71586b63-09d1-42fd-9a5b-06214abc064e	c2491471-8a37-44f4-8d7e-66f9f4f567ca	Camilo 	\N	\N	\N	2026-04-12 02:08:24.556	2026-04-12 02:08:24.556
650aaaf5-ec1d-402a-beef-c828c5ff64c3	de5c1082-08ac-4424-a539-81a3a5d93100	Jack	\N	\N	\N	2026-04-12 02:28:44.71	2026-04-12 02:28:44.71
4b363f77-61da-4c72-b9d0-88e073f65380	94a9107e-6332-4803-b270-a3fcad2aeefa	Jaider	\N	\N	\N	2026-04-12 02:43:14.779	2026-04-12 02:43:14.779
986a704f-69c0-4fc4-a671-828f339e53aa	04c2d87e-d93c-4609-bac2-1c73d428a458	Fran	\N	\N	\N	2026-04-12 02:45:09.567	2026-04-12 02:45:09.567
6fe3a402-851c-4b4e-84f5-5600f1f451d1	ead49473-ad37-4c04-8f18-29eee7e55171	Juane	\N	\N	\N	2026-04-12 02:59:29.162	2026-04-12 02:59:29.162
c8048ceb-8a49-4faf-b5f3-dde47f9f6eff	5c803021-df71-474a-bde9-44fa4d8b6d06	Juan	\N	\N	\N	2026-04-12 03:13:17.739	2026-04-12 03:13:17.739
e0c2050e-db4e-4f2a-ae7c-faffe10cd21d	3d050fac-5afa-4667-8363-63b858f7c7a1	José 	\N	\N	\N	2026-04-12 04:13:37.868	2026-04-12 04:13:37.868
c238c9a0-bfdf-4f81-853c-512231ad0b61	81df7097-2602-495d-a2ec-408c60637ddc	Luis 	\N	\N	\N	2026-04-12 06:07:40.676	2026-04-12 06:07:40.676
65d201e5-0682-43d9-b5bb-36a69a2511a8	fb214014-a2a2-41df-950b-b3950525c4b5	Tumbao	\N	\N	\N	2026-04-12 11:17:48.08	2026-04-12 11:17:48.08
acec91b2-d711-42a9-8bf5-3aa711697587	ba6b5d64-e36a-45fa-ae19-6c740bc88681	Álvaro 	\N	\N	\N	2026-04-12 11:24:14.124	2026-04-12 11:24:14.124
74797f16-8d3a-4914-81c0-7f811a5b7437	3b523806-29d5-4986-822d-20a397b04b97	Sarai	\N	\N	\N	2026-04-12 14:35:05.699	2026-04-12 14:35:05.699
4c46f38a-9346-4fff-95e0-f56fc75278dd	b32efeef-d31a-4665-b5ae-904cf68690cf	Sheyla 	\N	\N	\N	2026-04-12 19:29:39.204	2026-04-12 19:29:39.204
b07ad96a-8adb-4f95-872f-075228f1e102	162a0d88-4a0d-4f33-b394-d4a04f82da26	Niki	\N	\N	\N	2026-04-13 23:12:51.348	2026-04-13 23:12:51.348
e499fce2-6230-4b8c-b384-cd8754e4d39e	679437af-12b9-4053-b833-572033277abf	Submer 	\N	\N	\N	2026-04-15 02:25:28.647	2026-04-15 02:25:28.647
7f35b120-eee2-4a36-a62e-26cb8574967c	76f3797b-e979-4293-88ad-26d5757dd7a5	Alejandro 	\N	\N	\N	2026-04-15 09:20:26.716	2026-04-15 09:20:26.716
1aba0a1c-76f1-4ae6-8067-243ba77c1d92	d112f25b-610a-445a-85a0-0d53c22168c2	Michael 	\N	\N	\N	2026-04-15 23:47:09.449	2026-04-15 23:47:09.449
0c3cfec7-a43e-426f-a71c-78cfa3fa3385	5398b688-8844-424f-bc48-74b7cf60d774	Yammir	\N	\N	\N	2026-04-16 04:17:24.837	2026-04-16 04:17:24.837
45737cff-0bce-41aa-b1f3-487d9f071021	53362926-cf52-4db8-aa98-080fe2956c9a	Andrés Valentino	\N	\N	\N	2026-04-16 19:25:29.031	2026-04-16 19:25:29.031
e1635c5a-5552-4ae3-8102-ecbb45b42d62	67102934-186c-4281-8114-bfe9917fd8c0	Jordan	\N	\N	\N	2026-04-17 21:55:34.733	2026-04-17 21:55:34.733
e253fbf1-26bb-4633-89f8-584e3eadc08f	0f7b4e7b-17f3-4d7c-878b-055ee8dac528	Juan 	\N	\N	\N	2026-04-18 00:45:12.736	2026-04-18 00:45:12.736
03e78caa-2918-4aa5-ab06-6b90292939b0	9524f501-72d1-49ec-8dc5-bb2261177403	Celustiano 	\N	\N	\N	2026-04-18 07:14:26.961	2026-04-18 07:14:26.961
c3f6f983-b7ff-4a6c-942c-e2b107123711	e2a8876f-4ece-4125-93f5-9838a5560ef1	Tercero	\N	\N	\N	2026-04-18 20:23:40.086	2026-04-18 20:23:40.086
c2bd4037-cff4-4d5d-94d5-729c9587a6cf	28ad9e87-7377-4515-ac11-5c14512a382b	David 	\N	\N	\N	2026-04-20 09:42:30.731	2026-04-20 09:42:30.731
3f6f1d41-99e3-4320-9df5-5b08312c2a00	b556b7a8-f229-47f0-9453-6106c9a68653	Carlos	\N	\N	\N	2026-04-21 02:22:56.96	2026-04-21 02:22:56.96
f9d85645-b4d7-446d-bed3-ef3d792fb004	5b060e0c-a541-4249-abd6-9c2f08211c53	Bismar	\N	\N	\N	2026-04-21 04:57:19.457	2026-04-21 04:57:19.457
a54edda8-c284-415a-8db7-167fb51212c0	bb724137-7699-4ec2-9aa5-c59c6bfbe416	Juan 	\N	\N	\N	2026-04-22 15:47:36.712	2026-04-22 15:47:36.712
96bc5cfa-875a-48d8-90e5-68ee18b40c14	4ecad286-a43a-4487-9957-8a9d3d2af52d	Isabeth 	\N	\N	\N	2026-04-22 20:35:31.49	2026-04-22 20:35:31.49
14145114-092e-429f-9fce-d89cc421ed61	a5e6330c-0958-4715-bca2-05477d265316	Renato	\N	\N	\N	2026-04-25 17:34:52.408	2026-04-25 17:34:52.408
26c2b208-1e01-45f6-8731-b35c31aa3913	97181454-67d5-45d4-af28-e9eead994af0	Carlos 	\N	\N	\N	2026-04-26 23:11:37.789	2026-04-26 23:11:37.789
633a3286-dbce-4aa2-95d7-fefd3a705983	b9818e31-dfc8-4883-aaca-df0d3b536b3e	PATO	\N	\N	\N	2026-04-28 21:04:58.509	2026-04-28 21:04:58.509
367918be-565f-4b5d-b4a5-ca9762e08b74	5899b52e-6c02-4877-965d-0a4439257dae	José 	\N	\N	\N	2026-04-29 00:53:00.68	2026-04-29 00:53:00.68
edfe8271-cdac-4312-b4ca-8311d4f9e6da	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	Juan	\N	\N	\N	2026-04-30 00:03:56.234	2026-04-30 00:03:56.234
8cad2027-f698-4987-aef9-039e6b845a3d	3e957107-e648-43cc-baea-c5878ab6732c	Andy	\N	\N	\N	2026-05-02 01:31:19.681	2026-05-02 01:31:19.681
cb9ae574-235d-4f8c-a9ef-f62156445887	dc98d365-4239-45a0-818f-52edb3411bf6	Ced	\N	\N	\N	2026-05-03 01:38:04.917	2026-05-03 01:38:04.917
e333d684-7f3a-4859-89fe-b2e063df5603	da244740-12b0-4691-a6ca-280f6d83a716	Mauricio	\N	\N	\N	2026-05-03 10:39:11.912	2026-05-03 10:39:11.912
a631309b-f44b-4c0e-ae9d-a59f7fb6faab	f77c3216-b665-48c3-b3c1-5d48953c7026	Kuray 	\N	\N	\N	2026-05-03 17:22:26.727	2026-05-03 17:22:26.727
c67ef4ba-ea9e-422c-8436-36c03e1ba2ec	fb41944b-5d8e-4c5e-8b9f-4e8661e007af	Claudio	\N	\N	\N	2026-05-04 04:34:24.703	2026-05-04 04:34:24.703
16a6e417-1fd0-4d36-b826-efe1acf22a65	3d7da8a9-2210-4c42-89b6-1f9fa8c06d07	Manuel	\N	\N	\N	2026-05-04 09:18:00.273	2026-05-04 09:18:00.273
a32e2854-0cca-42de-be2f-4b0b4f48198c	28a52218-067b-4816-ba7c-581f48308a23	Mauricio	\N	\N	\N	2026-05-04 09:23:22.553	2026-05-04 09:23:22.553
251c0227-e526-457e-b065-2a077030a33a	f6c000b1-9659-4fcb-b39b-d1f31258c870	Kevin rafael	\N	\N	\N	2026-05-04 10:22:08.889	2026-05-04 10:22:08.889
e8b39551-0599-408f-b355-eec9089c469c	f3391727-9c64-4ab4-9623-7c92862899c6	Carlos Mauricio 	\N	\N	\N	2026-05-04 10:23:03.039	2026-05-04 10:23:03.039
7be5e792-cb01-49a2-8a81-67222471b60d	109ecd1a-3b55-475c-bed3-f1339005e2c4	Cristian 	\N	\N	\N	2026-05-04 10:33:57.071	2026-05-04 10:33:57.071
95ea710a-f225-4c94-b9f9-4d82a3552d10	0cdaf38d-21f5-47cf-9bfd-77386ea5a211	Negui	\N	\N	\N	2026-05-04 11:22:27.071	2026-05-04 11:22:27.071
2192934c-6df4-46be-87c3-2ff39f6ca7e2	d19fae64-dba5-4f3b-b12d-52a085efa21f	Hildemaro 	\N	\N	\N	2026-05-04 12:27:20.916	2026-05-04 12:27:20.916
1aeceff7-956a-4d52-9220-6113a4afd62b	6af62b72-c49f-49b4-90c8-b3e3467cd6ae	Liuver	\N	\N	\N	2026-05-04 12:40:10.934	2026-05-04 12:40:10.934
e54f6e0e-2789-44b5-8286-55c3f7d37a89	7276c868-9a13-4908-822f-403e45bca30b	Erick Jhordan 	\N	\N	\N	2026-05-04 12:55:59.886	2026-05-04 12:55:59.886
1928d422-035b-4dad-b180-59693c717085	d8e760c1-588f-4c94-be2b-2ea00e428332	Carlos julio	\N	\N	\N	2026-05-04 14:21:27.808	2026-05-04 14:21:27.808
7a8a42b8-2349-481f-9266-e0e6ebd668cf	01d48b51-6cb9-43ea-bfdc-5c2000af4fbe	Carlos Manuel 	\N	\N	\N	2026-05-04 14:40:50.069	2026-05-04 14:40:50.069
2fb4ae4f-0f5a-4540-8b7a-96634eff5e02	86860ded-58e9-43db-9e8e-00f1d4161fab	Santiago 	\N	\N	\N	2026-05-04 15:27:42.513	2026-05-04 15:27:42.513
3e63d209-c453-4d0f-affe-a9c25b8c5651	1773eab2-4727-40ee-a9b0-d1952a2a388d	Cristhian 	\N	\N	\N	2026-05-04 17:11:49.269	2026-05-04 17:11:49.269
dc80e1c0-3251-404f-a822-62e6ea251c06	579c6a3a-4186-4973-8522-bdebffcf304a	Gentil	\N	\N	\N	2026-05-04 17:41:24.121	2026-05-04 17:41:24.121
c7faf4af-4baf-41b1-ae06-82511b34d30a	198da2c0-0a8e-486d-b715-6cad34b02bc0	Jadiel 	\N	\N	\N	2026-05-04 17:44:33.78	2026-05-04 17:44:33.78
46d324e4-4977-4664-a573-c41e4a374cc6	47339094-1daa-4449-9dce-843579263fe4	Oscar 	\N	\N	\N	2026-05-04 17:52:05.134	2026-05-04 17:52:05.134
d507c6aa-b015-495b-aeec-f70ce1915063	ddae2e8c-5157-4006-985b-eefa7a3f0199	Ezequiel 	\N	\N	\N	2026-05-04 19:41:38.038	2026-05-04 19:41:38.038
b3703d7e-2c30-410f-b7cf-feff0f3f6fd9	7ebc1ad1-7828-4ed9-8c70-0201bf0905a0	José 	\N	\N	\N	2026-05-04 20:02:38.73	2026-05-04 20:02:38.73
56a71e19-0105-463b-9471-88255b0fae0d	9e7ae97a-42e8-4c75-9b92-a4dbf954ce19	Jhimy 	\N	\N	\N	2026-05-04 20:17:01.776	2026-05-04 20:17:01.776
a2629766-4b9e-48d7-87f1-27a6e524874e	d3bea0b4-86a4-46be-8c56-1cdb09c7da7c	Stiven 	\N	\N	\N	2026-05-06 04:35:42.342	2026-05-06 04:35:42.342
ad09472f-5efe-4426-abc9-2433f4ed1e7f	4e52747e-7e13-4333-98ea-a5c31722ed46	Heriberto 	\N	\N	\N	2026-05-07 01:03:01.194	2026-05-07 01:03:01.194
7edad895-af99-4aa3-b0b4-01502ecc9780	c7bd5193-a265-44ba-bc7a-ec8dae92b78b	Pedro	\N	\N	\N	2026-05-07 12:25:48.938	2026-05-07 12:25:48.938
405048c0-4a31-420e-b863-fd0663c2c0fd	135181f0-4f89-46db-86a1-eb721cf3913d	Andres 	\N	\N	\N	2026-05-08 07:06:52.713	2026-05-08 07:06:52.713
2c8eb46f-15b0-465b-b9ac-7c78b4f7ba3d	25b2a762-7e47-4134-bf3c-c69ef581863b	David 	\N	\N	\N	2026-05-08 09:50:04.05	2026-05-08 09:50:04.05
163c13fe-ea12-47b6-a149-3c427d86ae3e	6d13a28d-09ed-4bc2-bfdf-aa61c4dc03ac	Raul	\N	\N	\N	2026-05-08 10:13:52.36	2026-05-08 10:13:52.36
ee48f130-f03b-4fd7-b8eb-c38595ef8b43	ea97602c-9fc5-4aca-b2e1-e1142507c775	Stiven	\N	\N	\N	2026-05-08 10:16:08.409	2026-05-08 10:16:08.409
b46f3429-f5d1-4b56-963d-52a99ac0dcad	69ae8322-3c79-47e8-9712-ee0f426bd787	John Alexander	\N	\N	\N	2026-05-08 10:25:53.196	2026-05-08 10:25:53.196
d6decfe9-3051-4119-abdc-81cbaf6abff6	0d5b21f4-0dc6-466f-948f-9774bb5413f5	Fercho	\N	\N	\N	2026-05-08 11:28:39.196	2026-05-08 11:28:39.196
9613be8c-3459-4e3d-b589-6495d8af78cb	42ea5d02-a1fc-48d2-97d1-3bdd712dfd10	Ronal David 	\N	\N	\N	2026-05-08 11:45:16.76	2026-05-08 11:45:16.76
498b7d26-d74f-4802-9e8b-9f9339e62608	3eb8c9bf-adb0-40f3-bf0a-6d40339787ff	Soyler	\N	\N	\N	2026-05-08 13:42:13.384	2026-05-08 13:42:13.384
1770474a-edfb-4a15-9718-e512cdf9bd7a	98a21c81-0a67-4b4c-8923-e06d43c844d8	Miguel 	\N	\N	\N	2026-05-08 13:59:00.213	2026-05-08 13:59:00.213
7a7d33e8-3b45-4420-b989-156d377d8ab0	e33e08f9-dc8a-48f1-810c-bfb657d9fd48	Abel	\N	\N	\N	2026-05-08 14:06:09.13	2026-05-08 14:06:09.13
9791830a-a249-434e-a336-38011f7288a6	0ce11212-d428-4c69-ae11-c42946e0fe02	JOSE	\N	\N	\N	2026-05-08 14:41:55.558	2026-05-08 14:41:55.558
e6340541-1106-41c1-a0fc-38747ea45ca0	0efe47ef-da7e-48d2-b1fa-3236019ba015	Daniel	\N	\N	\N	2026-05-08 14:48:19.369	2026-05-08 14:48:19.369
a9f86423-a625-41e1-98ae-10b9a7e588cd	58c3b43f-2de4-4f0a-8d99-bb8c2605cc4d	Cesar	\N	\N	\N	2026-05-08 14:50:59.125	2026-05-08 14:50:59.125
e180d2e0-9533-4d78-9fbd-fec9cf3ac167	a9aa889e-3c05-40b3-986b-cb4bd653f10e	Samuel 	\N	\N	\N	2026-05-08 15:08:20.173	2026-05-08 15:08:20.173
d02e3fbf-6957-40b9-8fe9-a7e4ad1419cf	fc72d3d5-2270-462d-87ab-0c1d6239a205	Jhon kenery	\N	\N	\N	2026-05-08 15:21:20.997	2026-05-08 15:21:20.997
90713909-a350-4a78-824f-da965b48eb9e	e5c103a5-43e8-45fc-91fe-164692d790dd	Jose	\N	\N	\N	2026-05-08 15:51:31.251	2026-05-08 15:51:31.251
50afafad-6e76-4c9d-8482-b4a7105eb61c	8d15ad5d-09a9-49d7-bcf2-5bb2261f0c32	Keiner	\N	\N	\N	2026-05-08 16:34:50.884	2026-05-08 16:34:50.884
70f04f60-de1d-4118-b288-350a86d821d3	c8717ec0-2459-4453-9e07-def794fce32f	Emanuel 	\N	\N	\N	2026-05-08 17:26:59.897	2026-05-08 17:26:59.897
3fbd1252-8028-4821-bd1e-39d8b4988e73	7cdb0b1c-4dc2-40d0-877f-56ce39b46daa	Diego 	\N	\N	\N	2026-05-08 17:32:48.225	2026-05-08 17:32:48.225
6f50a05b-0711-4fea-adae-0ac2d3a31210	2c6d2131-3229-4cba-ae3c-794f14ca9580	Andres	\N	\N	\N	2026-05-08 18:02:26.711	2026-05-08 18:02:26.711
ce76b353-8d38-422a-b79e-d21fe164906f	eebf9f36-165f-455b-a649-d5f55d69baa0	Samuel  Sánchez 	\N	\N	\N	2026-05-08 18:10:33.511	2026-05-08 18:10:33.511
898401c5-9064-4d53-a61a-b3b45f135cf4	975162b0-1c94-4cc3-b740-b2b3a82c4870	Roberto 	\N	\N	\N	2026-05-08 18:12:43.891	2026-05-08 18:12:43.891
9badb116-d688-4663-b273-525edb6f2896	80140d9b-39a6-4691-bf0a-c0d00872de78	Omar	\N	\N	\N	2026-05-08 18:39:06.067	2026-05-08 18:39:06.067
2790808d-cc81-4c54-b7d2-4ab5ae7caacb	5317732e-ec0a-4c09-ade5-d28c2289c8f1	Henry Alberto 	\N	\N	\N	2026-05-08 18:51:09.87	2026-05-08 18:51:09.87
dc4dec8c-3115-45d8-92e1-89d278c48127	b075c824-5525-4904-8f72-e3812b41c53c	Carlos 	\N	\N	\N	2026-05-08 19:35:16.282	2026-05-08 19:35:16.282
41f05922-9fc6-40e3-af61-1e087997219a	fe11c4ad-6c7a-41b2-ad11-84071a3914be	Balyan 	\N	\N	\N	2026-05-08 20:11:19.564	2026-05-08 20:11:19.564
cb9c5156-8237-40e3-9ef0-3007100f9640	20de6987-2064-4d47-84ba-4d3763b67d51	Juan Pablo arenas 	\N	\N	\N	2026-05-08 20:20:21.239	2026-05-08 20:20:21.239
b4f113b5-5da6-4a89-aa85-a5a3e3d85487	13a6bff7-f64a-401f-8ff8-efe774497c49	Raymundo 	\N	\N	\N	2026-05-08 20:44:55.729	2026-05-08 20:44:55.729
359950d9-7d89-40d1-bf20-c3f748f26b9a	2b90c33b-af34-43b3-bec6-27c91d08d9e7	Cristian 	\N	\N	\N	2026-05-08 20:58:40.539	2026-05-08 20:58:40.539
0547980e-bc59-43e7-801c-0bd2e93de500	d55352a5-24d8-4aa0-92ac-e47c2a8b8055	Jose	\N	\N	\N	2026-05-10 04:11:24.627	2026-05-10 04:11:24.627
fe3ceff1-6245-4697-b608-3f4be38c3628	0986237c-cb80-4d13-a8aa-f86253b614a6	ANGEL 	\N	\N	\N	2026-05-10 05:06:41.992	2026-05-10 05:06:41.992
0de7e86e-7131-4f5e-8e84-3df77ceb883b	da92e284-f3ac-4797-a6d6-f2860ae59752	Andy 	\N	\N	\N	2026-05-12 19:51:58.23	2026-05-12 19:51:58.23
1d4dcc97-6d04-42ba-8aa3-dc0119efc7d7	8378d82d-b63f-49d5-8856-f515f0e2ccd4	user2	\N	\N	\N	2026-05-13 00:59:44.992	2026-05-13 00:59:44.992
3a8509e4-db23-4d84-852a-13f9c3b74c90	585fe0ad-dc81-4fa4-b28f-c0ab16e62c25	Jhon 	\N	\N	\N	2026-05-13 03:50:10.149	2026-05-13 03:50:10.149
76ced0f0-7d84-42e1-95bd-7fffae9a47e8	3e6953f8-8684-499e-8b22-d9c8f0403332	Cristian	\N	\N	\N	2026-05-13 13:23:46.786	2026-05-13 13:23:46.786
14bbcad7-1587-4351-beef-31ba7dfdd18c	370e5880-5ba0-4526-ba76-14f34e7dd92f	José 	\N	\N	\N	2026-05-13 20:33:41.245	2026-05-13 20:33:41.245
3f757873-2f72-4a30-b198-32db9d06be3d	a7cdc984-83f0-49e6-9351-53e0d7103501	Yefferson	\N	\N	\N	2026-05-13 21:50:48.767	2026-05-13 21:50:48.767
b4be30f8-ddc2-421a-b46f-623111ac3ba0	4da2c430-d1ea-4387-bccd-dd27daded98c	Alonso	\N	\N	\N	2026-05-13 23:12:37.979	2026-05-13 23:12:37.979
d7482534-9f77-4382-9b14-68348a149484	10f0f50b-675d-4fb9-bb15-b5e57bdbc52b	Daniel	\N	\N	\N	2026-05-15 01:22:45.819	2026-05-15 01:22:45.819
1b0268aa-e890-45bd-9177-39b4fa7ba0d3	c7d27475-082e-49f5-9810-2b87ed7428e0	Alexia	\N	\N	\N	2026-05-15 03:39:58.418	2026-05-15 03:39:58.418
955cf3fc-dd51-4be7-93b5-5c442bdf8647	5927fde2-f73e-4a02-afcf-08212a5dd015	Enrique	\N	\N	\N	2026-05-15 21:37:26.565	2026-05-15 21:37:26.565
7f60bc71-7b03-4ac3-a8f1-931f21b043b7	20f409ec-a9a0-4759-a2e0-841a58ad4583	Wildoro	\N	\N	\N	2026-05-16 04:38:24.082	2026-05-16 04:38:24.082
0a25a94d-d5e0-4ed4-99d7-394b952da93c	d83c5124-fd8f-4204-a9c7-f413cbc3d73d	Percy 	\N	\N	\N	2026-05-16 13:17:24.699	2026-05-16 13:17:24.699
d0c4485c-2e08-442f-aa22-786e4665fe62	bb77090c-f3fb-4421-851b-87649fdc9140	Maycol	\N	\N	\N	2026-05-17 00:27:54.21	2026-05-17 00:27:54.21
06bc0107-650b-4295-9c2f-b691d7c173a5	b3512702-02e5-4d5e-82e3-61c9c08973b5	Freddy antonio	\N	\N	\N	2026-05-17 01:02:48.875	2026-05-17 01:02:48.875
7f4a2d4f-a88d-4c01-86f8-5d7eed10c9de	4166446a-428a-4e83-95a1-3491ff92f622	Jonathan	\N	\N	\N	2026-05-17 07:59:14.617	2026-05-17 07:59:14.617
0eff4fbc-f620-48a7-8311-115e2619685d	ba25f67a-9d84-4e41-b869-77062401666f	Jose	\N	\N	\N	2026-05-17 22:28:46.545	2026-05-17 22:28:46.545
ff6eb9f7-1022-4cd6-aa5a-b037687ec160	dece3752-d51b-4d32-95ba-480d73b55db1	Miguel	\N	\N	\N	2026-05-19 06:50:49.835	2026-05-19 06:50:49.835
ad6b99a1-5efd-466e-83ed-b826d0634c9f	940e28c5-35f3-41ba-b0bf-5d958a85fbf7	Gello	\N	\N	\N	2026-05-20 03:42:47.447	2026-05-20 03:42:47.447
3b7dc63d-efc1-4785-9389-33b17e2823cd	a26f840d-db0d-40d8-b881-2005b8cf4473	Dervy	\N	\N	\N	2026-05-22 03:42:41.09	2026-05-22 03:42:41.09
5385401f-888b-4472-b826-a67f22ad1e1f	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	Carlos	\N	\N	\N	2026-05-27 08:25:12.139	2026-05-27 08:25:12.139
3e4cd069-a0f0-4755-8dd9-d07fc1e8a400	4e33169a-9f8c-4251-b531-fa7c38521bc7	Darwin	\N	\N	\N	2026-05-27 13:04:16.855	2026-05-27 13:04:16.855
e44fa29d-7e21-4ed5-8593-335f53099ca5	a8c3a75d-a86c-499e-9636-de4a14cdad5c	Antoni	\N	\N	\N	2026-05-27 15:45:01.95	2026-05-27 15:45:01.95
15db3ad0-abc1-4a3a-adfe-08fde30564b0	b342bee4-6e60-4395-b242-1f939d7967ca	Cesar alonso 	\N	\N	\N	2026-05-28 01:49:54.386	2026-05-28 01:49:54.386
4cc4af59-3c21-4e57-8c86-bef66cbdcede	64e07836-b136-45c5-87cf-41c14d10d114	Cesar	\N	\N	\N	2026-05-28 07:40:16.771	2026-05-28 07:40:16.771
ae61d8c1-6700-4086-9217-3ad022b43d30	a63afb22-98a2-4499-ae4b-fc21ea76eed5	Trigozo	\N	\N	\N	2026-05-29 19:19:18.649	2026-05-29 19:19:18.649
06c4d723-6206-4e67-b924-c8feaa4cbc34	58f02c46-5a60-47bf-b260-6935fba622d2	Milker 	\N	\N	\N	2026-05-31 03:53:25.851	2026-05-31 03:53:25.851
16507a5b-e0a2-4888-8585-9430b5826dcf	a89853a8-82aa-4b46-9bf6-005479c699b6	Junior	\N	\N	\N	2026-05-31 04:16:31.397	2026-05-31 04:16:31.397
6a85ee8b-2fe5-48be-bcd5-82b470a772f0	47aec11b-cf7d-4b92-81bc-70df20808a09	sebas	\N	\N	\N	2026-06-01 23:41:55.221	2026-06-01 23:41:55.221
f196aa64-a1a3-4c1e-86d4-d8bc1e56edff	b3c3c1e3-2c07-4014-99fe-9e888da32da0	Erick 	\N	\N	\N	2026-06-07 05:17:14.285	2026-06-07 05:17:14.285
9d7b4a11-4fa9-4ae5-a129-66c8e6943f6b	60ff77b5-54f8-434f-a918-2a981a03112c	Franklin	\N	\N	\N	2026-06-07 11:39:01.212	2026-06-07 11:39:01.212
1036a0ba-5881-4bd9-8138-2682487a3aac	a196b0f9-6e1a-41be-91df-cb19b320504a	Leo	\N	\N	\N	2026-06-08 04:25:40.224	2026-06-08 04:25:40.224
fb04e5cd-809b-48cd-9a72-2016181e9f54	56ebdbbb-8356-4503-89fa-791d55f200e5	Jhon 	\N	\N	\N	2026-06-09 07:47:28.014	2026-06-09 07:47:28.014
29c74b0e-6c09-44da-97bb-070ab6ecca34	189b0b52-fd73-470d-a4b2-b478b48d6868	Gustavo 	\N	\N	\N	2026-06-10 13:37:37.459	2026-06-10 13:37:37.459
095ce065-236a-4bf5-9ea3-17201b5a2bf6	941d8710-2e84-45dc-a1a1-6bca465fb251	Gio	\N	\N	\N	2026-06-10 16:43:19.622	2026-06-10 16:43:19.622
a552528a-9610-4035-9e59-75793a61ce34	6a5428d5-36cd-4d6e-ba3e-5977d06382ba	Noe	\N	\N	\N	2026-06-11 01:12:17.813	2026-06-11 01:12:17.813
eb5e6ef8-aadb-47cb-99df-d0675c2d1096	dd378c51-dec5-4580-bdd5-5f6975e1a3c8	Jhan	\N	\N	\N	2026-06-11 02:53:02.784	2026-06-11 02:53:02.784
98bcc671-57f9-46e2-a455-5697628d4bbe	10a7e4d8-d4d0-48f6-9b6f-9b5ff680f74e	Julio	\N	\N	\N	2026-06-11 07:27:05.08	2026-06-11 07:27:05.08
81845088-449d-458e-bb49-a54d62e2d922	9bad8d77-2bbd-40d7-b9a3-e4dc02b6b951	leo	\N	\N	\N	2026-06-13 20:25:46.216	2026-06-13 20:25:46.216
81de2239-21ee-4e9c-9695-fd5142b5b1a9	8e66e230-01a8-4503-bcdf-d90b4e431843	Harol	\N	\N	\N	2026-06-14 05:48:50.348	2026-06-14 05:48:50.348
7cca52d3-ba17-4c37-ae9d-b97c35abe30a	b95dcaf7-1ecd-4989-9237-bf0fec59efa2	Ale	\N	\N	\N	2026-06-15 20:26:57.805	2026-06-15 20:26:57.805
9b21e528-9707-42ce-85ab-1384a186b2ca	28fc4580-2010-4f0a-a39c-69cc54892617	Riky	\N	\N	\N	2026-06-15 21:22:53.563	2026-06-15 21:22:53.563
c0f6e5e9-9269-4d4c-8f82-2d8ebbf0dc38	0bf540d7-7834-4bfc-ae21-aba70e72b5c4	Sergio	\N	\N	\N	2026-06-16 09:14:23.102	2026-06-16 09:14:23.102
6adcc36e-5a7f-4409-aac9-dd12d41d9ca8	b06e72ed-13c3-4cff-823d-7977816685bc	Paredes	\N	\N	\N	2026-06-16 18:22:28.752	2026-06-16 18:22:28.752
71a055e6-a6ba-407f-957d-4e6d3a6bb5cf	5833ebc0-98f0-4a13-88fe-da3b1bc5b694	Jhoel	\N	\N	\N	2026-06-16 23:19:22.847	2026-06-16 23:19:22.847
5e642d3b-d112-4540-b0e6-edffd4a26afc	48869768-30fb-48db-86b4-9dc9d45fe727	Jhoel	\N	\N	\N	2026-06-16 23:38:16.446	2026-06-16 23:38:16.446
6596b035-a742-4c67-9b17-f05519071e52	e9f70fc1-a4b3-4ba7-aebe-80dd634a8d1e	jhoel	\N	\N	\N	2026-06-16 23:45:08.548	2026-06-16 23:45:08.548
0fc86da3-112a-4e45-b1e8-867cccb4aa74	1ee9e50f-7fce-4125-ad85-c544b4ee68a4	Paredesjhoelemp	\N	\N	\N	2026-06-16 23:57:55.183	2026-06-16 23:57:55.183
3573ee54-8ffc-433d-9ee5-f14cdbdd09f6	c61a6045-e7e9-44b2-93fb-ad367b08cb93	Jhoel	\N	\N	\N	2026-06-17 00:06:32.118	2026-06-17 00:06:32.118
dba6f5e0-a890-4a75-bcd3-99d7c80e5941	4215b759-9065-4de2-8d20-6397fffac991	Jhoel	\N	\N	\N	2026-06-17 00:39:20.315	2026-06-17 00:39:20.315
6ae123ce-8a5e-49ce-a3f6-22c1d656b4c1	2ca49a07-c657-4a76-9898-8cee99b8bf5b	Miguel angel	\N	\N	\N	2026-06-20 05:16:10.033	2026-06-20 05:16:10.033
8f16d94b-8100-437f-8a2b-909dfd4758a5	ee1cafe5-bb22-426b-bfec-c0471f2cff7f	Caesar	\N	\N	\N	2026-06-21 21:47:28.829	2026-06-21 21:47:28.829
f28563fb-4891-49b3-bf7a-3f7285b52a9e	01b121d2-a965-4ac2-bc8d-bde43303ad39	Gustavo	\N	\N	\N	2026-06-22 07:49:15.993	2026-06-22 07:49:15.993
3de52372-e753-481e-96a1-cf156bceff9e	2cabf7df-555a-467a-9cbd-3add658b68ce	Anibal	\N	\N	\N	2026-06-22 14:44:17.407	2026-06-22 14:44:17.407
2f99d1e4-0d87-4278-813a-4df83ace2cde	6885d8b2-726e-4e47-a1a5-b10d2234cd4d	Erlinda	\N	\N	\N	2026-06-23 10:40:51.458	2026-06-23 10:40:51.458
65248e23-b7f3-4c62-b494-d3c20cd88e48	011655d4-c895-49d6-aedb-af203c5a274b	Jesús	\N	\N	\N	2026-06-24 05:59:08.581	2026-06-24 05:59:08.581
e9f392d4-8af1-4428-a765-bfa67e5af755	e9159f6f-711d-4404-bb6e-e789072b7281	Jhan	\N	\N	\N	2026-06-25 02:30:06.513	2026-06-25 02:30:06.513
0da7fc43-3fae-44fb-bac1-b0a1e3b22085	624d8d60-25d1-4344-981f-4ead2477afea	Leo	\N	\N	\N	2026-06-29 20:54:05.578	2026-06-29 20:54:05.578
afe34484-2b5e-441c-a1c3-6993fff54c74	8b87715a-1a1b-42f2-a336-b106972cf7d0	Pachamama	\N	\N	\N	2026-07-01 20:25:53.581	2026-07-01 20:25:53.581
5b1942ca-5ff8-498c-8d58-4dd76ed1fb89	e9985fa3-2a2c-40a3-bdf6-a4c9feb9de42	Jerlicksson	\N	\N	\N	2026-07-05 02:04:39.359	2026-07-05 02:04:39.359
aa56bbef-d59c-4b13-bd0a-06de226a069e	dc74b107-7bd8-421a-b762-c5fd6977ccb0	Pachamama	\N	\N	\N	2026-07-15 06:17:34.081	2026-07-15 06:17:34.081
4afd5f36-d7f5-425e-a9e4-5385423efb17	2c406a15-425f-473a-aaca-1b04d8ecfd8f	Ornella perez	\N	\N	\N	2026-07-15 06:27:26.079	2026-07-15 06:27:26.079
65e9eed4-2692-40cd-b8f7-19f1fb2e924a	b4364d07-e796-45d1-9fd7-575a8ab796e7	PACHAMAMA	\N	\N	\N	2026-07-15 22:44:05.678	2026-07-15 22:44:05.678
b6a81ced-6a29-43a9-a616-9169330e69ce	9e692bcf-dd5e-48c8-ba02-db1c5b03913f	Juanaperez	\N	\N	\N	2026-07-16 00:37:53.589	2026-07-16 00:37:53.589
f7da16b8-3787-489a-ae52-38446cd5c175	4a9df2ac-3b35-4baa-8725-e21c81398dd3	Luis	\N	\N	\N	2026-07-16 00:49:24.725	2026-07-16 00:49:24.725
8c696479-c838-473f-83ef-261a9533cbf2	9c97906d-d2d7-4c7e-b796-ffaa83570eee	Jim	\N	\N	\N	2026-07-16 03:42:46.05	2026-07-16 03:42:46.05
dbd499e9-4658-4e08-8d8b-6ffbf84dd343	ff84c1c6-7ffb-4c0e-8b6e-c1590c140b8a	jhoel	\N	\N	\N	2026-07-16 04:40:56.482	2026-07-16 04:40:56.482
92376ce3-2a25-4f72-abaf-a20f7317a065	69273148-40bb-41b6-bea6-2c0a012528ef	Cinthia	\N	\N	\N	2026-07-16 05:58:26.415	2026-07-16 05:58:26.415
97b78c32-e5fe-4a11-ba0b-5935a2d6d8a2	f7973d9c-5f40-4355-818b-27b87f63c686	Luisa	\N	\N	\N	2026-07-17 22:19:50.778	2026-07-17 22:19:50.778
3c5134f5-a914-42f7-8a52-1239701c6ce0	fa07b0b3-9d12-49f7-95ce-68db809ea86e	Ornella	\N	\N	\N	2026-07-17 22:30:37.477	2026-07-17 22:30:37.477
68e2b6b8-cf3e-42c3-84be-2cd2bba4258c	6a84b80a-11f1-47a3-bb87-5e6e9097930d	Daiary mía Fernanda	\N	\N	\N	2026-07-18 02:38:53.145	2026-07-18 02:38:53.145
ce517190-6bf2-4fd6-9d66-99324f3edbf3	a3c9346c-cf3d-4e7a-a154-bc66c067ffdd	jhoel	\N	\N	\N	2026-07-18 19:48:31.475	2026-07-18 19:48:31.475
8d4dc8ff-ccce-4914-a911-59585cb5cccd	d295a430-11b3-46fe-a706-1dab4a7771ac	Jhoel	\N	\N	\N	2026-07-18 19:50:00.976	2026-07-18 19:50:00.976
379565c5-532f-40f0-9827-51a421e75011	25fb53a0-e8d3-40cf-97a0-1c629b8424a9	Proyecto	\N	\N	\N	2026-07-18 20:05:39.275	2026-07-18 20:05:39.275
e7e537b7-d09e-4069-b74f-b13431ab55a9	417f8dec-d73d-4e55-a170-7fd05748b315	Diego	\N	\N	\N	2026-07-18 20:09:10.143	2026-07-18 20:09:10.143
7be28ecb-97bd-4be9-9bb8-f5d227cf165a	52ba6f5c-999b-4f9d-892a-6946c2e7fe85	Diego	\N	\N	\N	2026-07-18 20:21:15.608	2026-07-18 20:21:15.608
ea415319-8067-4852-976c-3921c739579f	dfadeb82-59f5-4f2d-824d-a435e40d7484	Susej	\N	\N	\N	2026-07-19 02:11:30.461	2026-07-19 02:11:30.461
5043ef21-7684-4a3c-8f7c-2e748760d33d	ef1d27b4-7719-4bd7-89c3-c5b0f128bfee	Super	\N	\N	\N	2026-07-20 22:49:30.756	2026-07-20 22:49:30.756
a00bec9d-1d79-4bb2-97b8-cbf370809cae	26f4ea3d-ad31-4cdb-bea7-87388d707507	Fatima	\N	\N	\N	2026-07-21 02:01:42.328	2026-07-21 02:01:42.328
ee224056-5f89-4b8a-aead-d1d65046dcdf	a8a1d046-f4c5-431c-939a-f68bfe2cf274	Automatización	\N	\N	\N	2026-07-21 02:03:11.539	2026-07-21 02:03:11.539
d3c48f69-d6c4-44f8-a57f-baec0c918236	9c6ea184-db3d-471f-b8bf-a55877ee1ca7	Keyner	\N	\N	\N	2026-07-21 04:36:41.964	2026-07-21 04:36:41.964
15d39649-f7df-47f3-a881-4de9c7dcc907	8eefeb9e-8d9e-4278-b904-778e5727cfb9	Aldair	\N	\N	\N	2026-07-21 05:05:21.762	2026-07-21 05:05:21.762
a73bb374-c779-4203-bfa5-2e195e89e480	3a144e76-42a6-4a5f-b1e6-bac39df8c8a0	Max	\N	\N	\N	2026-07-21 05:27:05.939	2026-07-21 05:27:05.939
1571aa65-5d37-4e4f-9e89-3c159df5b0e5	c1d487fe-ca5d-4d9f-9bf7-5b85c3b96121	Pachamama	\N	\N	\N	2026-07-21 15:08:33.41	2026-07-21 15:08:33.41
ea4442d4-ba50-4810-bc82-b02ab0324570	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	Dilber	\N	\N	\N	2026-07-22 01:36:01.466	2026-07-22 01:36:01.466
805901c0-0c62-46bf-8e78-6fea8bfcaf5a	63e172c7-36e6-4c68-a980-fccc0bdece37	Nixson Adelkis	\N	\N	\N	2026-07-22 03:00:13.086	2026-07-22 03:00:13.086
\.


--
-- Data for Name: user_subscriptions; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.user_subscriptions (id, "userId", "subscriptionId", "expiresAt", "createdAt") FROM stdin;
dae57d90-5962-48c8-8150-6ce8abff0b7e	b6e54a63-4b05-46e5-8586-5f307f47006b	898676a1-7746-4099-add0-20799ce6a481	2026-05-06 23:38:09.479	2026-04-08 22:27:26.826
bd25e3b3-8a5c-4099-a88e-bfdc7d4ea16b	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	82615729-ff9a-4b2f-b36a-b1fec9c32d7d	2026-05-07 00:29:41.119	2026-04-07 00:29:41.12
539c7c52-d32a-418d-84f9-0e17b8b51fcc	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	898676a1-7746-4099-add0-20799ce6a481	2026-05-26 03:48:24.381	2026-04-26 03:48:24.386
7995acc1-3ac7-481a-b07b-8d523a43be04	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	898676a1-7746-4099-add0-20799ce6a481	2026-05-27 02:59:45.851	2026-04-27 02:59:45.854
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.users (id, "phoneNumber", email, password, "firstName", "lastName", "isProfileComplete", "createdAt", "updatedAt", "lastLogin", role, "resetPasswordExpiry", "resetPasswordToken", "isActive", "fcmToken", "lastActiveAt", "referralCode") FROM stdin;
ed917127-6f95-432e-aed5-7c4a8cf4157f	51933453022	jose.cp86@gmail.com	$2b$10$x4CvxfiAM06VVvGgY7DvVe/1RCS8Bw1/rpwMeFlGQBYJ8aOhuyaS.	Francisco		t	2026-03-29 03:22:48.903	2026-07-15 06:16:49.321	2026-07-14 17:09:48.246	USER	\N	\N	t	\N	2026-07-15 06:16:49.317	\N
a26f840d-db0d-40d8-b881-2005b8cf4473	51929268507	dervy.2023@gmail.com	$2b$10$hLZ7VuwU/nHRWP.vfw5X4.Lsj4wbfcBIvaGdlfLDIsjJmwtzKyy/6	Dervy		t	2026-05-22 03:42:41.09	2026-05-22 09:35:21.787	2026-05-22 03:42:41.106	USER	\N	\N	t	\N	2026-05-22 09:35:21.782	\N
20f409ec-a9a0-4759-a2e0-841a58ad4583	51957801576	djwillow1289@gmail.com	$2b$10$.bHHBo4Yutc0QmG0/7e0l.Uldku9f2Ii3I0qTFozG1CmPDNG0Z.bm	Wildoro		t	2026-05-16 04:38:24.082	2026-05-18 19:53:10.792	2026-05-16 04:38:24.09	USER	\N	\N	t	\N	2026-05-18 19:53:10.791	\N
2a051152-23c8-4597-a95a-cfbb96105715	51922721055	daniel05sanchez@gmail.com	$2b$10$Gs8K.7qjJcp4UOgbl/7KD..4UcehaWVtczgwqIaIT9csv0OheAagS	Josue		t	2026-04-05 01:02:12.442	2026-04-05 01:02:12.452	2026-04-05 01:02:12.449	USER	\N	\N	t	\N	\N	\N
8c116257-5c9a-44ab-9ed1-f5412bf989f8	\N	anygarciagonzales67@gmail.com	\N	Elizabeth	Liones	t	2026-07-16 05:45:11.38	2026-07-18 04:32:40.283	2026-07-16 05:59:38.29	ANFITRIONA	\N	\N	t	dpmW9GS6Qn-j53w5fRMRcT:APA91bH2DI5RtUZf9Erh_pRo1hfTE7-DVbiFk4_HsMlIJy6zWDOU2todKW69hFJFrW5vrXrQd8zV-KPRZtiok6kaiti6uitX2ogxEEcSrsmBM15hW5SLBGo	2026-07-18 04:32:11.739	ELIZFDEV
47aec11b-cf7d-4b92-81bc-70df20808a09	573155536236	menostreceautos@gmail.com	$2b$10$dPbIoFh96XmUa29zq6U5c.8Fva6xw4aT4MpWo65jreM4LRDXs2Y5e	sebas		t	2026-06-01 23:41:55.221	2026-06-04 06:17:01.935	2026-06-01 23:41:55.238	USER	\N	\N	t	\N	2026-06-01 23:43:18.48	\N
2e0740ed-8b4b-4f38-8c94-25812aff3cdf	51942034671	juceflomu93@gmail.com	$2b$10$OfNaX5Adk7NS2tyt0VP3zuGA/VALyK1mi22rYzMyhR6cA2UtSNJci	César		t	2026-03-31 20:28:47.971	2026-06-10 19:33:58.616	2026-04-08 01:46:17.84	USER	\N	\N	t	\N	\N	\N
dc74b107-7bd8-421a-b762-c5fd6977ccb0	\N	pachamamatarapoto2026@gmail.com	$2b$10$WRcTnpUN4Q4PgNTjzQTXkOzR3yCGJz7oCgalzZnTvRPthFCo0G36G	Pachamama	2025	t	2026-07-15 06:17:34.081	2026-07-15 06:26:46.53	2026-07-15 06:17:46.398	USER	\N	\N	t	\N	2026-07-15 06:26:46.529	\N
8b4647cf-a910-4878-9a1d-6849a7c8af42	59168501534	juan23@gmail.com	$2b$10$knP1Z9PmY7gIL.3BB5vmb.mesD4YLxeN7RJbSFShsDBd10jj3DLeO	Juan		t	2026-04-04 17:36:58.391	2026-04-26 00:56:46.468	2026-04-08 16:22:27.624	USER	\N	\N	t	\N	\N	\N
a3c9346c-cf3d-4e7a-a154-bc66c067ffdd	\N	paredespavajhoel@gmail.com	$2b$10$4s5aMT7yHDKM4RcOAXpEm.1xVjuORCuS3xCVWX/zpxHKH1gqsM5H2	jhoel	paredes pava	t	2026-07-18 19:48:31.475	2026-07-18 19:48:32.604	2026-07-18 19:48:31.487	USER	\N	\N	t	\N	2026-07-18 19:48:32.603	\N
c6c9f4d8-c7db-401d-b15f-f9509a8089a2	5165359695	jhasesaat@gmail.com	$2b$10$wJ5qpuuK1J1l1vvMpXxv6.KBRAXlSpth70zvTOpynnkrXXqMn3dYi	Jhaseft		t	2026-04-04 12:53:32.44	2026-07-21 00:50:20.788	2026-07-19 00:40:33.619	USER	\N	\N	t	f3gn8cZZQN-NN0FTBMP-0A:APA91bG9BdYTjlvrwIc3YGIEEoWRfemx9rTltc_wNaIvW5guqSgZ7rXA2dQPVOQgxJfTIcZLCoUpCTyAz5Fueib_8DP4nafimmIKLxn398v1AGKR5ATE0KY	2026-07-21 00:50:20.786	\N
ada1e029-08db-472b-851e-5f1265a66fc5	+51928255975	duverfarceque1489@gmail.com	$2b$10$.vPBaXlIyxODLoGM85/p4Ov6BAXmy2FavqkIw4rePP9WPYkZuzCXC	Duverly 	Farceque Peña 	t	2026-04-05 03:19:02.709	2026-05-04 20:30:36.77	2026-05-04 20:30:36.769	USER	\N	\N	t	\N	2026-05-04 20:30:36.769	\N
1b001974-feef-4faf-8237-45118c83847f	\N	automatizacion108@gmail.com	\N	Automatización	dasda	t	2026-07-21 02:04:14.734	2026-07-21 02:05:10.908	2026-07-21 02:04:53.751	ANFITRIONA	\N	\N	t	\N	2026-07-21 02:05:10.907	\N
8ad7a76f-ab75-4097-b92a-b07653454207	+51957223280	aldoamasifuenzumba70@gmail.com	$2b$10$cO257nUfW28Ru1M3ma4YPuK9vQXrC2zFeHbHdSocdnXMWMF..3JLu	Ali	Amasifuen 	t	2026-04-05 06:42:52.108	2026-04-05 06:43:10.468	2026-04-05 06:43:10.467	USER	\N	\N	t	\N	\N	\N
63e172c7-36e6-4c68-a980-fccc0bdece37	\N	nixsonadelkisgaonaguerrero19@gmail.com	\N	Nixson Adelkis	Gaona Guerrero	t	2026-07-22 03:00:13.086	2026-07-22 03:08:21.677	2026-07-22 03:00:13.097	USER	\N	\N	t	\N	2026-07-22 03:08:21.676	\N
4e7e7405-7841-436d-a277-55b2d8c4299e	+59170000001	user@gmail.com	$2b$10$/E25c4LOsIs7ZRxwKpCDp.hiEMNmDZrKH6fft8chYjC1HzUxQ6.TK	Usuario	Prueba	t	2026-04-04 01:10:09.455	2026-07-13 22:43:15.744	2026-05-22 17:02:32.276	ADMIN	\N	\N	t	\N	2026-05-22 17:02:32.877	\N
9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	59168806534	jhoelparedes@gmail.com	$2b$10$yljukxJEiKPl1rwU9A3Vh.Ou2/4QS3UFmecqfJd2/Dj3ZG4ubeckG	Jhoel		t	2026-04-04 14:28:24.353	2026-06-29 21:54:30.124	2026-06-16 21:39:32.512	USER	\N	\N	t	\N	2026-06-16 21:40:26.093	\N
6f9dd63d-2ffa-4634-a840-0617804df6b7	967965952	mamanidolores2003@gmail.com	$2b$10$U7HKDyDLfo2UKrR.AC4dT.jLu3oJ8frC37lZ1dOQAnsT4LBMlHzAi	Jimena2	López	t	2026-04-05 03:52:25.077	2026-05-04 08:16:25.981	2026-04-29 02:05:37.81	ANFITRIONA	\N	\N	f	ek9STc4eQIW-eBeB9QT4bP:APA91bHtmCgBi4QoIx83afriW0-T8iemSiQ81aP3ttsY6APS1wp6mFj1azjV76a-l09NvhyfdApCKaPKPRGVY-hQ_pLNhjrZcIvCZYAFmdnsLEIn5nH16RM	2026-04-29 02:05:37.81	\N
982f221b-fe45-496e-b958-70b8c4d0d2fc	991927783	ericapatriciapenapanaifo@gmail.com	$2b$10$yobUnltCc26eHonobaylQuRqJBj.qqpaAWbx8DY.LtFZGx..cIC3S	Stefania	Peña panaifo	t	2026-04-01 03:22:51.346	2026-04-08 17:57:45.15	2026-04-01 03:29:13.03	ANFITRIONA	\N	\N	f	crWaIjirSx65PX_t9-5jiq:APA91bFONMx6BLB1BNxK8_QA7SUKzLvWFlTn9gbByo7g7RgPSFvMsv-Z3Tw7MdqLyYWwA0fIW3KGG0-x_SCi9p69GYd38ufWqBmw0aFPkFtwQZQ4MWAxLuc	\N	\N
c2e6c369-0649-46e8-a0e2-b888d83d131f	+51967564187	erjamara140882@gmail.com	$2b$10$5WdP8nA5ri6OAiwjwhULKuh9Z5lum4PAkzYvSUxYuYM3sKLg0pZnW	Erick Javier	Marín del Aguila	t	2026-04-05 17:49:11.966	2026-04-05 19:27:07.638	2026-04-05 19:27:07.637	USER	\N	\N	t	\N	\N	\N
ae043ef6-64d1-4cdd-aead-cfaac366d79b	+51925895796	jhonnyriveroscorrea@gmail.com	$2b$10$a1p92ckoth70UmfHq75f/uJCL425nN9poaV1k8WJTMnHbdll3a.uG	Jhonny	correa	t	2026-03-31 19:19:24.691	2026-04-11 11:33:28.563	2026-04-11 11:33:28.562	USER	\N	\N	t	do6jE5VnTB6cVIDnvhr6Fk:APA91bHyGzS-lCqf5469nO7jdR7NdV-xPOPV9SUhSPqiaxq2kVMqVGfykPJBSiiev5ztbLwVPHbRXZJn34E-vAQVlDTX7LM6CJ_YOh9tRxGDwdv1tQnoS14	\N	\N
eac25be7-9bea-446f-8546-ae3f5b312d71	+584243246877	mari30009605@gmail.com	$2b$10$w4jxR7IPz005bckV./e0gelfx98lt/Hou9N77xjWk8eOMC.YE7Q9W	Marioxy	Graterol 	t	2026-04-05 12:50:35.99	2026-04-05 12:50:36.004	2026-04-05 12:50:36.002	USER	\N	\N	t	\N	\N	\N
55818434-6bf8-4190-851d-96dae9acb2b1	952461134	rivassnareth@gmail.com	$2b$10$VzKAJ7u7qDcECFcImluEkupD2CiPcxsljPt516i0VP2a1G7HiFBEK	Nazareth	Marcano	t	2026-04-05 05:07:37.061	2026-04-11 03:07:31.845	2026-04-07 02:45:38.696	ANFITRIONA	\N	\N	t	e68ptTH0STC9TzwnQn8JCP:APA91bGagMthGGv54RaKhiZzjizs18zRFhMpmUMOpkQMFJzYPyZV2Kv6pRsyoKgKh4Y2kYchP7Ql2j1jkrHNHI8qtyMXDhkKz7SJQoQvagWisyC-RvC8YaU	\N	\N
ed57ec95-8351-4367-8d45-f4b91911a099	+51932568049	abadjhonatan.31991@gmail.com	$2b$10$meJ8PeFADaOLoOMArBBLS.H.ZWOTvP.HlbwEwqa13omJ5AE1tDR6.	Jhon	Lescano 	t	2026-04-05 19:18:04.038	2026-04-05 19:18:35.748	2026-04-05 19:18:35.746	USER	\N	\N	t	\N	\N	\N
e66556cc-de35-467c-bffb-2bb10f08adef	+51915240789	shapiamajonas@gmail.com	$2b$10$kxHfo0JWDHqZn71USywDJul6LAQAKSQBeAaaNLIvB0tp5TGy6MZm6	Jonas 	Shapiama 	t	2026-04-05 22:51:46.116	2026-04-05 22:52:27.097	2026-04-05 22:52:27.096	USER	\N	\N	t	\N	\N	\N
8f36a80a-9e9c-4bc9-8603-72b22ae3c5f7	+51930529367	williamsocualaya23@gmail.com	$2b$10$uIxmidP4tpOM2rZHBCXPIuLwqB1G8wSDkH1hc/RD5pqZAtyavSEWq	William	Socualaya Zuasnabar	t	2026-04-06 01:34:56.231	2026-04-06 01:34:56.239	2026-04-06 01:34:56.238	USER	\N	\N	t	\N	\N	\N
9b580b58-46f3-4a8e-9319-7f3752ef92e2	+51922281748	sandrobaradalessaavedra63@gmail.com	$2b$10$sorY6djTmBT/HF2C1gOKG.faCD59HTPAUFcROmnPk8QMtgxsRFWQy	Sandro	Bardales saavedra 	t	2026-04-06 02:31:25.348	2026-04-06 02:31:25.356	2026-04-06 02:31:25.355	USER	\N	\N	t	\N	\N	\N
70eaa20c-9ea3-4368-865b-e82cc82efa23	+51913917453	yohancr345@gmail.com	$2b$10$m7YEbhJ08iNXRxC/0O.5T.mDakzUf/vp/m3Cts1zsq6Bcj4oCYAHG	Yohan	Carrion	t	2026-04-06 04:49:48.19	2026-04-06 04:49:48.203	2026-04-06 04:49:48.201	USER	\N	\N	t	\N	\N	\N
e59bf2b9-b176-4799-8e53-4132c7b4a82e	+51903083854	benji_el10@gmail.com	$2b$10$aGedcDTNxIrECzMNDIIjh.8kK33AxzB75jlhSeqvlZJlCipFOtOwK	Gema carlos	Alfaro 	t	2026-04-06 05:56:14.498	2026-04-06 05:57:09.877	2026-04-06 05:57:09.875	USER	\N	\N	t	\N	\N	\N
d832267c-c7e2-403e-85b1-78bb34a68493	51953901503	pierinho1206200177@gmail.com	$2b$10$YLCcbwBlSSS1XC2K9rP3S.f6Tfq7JlHCSY2rzVf4wgZLpbcf1FIQa	Piero	Joseph	t	2026-03-31 22:28:25.889	2026-03-31 22:29:09.433	2026-03-31 22:29:09.432	USER	\N	\N	t	\N	\N	\N
b2b9ec93-8741-4fa9-be0c-18b84d7d6ade	991927784	erocapatriciapenapanaifo@gmail.com	$2b$10$ghWQ0JVju7ieQdAC5n1fYu6siILukcg6L9kjmBoUREpmhwtOJLToa	Stefania	Peña	t	2026-03-31 07:44:48.455	2026-05-04 08:18:31.759	\N	ANFITRIONA	\N	\N	f	\N	\N	\N
affb0349-62e6-46a4-b877-f5a0e5a60ca0	917547719	karolaycampos62@gmail.com	$2b$10$BoGx.dg7p/Iu2C2qcRhK.uH4YDPxZFE2c6JgwMUHf3FWnORcDvtgy	Karito	Campos	t	2026-04-05 04:33:11.141	2026-05-16 05:08:00.401	2026-05-09 23:50:27.664	ANFITRIONA	\N	\N	t	e6MgelQuSj2oXrRV8hEay_:APA91bHzwWUmod1cn5K6LMUDlFFX6LcH3hN3_V0ax86LjuVXcDBB0n1yp9STIeNMI4fvBiL4cENWGaFXHbDicO8VllhtnCFzQ0AKS1p-O9ORlyYZ8h8IrOg	2026-05-16 05:07:54.723	\N
b5b75c40-3df4-4efc-a9c9-ed40804cf0e3	+584144069028	guevaravismar2@gmail.com	$2b$10$7WwGYH4ayzt5wkpDjeDTO.KwSJcq1Dt4Y8KmWvGtk4eGAhm4mEXCu	Camila	Torres	t	2026-03-31 03:55:05.483	2026-05-04 08:09:07.61	2026-03-31 03:57:42.422	ANFITRIONA	\N	\N	f	\N	\N	\N
81a59313-a192-44e6-9532-da180367abf0	+51925133095	jacjeyse1998@gmail.com	$2b$10$ORLZzbFQDpeu1TLS9BpPJ.nLi7G71f0VPh3.6tz8dRoxa.ew6H8ZW	Jac Jeyse	Mendoza Mozombite	t	2026-04-01 08:25:21.183	2026-04-01 08:26:06.129	2026-04-01 08:26:06.128	USER	\N	\N	t	\N	\N	\N
2c406a15-425f-473a-aaca-1b04d8ecfd8f	\N	ornellaperez1986@gmail.com	$2b$10$BvqUlsHI1LCQdHLdACaIi.4nVXmp8bxEmaK6EOBnLrF2JhZHhJVla	Ornella	perez	t	2026-07-15 06:27:26.079	2026-07-15 22:43:25.162	2026-07-15 06:27:36.004	USER	\N	\N	t	\N	2026-07-15 22:43:25.161	\N
9f83b658-6493-4a6a-931e-ccb6b8b7cad2	51927666537	richardzuta384@gmail.com	$2b$10$RaW3G/C7ffc3oS9.NmrU0O.3sp6RPZtQNclXdYfoc4QEy9EkUWYO2	Jose		t	2026-03-31 19:29:12.247	2026-07-14 17:25:27.797	2026-07-14 14:37:50.135	USER	\N	\N	t	df8ppn4oRNONShD53UYwJn:APA91bHCv95zJkZJaUSHvWfTqtnrjUTlJwb2vGoF6bBtSEdoVgYoEO3iQBdioybFZdTNJ-AUht8JpH2tudQAKHL8UxuPYJHXwoRYphyZsf9DGgsHy26uh04	2026-07-14 17:25:27.796	\N
3f3ef803-d6af-45a6-84f4-2d22d89390dd	+573043200145	jhonalexandercordoba71@gmail.com	$2b$10$n8uxJnJ53Q72M3iaUiGjMeTTw3qDLKPK/twM5s7zDyzkzxNSTo96a	Jhon	Cordoba 	t	2026-04-05 19:56:12.553	2026-04-05 19:56:12.562	2026-04-05 19:56:12.561	USER	\N	\N	t	\N	\N	\N
d83c5124-fd8f-4204-a9c7-f413cbc3d73d	+51983867537	percyrojas23791@gmail.com	$2b$10$SvpUbF24MHYAvCpiP1Wz7eBF09wYRLu5F46nBoOWma/HMlLu1zbcq	Percy 	Rojas ruiz	t	2026-05-16 13:17:24.699	2026-05-16 13:17:24.714	2026-05-16 13:17:24.711	USER	\N	\N	t	\N	2026-05-16 13:17:24.711	\N
20553dc3-047d-46f2-9ed3-c7419554a002	\N	kat2000katt@gmail.com	$2b$10$LHzPtcXn0Rob/Q.9wNzRM.kQq/hINbYqNoFyGOjQLbyZrEzopA3MW	Vivíana	Flores	t	2026-07-16 05:49:41.466	2026-07-16 06:08:04.449	2026-07-16 05:55:44.653	ANFITRIONA	\N	\N	t	ddv0hcCTQiW03EMEiO5B5e:APA91bH52I4dJ2Ac5YSIv2nru_K9B8q7jscF8tpLI_m4RH3yrmK7CUEUTiilUG9Maby3Zq0K3J-evmUB4VYaX0zgjXmLeCeQVLuzn8Sg7PEt8_95_VLaP9U	2026-07-16 06:08:04.447	\N
bce4910d-68ac-43d9-88d5-e9a76a648ed3	+51943861007	reynataminchi@gmail.com	$2b$10$UDmTO1WR9DhX2KDbrf.0hedZ/QtDTBAlyt3S0ic5GmWnsb8T6mk06	Nayely	Reyna 	t	2026-03-29 01:24:36.171	2026-04-06 20:48:20.358	2026-04-06 20:48:20.356	USER	\N	\N	t	\N	\N	\N
d295a430-11b3-46fe-a706-1dab4a7771ac	\N	jhoelparedespava@gmail.com	$2b$10$aloCN/CVvor90RT3.Ntx0uLfTW8H3sJZ2JI1OST4sv2Pv87g4wHi2	Jhoel	Paredes pava	t	2026-07-18 19:50:00.976	2026-07-18 20:02:01.591	2026-07-18 19:50:14.404	USER	\N	\N	t	\N	2026-07-18 20:02:01.59	\N
818ce99c-0c46-4ccf-a372-6c809194c562	+51993645315	inversionescarls20.09.2022@gmail.com	$2b$10$URaS0T6pRmNA8QjODh6rSON7SRqu5QS0syfIylXk0veHH7u7sRG8G	Carlos Raúl 	Sandoval 	t	2026-04-05 00:48:03.841	2026-04-06 09:28:40.678	2026-04-06 09:28:40.676	USER	\N	\N	t	\N	\N	\N
a652dbc4-c42b-4f12-92bb-40ad705f0614	51930485808	chujutalli0622@gmail.com	$2b$10$CeIlL/uwWkpkQlPa4YvYDegTLwaAenKf5Q3T1KhPM7Mhx0omXU2Nu	WENINGER		t	2026-04-05 22:02:17.182	2026-05-04 19:50:00.198	2026-04-05 22:02:17.19	USER	\N	\N	t	fSuiQzYKTyWuG4I2GH2ZvR:APA91bEYDB3hgVFGinRaUV3TRuFHMg97cAggwyksU6s_55l2d8T3RSY3AUXTgmJJuY4ZssuhAh4CByD4Z6faqOSUqR7wSltp3wuxHfWrAXYrEPsfuqw9xA0	2026-05-04 19:50:00.196	\N
fc5201a4-0e4f-40fa-a957-766a4bdfe40c	+51990803671	joelrequejorequejo76@gmail.com	$2b$10$nzQI3yIVgbXzSuvwRiU8DO7N.whNtswsliEkrgiboZm0tB6YImOsW	Jorge 	Falen	t	2026-03-31 18:36:50.574	2026-03-31 18:36:50.601	2026-03-31 18:36:50.599	USER	\N	\N	t	\N	\N	\N
0f618476-9f1f-40d6-8e89-3f8e2554af13	51914859185	alessia777@gmail.com	$2b$10$0fKtIJSes9AGBlcywm91d.MSHojlyLQSyItymzMjvs2q8zwn/C8zu	Frey	Raul Sanchez	t	2026-04-06 01:44:50.729	2026-04-06 02:34:38.612	2026-04-06 01:44:50.734	USER	\N	\N	t	\N	\N	\N
04273fa9-2979-4a3c-81e7-f8d17b3c2d4a	+51971192990	gpa6170@gmail.com	$2b$10$dcVBXh8H/zxyRu8RcGWnOOAVLGr/Uv60vAoGswnJamIPZnqkIGjI2	Amilquer Gabriel	Pua	t	2026-04-05 06:38:49.619	2026-04-05 06:39:14.749	2026-04-05 06:39:14.748	USER	\N	\N	t	\N	\N	\N
1da91f79-a244-4896-a7d7-08e15a34564b	+51951102846	denisgallardo130@gmail.com	$2b$10$y1i5blMPf86W39YsLXXeqOyxEOkFcMw85RrnZpiph5ehZJ8XeG1oa	Denis 	Gallardo 	t	2026-04-06 01:30:04.019	2026-04-06 01:30:04.034	2026-04-06 01:30:04.032	USER	\N	\N	t	\N	\N	\N
197e5a03-33be-498e-bf56-3943cdcebaac	+51994353309	alfredimx057@gmail.com	$2b$10$rKJQaRAd0X75qUOTtNkfHewwCT7loMEWUgwq1uI3GGdC42Nqoi0/i	Alfredo 	Arevalo 	t	2026-04-06 05:31:32.237	2026-05-02 06:28:55.205	2026-04-06 05:52:05.423	USER	\N	\N	t	\N	\N	\N
85299925-2366-4fd7-8a87-272883e763a0	967965951	Heididoloresmamanimarquez@gmal.com	$2b$10$Ng8O36654uXy6DkpTkATtOr.44qGtUv4uLF5sQVddYjG3L0zEwfSy	Jimena	Lopez	t	2026-04-05 03:47:36.077	2026-05-04 08:16:19.122	\N	ANFITRIONA	\N	\N	f	\N	\N	\N
599864fe-f89b-4445-8b25-7da50697043b	+51902600137	ottoperez938@gmail.com	$2b$10$XTshEThBKukMEMuj3zcYx.7.FQGJVPLoj8OjNZfvpoiKTto/0PRxK	Alejandro 	Perez	t	2026-04-05 13:21:15.927	2026-05-03 07:18:35.552	2026-04-12 04:33:30.239	USER	\N	\N	t	\N	\N	\N
d620ed02-c818-4d04-be91-d6814a76c7f3	+51990168978	guidololo7725@gmail.com	$2b$10$FkuTASKBoMhnDE7Ogb29.us1Twl3bp/nQygNXvE9O5Ljj.kxGlpem	Guudo 	Peña	t	2026-04-06 01:44:40.278	2026-04-06 01:45:03.713	2026-04-06 01:45:03.711	USER	\N	\N	t	\N	\N	\N
42da48c6-0a1b-4783-98e6-8457d0fc8f7d	+51966774574	potro5878@gmail.com	$2b$10$1UDHyKzlsyw9PhU8h4NU4OQQOy7zjv7TFX9L4dxRZAgUdPuzC.Z2.	Jhan pier 	Ushiñahua 	t	2026-04-05 18:54:54.474	2026-04-06 02:34:38.611	2026-04-05 20:49:58.731	USER	\N	\N	t	\N	\N	\N
a0275649-e6f1-48d5-9774-de80f2dcfd06	+5355963549	eliades003@gmail.com	$2b$10$/ww8u0.4g8HlJId7KReEm.pK4QKMVlsR0lbXa4D3pEBN6qaJoUzp2	Eliadito	Borrero	t	2026-04-06 02:42:54.62	2026-04-06 02:42:54.628	2026-04-06 02:42:54.627	USER	\N	\N	t	\N	\N	\N
a63afb22-98a2-4499-ae4b-fc21ea76eed5	51931460773	wiñertrigozocenepo@gmail.com	$2b$10$K9AiWi.23ffQZQRJkUtC4uIuViCS286XUyYb/X7l1TOj2UfqCfDDK	Trigozo		t	2026-05-29 19:19:18.649	2026-06-15 22:13:07.073	2026-05-29 19:19:18.671	USER	\N	\N	t	flXXPgwzTNyATh0Hy75doz:APA91bG9xQc5A5m0QAvDocdDw9RGMZ5I_PtxcX53lcMtq38JOIo0Tey3H8QliRIlW4VQxqDF-8eSNf1uunWh2LN24YgaCu50XLVa9mNQ-EAE4pAwE085bm4	2026-06-15 22:13:07.072	\N
5ee22644-5713-4342-b613-088344267c67	0421392161	Marisusej1226@gmail.com	$2b$10$a9Bu7dwEDOhNtta8/401BOihaqcZZlPLoXe7gHYZ9DzUtbp2a.mIm	Mariangel	Figuerea	t	2026-04-05 17:42:39.464	2026-05-04 08:18:03.773	2026-04-05 18:04:03.076	ANFITRIONA	\N	\N	f	dbp0r77FRWieURbcryx3yq:APA91bH4iWTEtuEpozKea0IQCoP4ReQPSEAzisSXN4ihk-TLhsAM_oqAAk-D0sosyINT8BXJZlfatSyPOnIZXNX2KpdnY2tcMqbO7IAUxEaImgETy5lm6rs	\N	\N
6f5b20d3-fb68-475a-b304-7aa067456fe5	917465368	anymorales370@gmail.com	$2b$10$qRojtmg8wdna/ugtmdvYH.gFTCK8bUj50cbkfCxvHGKJJaIJekfRW	Sara	Morales	t	2026-03-31 02:59:25.69	2026-07-13 16:30:20.588	2026-04-05 01:38:08.711	ANFITRIONA	\N	\N	t	\N	\N	\N
b6e54a63-4b05-46e5-8586-5f307f47006b	59168507534	h@gmail.com	$2b$10$YHI8fDlTRHXS7hbGdWLBlO4ioJy5DiesevXfMmh5D8PVFMeJlnmlK	Paredes		t	2026-04-04 17:12:51.603	2026-06-16 21:38:21.406	2026-06-16 21:38:21.402	USER	\N	\N	t	\N	2026-06-16 21:38:21.402	\N
9c6ea184-db3d-471f-b8bf-a55877ee1ca7	\N	tineoquispekeyner@gmail.com	\N	Keyner	Tineo quispe	t	2026-07-21 04:36:41.964	2026-07-21 16:42:26.994	2026-07-21 04:36:41.972	USER	\N	\N	t	\N	2026-07-21 16:42:26.992	\N
28fc4580-2010-4f0a-a39c-69cc54892617	584144867818	rdmarodag@gmail.com	$2b$10$/wXZigHSwktz6BWGbtFYnOMvQBGsiQKDDJOqMZPfltSCT4ipiSsKe	Riky		t	2026-06-15 21:22:53.563	2026-06-29 21:54:30.124	2026-06-15 21:22:53.571	USER	\N	\N	t	\N	2026-06-15 21:26:18.782	\N
d2c48c15-9d40-47e7-ba16-12cb5d2ee4ca	+51928126266	jhonydelgado98@gmail.com	$2b$10$.B0i.W.tRHnUDZgcytNhq.qwADz83rEUZN60oZ3r.6O71M5oynuWy	Juan	Delgado 	t	2026-04-06 20:09:59.701	2026-04-06 20:09:59.709	2026-04-06 20:09:59.708	USER	\N	\N	t	\N	\N	\N
59b401d0-9e20-4ada-82f4-ed81872c43d7	+51926234365	sanchezportalliessel@gmail.com	$2b$10$adT0tTntOMkNt.go0E8KauyoYOsjPXiLGd.Yl/fy9OHNbYA9h4JO6	Miguel 	Guevara 	t	2026-04-06 20:13:49.981	2026-04-06 20:13:49.991	2026-04-06 20:13:49.99	USER	\N	\N	t	\N	\N	\N
f0dd8dc7-f8a8-4e9e-9652-fece4fe389c3	+51993926718	haslerpro0@gmail.com	$2b$10$4Dmkob0RhsNRPRpobZ2CTOfMlrfcrQYsSZOb.9pQAzOEWRBWicjhy	Heineken 	Castañeda Pereyra 	t	2026-04-06 14:31:13.429	2026-04-06 14:31:41.607	2026-04-06 14:31:41.605	USER	\N	\N	t	\N	\N	\N
26e11e57-9d55-4cbf-aed1-40adc9f3f410	+51986871927	alfredoanduro9227@gmail.com	$2b$10$j7DnpbWhT9jMmNqOucIZkeAuqNfIBveRtekhLhZf2pcg/wTGxkfoq	PEDRO	Ruiz	t	2026-04-06 20:21:31.572	2026-05-07 11:57:33.858	2026-05-07 11:57:33.856	USER	\N	\N	t	\N	2026-05-07 11:57:33.856	\N
8a76fc2a-6f8c-4264-89bd-9827763d0bdf	+51903035965	halbertdelacruz9@gmail.com	$2b$10$fnwOK6t4lBg1vseIwro28OjyF9HEznduJCFqgBDPmrw.q.pFeoA1i	Halbert 	Delacruz 	t	2026-04-06 06:59:08.766	2026-04-06 06:59:41.069	2026-04-06 06:59:41.067	USER	\N	\N	t	\N	\N	\N
e4264309-988e-468b-9f8b-868b750e973b	51955056008	yadiel26@gmail.com	$2b$10$rcp6.C1zZR260YStcKU6Zu9MBNW/nzOhFWDJV7L4gDjysvTKC8R/q	Yadiel		t	2026-04-06 14:37:51.119	2026-04-06 14:51:06.327	2026-04-06 14:51:06.326	USER	\N	\N	t	\N	\N	\N
fa4d11c0-b6a4-43db-81e9-2a0b247af9ef	+51997066975	neymarjringapomacarhua@gmail.com	$2b$10$BHX/GRG4TuQK2rBMj35fhOCIyZq9Uk13YoS3zQuL4APxCzt8zNbNu	Rossel Edilberto	Inga pomacarhua	t	2026-04-06 17:52:40.618	2026-04-06 17:52:40.628	2026-04-06 17:52:40.626	USER	\N	\N	t	\N	\N	\N
fe63bb9a-4219-4da1-bf8f-c52412f6e801	+51938180384	wylfredyoropezamelendez@gmail.com	$2b$10$hDWl5zSTxzmHmGLPO59uK.MhZ6QxvBHyN1BbvHluWdTN8PxxTWBpW	Wylfredy 	Oropeza	t	2026-04-06 06:03:04.364	2026-06-08 14:03:42.853	2026-04-06 06:06:32.166	USER	\N	\N	t	\N	\N	\N
5b861f19-1c5a-47c6-a9a1-b4fc35eda3c6	+51935121158	vasquezlalo157@gmail.com	$2b$10$j.2e7bokrVwnYC/OFlsQn.FK6sagTp3UNLwg7Mhz/nbrzPlS7Geg2	Eduardo 	Vasquez	t	2026-04-06 06:48:13.905	2026-04-06 18:50:25.231	2026-04-06 06:52:28.613	USER	\N	\N	t	\N	\N	\N
56bc08e8-a2dd-4a71-b14b-6ea3daa38d69	+51940406961	eddybadirdiazlozano@gmail.com	$2b$10$35xT68NQNC3hPYPUEG6FRufNPN/vzVpWIy0hqUbfL21oLOw9DfQhK	Eddy	Díaz Lozano	t	2026-04-06 11:21:24.07	2026-04-06 11:21:55.149	2026-04-06 11:21:55.147	USER	\N	\N	t	\N	\N	\N
17996dbb-d4ba-4bef-b265-115cb4a281aa	+51925594290	superdotero2@gmail.com	$2b$10$xHI3eniafFECyfT2bcHfRuH3KKMlagktqaB/BTElrShAjqxuaUk.6	Yuder	Panez Estrella 	t	2026-04-06 21:01:21.235	2026-04-06 21:01:21.242	2026-04-06 21:01:21.241	USER	\N	\N	t	\N	\N	\N
72ebb69d-756a-4924-8a1e-80d5b794c07b	+51959347933	delacruzcarbajalc9@gmail.com	$2b$10$VCBfZez2EbCRt9Ipc5MBwehw29/fuk05gUNFcGqccrZMht2hKl9ti	Carlos	Alosno	t	2026-04-06 20:36:26.227	2026-04-06 20:37:21.732	2026-04-06 20:37:21.731	USER	\N	\N	t	\N	\N	\N
954d4a1a-0d08-48de-813d-f5665b5968a8	+51979835971	wonkioney@gmail.com	$2b$10$tfHDG5Cv8HPTu36xayoNMevBBkD5KiZ/96Kn1Ic43KecyeRqODYye	Ney	Pezo Utia	t	2026-04-06 20:39:51.557	2026-04-06 20:39:51.564	2026-04-06 20:39:51.563	USER	\N	\N	t	\N	\N	\N
25fb53a0-e8d3-40cf-97a0-1c629b8424a9	\N	p6625207@gmail.com	\N	Proyecto		f	2026-07-18 20:05:39.275	2026-07-18 20:05:40.744	2026-07-18 20:05:39.282	USER	\N	\N	t	\N	2026-07-18 20:05:40.742	\N
5893d81a-370d-46e6-8783-926054e7c5d7	917570302	carmenmilenisanchezpintado25@gmail.com	$2b$10$7T8QAYxkbDDVjkVCRvO5oe4tZRbuIo.xZjnrC.c03djtGgLbjjNNO	Candy	SancheZ	t	2026-03-31 06:18:26.643	2026-04-10 01:32:09.29	2026-04-08 07:37:42.139	ANFITRIONA	\N	\N	t	dDDKFBBgQr6lnCF56aOk2T:APA91bEhH-FJrarpM3PaYFfxOAoiNmY5hPT3bBGpCY6H0_DyTqO3piY3yqcRJYZZ_dTgGTFOQRNn38csf7FFOgqiYMW4Ax5qpwdwDZnGmdhcxRHnazO3YzE	\N	\N
1d005ba4-b597-475f-964d-90ad921e9020	+51971193951	juanito15352@gmail.com	$2b$10$Ld5uzhUh9Q/Ej173YOoyLuWLGdf0vNWr556aFxSV4DHpbei5c5hbS	Juanito	Villanueva	t	2026-04-06 21:27:26.764	2026-04-06 21:27:26.772	2026-04-06 21:27:26.771	USER	\N	\N	t	\N	\N	\N
04331537-fef9-439a-ab3e-c9ffbe3c2db4	+51910730589	rositasilviagarciatorres@gmail.com	$2b$10$sB9I9bsF/6B7c9/mpfvjeOQxNqcZ0kUrZqFxDMPJGv/GVUrxrFJMq	Jhon Ander 	Tineo bautista 	t	2026-04-06 21:50:37.913	2026-04-06 21:50:37.92	2026-04-06 21:50:37.919	USER	\N	\N	t	\N	\N	\N
03daa672-341a-4cce-91ab-81f3159a7036	+51946423610	piero.dj.tremix@gmail.com	$2b$10$cmaEtN5sUQRo.xfFJE1PLugduyLOolypz6iZhHm3wFYhnGUS3zH1C	Piero Antonio	Peña Pinedo	t	2026-04-06 21:53:22.336	2026-04-06 21:54:14.098	2026-04-06 21:54:14.096	USER	\N	\N	t	\N	\N	\N
867a333a-9f97-4133-8a15-ba350f41a16f	525625470038	loloej58@gmail.com	$2b$10$1TLOIkTZWtLLVapeH41ac.3Ic0MtFRgQYQut/qoqDJ5C4QqwGC1hu	Lalosd		t	2026-04-06 09:59:00.841	2026-04-06 22:24:35.495	2026-04-06 09:59:00.85	USER	\N	\N	t	\N	\N	\N
5e935756-3dc8-42e8-b732-ac2b40b5c053	+51926445981	anggelosshots@gmail.com	$2b$10$1f7e74egZczM8ZoCxMKuLuen3jC.TO7tt5MeLJ./W78EOjy0Mge1a	Angel	Garcia	t	2026-04-06 23:24:20.126	2026-04-06 23:24:20.132	2026-04-06 23:24:20.131	USER	\N	\N	t	\N	\N	\N
d3e37a3c-cc4d-4857-9d41-ecbaaa00d6bd	+51927499559	rolandsaavedracastillo29@gmail.com	$2b$10$5SHAYy115DxhqPYwSrXQfuxef8lj5.gwuqEnhVS0dBRPYItIUXEBC	Roland 	Saavedra castillo 	t	2026-04-06 21:02:02.109	2026-04-11 02:38:35.201	2026-04-11 02:38:35.2	USER	\N	\N	t	\N	\N	\N
ab44e481-2f7a-49ea-91f0-16be463368ec	+51993465076	abraham.galarza1591@gmail.com	$2b$10$NqpwO5GhqPxo.JjM2xA6JevUIJM1/soLdLNxkfvbURDUVbz/mrg9q	Abraham	Galarza	t	2026-04-06 22:37:45.663	2026-04-06 22:38:40.239	2026-04-06 22:38:40.237	USER	\N	\N	t	\N	\N	\N
6976b2a1-97f6-48c8-8411-b4207c2f440a	+51931029621	chavezmattos88@gmail.com	$2b$10$uO1uMmg3/LWGRHXvEYBm5OMZB6GVD3uPO96rFIaXTW8FGIX5aLZfS	Edwin Fernando	Chávez Mattos	t	2026-04-07 02:53:17.692	2026-04-07 09:21:48.135	2026-04-07 03:08:06.425	USER	\N	\N	t	\N	\N	\N
36df8ef2-4651-426d-ba5f-a3edc5984168	+51954224476	sivarme1989@gmail.com	$2b$10$mFbEDBjdNEdG/of9K9RoouZhLMPuyFqymZBtJ8R0JlfPuuIMp7cIe	Silver 	Vargas Meléndez 	t	2026-04-06 21:53:51.037	2026-05-16 01:34:21.93	2026-04-06 22:24:17.144	USER	\N	\N	t	\N	\N	\N
71406cb8-fd46-4cae-bf3c-bfef2cbd50a0	+51918378964	rogerparedesmurayari62@gmail.com	$2b$10$4csQN.BfL7iOzoBnsQTZKehP7NTvx/3KGLboP145a/rdguUfWtUGW	Roger	Paredes	t	2026-04-07 02:53:35.887	2026-04-07 02:55:12.72	2026-04-07 02:55:12.719	USER	\N	\N	t	\N	\N	\N
8ac6615a-71e9-48ec-910b-244b661d4950	+51992200160	pinchigarciajoseenrique@gmail.com	$2b$10$XTmv4Q0YwyS2igx9NdX6seOBl3btQ.8cQqUe20henVATMgMJD3r2K	Jose 	Pinchi 	t	2026-04-07 03:44:23.957	2026-04-07 03:44:46.445	2026-04-07 03:44:46.444	USER	\N	\N	t	\N	\N	\N
068de07b-6b37-4f64-9586-fb4196271108	+51940668233	elmer_mendoza1993@outlook.com	$2b$10$fh5JZoKktIk20skndC02JOvt18DuW/sIp8MqsY762XR2C4Qer69jK	Elmer 	Mendoza 	t	2026-04-07 04:47:57.819	2026-04-07 04:47:57.827	2026-04-07 04:47:57.826	USER	\N	\N	t	\N	\N	\N
66d5c599-eca6-4dd4-80a9-ba19de3f0e22	+51901146312	jeanpierrearmasloayza57@gmail.com	$2b$10$5cXf0WbGmfsLMa0Oa3cQXuIGNS4JpvF3ofnJHu5s4nN5GdOeTAP1K	Jean	Loayza	t	2026-04-07 05:15:48.783	2026-04-07 05:15:48.801	2026-04-07 05:15:48.794	USER	\N	\N	t	\N	\N	\N
bb77090c-f3fb-4421-851b-87649fdc9140	+51914384969	mayex_7@hotmail.com	$2b$10$pDzibkjiuY/ReNnKtwSp3.4.4rnrbP1OOrPP.yG9yipSG6JC8Bgey	Maycol	García Diaz	t	2026-05-17 00:27:54.21	2026-05-17 00:27:54.222	2026-05-17 00:27:54.219	USER	\N	\N	t	\N	2026-05-17 00:27:54.219	\N
52c1851b-d920-4c8c-8c81-d23099affa0a	59168505534	admin@gmail.com	$2b$10$hV/VccWrZbKUqf3RDRrSoevubHb0AWYEqHo75tmE0rB0QJbYId8XK	Admin		t	2026-03-21 18:58:11.413	2026-07-19 00:39:04.454	2026-07-17 18:39:20.273	ADMIN	\N	\N	t	\N	2026-07-19 00:39:04.452	\N
0bf540d7-7834-4bfc-ae21-aba70e72b5c4	+51961733716	chujito14@gmail.com	$2b$10$ML8oF2Hx/JlrlmfWN6SO6.H/u.1OcYsnZDUwgeXB9NPX7lR6cYaSq	Sergio	Chuju	t	2026-06-16 09:14:23.102	2026-06-16 09:14:23.126	2026-06-16 09:14:23.123	USER	\N	\N	t	\N	2026-06-16 09:14:23.123	\N
48869768-30fb-48db-86b4-9dc9d45fe727	\N	401hoelp@gmail.com	$2b$10$0u85Yz7M6s2TIbSENqa/xeE1yGWYp8wq2nem26xGQz2WTjOjtKRgG	Alejandro	Serna	t	2026-06-16 23:38:16.446	2026-06-29 21:54:30.124	2026-06-16 23:43:26.239	USER	\N	\N	t	\N	2026-06-16 23:43:26.868	\N
832aabaf-e4ec-4683-98aa-75eec4924379	958733601	milanggygarcia@gmail.com	$2b$10$HdXhaqv4Oc9wd2190IzGq.2PPH6kYXK2tnZdxROnAeUNIKXYEOxNi	Esther	García	t	2026-03-31 03:13:57.917	2026-07-22 03:04:33.14	2026-06-05 02:54:08.613	ANFITRIONA	\N	\N	t	\N	2026-06-05 02:54:13.341	ESTHE4JY
0d6251c4-0c8d-47e1-871f-d7446ce48732	+51916463323	alfonsomalcamiranda@hotmail.com	$2b$10$DJnYlgniVGVC2hFCc.cLUO9fCIyh3f0AIuuE270/pH9HiT/nCZRea	Alfonso	Malca Miranda	t	2026-04-07 21:13:09.711	2026-04-08 02:43:47.669	2026-04-08 02:43:45.636	USER	\N	\N	t	et7gI-tBThK_K-rRBdpJ_Q:APA91bGZ0NiWYu8Ps8S_QrhY5wOEtNryRyLVsZzJTaJKs7QUFDvQ9wn7S9k1JyRItoYRnN0CUn7yy9RJFHyw5_in9KPTEK9wueHxJL9YrFyOULIKBwoUuoI	\N	\N
b20f5b97-e85a-46e0-a77e-7839a7c5641f	+573245492414	valenciabrahyam@gmail.com	$2b$10$hCFErTlWSYmNu9bRaCc3ieBVRsHpTlVT.vEBWeN.HpSCE/e7iT4Fy	Brahyam	Valencia	t	2026-04-07 05:21:36.357	2026-04-07 05:22:30.749	2026-04-07 05:22:30.747	USER	\N	\N	t	\N	\N	\N
6aea1710-2fa4-4f91-9516-365e823a32d4	+51995126989	alerisuiza@gmail.com	$2b$10$7FUYpTq2vyM/qWDD97eySu/.MlLoAZAhJOuGb3NMli0T41KHUXDIW	Aler	Isuiza 	t	2026-04-08 00:04:01.275	2026-04-08 00:08:40.75	2026-04-08 00:08:40.749	USER	\N	\N	t	\N	\N	\N
93586e5a-4fd0-4bd2-9287-fa4f308af08b	+51984572700	flavicastita@gmail.com	$2b$10$yEmGBRCaJRgmkEi9UDfhrOxWrL7/INto3Jt6iTflOh3xb0AWe/aVu	Flavio	Castañeda	t	2026-04-07 05:40:33.412	2026-04-07 05:41:22.063	2026-04-07 05:41:22.061	USER	\N	\N	t	\N	\N	\N
8f939ead-58b8-4491-9485-1b885ad125b4	+51981954265	jhondelaguilavasquez@gmail.com	$2b$10$g4h/pGX3czoBQtFhwOOHu.O5BfgFwMEkGnRRHyP1OFZ3AM8ESS7hG	Jhon	Del aguila 	t	2026-04-07 16:01:35.87	2026-04-07 16:04:10.709	2026-04-07 16:04:10.707	USER	\N	\N	t	\N	\N	\N
1a689cb0-82e8-4344-87e3-82044bd26ee5	+51967456977	elmefer.98@gmail.com	$2b$10$OxziyWD7Tf54sN.uuuHtu.I1p0feuT9tS879k.nLilcdPICv3Pf5S	Jhon	Pérez Díaz 	t	2026-04-07 16:33:38.686	2026-04-07 16:33:38.694	2026-04-07 16:33:38.693	USER	\N	\N	t	\N	\N	\N
0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	+51930191022	m4cro.05@gmail.com	$2b$10$VnuOlCz/agIV8f.KVf5WUeg.f4qYteW47TNF8Hjb9JGZ6AMyyVYl.	Andre	Mori	t	2026-04-07 07:53:56.442	2026-04-07 07:57:15.968	2026-04-07 07:57:10.937	USER	\N	\N	t	fRdGTX_cQtyw-Z3YPdutiU:APA91bHEMUBE17YnSGcQlHWv5Ja9T9qwWds02qZ9AJoSJf6iZsfi7ZotIsT3_Mpgyw6ZTmvUCp7q3yVA3ol8e33oqfbosPsyk6gQIk6o7KbGKvwwpk5rdR4	\N	\N
b2351447-b63a-4e96-ab43-092fb29b8b06	+51925843848	morillocortezs@gmail.com	$2b$10$r0LlwTYVrFvjQ4NcyzSvV.kFzeYbXTgzz4KIbbByNt3LgXT1iSDSy	Saul efrain	Morillo cortez	t	2026-04-07 19:25:43.779	2026-04-07 19:27:53.184	2026-04-07 19:27:53.183	USER	\N	\N	t	\N	\N	\N
ebc57105-d551-4f37-b5fe-924e337de7aa	+59168506535	patricia@gmail.com	$2b$10$2pM3HPMWhUx8ryOlYdGCQOobItmJtVXJrBOjskLOOi4mBsniTP31m	Patricia	Lozada	t	2026-04-08 15:53:42.705	2026-04-26 00:56:46.468	2026-04-08 16:05:21.841	ANFITRIONA	\N	\N	f	\N	\N	\N
360a68ea-671e-492e-b56f-05b2000e671f	+573112906855	joseluiscruzduenas6@gmail.com	$2b$10$VyyXkRI0OUdYkPzovHX3iubgxfztmdxMYY6pBk7okphzDlQcgtJDK	Jose luis	Cruz dueñas	t	2026-04-07 09:59:24.349	2026-04-07 09:59:24.357	2026-04-07 09:59:24.357	USER	\N	\N	t	\N	\N	\N
9cfad3d0-e269-4d5e-adb2-1d745ab9d571	+51908656492	jeanmozombite201820@gmail.com	$2b$10$QsvNe0AO/d7QU8wZ1/pSSOZwP/4uRsJLQ6POW7FZATmfZNK14ot3K	Jean	Mozombite 	t	2026-04-08 00:39:03.544	2026-04-08 00:39:34.577	2026-04-08 00:39:34.575	USER	\N	\N	t	\N	\N	\N
d2a7dadb-154c-442e-9806-bb52e9e380f1	+51933281127	eduard210386@gmail.com	$2b$10$vRERKvU1119q5R27Til.s.tZ3MuXRA3qIE6T7/3iVKNI7nSdSvLwq	Edu	Saenz	t	2026-04-07 11:00:48.522	2026-04-07 11:01:49.138	2026-04-07 11:01:49.136	USER	\N	\N	t	\N	\N	\N
5643cd07-a7d4-478b-b66a-964dece5ad4f	+51946933577	frankkevin768@gmail.com	$2b$10$Dw8wEqavIpi9xEXBpOe36Osz2Gqhxvis33QWaIxO8pR6c2W9IVfoW	Frank 	Cachique 	t	2026-04-07 12:38:56.948	2026-04-07 12:38:56.958	2026-04-07 12:38:56.957	USER	\N	\N	t	\N	\N	\N
178ced85-ad0e-4ba4-9cd7-27020fbd3777	+573223219958	pedro394848jfjdusjdjf@gmail.com	$2b$10$2sv/ZVnnKWRMEJWrAYoWHeEgfPmXeaFLTAekHCE29H3Ayk4LRh.Ae	Pedro 	Contreras 	t	2026-04-08 00:50:24.236	2026-04-08 00:50:24.243	2026-04-08 00:50:24.242	USER	\N	\N	t	\N	\N	\N
225a5f55-64fd-4ac1-8eb3-3d24fe0811c6	51939820963	morigarciaroni7@gmail.com	$2b$10$pjv/rW2DKAWJnHJj5zGMe.Z0fkjYYa0jE4lWiuRSwKoJfZ2/eEUNW	Roni	Morí Garcia	t	2026-04-07 20:08:39.244	2026-04-07 23:54:52.905	2026-04-07 20:08:39.254	USER	\N	\N	t	\N	\N	\N
b843e168-1f1c-419d-b9b7-eefc7f7dc435	+51932867682	leocoronelsanchez@gmail.com	$2b$10$oa3ENUZ8Ml8WS1sWBnmaK.ec.JxkDKFuZ/p.vUaHM6qGKr7oLDJ4m	Leodan 	Coronel Sánchez 	t	2026-04-08 03:27:54.104	2026-04-08 03:28:21.752	2026-04-08 03:28:21.751	USER	\N	\N	t	\N	\N	\N
169ae99c-219b-42dd-9089-3e58391b41be	+51939841467	omarmorenoinga9@gmail.com	$2b$10$/u9USOaXYWnP/kEFtnpvEuIwPsBXzDwWiDguIdbML8CP1eC67s12a	Omar	Moreno inga	t	2026-04-08 01:02:32.111	2026-04-08 01:03:02.582	2026-04-08 01:03:02.581	USER	\N	\N	t	\N	\N	\N
f5dafb55-6ad4-43f9-a8e2-8d2f29560c2a	+51918240207	wenderchistamasinarahua@gmail.com	$2b$10$2IamTLNxUop6A/X1KuC0muAA1x8kxcB5rH3d9DmdRVh0of3mXoVnG	Wender 	Chistama 	t	2026-04-08 12:25:30.917	2026-04-08 12:26:47.797	2026-04-08 12:26:47.796	USER	\N	\N	t	\N	\N	\N
5a131531-7b19-4198-838d-eadbbd87d2bd	+51958145643	jamilrios1102@gmail.com	$2b$10$5bBs8cF5kp2uIw/0dR4RMODsWzOhAkN2qnjSfxFoUTZH2YodGxqlC	Jamil	Rios 	t	2026-04-08 02:14:52.835	2026-04-08 02:15:11.925	2026-04-08 02:15:11.924	USER	\N	\N	t	\N	\N	\N
30fba7af-7a9a-498d-b253-b9a14c17dae4	+51945335089	erickmartinemc@gmail.com	$2b$10$vY0CIjfC5L.t7zhVp2MBsu.OJZSm3u9me78WGdiHX1XotTKSzJQcy	Martin	Morales 	t	2026-04-08 04:11:46.443	2026-04-08 04:12:41.882	2026-04-08 04:12:41.881	USER	\N	\N	t	\N	\N	\N
9327dc29-688e-483c-a262-1fe1c180361b	+51930423249	cesardavila271102@gmail.com	$2b$10$Mn/9idMJvGBBCJ4IxZj8xubG0kymmKFkdnbIfGNXFgyUQN0tDWtra	Cesar	Davila	t	2026-04-08 04:18:49.726	2026-04-08 04:18:49.733	2026-04-08 04:18:49.732	USER	\N	\N	t	\N	\N	\N
d217a78d-603e-4ea9-82af-657d3cee1827	+51973761706	tecno2090@hotmail.com	$2b$10$mf/b51PC4gGS5Y5KMeR.Ue9lssPuABhuPvjabHKGgcF8E6e1/qXiG	Rafael 	Rivera 	t	2026-04-08 04:21:45.44	2026-04-08 04:21:45.448	2026-04-08 04:21:45.447	USER	\N	\N	t	\N	\N	\N
740b94fc-cba0-44c8-8169-1f4c239f26fe	+573127094058	cante1234@hotmail.com	$2b$10$c3h5vi9ichs8HIyyAQGYb.ndSq319AIcTVwpjgNVDDq9zVlejn.qq	Cristian jose	Rossi	t	2026-04-11 05:32:26.257	2026-04-11 05:32:26.264	2026-04-11 05:32:26.263	USER	\N	\N	t	\N	\N	\N
b3512702-02e5-4d5e-82e3-61c9c08973b5	+51933880203	freddyantonioguardiapena7@gmail.com	$2b$10$emAT1qbwgGvBsg8yo/J3A.ajUMQaK272qid.IqDuUm/4YvLvZcDfu	Freddy antonio	Guardia Peña	t	2026-05-17 01:02:48.875	2026-05-17 01:02:48.885	2026-05-17 01:02:48.882	USER	\N	\N	t	\N	2026-05-17 01:02:48.882	\N
b4364d07-e796-45d1-9fd7-575a8ab796e7	\N	pachamamabar2020@gmail.com	$2b$10$o.NVvcizvnLQEQ2dbZyHJey.apf6rRNUE2gFeCegciqDk2gU9nMSG	PACHAMAMA	BAR	t	2026-07-15 22:44:05.678	2026-07-15 23:07:51.246	2026-07-15 22:44:18.171	USER	\N	\N	t	\N	2026-07-15 23:07:51.243	\N
b827b865-dde5-4384-9b10-cd7f858c4d0f	+51976453146	luzsuarez2332@gmail.com	$2b$10$htAtCx5aF3c7/K67k6IhOuuMeecA.DsM3qQoFIesqvgtrUT19yci.	Ale	Sanchez	t	2026-06-04 06:12:31.703	2026-07-21 07:15:16.475	2026-06-05 04:41:02.67	ANFITRIONA	\N	\N	t	\N	2026-06-06 04:54:00.694	ALE4M3P
6b72ce53-38fc-4334-b789-b75a4fe111d5	930724875	araujozambranoe@gmail.com	$2b$10$ieD/ICBBvePVdLi0.pvoveIVsSuOgReTTRg40Y4U1ftNiTXUavjiO	Melany	garcia	t	2026-04-08 06:03:23.008	2026-05-04 08:19:34.353	2026-04-08 06:04:09.549	ANFITRIONA	\N	\N	f	df4RT7lgTGK8iwbhXXZ1lV:APA91bHUHaxVfJEyXLQ2wLVLOEPJ1VZGlwwfXFZ19Jpae_Z0g2r44bRrivOi0pRxgpXu_4uVwsVfCbjiPph6CA5q0y0j4S2E-lcshbaE68ulx6vAdVYzh8E	\N	\N
417f8dec-d73d-4e55-a170-7fd05748b315	\N	diegoher.com	\N	Diego	Herrera	f	2026-07-18 20:09:10.143	2026-07-18 20:20:50.602	2026-07-18 20:14:13.216	USER	\N	\N	t	\N	2026-07-18 20:20:50.6	\N
30a3bae8-ee22-47df-aa5f-c50c2a90e629	584242971063	andersonmora1629@gmail.com	$2b$10$afiPGN91RemgHiMV3F.nWeXJBqTurwQmOR2KsRKtlhdMqPNpl37Y.	Anderson		t	2026-04-08 16:56:27.109	2026-04-09 21:27:28.481	2026-04-08 16:56:27.12	USER	\N	\N	t	\N	\N	\N
1b80ea97-9a78-4674-804f-39ef05924c67	+51901407054	artemiopizango@gmail.com	$2b$10$ExVvd7rDSv2b5Ra1BrV12uNdke23YiD9bkXILGNFVazWQYQhLR6Kq	Artemiio	Pizango Huainacari 	t	2026-04-07 08:35:35.065	2026-06-29 21:54:30.125	2026-04-07 12:51:25.735	USER	\N	\N	t	\N	\N	\N
7ce68788-0883-4d55-aef1-dc64dfe7e184	+59168506536	lola@gmail.com	$2b$10$YCGKtZmVrePpvYZxYZJO7.GRuZlY0nELg4rbm/1111UTgytAJuPQ6	Lola	Rodrigues	t	2026-04-08 16:12:39.154	2026-04-26 00:56:46.468	2026-04-08 16:14:50.752	ANFITRIONA	\N	\N	f	\N	\N	\N
b06e72ed-13c3-4cff-823d-7977816685bc	\N	@.com	$2b$10$NN5lQFddI8cKz1laYf3Zlu/ZAeGn/7u9o9LKuLgQyEw9oxPSqMSYi	Paredes	Seven	t	2026-06-16 18:22:28.752	2026-06-29 21:54:30.124	2026-06-16 23:49:41.387	USER	\N	\N	t	\N	2026-06-16 23:49:41.992	\N
4166446a-428a-4e83-95a1-3491ff92f622	51982044619	jonathancanchuaguerrero10@gmail.com	$2b$10$b2mVqGHMK/LbqvQWZjKBLu9oasUqueXLSUO1DT9Gb2eGmMTkgWR0i	Jonathan	Canchua Guerrero	t	2026-05-17 07:59:14.617	2026-05-17 08:03:21.028	2026-05-17 07:59:14.624	USER	\N	\N	t	cidXA8CsS-Ct7lZbJfLefM:APA91bF8qKT003SIymenEANfLo2u8u4AFYOM-AzDiF3qEMWhXLWR2Zd-Gm0MpyjIglOKFXH-UcN7OVME4ClW8bQ8SavaYaU5TR1QIiyonlKr-mXrZ0QEZSo	2026-05-17 08:03:21.027	\N
a28528b4-e871-4137-a29b-b39f512397a6	+51912699580	mariligoshi91@gmail.com	$2b$10$zIJdHvJ0OzDmLquo9QeJ0ustmW7YeH6xQ9HZOyVJ5LOoFVBwOVu3a	Mari	Goshi	t	2026-04-10 19:39:12.462	2026-05-09 02:16:35.583	2026-04-10 21:38:54.471	USER	\N	\N	t	\N	\N	\N
906f801f-ad3d-44c7-9bb2-887351e8355b	+541140616220	valentindetullio@gmail.com	$2b$10$qVPYMEfrS570ulBmIAcsjumpQn4K6gD9FBmdo/zgyzSMU25v5AJ4C	Daniel	De tullio	t	2026-04-10 03:05:16.87	2026-04-10 03:09:33.476	2026-04-10 03:09:33.475	USER	\N	\N	t	\N	\N	\N
41e81b4b-c22c-40a2-9176-2546ccae0163	+51994081364	nyloryan@gmail.com	$2b$10$FaL9C65d.Zxy1kpsryHCwOTfzHzWRnYaMBlfYoiJ6m.OQwFk.nZDy	Bryan	Nylo	t	2026-04-10 00:18:46.469	2026-05-02 06:28:55.205	2026-04-30 05:29:58.914	USER	\N	\N	t	\N	2026-04-30 05:36:21.99	\N
3c1870c9-d5d5-4c25-8c49-8a2d2fc6fcc9	\N	pachamamakaraoke@gmail.com	\N	Angelica	PereZ	t	2026-07-15 23:17:19.035	2026-07-17 22:21:35.804	2026-07-15 23:18:15.283	ANFITRIONA	\N	\N	t	\N	2026-07-17 22:21:35.803	\N
1b22e452-ca71-4eed-81af-1839e08acae2	+59168506544	estefani@gmai.com	$2b$10$pg4ezT9liyD0abM8UoN9U.UT42QaQQE3diu3BqdQW.5yEPoAHuypO	Lili	Versi	t	2026-04-08 17:25:13.953	2026-04-26 00:56:46.468	2026-04-08 17:25:16.87	ANFITRIONA	\N	\N	f	\N	\N	\N
7fcb3884-c6b7-4320-b363-e1cefcd41878	+528611221800	erikgallegos225@gmail.com	$2b$10$PLwxZEC0zE0wiN78rCIqb.Am8Um2AmI0b2jW75Qu0vwJS7hYPs9Ce	Erik 	Espinosa 	t	2026-04-10 09:51:57.026	2026-04-10 09:52:28.862	2026-04-10 09:52:28.861	USER	\N	\N	t	\N	\N	\N
81c8998a-a498-40ad-8c01-bb0825873033	+51900014069	calebamasifuen1234@gmail.com	$2b$10$Xc.cP2ulToFepfxk9Of4dub2sXNHzdev2/mDGY/PIpg2W0Pbj08hy	Caleb 	Amasifuen 	t	2026-04-09 02:33:20.392	2026-04-09 02:33:20.403	2026-04-09 02:33:20.402	USER	\N	\N	t	\N	\N	\N
b2a44427-6ffb-4e4d-830b-714c80517b18	+51903417916	antichsesendanilo636@gmail.com	$2b$10$JL6reaXPYHKJxlbCH0S2cekxi.cLtkFIzPnrOWSGgVylDjUv3qGvS	Danilo 	Anse	t	2026-04-09 09:03:05.635	2026-07-16 05:23:10.721	2026-04-09 09:10:15.543	USER	\N	\N	t	\N	\N	\N
ce3225ba-19c4-42d9-a94e-547708f6d44a	979236091	fernandezsaucedozulylidany@gmail.com	$2b$10$RmviXxyPGd.dAHhdFKIg2OLx.ZsVy7yzlMvFXmZBJlWYPS1kdnDO.	Zully	Fernandez	t	2026-04-08 19:16:11.795	2026-04-09 22:17:14.992	\N	ANFITRIONA	\N	\N	f	\N	\N	\N
9ae2ae60-ae26-4a7b-910b-08bbfc38db30	+59165359695	aarara@gmail.com	$2b$10$1V2vF6yum0b690CCYl0hq.5boUiNWbDYfaZ46oCJc5Z.IURkCLqwS	Camila	Sanchez	t	2026-04-09 04:57:42.195	2026-04-09 22:17:34.275	2026-04-09 04:57:43.29	ANFITRIONA	\N	\N	f	\N	\N	\N
e082d771-fb3c-41e8-805f-052e544edcc6	51967288592	avilaguilar@gmail.com	$2b$10$MnurR0sFQtkqpg83ua6e4O3vyceLoUAD5grcWk0o1DrQlXOr.yyMm	Alexis		t	2026-04-09 20:12:20.241	2026-04-09 20:12:20.95	2026-04-09 20:12:20.255	USER	\N	\N	t	dnNXdnnlTRqWTGPa7PHz__:APA91bFoSitd2-_FGCVG3QtKogXuZrWqC0QYw05x7CZym7Huc4S_Lwtqpuvsbfdu9pm1-8PfR-rJPoQ7GJdkpjn94C_Zv0cqkW1g211ruBgLpOS3GJvrjmg	\N	\N
1fb7991b-f01b-4132-8731-f6331aa2cb43	+51983619836	johan.val@gmail.com	$2b$10$qKfNqDRa.5rcisB8BID.Vepcpch2w3Lnv.yYkn0zUFf7JBBRES656	Johan	Valverde 	t	2026-04-10 14:43:57.578	2026-04-10 14:43:57.589	2026-04-10 14:43:57.588	USER	\N	\N	t	\N	\N	\N
5004709f-d63e-4e19-88e0-a888aa06482d	+51960760881	ivanna.dgp@gmail.com	$2b$10$zXHHPFISxjTa/KGNxJkk2ecCFAQ0OSapP49INE5KFbcE8m4arF/UO	Ivanna 	Parra	t	2026-04-10 18:26:31.336	2026-04-10 18:26:31.344	2026-04-10 18:26:31.343	USER	\N	\N	t	\N	\N	\N
d1feff79-fbc1-4252-8f1e-0c9e58e7d531	+51938879969	goshimarili81@gmail.com	$2b$10$x41e...Ta4kaQsPhhOr0cO6l9hBt5VjM7XxwACP0GgdtWm2V2AVEa	Marili	Gsht	t	2026-04-10 19:59:00.786	2026-04-10 21:39:54.307	2026-04-10 21:39:54.305	USER	\N	\N	t	\N	\N	\N
2456172b-6d96-4f6a-87be-dc9ff922f955	+525575252890	miguel.herrera2747@gmail.com	$2b$10$ueJik9n036FAYSiTrE1ftOASaMn9yXpci0TEm82m0DKniDQSCWt2a	Miguel 	Miguel Herrera	t	2026-04-11 02:27:51.689	2026-04-11 02:27:51.696	2026-04-11 02:27:51.695	USER	\N	\N	t	\N	\N	\N
69d3d892-68a5-45df-82a6-58a6ad40cb89	51970277792	josepardo9425@gmail.com	$2b$10$wfN8wUaGBrAgZeGzyZ7S0O6a5/ggJUVkfZp5s1Jbtj6DVc14x8XDy	Jose		t	2026-04-08 23:28:27.759	2026-04-11 00:52:19.306	2026-04-08 23:28:27.769	USER	\N	\N	t	\N	\N	\N
36e462f3-a9c2-4837-b8ac-481293147bae	+573044698493	salodivina8@gmail.com	$2b$10$vNzLdmU01KApI414Wfm3IuPo6xMduYV3ZWRYEf9VDl0yz6cwzVLP2	Salomé 	Durango 	t	2026-04-11 01:30:58.387	2026-04-11 01:35:18.484	2026-04-11 01:35:18.482	USER	\N	\N	t	\N	\N	\N
f853fc56-f829-484d-812c-ed35a46950c9	+51950859059	robertoarteagaleyva4@gmail.com	$2b$10$guAZtB6BX0q.NGpVDm6xP.r1E8LTQNPkdlU5DMdWf4.Lg9iZdAx0K	Roberto	arteaga leyva	t	2026-04-11 03:03:26.289	2026-04-11 03:03:46.931	2026-04-11 03:03:46.93	USER	\N	\N	t	\N	\N	\N
43747451-b9a7-4d8c-83a9-f6340bdc6c5c	+573185955606	sneiderduvanbelenomartinez@gmail.com	$2b$10$sLiJeovncHl.Mf8PIVfIbe3fe5I59lIMX1LkFVDMPe2K54j8/b1tm	Neider 	Martinez 	t	2026-04-11 03:17:54.098	2026-04-11 03:17:54.105	2026-04-11 03:17:54.104	USER	\N	\N	t	\N	\N	\N
c1c9af7f-cbd3-4e91-87e9-2d233baf7ad6	+573114948714	thaliavandre2@gmail.com	$2b$10$ohW7DuQ3rifg/naaQZ8aPezjZf.89rpLJBhZYnjvit3YZG01fMWCa	Taineys 	Vandre 	t	2026-04-11 03:56:02.213	2026-04-11 03:56:38.431	2026-04-11 03:56:38.43	USER	\N	\N	t	\N	\N	\N
7669d18c-044c-4528-9acd-be58bd8bb137	+573226708351	angiepaolatrillos20@gmail.com	$2b$10$Vr6S5G9okHwERMkNz9JVs.8XXgDJWUyaHkviHLXSIJBjlJxRHczHe	Angie Paola	Trillos Santana	t	2026-04-11 04:00:22.944	2026-04-11 04:18:33.348	2026-04-11 04:18:33.347	USER	\N	\N	f	\N	\N	\N
b8875411-fa9d-4256-b7e0-6a725a3f1436	+51992763886	hugoforero76@gmail.com	$2b$10$Yf6V0p72.leBwUz7kd1e1eSEtMzfP2dMSHXBq51DQg1/fdH1NcA8O	Hugo	Forero	t	2026-04-11 04:27:08.932	2026-04-11 04:27:08.938	2026-04-11 04:27:08.937	USER	\N	\N	t	\N	\N	\N
50f22bbe-f8c5-440f-bbd4-9d39b2a25275	+573007205216	deibiscastro789@gmail.com	$2b$10$YPgOHZ0uql1XYmtDjdf.o.mowNHBQ.lZL9r6Ew3mBhONf8UVIaJw2	Deibis 	Castro 	t	2026-04-11 05:29:22.26	2026-04-11 05:29:22.267	2026-04-11 05:29:22.266	USER	\N	\N	t	\N	\N	\N
b3c3c1e3-2c07-4014-99fe-9e888da32da0	+51925281149	erickvera0806@gmail.com	$2b$10$6ySDLJXmFBO5KNIKcLtuk.csYnLdkOjWaslArZRtw6pNmRys8XjVS	Erick 	Vera 	t	2026-06-07 05:17:14.285	2026-06-07 05:17:14.316	2026-06-07 05:17:14.313	USER	\N	\N	t	\N	2026-06-07 05:17:14.313	\N
261efc59-4ced-447c-80d4-1070eada2618	+59170000011	anfi2@gmail.com	$2b$10$5FAYFzNGlsknjJSMcFMKj.woFj3pDswieDmc/Vqa9UvrJdchAFJzq	Jossssa	Jsef	t	2026-05-22 16:41:59.635	2026-07-17 18:41:11.321	2026-05-22 16:48:49.204	ANFITRIONA	\N	\N	f	\N	2026-05-22 16:48:49.204	JOSSHTRB
801e144e-1c66-4032-aaec-587d3db15034	+59168506512	sofiss@gmail.com	$2b$10$nhp6.ndgWekw2CosFgENuO0aa8EEk5sIT.DQLkZpFdyjjWTpRvOeC	Sofisss	Poter	t	2026-04-08 17:37:34.787	2026-04-26 00:56:46.468	2026-04-08 17:37:37.908	ANFITRIONA	\N	\N	f	\N	\N	\N
fd8ab344-97a1-4130-ba7d-48903ff2978c	+5916850657	dayanita@gmail.com	$2b$10$yiUGR/R0lJ/BqgbqT4brVu6nG.zHfOxLL/56m9WiM0FJdK0M50lrC	Dayana	Choque	t	2026-04-08 18:21:06.212	2026-06-08 14:05:49.446	2026-04-24 02:13:46.467	ANFITRIONA	\N	\N	f	\N	2026-04-24 02:13:46.467	\N
dd0257c2-4f37-4b20-b336-b13494e0ba74	+584120220562	deglinmaraponte@gmail.com	$2b$10$yu.w8b1NYWsoHoGKxX6Wx.LgpkO/XmDqiCQXWgwd4Edelw9WO1Oza	Deglinmar	Aponte	t	2026-04-11 00:33:28.036	2026-05-04 08:06:54.582	2026-04-11 00:33:29.106	ANFITRIONA	\N	\N	t	fDQV2nYFQUKYNHosrL0QfR:APA91bEZpwSs8OKNyE3bLT5prb6GGVMQviQrPhRM-hAf17uoXKz26GKysX3Yz2FzR9QiPr9eBtrNhSzuBgEnOeQb-saoGdIis62m_6m2agE9QZvi8kjd_Es	\N	\N
a196b0f9-6e1a-41be-91df-cb19b320504a	+51918332962	wilersacruz@gmail.com	$2b$10$xUTKQ5L2e0imm11GDkWmf.Z9MrAC4Yfocdwjo0HduTOM1XHyvvnzm	Leo	Rodriguez Santa Cruz	t	2026-06-08 04:25:40.224	2026-06-08 04:26:04.969	2026-06-08 04:26:04.967	USER	\N	\N	t	\N	2026-06-08 04:26:04.967	\N
f334565b-4fa3-4c9a-9608-832f8c472aee	+51933453022	jose.cp186@gmail.com	$2b$10$hzfpRDhHFOmB92BQd4JJCuZ6Q0f/YpIADDFI4iKxy/wKWuPw.E0Qi	Argelia Ornella	Perez Rojas	t	2026-04-09 21:13:25.592	2026-07-08 20:29:28.679	2026-04-09 21:13:27.051	ANFITRIONA	\N	\N	f	\N	\N	\N
69273148-40bb-41b6-bea6-2c0a012528ef	\N	cinthiaishuizasangama@gmail.com	$2b$10$F2ToF3DWPSW7ResNHKhQ7OXoxQ4s5CofHsKfaaKgzYihtkirP/RNS	Tania	Ishuiza sangama	t	2026-07-16 05:58:26.415	2026-07-16 06:12:40.808	2026-07-16 06:12:40.806	USER	\N	\N	t	\N	2026-07-16 06:12:40.806	\N
52ba6f5c-999b-4f9d-892a-6946c2e7fe85	\N	diegoherrera4900@gmail.com	\N	Diego	Herrera	t	2026-07-18 20:21:15.608	2026-07-18 20:21:16.729	2026-07-18 20:21:15.616	USER	\N	\N	t	\N	2026-07-18 20:21:16.725	\N
b475ab92-5be8-43e6-8091-633218517683	+51953375280	garayraul337@gmail.com	$2b$10$qzRv3nmoxLUuxyUDZG71Ce5suDzOO63KyY2jOYou4RRKoNZcYApa2	Deyber 	Canales 	t	2026-04-11 05:50:35.782	2026-04-11 05:56:10.693	2026-04-11 05:56:10.692	USER	\N	\N	t	\N	\N	\N
2d91f582-36cd-4e9e-8224-cc02977a53c4	+51925060298	jhonaralexgranadosalegre@gmail.com	$2b$10$RXYJtXUjt2JoXHW8uT3yd.JEcmCkxJ5iAS83BMgiKMuYptUjBis9O	Juan	Rodríguez 	t	2026-04-11 06:47:26.763	2026-04-11 06:47:26.771	2026-04-11 06:47:26.769	USER	\N	\N	t	\N	\N	\N
f7e40bd8-6bb0-455b-8000-85847525a2df	+51935642596	jimmytuestatagle3@gmail.com	$2b$10$ydfzPVeSCruz.0fewgetMOZJwsL4092T48WG5XXYFzRUGw6LqNNDa	Jimmy 	Tuesta 	t	2026-04-11 11:28:07.409	2026-04-11 11:28:07.415	2026-04-11 11:28:07.415	USER	\N	\N	t	\N	\N	\N
5c803021-df71-474a-bde9-44fa4d8b6d06	+51901603933	juanduran123789@gmail.com	$2b$10$RHE1s4PItHXvgpDJiGt2OeZycmjFc5WIrvHjzcPj2OLDScm2iIb.u	Juan	Cervantes	t	2026-04-12 03:13:17.739	2026-04-12 03:13:17.747	2026-04-12 03:13:17.746	USER	\N	\N	t	\N	\N	\N
162a0d88-4a0d-4f33-b394-d4a04f82da26	+59167507985	niki12arevalo@ejemplo.com	$2b$10$EqbF5qVGKPEJaTKJftejz.F6YdR3Yokd1obChZigr/zq1M.RWG6oG	Niki	Arevalo 	t	2026-04-13 23:12:51.348	2026-04-14 15:20:38.422	2026-04-14 15:20:38.421	USER	\N	\N	t	\N	\N	\N
3d050fac-5afa-4667-8363-63b858f7c7a1	+527811030294	jose97@26gmail.com	$2b$10$reZflVQni2c4oFn01P7AweeelvZwFtMirHzws17ravvnnY76tPQaq	José 	Gordillo 	t	2026-04-12 04:13:37.868	2026-04-12 04:14:40.765	2026-04-12 04:14:40.764	USER	\N	\N	t	\N	\N	\N
3aadf9c4-2722-4419-82f2-74d00e6441e4	+51995990043	hurremnavas@gmail.com	$2b$10$Deag/DUS.0aJv/RxDES1be1RHtkMb3IqrH90P6Pybc0vOcmNPsgpq	Hurrem 	Navas 	t	2026-04-11 16:59:10.66	2026-04-11 20:09:21.662	2026-04-11 20:09:21.661	USER	\N	\N	t	\N	\N	\N
c2491471-8a37-44f4-8d7e-66f9f4f567ca	+573224001088	camiloescobar136@gmail.com	$2b$10$St5R5tONfHmoUhjcvwCVoeGCoU9PfKDc3CIEDhhb0BJFtVa13Tu26	Camilo 	León 	t	2026-04-12 02:08:24.556	2026-05-08 17:44:45.193	2026-05-08 17:44:45.191	USER	\N	\N	t	\N	2026-05-08 17:44:45.192	\N
56ebdbbb-8356-4503-89fa-791d55f200e5	+573053303841	jhoncaicedoperea1234@gmail.com	$2b$10$iSCCQeDt9.ufRH5y7cvgi.dMF8abObevnk4ZyXW2NChkwc9wn1gji	Jhon 	Caicedo	t	2026-06-09 07:47:28.014	2026-07-14 07:45:16.238	2026-06-09 07:47:51.287	USER	\N	\N	t	\N	2026-07-14 07:45:16.236	\N
81df7097-2602-495d-a2ec-408c60637ddc	+573021069421	giraldocastilloluismanuel@gmail.com	$2b$10$/N5j5cW8TusKzPcvWdnCXeY3OLLvty3Y.9IhC2l9xpLvgcqtaSaY.	Luis 	Giraldo 	t	2026-04-12 06:07:40.676	2026-04-12 06:08:29.971	2026-04-12 06:08:29.97	USER	\N	\N	t	\N	\N	\N
de5c1082-08ac-4424-a539-81a3a5d93100	+51979780813	galante01_01@hotmail.com	$2b$10$Vz/r3MjHvPIIlu.WI3HLCuKEeGugrFG95/SUm6dsVxq1/MUfFbZqG	Jack	Ramirez	t	2026-04-12 02:28:44.71	2026-04-12 02:28:44.719	2026-04-12 02:28:44.718	USER	\N	\N	t	\N	\N	\N
94a9107e-6332-4803-b270-a3fcad2aeefa	+573128604334	jaider33zapata33@gmail.com	$2b$10$v3P0Kl4D88gkSCfMbV.y0O3s523o2k2ikBUswNnw03WsakQGyu9He	Jaider	Zapata	t	2026-04-12 02:43:14.779	2026-04-12 02:43:14.786	2026-04-12 02:43:14.785	USER	\N	\N	t	\N	\N	\N
04c2d87e-d93c-4609-bac2-1c73d428a458	+51929421875	billypasrorriosroncal@gmail.com	$2b$10$Wh4uzVY2964idlHqd/7UBuzNHlR34hg.HPtSx/Xp8uP9pE/bacujO	Fran	Trigoso	t	2026-04-12 02:45:09.567	2026-04-12 02:45:09.574	2026-04-12 02:45:09.574	USER	\N	\N	t	\N	\N	\N
ead49473-ad37-4c04-8f18-29eee7e55171	+573115966034	juanpinilla0813@gmail.com	$2b$10$GuE2RYCuDZuxx4EVKowWPuMbDtc2lcArMV0UsdaxUHNqzhRDHCIqy	Juane	Pinilka	t	2026-04-12 02:59:29.162	2026-04-12 02:59:29.172	2026-04-12 02:59:29.171	USER	\N	\N	t	\N	\N	\N
53362926-cf52-4db8-aa98-080fe2956c9a	+51967095021	andrescalderonr27@gmail.com	$2b$10$PvUgOEdADoeJhDzdQmFx7eX/cRlbrRIGMBknIM/bDLVS25Y5VsFeW	Andrés Valentino	Calderon Rodriguez	t	2026-04-16 19:25:29.031	2026-04-16 19:26:16.337	2026-04-16 19:26:16.336	USER	\N	\N	t	\N	\N	\N
fb214014-a2a2-41df-950b-b3950525c4b5	+526699414028	t7096614@gmail.com	$2b$10$CK6PYKEysOJyyiYH5OKqZOUO05/kzZJc49wqF8qzf5BgoZbBuWBDG	Tumbao	19	t	2026-04-12 11:17:48.08	2026-04-12 11:18:15.397	2026-04-12 11:18:15.396	USER	\N	\N	t	\N	\N	\N
ba6b5d64-e36a-45fa-ae19-6c740bc88681	+573125089938	liamespinosaespitia30@gmail.com	$2b$10$grS6ZJJU1jgu6GBxguaXsOvR/Kxoze5o42eYF.caMVzHR98OPBwxa	Álvaro 	Espinosa 	t	2026-04-12 11:24:14.124	2026-04-12 11:25:12.382	2026-04-12 11:25:12.381	USER	\N	\N	t	\N	\N	\N
b32efeef-d31a-4665-b5ae-904cf68690cf	+51947156340	jarashey183@gmail.com	$2b$10$Y.i0lNoQoCOQnJ2Ah7q9.eKASkenIzx8H3U8dlMUFnr0sjGAhXs5e	Sheyla 	Jara	t	2026-04-12 19:29:39.204	2026-04-12 19:29:39.213	2026-04-12 19:29:39.212	USER	\N	\N	t	\N	\N	\N
d112f25b-610a-445a-85a0-0d53c22168c2	+51920022254	michelsaenz1984@gmail.com	$2b$10$Gu9tCczRa8CIJUt.LeYquukiq5/pBfmkleFr6v/JjR0yRCOrrWbbm	Michael 	Sánchez	t	2026-04-15 23:47:09.449	2026-04-15 23:47:58.224	2026-04-15 23:47:58.223	USER	\N	\N	t	\N	\N	\N
3b523806-29d5-4986-822d-20a397b04b97	+584244220919	fefasara6@gmail.com	$2b$10$BP8xjWvYpQf6dYyZAPCTcO2nQD2tYQpWzM6WcinKXs/LKZZxlfIPm	Sarai	Silva	t	2026-04-12 14:35:05.699	2026-04-15 00:56:22.833	2026-04-12 15:03:44.416	USER	\N	\N	t	\N	\N	\N
679437af-12b9-4053-b833-572033277abf	+51968353273	alexraulcachiquesangama@gmail.com	$2b$10$RCgmQPK/GhSewUzMECx5P.B0rVsG3t6YmGxLCorcvCdKryRYS7bmK	Submer 	CACHIQUE SANGAMA	t	2026-04-15 02:25:28.647	2026-04-15 02:25:28.661	2026-04-15 02:25:28.659	USER	\N	\N	t	\N	\N	\N
76f3797b-e979-4293-88ad-26d5757dd7a5	+523330731736	vazquezal386@gmail.com	$2b$10$9gOBFEE6rrK247./UM9xkeOMYoNwEb9sTGIwOrRYkkWRvM4Uc.EYu	Alejandro 	Vazquez	t	2026-04-15 09:20:26.716	2026-04-15 09:21:23.561	2026-04-15 09:21:23.56	USER	\N	\N	t	\N	\N	\N
92491ea2-42e2-4803-81f2-c9856f9503c1	+51916618214	tenteyoangelica@gmail.com	$2b$10$qRlOzOpTWRXpRduprTnbYu5CX8J08T3fE/uV5JheyXMXrbKWBq2LO	Mari	Goshi	t	2026-04-10 21:43:15.84	2026-05-09 02:16:35.583	2026-04-11 15:48:47.404	ANFITRIONA	\N	\N	f	\N	\N	\N
9524f501-72d1-49ec-8dc5-bb2261177403	+51986606741	celuis.rojas@gmail.com	$2b$10$NnbDBlxAb56nZ93b6WAfL.mCXFV95OunKg7oJdCH9U48QOvPSPkxa	Celustiano 	rodriguez	t	2026-04-18 07:14:26.961	2026-04-18 07:14:26.974	2026-04-18 07:14:26.973	USER	\N	\N	t	\N	\N	\N
67102934-186c-4281-8114-bfe9917fd8c0	+51942997750	jhoelz704@gmail.com	$2b$10$HVQga5NRc3LXU2Fq2Cq1ludJIY7liRlBZ3GKiVJOa6Jko0xkN8QO2	Jordan	Rojas 	t	2026-04-17 21:55:34.733	2026-04-17 21:56:52.809	2026-04-17 21:56:52.808	USER	\N	\N	t	\N	\N	\N
0f7b4e7b-17f3-4d7c-878b-055ee8dac528	+51925636087	jhonnycampossegura@gmail.com	$2b$10$06WRF8njW8ya0j/PyireaOvq9HHEC2Wg8RpzbTHa4QOdbK.EIZ0Tm	Juan 	Polo delgado 	t	2026-04-18 00:45:12.736	2026-04-18 00:45:12.748	2026-04-18 00:45:12.747	USER	\N	\N	t	\N	\N	\N
28ad9e87-7377-4515-ac11-5c14512a382b	+51958255806	soriasolanoangeldavid@gmail.com	$2b$10$e/uIAZlPS1tfsi8HkFAaJeqdujDJCH8wZeE.WgBdf2gQyd7Psax7u	David 	Solo 	t	2026-04-20 09:42:30.731	2026-04-20 09:47:34.31	2026-04-20 09:47:34.309	USER	\N	\N	t	\N	\N	\N
b556b7a8-f229-47f0-9453-6106c9a68653	+584221742320	gtcarlos71@gmail.com	$2b$10$Xj36do/ubjAeglXaeP5Fb.6u.q8RY.l9iPaVuhrIbK67zLPBNOu7a	Carlos	González	t	2026-04-21 02:22:56.96	2026-04-21 02:22:56.973	2026-04-21 02:22:56.972	USER	\N	\N	t	\N	\N	\N
5b060e0c-a541-4249-abd6-9c2f08211c53	+50586593138	pl692328@gmail.com	$2b$10$7533uofuwwmCqDsgu6QlmuUAuArwtU/5gaWfQ98JLfvABuvVoDLUq	Bismar	López 	t	2026-04-21 04:57:19.457	2026-04-21 04:57:19.468	2026-04-21 04:57:19.467	USER	\N	\N	t	\N	\N	\N
e2a8876f-4ece-4125-93f5-9838a5560ef1	+51914749670	rioscumapatercero2@gmail.com	$2b$10$RD0x.i8OqS1uA8Vhp0Qf1..KNWhmBxT6wFF8HNGgTblisNA.tHOWu	Tercero	Rios	t	2026-04-18 20:23:40.086	2026-07-18 00:42:04.739	2026-04-18 20:23:40.097	USER	\N	\N	t	\N	2026-07-18 00:42:04.738	\N
bb724137-7699-4ec2-9aa5-c59c6bfbe416	+573145660547	jb2650594@gmail.com	$2b$10$yG3rmw4WJ5fKRyz4w1HnJ.SU4siYGRbV7rbDQC.13ixhTr7x99Hni	Juan 	Barrios Hernández 	t	2026-04-22 15:47:36.712	2026-04-22 15:48:45.099	2026-04-22 15:48:45.096	USER	\N	\N	t	\N	\N	\N
5398b688-8844-424f-bc48-74b7cf60d774	51941314030	yammir2402@gmail.com	$2b$10$TU3rcRgeF50tKxC2adQor.Ic6/ylsueVu7F9ZcJXDK4wjiS6/WMUm	Yammir		t	2026-04-16 04:17:24.837	2026-04-26 00:56:46.468	2026-04-16 04:17:24.847	USER	\N	\N	t	\N	\N	\N
6cd4c719-68fb-4e7c-8455-f7909ce58666	+59173662013	yess12mendosa@gmail.com	$2b$10$6E.jOvJJLHhqw/azp07vm.UNa9EMXsRw2Z4RnMwZjOF33WEC94toy	Niki	Arevalo	t	2026-04-14 16:21:13.035	2026-07-14 05:19:01.085	2026-04-14 16:21:15.116	ANFITRIONA	\N	\N	t	\N	\N	\N
b8f63138-a5ba-4b5c-b25c-ffd88ec1386b	+59170000000	anfi3@gmail.com	$2b$10$Kevwyh2.XHOaus2PINkipeuCpmJc7Wdwt22W.zuUsrzieuWVV0zpK	Test3	Aaaa	t	2026-05-22 16:55:52.148	2026-07-17 18:39:50.822	2026-05-22 17:01:24.715	ANFITRIONA	\N	\N	f	\N	2026-05-22 17:01:25.421	TEST4QU4
4ecad286-a43a-4487-9957-8a9d3d2af52d	+51981980134	isabeths713@gmail.com	$2b$10$qC7kAOYbsPcAqYvZnxqlzeNKtDQOqP5D1GwlL7VILDnDq12CVtYFm	Isabeth 	Sangama 	t	2026-04-22 20:35:31.49	2026-04-24 11:08:47.282	2026-04-24 11:08:47.26	USER	\N	\N	t	\N	2026-04-24 11:08:47.26	\N
3e957107-e648-43cc-baea-c5878ab6732c	+51900424290	andy.rengifo.12@gmail.com	$2b$10$Vz4zRdIea2xKxyiE3EADMuL/.5Y2UtzaEvNgtNLohwVYRhAOUh382	Andy	Rengifo	t	2026-05-02 01:31:19.681	2026-05-02 01:31:19.696	2026-05-02 01:31:19.694	USER	\N	\N	t	\N	2026-05-02 01:31:19.694	\N
11f7cff7-cc4e-4973-b09c-b415f8a4393f	+51932901770	olenkap781@gmail.com	$2b$10$RZ6YGS/ZvJ9u9fV2U6PN3OfGNBohdEJzvVZNalnHisX9nfVFMt5kq	Olenka	Palma	t	2026-05-10 01:50:15.25	2026-07-17 18:46:05.123	2026-05-10 01:50:16.502	ANFITRIONA	\N	\N	f	eml7KTu-RrKp2Q4YC5venb:APA91bGOy9XCwTuG-DTP9NkI-oa09TqBCNhkxoc8XTSjkYQwltpbk9Cky3QtBFKl-NYaCGEj8BpQffMKk8tK28gGajT56pcXnHZPKHpy9wmwfxrYDl4VQvI	2026-05-10 19:04:08.591	\N
97181454-67d5-45d4-af28-e9eead994af0	+584124129589	anamargarita1414@gmail.com	$2b$10$6bqiMiDqGSMe9fKgL5sVOumGpdjls5uyA7DN4CdGzC7lRwFNnRYka	Carlos 	Vasquez 	t	2026-04-26 23:11:37.789	2026-04-26 23:12:02.273	2026-04-26 23:12:02.271	USER	\N	\N	t	\N	2026-04-26 23:12:02.272	\N
fb41944b-5d8e-4c5e-8b9f-4e8661e007af	+56932648567	ci846364@gmail.com	$2b$10$brjDFTN2G7QMP7xyX3ITYOWi7KyN3ufJg8Z7SIJlr4Y1wc04Y1/DS	Claudio	Ignacio	t	2026-05-04 04:34:24.703	2026-05-13 09:59:11.056	2026-05-04 04:35:22.79	USER	\N	\N	t	\N	2026-05-05 04:19:04.529	\N
9e692bcf-dd5e-48c8-ba02-db1c5b03913f	\N	juanaperezrojas2024@gmail.com	$2b$10$4zZvA7Z/foryqXb8ccvlTe4nqC1cf4pw31ghEQ0NG1H98CH0oLG4u	Juanaperez	Rojas	t	2026-07-16 00:37:53.589	2026-07-16 00:48:54.575	2026-07-16 00:38:02.007	USER	\N	\N	t	\N	2026-07-16 00:48:54.574	\N
da244740-12b0-4691-a6ca-280f6d83a716	+51966362568	mauriciovanegs4@gmail.com	$2b$10$tK0LO7ttGNxaqpMzv0QUAOI7RBKM1bzriIz4pbr6PTHzOtQz2yiwu	Mauricio	Vanegs	t	2026-05-03 10:39:11.912	2026-05-03 10:39:11.922	2026-05-03 10:39:11.92	USER	\N	\N	t	\N	2026-05-03 10:39:11.92	\N
304884e0-e87c-44b3-a135-525fcc3b24d6	59174048209	jaimeluismamanicuellar@gmail.com	$2b$10$mfKTrurDjtM5YfSEp04iAOmfhf/jaMlGMFm/.ZlGlcOjqr5DxnOBu	Jaime		t	2026-03-22 09:59:42.901	2026-07-18 20:04:39.019	2026-07-17 18:28:59.846	USER	\N	\N	t	\N	2026-07-18 20:04:39.018	\N
296837fd-6a53-4694-9b6c-20465408e9cd	+51964689347	derlinnoeliaespinozavalladolid@gmail.com	$2b$10$rX2UNc07HxASDD.cxrQALu0mjpFHzBK61bcKh2Y5rLwLbOwai80Ya	Rosa	Radiante	t	2026-05-03 17:39:56.966	2026-05-09 05:26:09.485	2026-05-03 17:39:58.517	ANFITRIONA	\N	\N	f	eTOSIMMNQ9a-cgiAVgE4eR:APA91bHfMWVCt633bZP-rEaFHFwN9jfJa2ISIngy0Ml727i5U45GT84x6CcshVJQCKLxm9C7nm2Vulr_U1SbGFGilP3VyvvJIm2rxImdOUM_GTtaDJEOJio	2026-05-09 05:26:08.919	\N
fdd45029-8e81-4f0c-81a5-e58cbebd0385	+59168506534	cintia@gmail.com	$2b$10$FiMtMbv5PR9bgidXNRDUFe/nOg4TcPhSlcwXjSXjpdYplQx/xpRa.	Romane	Gonzales	t	2026-04-24 02:20:19.689	2026-05-21 12:40:01.699	2026-05-21 12:40:01.69	ANFITRIONA	\N	\N	f	\N	2026-05-21 12:40:01.69	\N
162560a3-6076-4e84-810d-4d0f94abe28b	+59168506538	estefani@gmail.com	$2b$10$KMltIgmjsNSP/bk4D0qNTuBqiIq.zLyyeTjTyhZ1OraQgHsxdu.Lu	Estefani	Lopez	t	2026-04-08 16:44:00.237	2026-04-26 00:56:46.468	2026-04-22 01:09:16.581	ANFITRIONA	\N	\N	f	\N	\N	\N
5899b52e-6c02-4877-965d-0a4439257dae	+51991436600	lapto_rulx@hotmail.com	$2b$10$uIKuxE4413/KyxGzQWeCHejr/.57lJTz6X5ASddLUkkYIfnH9QosC	José 	Peralta	t	2026-04-29 00:53:00.68	2026-04-29 00:56:03.97	2026-04-29 00:56:03.968	USER	\N	\N	t	\N	2026-04-29 00:56:03.968	\N
a5e6330c-0958-4715-bca2-05477d265316	+51944681483	rosalithgonzalesgarcia@gmail.com	$2b$10$uQjDIT.4CebkQO6ksU/rjul1iXwCguX0aaG2v/LKlShwid9kjA6eS	Renato	Gonzales	t	2026-04-25 17:34:52.408	2026-04-25 17:35:31.435	2026-04-25 17:35:31.432	USER	\N	\N	t	\N	2026-04-25 17:35:31.432	\N
dfadeb82-59f5-4f2d-824d-a435e40d7484	\N	arucanosusej@gmail.com	\N	Susej	Arucano	t	2026-07-19 02:11:30.461	2026-07-19 02:13:19.142	2026-07-19 02:11:30.469	USER	\N	\N	t	\N	2026-07-19 02:13:19.14	\N
dec3b28d-030e-49f1-af9b-441d3188a3a7	+59160761264	202300683@est.umss.edu	$2b$10$hGVO4de61W32OPf8nnwnzOi9a/Z/UGPR1mKwImBoii/ZJ1N6tHB9i	Joel	Paredes	t	2026-04-05 02:19:33.528	2026-05-27 09:21:07.484	2026-05-25 03:48:17.518	ANFITRIONA	\N	\N	f	\N	2026-05-25 03:48:20.35	JOELGDNC
8eefeb9e-8d9e-4278-b904-778e5727cfb9	\N	aldairobet123456@gmail.com	$2b$10$XYRO8UKE8I9hRsTzRvBKF.72BjVOSVpXBEVVwMAX78OMKWWrXlspK	Aldair		t	2026-07-21 05:05:21.762	2026-07-21 05:05:22.941	2026-07-21 05:05:21.769	USER	\N	\N	t	\N	2026-07-21 05:05:22.94	\N
ba25f67a-9d84-4e41-b869-77062401666f	51971834185	cerongarcia2307@gmail.com	$2b$10$2ueBdMg.lTJmyyIMQ.iGMOvUh8qHg08eTBlFvYt9HMJ1KHv.ejmp2	Jose		t	2026-05-17 22:28:46.545	2026-05-22 17:02:17.428	2026-05-17 22:28:46.558	USER	\N	\N	t	\N	2026-05-19 01:10:17.999	\N
dc98d365-4239-45a0-818f-52edb3411bf6	+524471514681	cedrtzz@gmail.com	$2b$10$Vl/5yEsFRh0wqLcRMQrD2.HsYgAbD8NYPYQAAgakK3JujjnMCK7cu	Ced	Gom	t	2026-05-03 01:38:04.917	2026-05-03 01:38:04.934	2026-05-03 01:38:04.932	USER	\N	\N	t	\N	2026-05-03 01:38:04.932	\N
b9818e31-dfc8-4883-aaca-df0d3b536b3e	59169993742	pabrozzz911@gmail.com	$2b$10$khRscl2C9SjQO83tdIZ5ou/KnVusjHNXGlZMtjjxDhpdj224ThuEG	PATO	KOCO	t	2026-04-28 21:04:58.509	2026-05-03 07:18:35.552	2026-04-28 21:04:58.52	USER	\N	\N	t	\N	2026-04-30 15:06:48.326	\N
07756b0f-e984-4beb-9fdd-1f03b3f9b811	+51924401850	jujutapiayabar@gmail.com	$2b$10$LcAcwHM9s/J9z95vNx9Xy.N4vcq1snVcLNN0xftbifQUXJIABPEzW	Cory	Grown	t	2026-06-10 03:36:01.56	2026-07-22 03:06:12.694	2026-06-10 03:36:02.987	ANFITRIONA	\N	\N	t	\N	2026-06-15 16:02:00.933	CORYRZKK
f77c3216-b665-48c3-b3c1-5d48953c7026	+51920135727	derlinnoeliae@gmail.com	$2b$10$1OrB9eufQIGldYByGS7lLuF2s71n63qt/w//4Im1oHeOe3jsmZKcu	Kuray 	Ballesteros 	t	2026-05-03 17:22:26.727	2026-06-08 14:00:20.836	2026-05-03 17:27:23.416	USER	\N	\N	t	\N	2026-05-03 17:27:23.416	\N
3ba3ccfc-600e-4690-a156-86ca7eb4aaba	59168119348	cristofervera110@gmail.com	$2b$10$Z4mlXaOcSseX/2.mzn.U/u6z/KGEzI0WVnIZkaTF/u8EOU8iCjtlK	Juan	perez	t	2026-04-30 00:03:56.234	2026-06-10 19:33:58.617	2026-05-08 01:33:38.939	USER	\N	\N	t	\N	2026-05-11 20:10:07.89	\N
8378d82d-b63f-49d5-8856-f515f0e2ccd4	+59399000002	user2@gmail.com	$2b$10$Vib5AP3EH1XvsyEf0rJwI.7JsVqziidvbJ/8Ynqz6.K67IPsebh6.	User	Dos	t	2026-04-24 14:27:14.023	2026-06-10 19:33:58.617	2026-05-17 00:41:39.341	USER	\N	\N	t	\N	2026-05-17 01:09:54.848	\N
60ff77b5-54f8-434f-a918-2a981a03112c	+51904387973	fchinchayticliahuanca59@gmail.com	$2b$10$GuJD8KhZ6luIMAI7GQUfhuiqNXh3Oypn/RyrvhYAgo7PVqIzhV1ie	Franklin	ticliahuanca	t	2026-06-07 11:39:01.212	2026-06-10 19:33:58.617	2026-06-07 11:46:10.944	USER	\N	\N	t	\N	2026-06-07 11:54:44.487	\N
cadca8ec-879f-4f06-9295-1a9731149965	+59170199193	sofi@gmail.com	$2b$10$DNa7pvAwQU1IaJf6AR59DOIjDrR4uIC4FeHywVa00cPzHzqVo/Psq	Sofias	Luna	t	2026-04-04 03:03:42.953	2026-07-13 22:43:15.744	2026-05-22 17:03:55.955	ANFITRIONA	\N	\N	f	\N	2026-05-22 17:22:41.067	SOFIU8ZE
6a5428d5-36cd-4d6e-ba3e-5977d06382ba	51929266239	noebaldeon624@gmail.com	$2b$10$efYQwupNyc/NwU0W5xG4V.12cQBN25GiyLQwS7bI7sFozbfvGJpOa	Noe		t	2026-06-11 01:12:17.813	2026-06-29 21:54:30.125	2026-06-11 01:12:17.827	USER	\N	\N	t	\N	2026-06-11 01:15:05.199	\N
43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	+59168506514	@gmail.com	$2b$10$aVNZuczA/uP3WsGVmlz7eukF//102u33556fsoFSxW11qM9Mdijsm	Maria	Roman	t	2026-03-21 19:07:07.781	2026-06-29 21:54:30.124	2026-06-16 18:20:08.723	ANFITRIONA	\N	\N	f	\N	2026-06-16 18:20:09.449	\N
e9f70fc1-a4b3-4ba7-aebe-80dd634a8d1e	\N	paredesmp@gmail.com	$2b$10$VZ3KQhaUu3J2awVc4PXiPepiHIMkHJMTxKJPNeFwXTHfPfDO0UDCC	Aeazaka	paredes pava	t	2026-06-16 23:45:08.548	2026-06-29 21:54:30.124	2026-06-16 23:46:06.293	USER	\N	\N	t	\N	2026-06-16 23:46:06.294	\N
8b87715a-1a1b-42f2-a336-b106972cf7d0	\N	pachamamakaraokebarboxes@gmail.com	$2b$10$uwPgxoUkfh.ZctMQrcCzl.azRILH6k2OhNpcaxsPhdqK/HtzDbGZK	Lucas	Karaoke bar boxes	t	2026-07-01 20:25:53.581	2026-07-01 20:27:35.442	2026-07-01 20:26:24.339	USER	\N	\N	t	\N	2026-07-01 20:27:35.441	\N
3d7da8a9-2210-4c42-89b6-1f9fa8c06d07	+51928551421	manuelhuanio2@gmail.com	$2b$10$9XQCs7r3VxmWlbNnik1mzO/MhEC3xm3kvrAO69U.Tb00wNCLZL.PG	Manuel	Huanio	t	2026-05-04 09:18:00.273	2026-05-04 09:18:00.293	2026-05-04 09:18:00.289	USER	\N	\N	t	\N	2026-05-04 09:18:00.29	\N
7276c868-9a13-4908-822f-403e45bca30b	+51963921310	echistama99@gmail.com	$2b$10$TX/5JDssEOffZQHIYWbZ2uHAGiAxnjcNCjLM9Gh4QWMWLjZiVEml.	Erick Jhordan 	Lapiz chistama 	t	2026-05-04 12:55:59.886	2026-05-04 12:55:59.894	2026-05-04 12:55:59.893	USER	\N	\N	t	\N	2026-05-04 12:55:59.893	\N
28a52218-067b-4816-ba7c-581f48308a23	+573227686429	maurotoca1992@gmail.com	$2b$10$1SFuNCfAhS3HtHpwkkPQF.ZkcOn8Jr8k6U6xhd0ucNDaNdeUBsdsi	Mauricio	Becerra	t	2026-05-04 09:23:22.553	2026-05-04 09:23:22.563	2026-05-04 09:23:22.561	USER	\N	\N	t	\N	2026-05-04 09:23:22.561	\N
f6c000b1-9659-4fcb-b39b-d1f31258c870	+573217321838	kevinrafaelmorenogarcia9@gmail.com	$2b$10$N46s2SD93FpFFuwKUzdwGuD9hfKfXmbNmSA35XxM47dWiB9wYrJw6	Kevin rafael	Moreno 	t	2026-05-04 10:22:08.889	2026-05-04 10:22:08.899	2026-05-04 10:22:08.897	USER	\N	\N	t	\N	2026-05-04 10:22:08.897	\N
f3391727-9c64-4ab4-9623-7c92862899c6	+573245491066	c1973dpino@gmail.com	$2b$10$h0JO0W8.gafHDQVO5yfTcOMv6IDpixlBxXyH9jjN6Qo9cW0utuJDm	Carlos Mauricio 	David pino 	t	2026-05-04 10:23:03.039	2026-05-04 10:23:03.047	2026-05-04 10:23:03.046	USER	\N	\N	t	\N	2026-05-04 10:23:03.046	\N
7ebc1ad1-7828-4ed9-8c70-0201bf0905a0	+573127553281	juanjosegacri25@gmail.com	$2b$10$VX9ZvGA1WYNTZHzWLvxwrOMrokZtQOr7ka/Yt.QVmo0AACzWSqPhy	José 	Gamarra 	t	2026-05-04 20:02:38.73	2026-05-04 20:04:56.898	2026-05-04 20:04:56.897	USER	\N	\N	t	\N	2026-05-04 20:04:56.897	\N
579c6a3a-4186-4973-8522-bdebffcf304a	+573136019175	gentilcaizamo9@gmail.com	$2b$10$.R/owK2YW0STr7qB57fF7O2QUXlR/D5tIl1iWpHthTfPfTIOxEDre	Gentil	Caizamo	t	2026-05-04 17:41:24.121	2026-05-04 17:41:24.132	2026-05-04 17:41:24.13	USER	\N	\N	t	\N	2026-05-04 17:41:24.131	\N
109ecd1a-3b55-475c-bed3-f1339005e2c4	+573245889069	herreravierisimperio@gmail.com	$2b$10$3B/cyIFpTJbqjtrFWkLId.HHFFwEn1TDQPk7aC6EXsYnFXTrZAufO	Cristian 	Herrera 	t	2026-05-04 10:33:57.071	2026-05-04 10:34:12.82	2026-05-04 10:34:12.818	USER	\N	\N	t	\N	2026-05-04 10:34:12.818	\N
4e52747e-7e13-4333-98ea-a5c31722ed46	+573135945365	vilareteheri04@gmail.com	$2b$10$jdxbqneXxuaGxus6kYYz2.VcZFbat5xzXeBjgrKMvhjBm3ohcPHpa	Heriberto 	Vilarete 	t	2026-05-07 01:03:01.194	2026-05-07 01:03:28.105	2026-05-07 01:03:28.103	USER	\N	\N	t	\N	2026-05-07 01:03:28.103	\N
d8e760c1-588f-4c94-be2b-2ea00e428332	+573046003285	cmendozachoperena@gmail.com	$2b$10$EA6IJn/CURWAMTMb77gtceSgmDg1vuNy4dzpQ1u6MwNopvQu84grC	Carlos julio	Mendoza 	t	2026-05-04 14:21:27.808	2026-05-04 14:33:10.901	2026-05-04 14:33:10.899	USER	\N	\N	t	\N	2026-05-04 14:33:10.899	\N
0cdaf38d-21f5-47cf-9bfd-77386ea5a211	+584261240436	neguigarcia480@gmail.com	$2b$10$nyjWZ17cuvd/8lI4q92Cxun8woifEf7edkn0kV931GXVVKbDWaVN6	Negui	Garcia	t	2026-05-04 11:22:27.071	2026-05-04 11:22:27.079	2026-05-04 11:22:27.077	USER	\N	\N	t	\N	2026-05-04 11:22:27.077	\N
d19fae64-dba5-4f3b-b12d-52a085efa21f	+51959418765	lozanomaro26@gmail.com	$2b$10$3DdrFKGrEeHpsYFCwfYf/.ijkDc31YsBbtDBZxRKNrV.RptvipelG	Hildemaro 	Lozano 	t	2026-05-04 12:27:20.916	2026-05-04 12:27:20.925	2026-05-04 12:27:20.923	USER	\N	\N	t	\N	2026-05-04 12:27:20.923	\N
198da2c0-0a8e-486d-b715-6cad34b02bc0	+525551964776	anluis585@gmail.com	$2b$10$re1veSj19O1CZaBR/JdFQuBWY95kh0POMF34935SyxYJce71mfTEm	Jadiel 	Rojas 	t	2026-05-04 17:44:33.78	2026-05-04 17:44:33.787	2026-05-04 17:44:33.785	USER	\N	\N	t	\N	2026-05-04 17:44:33.785	\N
01d48b51-6cb9-43ea-bfdc-5c2000af4fbe	+51930343708	carloscarrionv16@gmail.com	$2b$10$H1OgMlknUdeL2aD4ur3md.H3NhWrKN2agN3juysQ1ZzflqCU1Bcxe	Carlos Manuel 	carrion Villanueva 	t	2026-05-04 14:40:50.069	2026-05-04 14:40:50.078	2026-05-04 14:40:50.076	USER	\N	\N	t	\N	2026-05-04 14:40:50.076	\N
6af62b72-c49f-49b4-90c8-b3e3467cd6ae	+573011031005	liuversanchez045@gmail.com	$2b$10$RjM9Z2iuF7WhBsV1PRjlw.DrUwX3VdQPaFBIIKgfHW0pgAp.y5Ex.	Liuver	Sánchez	t	2026-05-04 12:40:10.934	2026-05-04 12:41:02.242	2026-05-04 12:41:02.24	USER	\N	\N	t	\N	2026-05-04 12:41:02.24	\N
86860ded-58e9-43db-9e8e-00f1d4161fab	+573117647884	chaconsneyderjose@gmail.com	$2b$10$y9JPu1qdZ2pvXg1G9cryAum9BgR6FvjvPeeYZbURCz40pRppyMHO.	Santiago 	Londoño	t	2026-05-04 15:27:42.513	2026-05-04 15:27:42.523	2026-05-04 15:27:42.521	USER	\N	\N	t	\N	2026-05-04 15:27:42.521	\N
47339094-1daa-4449-9dce-843579263fe4	+525657375506	ol555165@gmail.com	$2b$10$ISpHuWNEVheqhcIlM27f8utqwYV7UoFpqG7TPyUwyhbsAK0JoPatK	Oscar 	López 	t	2026-05-04 17:52:05.134	2026-05-25 05:02:02.616	2026-05-25 05:02:02.614	USER	\N	\N	t	\N	2026-05-25 05:02:02.614	\N
9e7ae97a-42e8-4c75-9b92-a4dbf954ce19	+51935152312	llamocamposj@gmail.com	$2b$10$gKFycNHuhB5JGnZWk4hSUeti6kt5x0mV90S04e2OyvXmX9AYZdT7G	Jhimy 	Llamo campos 	t	2026-05-04 20:17:01.776	2026-05-04 20:17:01.786	2026-05-04 20:17:01.784	USER	\N	\N	t	\N	2026-05-04 20:17:01.784	\N
1773eab2-4727-40ee-a9b0-d1952a2a388d	+51925471786	cristiantolentino977@gmail.com	$2b$10$o69fgZXfRlt.UsOU4JlgtO7NPtqW02M.yu8nAAIU1zGfSHHwQbj1y	Cristhian 	Tolentino	t	2026-05-04 17:11:49.269	2026-05-04 17:12:05.192	2026-05-04 17:12:05.19	USER	\N	\N	t	\N	2026-05-04 17:12:05.19	\N
ddae2e8c-5157-4006-985b-eefa7a3f0199	+50584323474	moro777l935@gmail.com	$2b$10$YL0UX9NzZwNXlnvGqQO28OloJv8iPNr9kBDz4RLvaz0SBZf/Rsiba	Ezequiel 	Ramos	t	2026-05-04 19:41:38.038	2026-05-04 19:41:38.047	2026-05-04 19:41:38.045	USER	\N	\N	t	\N	2026-05-04 19:41:38.046	\N
b41ef399-b937-4fd5-b26c-258d14a5845a	+51917740019	andrearodruiguez57@gmail.com	$2b$10$GBuKKXv3V8U7UHQfJBEXCuXhHGuLmhZYJdxBrE4Dq0bnayL/suARK	Camila	Peres	t	2026-05-04 06:41:38.905	2026-05-05 00:38:18.833	2026-05-04 06:41:40.343	ANFITRIONA	\N	\N	t	e4V6BgUAT4CCF8FA5uwugX:APA91bG8Xk6KWJNPXzQtQvPiVcGqIjoz8JMK-cpNrvfk_6hDw7Pohs-qOSIW1hhY9yeGPRWUWhTnD6LfFRG7X0oI3aDyqEUgtbYIXEBNz4GlvwSYYS47L8I	2026-05-05 00:38:18.832	\N
25b2a762-7e47-4134-bf3c-c69ef581863b	+573225264357	jorgeachacue8@gmail.com	$2b$10$OB9/l54K8fAmLl4MHBV8y.ts6MUaAaWvrVVu3BLHF550133T52JGi	David 	Zapata	t	2026-05-08 09:50:04.05	2026-05-08 09:50:44.588	2026-05-08 09:50:44.587	USER	\N	\N	t	\N	2026-05-08 09:50:44.587	\N
135181f0-4f89-46db-86a1-eb721cf3913d	+573218611379	andresvalencia11deabril031125@gmail.com	$2b$10$H2vX1.rvNnOftCqPmdw0veCTta.EFFK5ewYvWVrC2EK8W6ePPEO9u	Andres 	Valencia	t	2026-05-08 07:06:52.713	2026-05-08 07:06:52.725	2026-05-08 07:06:52.724	USER	\N	\N	t	\N	2026-05-08 07:06:52.724	\N
6d13a28d-09ed-4bc2-bfdf-aa61c4dc03ac	+51918120070	raulpumacota1509@gmail.com	$2b$10$Kqzx.6YKiwr5c3U1fSpPCeHCCwPJaSNeckNze.y/vK4ZWeoVu0BpO	Raul	Pumacota	t	2026-05-08 10:13:52.36	2026-05-08 10:13:52.368	2026-05-08 10:13:52.367	USER	\N	\N	t	\N	2026-05-08 10:13:52.367	\N
ea97602c-9fc5-4aca-b2e1-e1142507c775	+573243942413	villadastiven2001@gmail.com	$2b$10$s2/0EERN9r2cFN04km5iXOXW.RSoprUrmsygiMfdJtGJcwTjKFkMe	Stiven	Villada	t	2026-05-08 10:16:08.409	2026-05-08 10:16:08.417	2026-05-08 10:16:08.416	USER	\N	\N	t	\N	2026-05-08 10:16:08.416	\N
69ae8322-3c79-47e8-9712-ee0f426bd787	+573113810891	jhoncarvajal260@gmail.com	$2b$10$ZgSf6SaDSFrmVbloS.p7BOWjvcIEznPJgnYfEYqnIyrPRo4bbLCcW	John Alexander	Carvajal Gómez	t	2026-05-08 10:25:53.196	2026-05-08 10:25:53.205	2026-05-08 10:25:53.203	USER	\N	\N	t	\N	2026-05-08 10:25:53.203	\N
0d5b21f4-0dc6-466f-948f-9774bb5413f5	+573189524871	ferchoj524@gmail.com	$2b$10$7jxlbRr2Nb3ngvTh2sE/WOxuF3uFcZJo1ALe9UoIKXoVeHRc7ArRa	Fercho	Jimenesz	t	2026-05-08 11:28:39.196	2026-05-08 11:28:39.206	2026-05-08 11:28:39.204	USER	\N	\N	t	\N	2026-05-08 11:28:39.204	\N
1bfee12b-3ef6-42f4-af35-a08473c4e0ca	51983081971	samyelena1018@gmail.com	$2b$10$gHZPmHoGU.LntW5aiqc7wePCm3zr0RRkSOzXj.YR9z0ma.TlX4InW	Carlos		t	2026-05-27 08:25:12.139	2026-05-27 19:47:38.551	2026-05-27 09:01:08.195	USER	\N	\N	t	\N	2026-05-27 09:27:00.465	\N
81a45612-532a-459c-890c-55d6d3391455	+51952010641	anggyg723@gmail.com	$2b$10$KFQIvnyRLDWHZqGN7wkk5.ciALrerRp1fGEM4fGcGOrwVLFkeomc2	Andrea	Garcia	t	2026-05-02 07:07:14.122	2026-06-02 07:13:18.738	2026-05-30 12:32:46.032	ANFITRIONA	\N	\N	t	dnpMf2UfSNe-XSiKwjQDXB:APA91bE5SldDN1qkRUraZRPR1EjyN_3mOtGgSNLj24DltiWwjD-ZcatW_TtvXddnuZvzDNaxUlcNbCNtwAayFfOXM8PbmputRp1f_vu0-t0GoVOL6OWwjyg	2026-06-02 07:13:18.736	ANDRTFNB
189b0b52-fd73-470d-a4b2-b478b48d6868	+51931539478	gustavotg.20.86@gmail.com	$2b$10$WJZtSNKzqMniWDW6BLtkGuPMsrNZfW.Pu8A2nKNM3xf2mvDbJSw5O	Gustavo 	Tuanama García 	t	2026-06-10 13:37:37.459	2026-06-10 13:37:37.481	2026-06-10 13:37:37.478	USER	\N	\N	t	\N	2026-06-10 13:37:37.478	\N
42ea5d02-a1fc-48d2-97d1-3bdd712dfd10	+573106943318	perezronaldavid55@gmail.com	$2b$10$UbKPIB31qeXLEykjdPhbl.4mhLkNC7IIQcMlT3Oa1N3TBn0uVnnlC	Ronal David 	Perezarreola	t	2026-05-08 11:45:16.76	2026-05-08 11:45:16.769	2026-05-08 11:45:16.768	USER	\N	\N	t	\N	2026-05-08 11:45:16.768	\N
3eb8c9bf-adb0-40f3-bf0a-6d40339787ff	+51952583874	vargaschista.23@gmail.com	$2b$10$A49T6XtjbU4Ii9f0mcaWoezYs4bplmRbHdOUFolnd27heTtzIbe16	Soyler	Vargas chistama	t	2026-05-08 13:42:13.384	2026-05-08 13:42:13.393	2026-05-08 13:42:13.391	USER	\N	\N	t	\N	2026-05-08 13:42:13.391	\N
e5c103a5-43e8-45fc-91fe-164692d790dd	+529837335487	mjosemilan1234@gmail.com	$2b$10$QIRegzTHYQ2qQRFPJ9/gH.vZQP.Ko.xEdGlsK1ZTDGS2GaMC4gW1S	Jose	Gome	t	2026-05-08 15:51:31.251	2026-05-08 15:51:31.259	2026-05-08 15:51:31.257	USER	\N	\N	t	\N	2026-05-08 15:51:31.257	\N
975162b0-1c94-4cc3-b740-b2b3a82c4870	+51900725000	routher130998@gmail.com	$2b$10$yJM4U/Ay8haeZOQluCsgBuWmC86UnbBEmu3lijwI3Egs4QDAJz5A6	Roberto 	Roca 	t	2026-05-08 18:12:43.891	2026-05-08 18:12:43.9	2026-05-08 18:12:43.899	USER	\N	\N	t	\N	2026-05-08 18:12:43.899	\N
98a21c81-0a67-4b4c-8923-e06d43c844d8	+573225687354	miguel64perez76@gmail.com	$2b$10$dWB/.RWSy9xCB.h8a7nppebiktwPUHtiUrcEzWLFsrhDpe/31G2ue	Miguel 	Perez 	t	2026-05-08 13:59:00.213	2026-05-08 13:59:21.896	2026-05-08 13:59:21.895	USER	\N	\N	t	\N	2026-05-08 13:59:21.895	\N
fe11c4ad-6c7a-41b2-ad11-84071a3914be	+525559511241	yahirmartinez84766@gmail.com	$2b$10$aRBuqW5UfnCoGeZzXIPn6eVh1rD80tBoFxGv6uno0f.E0kg6nropu	Balyan 	Jaime 	t	2026-05-08 20:11:19.564	2026-05-08 20:11:40.917	2026-05-08 20:11:40.915	USER	\N	\N	t	\N	2026-05-08 20:11:40.915	\N
e33e08f9-dc8a-48f1-810c-bfb657d9fd48	+51927484924	abeljesusestrellafretel90@gmail.com	$2b$10$SMOwo.Lj6amK2him.1GD9e9JDjCOgLI7VoHYK/qp.em3J7sIavcQK	Abel	fretel	t	2026-05-08 14:06:09.13	2026-05-08 14:06:09.138	2026-05-08 14:06:09.137	USER	\N	\N	t	\N	2026-05-08 14:06:09.137	\N
eebf9f36-165f-455b-a649-d5f55d69baa0	+522331027240	marirodriguezsalazar4@gmail.com	$2b$10$DYfR8R74ZSxVQUKipuReYulcsE1aJ5uGlQEIoSPgh.X.FFvcQ3ehO	Samuel  Sánchez 	Reyes 	t	2026-05-08 18:10:33.511	2026-05-08 18:14:05.437	2026-05-08 18:14:05.434	USER	\N	\N	t	\N	2026-05-08 18:14:05.434	\N
0ce11212-d428-4c69-ae11-c42946e0fe02	+573185136010	jmbc33661@gmail.com	$2b$10$ZqevzO5G7G32Uq.QBa9fteVOfh5MnGy/TUsdvEXBIm4KCE/wKxi.G	JOSE	BARRIOS	t	2026-05-08 14:41:55.558	2026-05-08 14:41:55.572	2026-05-08 14:41:55.569	USER	\N	\N	t	\N	2026-05-08 14:41:55.569	\N
8d15ad5d-09a9-49d7-bcf2-5bb2261f0c32	+573027495898	rangelvasquezkeiner@gmail.com	$2b$10$LIy67Szk7zRV/VR.dPvpy.ZbZ8mxoIU3lpypI6lM5YnaetZxqRGRi	Keiner	Rangel	t	2026-05-08 16:34:50.884	2026-05-08 16:35:23.17	2026-05-08 16:35:23.169	USER	\N	\N	t	\N	2026-05-08 16:35:23.169	\N
58c3b43f-2de4-4f0a-8d99-bb8c2605cc4d	+529921136892	cesarmoreno@gmail.com	$2b$10$bIb67lVAejtY3uii1Pavt.qW2Jp8sdBlLwQU4ebOXMhLgTOoCfmUa	Cesar	Moreno	t	2026-05-08 14:50:59.125	2026-05-08 14:50:59.132	2026-05-08 14:50:59.13	USER	\N	\N	t	\N	2026-05-08 14:50:59.13	\N
c8717ec0-2459-4453-9e07-def794fce32f	+51918459306	rihannaisabelitaarmastuanama@gmail.com	$2b$10$Tjnwa3k70jWN7eaUO1mqMekYYJFYIxxvbwADIodjNqQM6I26mRupW	Emanuel 	Armas Alvarado 	t	2026-05-08 17:26:59.897	2026-05-08 17:26:59.906	2026-05-08 17:26:59.904	USER	\N	\N	t	\N	2026-05-08 17:26:59.904	\N
0efe47ef-da7e-48d2-b1fa-3236019ba015	+51963782938	danielmormontoysara@gmil.com	$2b$10$67Ci8Q/0LcCeXcQNbQJaw.6ghQMWRscOptoXqTQvNGkJbe7Eq.U.G	Daniel	Mormontoy	t	2026-05-08 14:48:19.369	2026-05-08 14:52:57.725	2026-05-08 14:52:57.723	USER	\N	\N	t	\N	2026-05-08 14:52:57.723	\N
a9aa889e-3c05-40b3-986b-cb4bd653f10e	+573214389648	samuelendo2017@gmail.com	$2b$10$1mhbRrpklYtsxVeUd8w1tu5AIY3ndibXueadfXxwdQ9N2oQs.WI82	Samuel 	Endo rojas	t	2026-05-08 15:08:20.173	2026-05-08 15:08:20.181	2026-05-08 15:08:20.18	USER	\N	\N	t	\N	2026-05-08 15:08:20.18	\N
80140d9b-39a6-4691-bf0a-c0d00872de78	+51953058514	rodrigo123@gmail.com	$2b$10$HQFZ1mOX2Sifr0wUzDzdJuMu6LtV4.aNH3WgnJkuHdkRHTpCyaowG	Omar	Contreras human	t	2026-05-08 18:39:06.067	2026-05-08 18:39:06.086	2026-05-08 18:39:06.084	USER	\N	\N	t	\N	2026-05-08 18:39:06.084	\N
fc72d3d5-2270-462d-87ab-0c1d6239a205	+51926227603	luisangelmarquezpozo396@gmail.com	$2b$10$qAKYBa4gpoc8aXOQMsk.oebkIP6SiiTxoMIvPLHbeJUejvfCc9Ur.	Jhon kenery	Gutuerrez pozo	t	2026-05-08 15:21:20.997	2026-05-08 15:21:53.066	2026-05-08 15:21:53.064	USER	\N	\N	t	\N	2026-05-08 15:21:53.065	\N
7cdb0b1c-4dc2-40d0-877f-56ce39b46daa	+573009091175	andrecuchala.04@gmail.com	$2b$10$EYPEKW/x9Q693T189M5Slucekdmcifw3XeRfKBEnpgZHUzW5thl2y	Diego 	Cuchala 	t	2026-05-08 17:32:48.225	2026-05-08 17:33:16.691	2026-05-08 17:33:16.689	USER	\N	\N	t	\N	2026-05-08 17:33:16.689	\N
2b90c33b-af34-43b3-bec6-27c91d08d9e7	+573202058074	cristianalejandrocruzgomez7@gmail.com	$2b$10$nrBxpIfClowUvjOVyUOzHuXtJnJC.RkiD1R9SMEaE/51bT1DxAJf6	Cristian 	Cruz 	t	2026-05-08 20:58:40.539	2026-05-08 20:58:40.549	2026-05-08 20:58:40.547	USER	\N	\N	t	\N	2026-05-08 20:58:40.547	\N
2c6d2131-3229-4cba-ae3c-794f14ca9580	+573015636165	nattyarango5@gmail.com	$2b$10$0Xawt1cLj7YmzJDxJOTvnu7ALL9OPZWQRGkCPPeufI09uZb6GNWkO	Andres	López 	t	2026-05-08 18:02:26.711	2026-05-08 18:02:26.72	2026-05-08 18:02:26.718	USER	\N	\N	t	\N	2026-05-08 18:02:26.718	\N
5317732e-ec0a-4c09-ade5-d28c2289c8f1	+573003474778	albertogomezdurango@gmail.com	$2b$10$GkS4Lb8YqCz8acR5s5jkuuSVZSdYjyc7SDvwC8mN582Q4E35/9riO	Henry Alberto 	Gómez Durango 	t	2026-05-08 18:51:09.87	2026-05-08 18:51:09.88	2026-05-08 18:51:09.878	USER	\N	\N	t	\N	2026-05-08 18:51:09.879	\N
20de6987-2064-4d47-84ba-4d3763b67d51	+573006540125	juanpablosandraga@gmail.com	$2b$10$K3eRTxecEO6XhS7IrZ8nLOW6HrSUREask2kMUJ5apr9z8hFWJN75u	Juan Pablo arenas 	Saldarriaga	t	2026-05-08 20:20:21.239	2026-05-08 20:20:21.248	2026-05-08 20:20:21.247	USER	\N	\N	t	\N	2026-05-08 20:20:21.247	\N
b075c824-5525-4904-8f72-e3812b41c53c	+573223607430	carlosnova169@gmail.com	$2b$10$zSbizIK8uiFecS3YKXiga.fiqkwvKpkvnpagKiCQwHMRXmAwRv0qC	Carlos 	Nova 	t	2026-05-08 19:35:16.282	2026-05-08 19:35:16.289	2026-05-08 19:35:16.288	USER	\N	\N	t	\N	2026-05-08 19:35:16.288	\N
d55352a5-24d8-4aa0-92ac-e47c2a8b8055	+51939726588	silupupercy33@gmail.com	$2b$10$YTGw02ZVlLP3pU3wihfaouQ6XT0MNqgmKQPRTsafUx2eww6VKP5O.	Jose	Mendes 	t	2026-05-10 04:11:24.627	2026-05-10 04:11:42.827	2026-05-10 04:11:42.825	USER	\N	\N	t	\N	2026-05-10 04:11:42.825	\N
13a6bff7-f64a-401f-8ff8-efe774497c49	+527701068220	reaxqw2333@gmail.com	$2b$10$R5gkYQag7TyH1TnkPxKGJeGg2aVRgpiCXV/.5ziUOADLWPZbR2f1K	Raymundo 	Martínez 	t	2026-05-08 20:44:55.729	2026-05-08 20:45:11.321	2026-05-08 20:45:11.319	USER	\N	\N	t	\N	2026-05-08 20:45:11.319	\N
da92e284-f3ac-4797-a6d6-f2860ae59752	+51900393772	castilloandy3012@gmail.com	$2b$10$tWczw8WUaw4MCnZE5BHKy.o9oFjQfKkbhGduX9EVU79u.iQ/mnKHq	Andy 	Adrian Castillo	t	2026-05-12 19:51:58.23	2026-05-12 19:51:58.247	2026-05-12 19:51:58.244	USER	\N	\N	t	\N	2026-05-12 19:51:58.244	\N
0986237c-cb80-4d13-a8aa-f86253b614a6	+51954304478	angelaquinoangulo@gmail.com	$2b$10$N7mjx7P9ES6SYFgQKnV2IOINUyZM6GBGjkUoyUtsPR3QwXvTk6qfi	ANGEL 	Aquini	t	2026-05-10 05:06:41.992	2026-05-25 00:58:18.806	2026-05-21 09:01:24.349	USER	\N	\N	t	\N	2026-05-21 09:08:25.676	\N
16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c	+51999000001	anfitriona.test@pachamama.com	$2b$10$t81IaYIE5IfpB00kEOR6cu0aA19Yq19AxiMfGFlqKx4hj.8/8/wDW	Ana	Torres	t	2026-05-11 20:23:55.539	2026-07-17 18:41:25.318	2026-05-11 20:24:48.077	ANFITRIONA	\N	\N	f	\N	2026-05-11 20:36:45.917	\N
585fe0ad-dc81-4fa4-b28f-c0ab16e62c25	+51928173849	aspajojhon427@gmail.com	$2b$10$vzvXBhikNXqjkCBuHBs.4.0D9HBhWrPqr1lPWIvplLLN3IAReBHQy	Jhon 	Lima 	t	2026-05-13 03:50:10.149	2026-05-13 03:50:10.159	2026-05-13 03:50:10.157	USER	\N	\N	t	\N	2026-05-13 03:50:10.157	\N
4e33169a-9f8c-4251-b531-fa7c38521bc7	584125949993	jostynrojas53@gmail.com	$2b$10$TGgzaHj2gN4nYPUu.2wyMuLVbncEmTuZ44lD3rqC4DD8ZmrC30v9K	Darwin		t	2026-05-27 13:04:16.855	2026-05-27 19:47:38.551	2026-05-27 13:04:16.869	USER	\N	\N	t	\N	2026-05-27 13:05:16.572	\N
dd378c51-dec5-4580-bdd5-5f6975e1a3c8	+51935942594	barbozajhan45@gmail.com	$2b$10$elCNKFJ.kRsOYFW3oEawS.XkhK1VbFe0IIF13ec98L4XpEy0uLvjK	Jhan	Barboza	t	2026-06-11 02:53:02.784	2026-06-11 02:53:02.794	2026-06-11 02:53:02.792	USER	\N	\N	t	\N	2026-06-11 02:53:02.792	\N
4a9df2ac-3b35-4baa-8725-e21c81398dd3	\N	luisperezchoque1986@gmail.com	$2b$10$9VUIVDmAWncIpYSIxfaMveVVeBMC1MWln3X53We6/A4FsdIpgEyvG	Luis	Perez	t	2026-07-16 00:49:24.725	2026-07-18 00:42:19.751	2026-07-16 00:49:33.921	USER	\N	\N	t	\N	2026-07-18 00:42:19.75	\N
ef1d27b4-7719-4bd7-89c3-c5b0f128bfee	\N	supersupervip2025@gmail.com	\N	Super	Vip2025	t	2026-07-20 22:49:30.756	2026-07-20 22:49:31.913	2026-07-20 22:49:30.778	USER	\N	\N	t	\N	2026-07-20 22:49:31.912	\N
f7973d9c-5f40-4355-818b-27b87f63c686	\N	luisaornellaperez1986@gmail.com	$2b$10$ZBetO5AXD8Y/knMg8yBcUePO1LnY2/HOSdXTIK2orNYPvE2I3DT0y	Luisa	PereZ	t	2026-07-17 22:19:50.778	2026-07-21 07:04:58.107	2026-07-17 22:20:02.963	USER	\N	\N	t	\N	2026-07-21 07:04:58.104	\N
2cabf7df-555a-467a-9cbd-3add658b68ce	\N	estabaanibal1994@gmail.com	$2b$10$Ix0u3cUQ3CC0bdrBX9Ukk.pGHrPyxwuhzrN0OLpc9KjPDbw.ZfSne	Jesus		t	2026-06-22 14:44:17.407	2026-06-29 21:54:30.126	2026-06-22 14:45:07.585	USER	\N	\N	t	\N	2026-06-22 14:47:10.201	\N
4da2c430-d1ea-4387-bccd-dd27daded98c	+51931578686	reateguialonso21@gmail.com	$2b$10$tZMdRlKKDRNOJF/UM.YDGeefxeTB./RNbuYjrBhXGKjZWOH.prPv2	Alonso	Reategui 	t	2026-05-13 23:12:37.979	2026-05-13 23:12:37.987	2026-05-13 23:12:37.985	USER	\N	\N	t	\N	2026-05-13 23:12:37.985	\N
c7d27475-082e-49f5-9810-2b87ed7428e0	584124697747	alilyvasquez28@gmail.com	$2b$10$nD1oDb/JBaJVVSiQ9RDxWuLE.wH3EP9maZOcSHIqVWvbnhcElKM12	Alexia		t	2026-05-15 03:39:58.418	2026-05-16 01:35:37.507	2026-05-15 09:44:23.19	USER	\N	\N	t	dF51Z12dRNy1XbYZ3VlHKn:APA91bGlZojLhBOdkvtEx48mHICwYcec_X4cP1mtTuO-GBrfpCq3dI6s-XdUG08AdEUMdAwm8yVY2ySf6xgd0PZOAS9_H_JFpwrM_Gxq88f5FUOijL1yBAs	2026-05-16 01:35:37.505	\N
370e5880-5ba0-4526-ba76-14f34e7dd92f	+584147852418	miguelmonastrio632@gmail.com	$2b$10$HmkAnvW.VOCDtpKLPu6i3eOvIqG4HfB/DTMMheWNFIHgCRhoXRiBO	José 	López 	t	2026-05-13 20:33:41.245	2026-05-13 20:33:41.259	2026-05-13 20:33:41.256	USER	\N	\N	t	\N	2026-05-13 20:33:41.257	\N
3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf	\N	automatizacion10dsad8@gmail.com	\N	Automatización	Santos	t	2026-07-21 01:21:21.112	2026-07-21 01:28:28.339	2026-07-21 01:27:02.752	ANFITRIONA	\N	\N	t	\N	2026-07-21 01:27:03.103	\N
3e6953f8-8684-499e-8b22-d9c8f0403332	51925001091	cristian.hmc82@gmail.com	$2b$10$0UKeMw.VKWszRlWvQadpPuBNolVyrcMhRNr2/mgfGq52v1fGzHeE2	Cristian		t	2026-05-13 13:23:46.786	2026-06-10 01:30:55.028	2026-06-10 01:30:43.913	USER	\N	\N	t	e3C8xlN6RlCWP_0GX0ci6d:APA91bG3qE0X-w_N4WMBe9nTDDEeHpc3Rt7WlS857DG22a1Q8IAXn2EogJx0RfNVSB62bCi-Xjbv5a9aVFh3YW1K-EY_XBn-OiF27oVpZqsRdG4AeqSN2dY	2026-06-10 01:30:45.912	\N
a7cdc984-83f0-49e6-9351-53e0d7103501	+51981680992	yeffersonaugustosalazar@gmail.com	$2b$10$aMm9JCyvqs03NbHIA1mMn.Gvk36fvfp8UqmtIqQn0WKnumdi1EpCe	Yefferson	Augusto Salazar	t	2026-05-13 21:50:48.767	2026-05-15 02:47:18.618	2026-05-13 21:53:05.129	USER	\N	\N	t	\N	2026-05-13 22:00:08.95	\N
10f0f50b-675d-4fb9-bb15-b5e57bdbc52b	+51901449256	mauriciocriollocarrillo@gmail.com	$2b$10$Jt121eLUVua7O5CD73O64OaBh345t3xY4.n.FvptBXyfp3w0Uyg9K	Daniel	Gutiérrez Morey	t	2026-05-15 01:22:45.819	2026-05-15 02:47:18.619	2026-05-15 01:24:43.906	USER	\N	\N	t	\N	2026-05-15 01:24:45.685	\N
dece3752-d51b-4d32-95ba-480d73b55db1	51979761094	angelfloresencalada0134@gmail.com	$2b$10$FPjRw4R0Fcx/gLpCjJyDdO5LemzyAvTjYCgDL5kUDYpynatoOPtoK	Miguel		t	2026-05-19 06:50:49.835	2026-05-22 17:02:17.43	2026-05-19 06:50:49.849	USER	\N	\N	t	\N	2026-05-19 07:37:54.372	\N
ee1cafe5-bb22-426b-bfec-c0471f2cff7f	\N	augustojara95@gmail.com	$2b$10$VVZrHH.f4ZMRUGOKfz/Ng.qfAZsMafcZ3wyP9qBtsY79ZFNMrmuY.	Orejas	J B	t	2026-06-21 21:47:28.829	2026-06-29 21:54:30.126	2026-06-21 21:48:03.572	USER	\N	\N	t	\N	2026-06-21 21:51:17.084	\N
9900429a-7d71-4fb3-8919-a5e2bb7e1460	\N	.com	$2b$10$E3LYIK6hJ/q.R7njS5qmsun.dZJpNQQwh0gxT0X.QjbxTZq.wD/ve	Luciass	Sanchesss	t	2026-06-17 00:18:54.325	2026-07-17 18:40:30.788	2026-07-14 23:47:47.737	ANFITRIONA	\N	\N	f	dqD05Yg3TyOvtAJlZzoSmC:APA91bG6VcJ6rueNNsyj8XYSNJ7SIU8XDNS4FmIeKTa8XT-jzyb2uzJOIlrjokuKbwFp6jSi8GbziMohST3Wh-S2ixLGl0Ara3XnHD29cO8E0LhwDweVBlY	2026-07-15 02:59:16.485	LUCIU8PL
941d8710-2e84-45dc-a1a1-6bca465fb251	584123908942	giovannimontilla49@gmail.com	$2b$10$excRAdqHIZO/YrA34A/PEe.Qb8ssAgToTQQDInEXUk33rA9OnY3uS	Gio		t	2026-06-10 16:43:19.622	2026-06-10 19:33:58.618	2026-06-10 16:43:19.642	USER	\N	\N	t	\N	2026-06-10 16:49:28.73	\N
a8c3a75d-a86c-499e-9636-de4a14cdad5c	+51936715784	antoniotuanama971@gmail.com	$2b$10$g2V2nfCTNkXu3S1OjmSldeZYyjTGFiRpWLyALKRNX7OOtJWaIczfa	Antoni	Tuanama	t	2026-05-27 15:45:01.95	2026-05-30 22:51:13.257	2026-05-27 19:35:18.544	USER	\N	\N	t	\N	2026-05-28 04:15:38.247	\N
8a3bb928-b6e1-4334-a038-55d49c49d7ce	+51986350228	brike_128@hotmail.com	$2b$10$LVtxmJn3EkLH0rSaEH2EdOKuv18.yqrNLwawiAjrl1Yz51XHNEsYi	Erika Brigith	Saldaña Pérez	t	2026-05-30 22:44:16.49	2026-06-01 23:49:48.855	2026-05-30 22:44:18.094	ANFITRIONA	\N	\N	t	e04n9QHYT8SR0m2dyhBZRl:APA91bHexDPI-F4Yw7XJM39Aiufm43pVniRkPk5h2ZjKM6hSKKVJKOCJpF_c7JaVc3trbwpDI2f1K8YxasWCib6HHNcAgzeViyALaRVTwdo-LG9I4rQj0c8	2026-06-01 23:49:48.854	ERIKTRBB
9bad8d77-2bbd-40d7-b9a3-e4dc02b6b951	+51930421969	leoperez567@gmail.com	$2b$10$Bre6GPpJrV5fxxFB3EEb3O0EBfWjY5jYj4qbTYJucrh2OykYrMma2	leo	pérez 	t	2026-06-13 20:25:46.216	2026-06-13 20:25:46.25	2026-06-13 20:25:46.246	USER	\N	\N	t	\N	2026-06-13 20:25:46.247	\N
9c97906d-d2d7-4c7e-b796-ffaa83570eee	\N	jimmassey.00994@gmail.com	\N	Jim	Massey	f	2026-07-16 03:42:46.05	2026-07-16 03:42:48.74	2026-07-16 03:42:46.061	USER	\N	\N	t	etjCxErYQM2s_6sOhJXDd6:APA91bHI-mDcb2L47Dt9eX03Am4iyF95eV3-MIcEfjUgemHc94TJTjDXdica7s_Hgr2QDX2ojrgAkLw6vEJjQzmt5MEtAaeIFBs9K5TzeTJU81CclHEIBbw	2026-07-16 03:42:46.062	\N
10a7e4d8-d4d0-48f6-9b6f-9b5ff680f74e	51979418155	isaacrodrigo520@gmail.com	$2b$10$25VhZ8luIXo3e8YOVNHIJOs2N9x8aU/ai7cyniH.V5q4pQJnKI8L6	Julio		t	2026-06-11 07:27:05.08	2026-06-29 21:54:30.125	2026-06-11 07:27:05.092	USER	\N	\N	t	\N	2026-06-11 07:31:45.674	\N
705bcf07-fd33-4f4d-a2c3-9fb8d2ab97c7	\N	202301667@est.umss.edu	$2b$10$pxsa.VC2fPibwCOd4Ndt5OGsoUjGp2HWfakC.aMlUBL0sTblpIsiy	Sonia	Sanchea	t	2026-06-17 01:12:33.955	2026-07-22 02:36:50.664	2026-07-22 02:31:28.054	ANFITRIONA	\N	\N	f	dCrG4ieWSamCCPxYZNCGc7:APA91bHZb5hjxLo7E1Rq0Txd65Juu7av54Or0mDLXbYKv4viU450hJe3IHU3WchNvX60CAPuDzT2lojqVNPcfDt3whwhhnhIsM2zHeZ-iGYN9Cayc3fQAFc	2026-07-22 02:36:50.662	SONIJ9HF
e9159f6f-711d-4404-bb6e-e789072b7281	\N	jhonatancabrera08082001@gmail.com	$2b$10$Rr1Oivu5sZqPbRrqQzrn1.K2zFKpM/RYNcwIYiACdNgi89/2vlbry	Jhan	Piter	t	2026-06-25 02:30:06.513	2026-07-07 23:56:37.938	2026-07-07 20:01:07.463	USER	\N	\N	t	\N	2026-07-07 20:01:07.463	\N
bac87303-3c5f-4c06-aa9d-c2013ceeef53	904261175	rojasargelia53@gmail.com	$2b$10$NbbCoeC5Fsp.KoIy2ALU6u1Lo0Z098eZrJ5d4DpLFo0neDXgkz5lS	Luisa	Perez	t	2026-03-31 12:08:49.914	2026-07-22 03:08:45.077	2026-07-21 20:15:18.353	ANFITRIONA	\N	\N	t	fLeueVFXS5OrugEWbDehlz:APA91bFb7gbK6aEftm5twWIAK3Fb247M4H1LdWv6rHfYwpJRyjTiOBCPk9tR4JaJ1b4qDC-bdtFctSrplilJIiWDAWtcxVSUUXTF-ghUCYN5NckGADCcCsw	2026-07-22 03:08:45.076	LUISETMY
1ee9e50f-7fce-4125-ad85-c544b4ee68a4	\N	elemp@gmail.com	$2b$10$2eLploTlkujm7RI./Jx1tuUD6j7.QGyofc0Lb3.LEgjrjZtixRFp6	Paredesjhoelemp		t	2026-06-16 23:57:55.183	2026-06-29 21:54:30.124	2026-06-17 00:05:55.752	USER	\N	\N	t	\N	2026-06-17 00:05:56.936	\N
50953781-3741-4d74-82a3-e6f009e9b033	\N	gmail.com	$2b$10$SRnTktKsMyiRM8Ncbow7heMSVo6RIEY4/Qn185H/PgJuzH02U4qXO	Micaela	Sanchesa Lopes	t	2026-06-16 21:34:02.189	2026-06-29 21:54:30.124	2026-06-17 00:31:00.499	ANFITRIONA	\N	\N	t	\N	2026-06-17 00:31:00.499	MICATJFQ
3a144e76-42a6-4a5f-b1e6-bac39df8c8a0	\N	maxmurrieta123@gmail.com	$2b$10$h6De7SY8j.rdiYk/uwPYrOexNdVa2vjt0Hj14q.uf0XQKeCgOQCEe	Max	Murrieta	t	2026-07-21 05:27:05.939	2026-07-21 07:13:54.856	2026-07-21 05:27:05.948	USER	\N	\N	t	\N	2026-07-21 07:13:54.855	\N
fa07b0b3-9d12-49f7-95ce-68db809ea86e	\N	ornellaperez604@gmail.com	$2b$10$.Nr/GXF1WUPAb0tapNjQeOHA/bpkTtZIm0kVzO9mqcxoLmk91FL8i	Ornella	Perez	t	2026-07-17 22:30:37.477	2026-07-17 22:31:22.284	2026-07-17 22:31:21.103	USER	\N	\N	t	\N	2026-07-17 22:31:22.283	\N
940e28c5-35f3-41ba-b0bf-5d958a85fbf7	+51926286783	angellogarciavasquez12@gmail.com	$2b$10$6AfRLrOq4NVC5V5j5bL4ROjekZRtR4Df19vR6/mYgDG.rOAYSzVLa	Gello	Vasquez	t	2026-05-20 03:42:47.447	2026-05-20 03:43:45.566	2026-05-20 03:43:45.564	USER	\N	\N	t	\N	2026-05-20 03:43:45.564	\N
5927fde2-f73e-4a02-afcf-08212a5dd015	51978797031	jervalles@gmail.com	$2b$10$2vzLjanafj0PXQeRYyY9k.wjv8kk4oT/VbXR1lneukmK.NRQIaFp2	Enrique		t	2026-05-15 21:37:26.565	2026-05-16 01:34:21.93	2026-05-15 21:37:26.574	USER	\N	\N	t	\N	2026-05-15 21:47:12.944	\N
b342bee4-6e60-4395-b242-1f939d7967ca	+51928826114	gonzalesgarciacesaralonzo59@gmail.com	$2b$10$Zp8HwmVWqnQgcz7BQ43OwuHCBscTENimXd5LrlI/T7Kieu63LrJOK	Cesar alonso 	Gonzales garcia 	t	2026-05-28 01:49:54.386	2026-05-28 01:49:54.396	2026-05-28 01:49:54.394	USER	\N	\N	t	\N	2026-05-28 01:49:54.394	\N
1e726e4e-83df-4f9f-b369-0d4e9e9d3b81	87654321	pdstecnologies@gmail.com	$2b$10$wJOW.uD8S5eYfLLnwaXB4OUYuyVKG3jRkGyPVQK5zNSifTUXBR/Ru	Saasita	Saat	t	2026-06-16 21:49:06.602	2026-07-19 00:45:09.96	2026-07-18 03:05:19.991	ANFITRIONA	\N	\N	t	\N	2026-07-19 00:45:09.959	\N
58f02c46-5a60-47bf-b260-6935fba622d2	+51901670069	milkertuanamasatalaya@gmail.com	$2b$10$LC1gPzapcG/FvUaJpR30uOzPTu0Zq82LpT1pxkISg/YOku4Tr3mV2	Milker 	Tuanama 	t	2026-05-31 03:53:25.851	2026-05-31 04:02:59.025	2026-05-31 04:02:59.023	USER	\N	\N	t	\N	2026-05-31 04:02:59.023	\N
26f4ea3d-ad31-4cdb-bea7-87388d707507	\N	fatycbba@gmail.com	\N	Fatima	Solares	t	2026-07-21 02:01:42.328	2026-07-21 02:01:43.534	2026-07-21 02:01:42.349	USER	\N	\N	t	\N	2026-07-21 02:01:43.531	\N
1808fc9e-a96d-4dc0-a466-3e5445ff8abd	+51945859724	carolayvillamon@gmail.com	$2b$10$D57UwKClSSETIXVoWlT5ZeU5djaN0uPtfiNQpLmLw71CafDiKlCcm	Abril	Ramirez	t	2026-05-16 01:26:45.344	2026-05-17 00:47:24.28	2026-05-16 01:26:47.661	ANFITRIONA	\N	\N	t	f2gbozw-QKyKv0ieFpWqES:APA91bHliRSW2HrpI0CfxYcGTSHJVwieVyfZJ6crYpK5fxHsyHApOOBEbh1Tf8zGOrussPexrfwYldQjvXkIcWkacGKPXtccgcVME_XML8aOnTSi3mEGVSg	2026-05-17 00:47:24.279	\N
c61a6045-e7e9-44b2-93fb-ad367b08cb93	\N	4012005jhoelp@gmail.com	$2b$10$2pwrHMfODRh4QgQzkyeND.sO/4Q5zvBtrtBg.VUwWl/hCuDVJLJDO	Jhoel	P	t	2026-06-17 00:06:32.118	2026-06-29 21:54:30.126	2026-06-19 00:13:13.942	USER	\N	\N	t	\N	2026-06-19 00:16:19.75	\N
8e66e230-01a8-4503-bcdf-d90b4e431843	+51912130240	harolzumaetaguerra@gmail.com	$2b$10$lrHInXVWfW2EtEpaTev2Veh2wg8IaREqmc0cAf6GJX8KBzoHNj2ti	Harol	Guerra	t	2026-06-14 05:48:50.348	2026-06-14 05:49:07.961	2026-06-14 05:49:07.959	USER	\N	\N	t	\N	2026-06-14 05:49:07.959	\N
01b121d2-a965-4ac2-bc8d-bde43303ad39	\N	gustavomachuca0710@gmail.com	$2b$10$ugz6slpyTCy6HcvPlPTzle5wgIWJg.sSoqYROwrLVUm/bf2Qeukzu	Kaiser	Machuca	t	2026-06-22 07:49:15.993	2026-06-29 21:54:30.127	2026-06-22 07:49:45.411	USER	\N	\N	t	\N	2026-06-22 10:02:24.595	\N
e9985fa3-2a2c-40a3-bdf6-a4c9feb9de42	\N	jerlickssonfatamatorres8@gmail.com	$2b$10$bms6JslL3r5GC2h72UDaJe2zTr7AW0n4kyKyCri2s78thvqHM19oO	Jerlicksson		t	2026-07-05 02:04:39.359	2026-07-07 02:55:18.33	2026-07-05 02:04:39.376	USER	\N	\N	t	\N	2026-07-05 02:06:02.923	\N
74b016d6-a584-47a6-b95b-c754b24f07b1	\N	gonzalezdiscarlos@gmail.com	$2b$10$hUjhXOYpdBg2SlI.jn1CfeSj8gfVWeFl3HsGKVeUYADVMoYEM0Jji	Pedro	Perez	t	2026-06-25 03:42:09.949	2026-06-25 03:43:31.15	2026-06-25 03:42:51.148	ANFITRIONA	\N	\N	t	fPtIUHz2RuqeUfET1zbYfh:APA91bEC_YSwnnA3FW02NR3oZE3sS4s6NeDo0RbLjy4omAldOa34IncZm59ri2Tgtn_kkKCRjrLuA3NWUQ3GFMQax7oSSpStBXL-NGUPhoTeqZWi5-SM1PI	2026-06-25 03:43:31.149	PEDRRQQH
850654ff-c2a8-4215-bc96-c0afdb615949	943 861 007	Karinreynataminchi641@gmail.com	$2b$10$2O2kTEVWMXlCn5Ni7d5J0.p/GEXDYZEYta7gSeuaVXRkhE5DvBRiW	Karin	Reyna	t	2026-04-06 21:00:00.984	2026-07-14 05:19:23.898	2026-04-06 21:03:09.161	ANFITRIONA	\N	\N	t	\N	\N	\N
2ca49a07-c657-4a76-9898-8cee99b8bf5b	\N	mendozaalejosmiguelangel29@gmail.com	$2b$10$gCu3VIvqLFXmaPhQ9UyXwuWvJ2/0rq05lGyR8/2OpzKD8yYYtr.8m	Angel	Mendoza alejos	t	2026-06-20 05:16:10.033	2026-06-29 21:54:30.126	2026-06-20 05:16:39.743	USER	\N	\N	t	\N	2026-06-20 05:21:40.855	\N
6a84b80a-11f1-47a3-bb87-5e6e9097930d	\N	daiarymiafernandapenarengifo@gmail.com	$2b$10$ljfS/pzoq19UazmPRfUUJ.rPR/OY.mfc9nPD7Q1NfapsSHOn4P47y	Daiary	mía Fernanda	t	2026-07-18 02:38:53.145	2026-07-18 07:04:34.408	2026-07-18 02:39:16.037	USER	\N	\N	t	\N	2026-07-18 07:04:34.399	\N
6885d8b2-726e-4e47-a1a5-b10d2234cd4d	\N	erlindacenepo@gmail.com	$2b$10$TL52qAqCtetW/PMxeuthT.s79hDsH49xwKNAAujr1EoZh4sG4jjXO	El	Ppi	t	2026-06-23 10:40:51.458	2026-07-01 01:07:26.596	2026-06-23 10:41:36.36	USER	\N	\N	t	flXXPgwzTNyATh0Hy75doz:APA91bG9xQc5A5m0QAvDocdDw9RGMZ5I_PtxcX53lcMtq38JOIo0Tey3H8QliRIlW4VQxqDF-8eSNf1uunWh2LN24YgaCu50XLVa9mNQ-EAE4pAwE085bm4	2026-07-01 01:07:26.59	\N
ff84c1c6-7ffb-4c0e-8b6e-c1590c140b8a	\N	paredesjhoelemp@gmail.com	$2b$10$nrWeisaL/sEz/dPKQr095eKOXKpk2wnrsaoMy6yBHEOPHwfktQfP6	jhoel	paredes pava	t	2026-07-16 04:40:56.482	2026-07-18 19:42:00.526	2026-07-18 19:41:59.375	USER	\N	\N	t	\N	2026-07-18 19:42:00.525	\N
c1d487fe-ca5d-4d9f-9bf7-5b85c3b96121	\N	pachamamabar1986@gmail.com	\N	Pachamama	Bar	t	2026-07-21 15:08:33.41	2026-07-21 15:16:29.245	2026-07-21 15:08:33.434	USER	\N	\N	t	\N	2026-07-21 15:16:29.243	\N
aa134fd6-6b30-4b19-844c-73d700d6800d	\N	paredesjhoele	$2b$10$Kw895odZ.IVT6fAsRijiUukyob/woHEoLWGm7E0oEKR1SkCB8irCe	Mica	Ds	t	2026-06-17 00:16:00.257	2026-07-17 18:40:23.73	2026-06-17 00:31:31.841	ANFITRIONA	\N	\N	f	\N	2026-06-17 00:31:33.003	MICA3XF6
b3e7b293-ecbb-4ebc-a5bd-97d820611660	\N	mail.com	\N	Merlene	Vallejos Lisboa	t	2026-06-17 00:11:05.001	2026-07-17 18:40:11.4	2026-06-17 00:12:25.163	ANFITRIONA	\N	\N	f	\N	2026-06-17 00:12:25.163	\N
05c0a4ac-fe39-4689-90aa-c01f80b77da4	\N	luzcamposhuaman390@gmail.com	$2b$10$b8R5VAvl2ADhaGdvOzW5EOE8MlKN1AXAFO8kvuUBxvSFU0IwRwZl6	Rosi	Aguilar	t	2026-07-16 04:59:29.866	2026-07-18 18:17:03.8	2026-07-16 05:26:32.391	ANFITRIONA	\N	\N	t	djZcTqb0Qq-YYKFf2a-U7D:APA91bEx0EvyWB7h-1mKvkmJYWHB_sPJWoYMW5NgVI5rFk6HTdSHoQDmhwYQH-63pyK4HoJPHC9MSoFNnhYOw71olBNTWJOn6KK5H7PCmonOKuhomPT9G9c	2026-07-18 18:17:03.799	ROSISLDV
d3bea0b4-86a4-46be-8c56-1cdb09c7da7c	+51921808790	stivenhuayami@gmail.com	$2b$10$2KcVCkLEU0DdkU7BShllUuiXBwY8ST/KSOerCN1JilerTrpqoGrIO	Stiven 	Castillo huayamí 	t	2026-05-06 04:35:42.342	2026-05-21 06:23:02.777	2026-05-21 06:22:54.296	USER	\N	\N	t	f7QoNE2rRrmdexqHw5YlkH:APA91bEnVvr_SwWZ7rzpfDfVvCa55gAmq-BYnqRQcHwXcae86EYA20eLkP2dOqlIrEQ2YJDPlJTCU2JU04eSRHROS79H8uGw-WiGPMBbRhGZqLaHLDI05vY	2026-05-21 06:23:02.776	\N
c7bd5193-a265-44ba-bc7a-ec8dae92b78b	51986871927	fredopanduro9227@gmail.com	$2b$10$ZuURsJ40OV/8gT5Imry/COnupRdEa.iyuc7XEpuJcO2C2H/84f1Oe	Pedro		t	2026-05-07 12:25:48.938	2026-06-29 21:54:30.127	2026-06-22 12:16:45.014	USER	\N	\N	t	\N	2026-06-22 12:27:21.732	\N
64e07836-b136-45c5-87cf-41c14d10d114	+51922375902	cesaraugustochavezvargas@gmail.com	$2b$10$.twPu6pkTaeGD/U6rxPiteEvpxdwGj39nDB.Y/ELNRKPA5tFs2d8y	Cesar	Chávez 	t	2026-05-28 07:40:16.771	2026-05-28 07:40:36.849	2026-05-28 07:40:36.846	USER	\N	\N	t	\N	2026-05-28 07:40:36.846	\N
fa82f190-e133-460e-a800-145362c903a5	\N	orbyx.corp@gmail.com	$2b$10$m2GJZMYwAgNMprvADJ87BO2DTgJxUaLNjhCvgoI1LJqEnbM1vVoaS	Saatsita	Saat	t	2026-07-07 03:21:26.495	2026-07-18 00:54:44.918	2026-07-16 05:19:33.657	ANFITRIONA	\N	\N	f	dqD05Yg3TyOvtAJlZzoSmC:APA91bG6VcJ6rueNNsyj8XYSNJ7SIU8XDNS4FmIeKTa8XT-jzyb2uzJOIlrjokuKbwFp6jSi8GbziMohST3Wh-S2ixLGl0Ara3XnHD29cO8E0LhwDweVBlY	2026-07-18 00:54:44.917	SAAT7RKU
011655d4-c895-49d6-aedb-af203c5a274b	\N	jaxpnotic231@gmail.com	$2b$10$bxSLdPV2kLmh4yFQ/xlYxevwqLqQIuJ2waLL/yTmGCgzxajzR5.hC	Jesús		t	2026-06-24 05:59:08.581	2026-06-29 21:54:30.127	2026-06-24 05:59:08.598	USER	\N	\N	t	\N	2026-06-24 12:28:42.895	\N
b95dcaf7-1ecd-4989-9237-bf0fec59efa2	+593979929240	cvasco796@gmail.com	$2b$10$8UL3QujJh8O4eKF0Vyd8suOHb1fcaJ5O5o/88gok/nD70F.0mEL9C	Ale	Vasco 	t	2026-06-15 20:26:57.805	2026-06-15 20:27:47.132	2026-06-15 20:27:47.13	USER	\N	\N	t	\N	2026-06-15 20:27:47.13	\N
a89853a8-82aa-4b46-9bf6-005479c699b6	51962395938	estudiojuridicovallesvalera@gmail.com	$2b$10$Y.AoLq/vTuODDRDWA26KyOhgbj8X2rbz.7Wy76/MqbMKLuyIy5zSy	Junior		t	2026-05-31 04:16:31.397	2026-06-29 21:54:30.127	2026-05-31 04:16:31.404	USER	\N	\N	t	\N	2026-05-31 04:50:42.332	\N
c66c79d2-b59e-41c3-aef0-ec1ce54c77d3	+51967098862	therex20002@gmail.com	$2b$10$YUmgiz/FDYyqgMcDo018Fu2DDOTgPzGJXQMMvsWBelcdiAdmRPLIq	Tonny	Melendez	t	2026-04-05 20:33:49.169	2026-07-02 22:32:50.834	2026-07-02 22:32:08.761	USER	\N	\N	t	cESB3EB_R5eG_FM1y7imY8:APA91bG7sbvvPrYf-x5H7X6Yyk9qjX1iJTpC3iWoMyxaadOy1It6HUJGck6T01DeVBdKzY5d7SjxK2Bmex71B2YY5YECywqhKmVvQaHJejPgLi58fWSgmHk	2026-07-02 22:32:50.833	\N
624d8d60-25d1-4344-981f-4ead2477afea	\N	leonplc31@gmail.com	$2b$10$4gd/ZqQCbHzmrHDlVLgP5OWQy6/A46PKb7hiNDa9vM0BQCjBIm5J2	Leo		t	2026-06-29 20:54:05.578	2026-06-29 20:56:51.125	2026-06-29 20:54:05.589	USER	\N	\N	t	\N	2026-06-29 20:56:51.124	\N
5833ebc0-98f0-4a13-88fe-da3b1bc5b694	\N	4012hoelp@gmail.com	$2b$10$7i28WEAShiirIOoRaAda4OCvVGuZRCLjPMyey5ZrkTkJoCpUy.sXG	Paredes	Jhoel	t	2026-06-16 23:19:22.847	2026-06-29 21:54:30.124	2026-06-16 23:37:43.144	USER	\N	\N	t	\N	2026-06-16 23:37:43.583	\N
6e276e63-0515-4855-95b6-f65ff85dbf24	917465367	annymorales370@gmail.com	$2b$10$mSEg5M1EuqW2AhKLsaVYzOzvu73v1AgduHPJ7WIx8l6WUD1vRH1lC	Sara	Morales	t	2026-04-05 07:16:28.45	2026-07-18 02:41:24.157	2026-07-18 02:40:28.656	ANFITRIONA	\N	\N	t	fL9QDDrcTu2p93tK8fJO4u:APA91bHcrE-bO0pKWbx0x9MkbuPRPzAVnlgHUdhPooSIYfLP6UFYvC3yNA2GGEDjNbamfAd9uteF2Xv_VLZFDnb6iPBL4PM_DCThPgd6_p5D_NtG49o38mY	2026-07-18 02:41:24.156	SARAE5FP
4215b759-9065-4de2-8d20-6397fffac991	\N	paredespavaj.com	$2b$10$T05WaCB8XoOm4XgRamGstuvFhNXX9GkmfE5GGIjRxvqArHyF42ZD.	Juanito	Lopes Arazaka	t	2026-06-17 00:39:20.315	2026-07-18 19:36:54.474	2026-07-18 19:31:46.624	USER	\N	\N	t	\N	2026-07-18 19:36:54.473	\N
4ab63f64-58fa-437c-85fb-ade3dcc9dca6	\N	dilbervela447@gmail.com	\N	Dilber	Vela	t	2026-07-22 01:36:01.466	2026-07-22 02:02:36.904	2026-07-22 01:36:01.484	USER	\N	\N	t	\N	2026-07-22 02:02:36.903	\N
a8a1d046-f4c5-431c-939a-f68bfe2cf274	\N	asdasdasd08@gmail.com	\N	Automatización		t	2026-07-21 02:03:11.539	2026-07-21 02:03:12.657	2026-07-21 02:03:11.545	USER	\N	\N	t	\N	2026-07-21 02:03:12.655	\N
\.


--
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.wallets (id, balance, "userId", "createdAt", "updatedAt") FROM stdin;
5027eb00-bd78-4514-b5ea-54825aa20729	0.00	5ee22644-5713-4342-b613-088344267c67	2026-04-05 17:42:39.464	2026-04-05 17:42:39.464
a5348a04-e289-4334-a8d7-4e80bb0a68ce	0.00	dec3b28d-030e-49f1-af9b-441d3188a3a7	2026-04-05 02:19:33.528	2026-04-06 15:33:53.236
8463f9db-5f2b-4d53-9617-69beb1cc6817	0.00	04273fa9-2979-4a3c-81e7-f8d17b3c2d4a	2026-04-05 06:38:49.619	2026-04-05 06:38:49.619
644deaae-3377-4848-a531-d4ead554803b	0.00	6f5b20d3-fb68-475a-b304-7aa067456fe5	2026-03-31 02:59:25.69	2026-04-05 00:02:12.996
3a074996-8ea7-4e9d-9ba5-2885bfff8092	0.00	818ce99c-0c46-4ccf-a372-6c809194c562	2026-04-05 00:48:03.841	2026-04-05 00:48:03.841
28f0bc26-ec77-466d-8104-5a4274a97ef0	0.00	85299925-2366-4fd7-8a87-272883e763a0	2026-04-05 03:47:36.077	2026-04-05 03:47:36.077
e30d4a88-8768-4f8b-9c35-f4e30e5dbe2c	0.00	bce4910d-68ac-43d9-88d5-e9a76a648ed3	2026-03-29 01:24:36.171	2026-03-29 01:24:36.171
fc395138-f0a1-4024-a0ec-336324fa148e	0.00	b5b75c40-3df4-4efc-a9c9-ed40804cf0e3	2026-03-31 03:55:05.483	2026-03-31 03:55:05.483
6861d4b3-7be8-442a-ad5f-efb22dade438	0.00	5893d81a-370d-46e6-8783-926054e7c5d7	2026-03-31 06:18:26.643	2026-03-31 06:18:26.643
b8e8eef9-e394-44e7-ba73-7abd840ba671	0.00	b2b9ec93-8741-4fa9-be0c-18b84d7d6ade	2026-03-31 07:44:48.455	2026-03-31 07:44:48.455
eb59fc8a-b645-4886-822b-da7eafc43ba8	0.00	7ce68788-0883-4d55-aef1-dc64dfe7e184	2026-04-08 16:12:39.154	2026-04-08 16:12:39.154
b90f229d-bcdf-4f16-ac20-e8c863470e6c	0.00	0a19a08e-7705-4b83-9e1e-80b2aef4c1fa	2026-04-07 07:53:56.442	2026-04-08 05:45:58.241
f40bf281-08f1-43f3-9874-b84fd1bc3f6a	0.00	801e144e-1c66-4032-aaec-587d3db15034	2026-04-08 17:37:34.787	2026-04-08 17:37:34.787
989d03e9-a8cd-4002-b2b1-34f536e5df71	0.00	197e5a03-33be-498e-bf56-3943cdcebaac	2026-04-06 05:31:32.237	2026-04-06 05:59:43.206
a901eb94-463b-46be-a2c7-c9ae2a8a2984	0.00	ebc57105-d551-4f37-b5fe-924e337de7aa	2026-04-08 15:53:42.705	2026-04-08 15:53:42.705
3baf3db9-3ad7-417f-a20c-1cd0aa0f9595	0.00	fc5201a4-0e4f-40fa-a957-766a4bdfe40c	2026-03-31 18:36:50.574	2026-03-31 18:36:50.574
6124e391-9f29-4b07-863d-9d8d16542886	0.00	ae043ef6-64d1-4cdd-aead-cfaac366d79b	2026-03-31 19:19:24.691	2026-03-31 19:19:24.691
f75d3a52-a4b8-436a-a652-d408d2b5eddb	0.00	d832267c-c7e2-403e-85b1-78bb34a68493	2026-03-31 22:28:25.889	2026-03-31 22:28:25.889
9993d30a-6bfa-4934-be9a-a8ef8fa9a425	0.00	982f221b-fe45-496e-b958-70b8c4d0d2fc	2026-04-01 03:22:51.346	2026-04-01 03:22:51.346
8bef66c2-207a-41ca-88d2-bc8992fb6f47	0.00	162560a3-6076-4e84-810d-4d0f94abe28b	2026-04-08 16:44:00.237	2026-04-08 16:44:00.237
2e5beb46-8c58-417d-8159-9065668a0f8b	0.00	81a59313-a192-44e6-9532-da180367abf0	2026-04-01 08:25:21.183	2026-04-01 08:25:21.183
2d3639cd-d5bd-4ee3-93b4-d477d6a65ce2	0.00	55818434-6bf8-4190-851d-96dae9acb2b1	2026-04-05 05:07:37.061	2026-04-05 05:07:37.061
380b54b9-5a70-4804-8c8b-1913590b0ab9	0.00	8ad7a76f-ab75-4097-b92a-b07653454207	2026-04-05 06:42:52.108	2026-04-05 06:42:52.108
549b93db-b142-4b1b-ad18-3a4ca79c888c	400.00	1b22e452-ca71-4eed-81af-1839e08acae2	2026-04-08 17:25:13.953	2026-04-08 17:25:13.953
fd7d5615-1f04-4423-975d-ef297f14f2f7	10.00	69d3d892-68a5-45df-82a6-58a6ad40cb89	2026-04-08 23:28:27.759	2026-04-08 23:28:27.759
41326801-7675-4161-a3ee-2320b11c3f94	0.00	9ae2ae60-ae26-4a7b-910b-08bbfc38db30	2026-04-09 04:57:42.195	2026-04-09 04:57:42.195
03d44225-654c-4ced-b762-80b2082df1cc	0.00	f334565b-4fa3-4c9a-9608-832f8c472aee	2026-04-09 21:13:25.592	2026-04-09 21:13:25.592
44849973-050e-45a2-b418-01afaf92d5a0	10.00	f77c3216-b665-48c3-b3c1-5d48953c7026	2026-05-03 17:22:26.727	2026-05-03 17:22:26.727
42e7cb3b-e651-403f-8625-8df09064cbaf	10.00	5004709f-d63e-4e19-88e0-a888aa06482d	2026-04-10 18:26:31.336	2026-04-10 18:26:31.336
fa39581d-8edf-471f-8eab-5b13ff902474	88.70	304884e0-e87c-44b3-a135-525fcc3b24d6	2026-03-22 09:59:42.901	2026-07-14 16:04:35.791
6f6ea973-a372-451a-a4bc-0da894e38878	10.00	f853fc56-f829-484d-812c-ed35a46950c9	2026-04-11 03:03:26.289	2026-04-11 03:03:26.289
6b4cc5e7-c0cc-47c7-a2bc-32ec41e78299	10.00	b8875411-fa9d-4256-b7e0-6a725a3f1436	2026-04-11 04:27:08.932	2026-04-11 04:27:08.932
4d865210-fc4d-4553-ba4e-1dc3df419b62	10.00	2d91f582-36cd-4e9e-8224-cc02977a53c4	2026-04-11 06:47:26.763	2026-04-11 06:47:26.763
30fff396-418d-4e9a-807d-586f9cc5be6b	10.00	de5c1082-08ac-4424-a539-81a3a5d93100	2026-04-12 02:28:44.71	2026-04-12 02:28:44.71
2ee37c0d-682a-4b2a-b732-1adfeff32b57	10.00	5c803021-df71-474a-bde9-44fa4d8b6d06	2026-04-12 03:13:17.739	2026-04-12 03:13:17.739
c9a290c4-8ac3-4ea9-b854-339644b79e70	10.00	ba6b5d64-e36a-45fa-ae19-6c740bc88681	2026-04-12 11:24:14.124	2026-04-12 11:24:14.124
17b0bb98-f3ec-486a-83ce-0dccb66169ef	9.50	5398b688-8844-424f-bc48-74b7cf60d774	2026-04-16 04:17:24.837	2026-04-16 04:17:47.507
6422b606-aa59-443e-b674-b04c212f3856	10.00	9524f501-72d1-49ec-8dc5-bb2261177403	2026-04-18 07:14:26.961	2026-04-18 07:14:26.961
76165246-7076-4944-84f1-339159a79df6	10.00	5b060e0c-a541-4249-abd6-9c2f08211c53	2026-04-21 04:57:19.457	2026-04-21 04:57:19.457
4b52debf-3f19-4f2b-bf92-a24247dfa383	0.75	6e276e63-0515-4855-95b6-f65ff85dbf24	2026-04-05 07:16:28.45	2026-07-22 01:46:48.019
3f1f2ece-b8e2-40fd-a084-a93649602e22	10.00	a5e6330c-0958-4715-bca2-05477d265316	2026-04-25 17:34:52.408	2026-04-25 17:34:52.408
85cdede2-1628-413f-aabe-bfb541512a62	10.00	b9818e31-dfc8-4883-aaca-df0d3b536b3e	2026-04-28 21:04:58.509	2026-04-28 21:04:58.509
2a7f047f-2fe4-413d-b9d7-8ad2af7b4a23	10.00	3d7da8a9-2210-4c42-89b6-1f9fa8c06d07	2026-05-04 09:18:00.273	2026-05-04 09:18:00.273
d537345a-587d-4205-be89-78e2ff36f818	10.00	4e52747e-7e13-4333-98ea-a5c31722ed46	2026-05-07 01:03:01.194	2026-05-07 01:03:01.194
b4fb8296-2a1b-49d6-ac70-8abb876e8d06	15.00	6cd4c719-68fb-4e7c-8455-f7909ce58666	2026-04-14 16:21:13.035	2026-07-14 05:19:00.802
9eb2f922-eabe-4c87-8cfc-c6f9b754e896	10.00	3e957107-e648-43cc-baea-c5878ab6732c	2026-05-02 01:31:19.681	2026-05-02 01:31:19.681
02e98952-4dbd-4f44-a970-34470e78d7a2	10.00	109ecd1a-3b55-475c-bed3-f1339005e2c4	2026-05-04 10:33:57.071	2026-05-04 10:33:57.071
f0dbcbc2-bb40-41f2-affe-a45a7653ee16	10.00	7276c868-9a13-4908-822f-403e45bca30b	2026-05-04 12:55:59.886	2026-05-04 12:55:59.886
3b7630c2-1b3c-463d-911e-b93793fecb29	10.00	1773eab2-4727-40ee-a9b0-d1952a2a388d	2026-05-04 17:11:49.269	2026-05-04 17:11:49.269
89c57cc7-01f7-4e3c-9bb2-f79e92418a66	7.25	832aabaf-e4ec-4683-98aa-75eec4924379	2026-03-31 03:13:57.917	2026-07-22 03:05:26.182
c3bde088-c244-45fe-a6c9-56720a26f698	10.00	6d13a28d-09ed-4bc2-bfdf-aa61c4dc03ac	2026-05-08 10:13:52.36	2026-05-08 10:13:52.36
5317b5b5-f2f2-447b-9447-32203b5df347	10.00	ddae2e8c-5157-4006-985b-eefa7a3f0199	2026-05-04 19:41:38.038	2026-05-04 19:41:38.038
b81eb303-54ac-4906-a0cd-4b473bff9fc5	10.00	42ea5d02-a1fc-48d2-97d1-3bdd712dfd10	2026-05-08 11:45:16.76	2026-05-08 11:45:16.76
9ad9fdd1-cc1c-4207-a23a-97f2e35920f7	10.00	0ce11212-d428-4c69-ae11-c42946e0fe02	2026-05-08 14:41:55.558	2026-05-08 14:41:55.558
e9421675-c800-46d6-96a7-32e63d08c740	10.00	fc72d3d5-2270-462d-87ab-0c1d6239a205	2026-05-08 15:21:20.997	2026-05-08 15:21:20.997
e0e269d4-d442-495f-928f-d6cc6229dc3b	10.00	7cdb0b1c-4dc2-40d0-877f-56ce39b46daa	2026-05-08 17:32:48.225	2026-05-08 17:32:48.225
10ca55ff-2bd8-42d6-b6ad-8bd661da1901	10.00	80140d9b-39a6-4691-bf0a-c0d00872de78	2026-05-08 18:39:06.067	2026-05-08 18:39:06.067
c088f4ab-0de5-46a9-ab66-6e3e43719f88	9000.00	4e7e7405-7841-436d-a277-55b2d8c4299e	2026-04-04 01:45:32.526	2026-05-22 17:02:57.741
0f662fd9-a2c3-4b35-9059-426730ed8778	25.50	850654ff-c2a8-4215-bc96-c0afdb615949	2026-04-06 21:00:00.984	2026-07-14 05:19:40.446
8d6d5e60-9a68-4813-832b-fd313b8d617a	10.00	42da48c6-0a1b-4783-98e6-8457d0fc8f7d	2026-04-05 18:54:54.474	2026-04-05 18:54:54.474
96459afd-6889-41c7-8557-0484f1a5e3f2	0.00	5643cd07-a7d4-478b-b66a-964dece5ad4f	2026-04-07 12:38:56.948	2026-04-07 12:38:56.948
4e378183-31e1-4ad4-8e60-c8e50dee53b8	10.00	5b861f19-1c5a-47c6-a9a1-b4fc35eda3c6	2026-04-06 06:48:13.905	2026-04-06 06:48:13.905
ed3896e5-cd8c-4839-84f0-c9c8d1d98143	10.00	867a333a-9f97-4133-8a15-ba350f41a16f	2026-04-06 09:59:00.841	2026-04-06 09:59:00.841
553e0acf-d2f2-4e4d-a52f-1630fda4d226	0.00	599864fe-f89b-4445-8b25-7da50697043b	2026-04-05 13:21:15.927	2026-04-05 19:35:49.413
12bedc3c-af70-48f9-aa8f-413083a1c95e	0.00	d83c5124-fd8f-4204-a9c7-f413cbc3d73d	2026-05-16 13:17:24.699	2026-05-16 13:17:24.699
5d416464-1ba3-4aab-8385-da121c674db9	0.00	6b72ce53-38fc-4334-b789-b75a4fe111d5	2026-04-08 06:03:23.008	2026-04-08 06:03:23.008
f15b5111-2e0f-487d-9514-a3e61c157138	0.00	36df8ef2-4651-426d-ba5f-a3edc5984168	2026-04-06 21:53:51.037	2026-04-06 22:36:24.169
5256a000-ac4f-47fd-8979-dbfe1a014849	0.00	fd8ab344-97a1-4130-ba7d-48903ff2978c	2026-04-08 18:21:06.212	2026-04-08 18:21:06.212
e8c7be9e-7887-40d9-8c70-70b2a3ba7b36	10.00	81c8998a-a498-40ad-8c01-bb0825873033	2026-04-09 02:33:20.392	2026-04-09 02:33:20.392
347aea1b-57ed-46a4-94d1-0c5193de8e48	10.00	b2a44427-6ffb-4e4d-830b-714c80517b18	2026-04-09 09:03:05.635	2026-04-09 09:03:05.635
f883d438-90ec-4964-a9ae-75bc241a02e1	0.00	4da2c430-d1ea-4387-bccd-dd27daded98c	2026-05-13 23:12:37.979	2026-05-13 23:12:37.979
6b846412-dac0-4f2d-b760-bd82290d6420	0.25	dd0257c2-4f37-4b20-b336-b13494e0ba74	2026-04-11 00:33:28.036	2026-04-11 00:41:18.218
9432f502-88fe-4edb-b7ee-65d9d1a56dba	10.00	7fcb3884-c6b7-4320-b363-e1cefcd41878	2026-04-10 09:51:57.026	2026-04-10 09:51:57.026
9d69ecb9-2e65-4fa0-9cbe-12ad7a322269	10.00	97181454-67d5-45d4-af28-e9eead994af0	2026-04-26 23:11:37.789	2026-04-26 23:11:37.789
3aa72531-fa59-4f81-9154-ce637b34e0f0	10.00	43747451-b9a7-4d8c-83a9-f6340bdc6c5c	2026-04-11 03:17:54.098	2026-04-11 03:17:54.098
5a6d7abe-1d44-4890-bf13-2d8aedfe07fa	10.00	50f22bbe-f8c5-440f-bbd4-9d39b2a25275	2026-04-11 05:29:22.26	2026-04-11 05:29:22.26
3ed2f911-8d4c-4275-95d1-1e958f68efa7	10.00	f7e40bd8-6bb0-455b-8000-85847525a2df	2026-04-11 11:28:07.409	2026-04-11 11:28:07.409
b10f243a-49ac-4eeb-b7fa-bbc90c8472e1	9.50	c7bd5193-a265-44ba-bc7a-ec8dae92b78b	2026-05-07 12:25:48.938	2026-06-22 12:27:26.059
e3c1a016-cb88-473e-88f2-09e274fcd35a	10.00	94a9107e-6332-4803-b270-a3fcad2aeefa	2026-04-12 02:43:14.779	2026-04-12 02:43:14.779
8973792f-06d4-4002-b85a-3d362510d4d3	10.00	3d050fac-5afa-4667-8363-63b858f7c7a1	2026-04-12 04:13:37.868	2026-04-12 04:13:37.868
559f5f41-4a9b-469d-b5f9-f3800eb3cef0	10.00	3b523806-29d5-4986-822d-20a397b04b97	2026-04-12 14:35:05.699	2026-04-12 14:35:05.699
e8e058c8-fe97-43ab-995f-9d88f0e84ebb	10.00	679437af-12b9-4053-b833-572033277abf	2026-04-15 02:25:28.647	2026-04-15 02:25:28.647
c1cff427-557b-409a-9a14-dd9a359a601f	10.00	53362926-cf52-4db8-aa98-080fe2956c9a	2026-04-16 19:25:29.031	2026-04-16 19:25:29.031
65154f0b-41a0-4dc4-999b-eba1bdaba0fd	10.00	e2a8876f-4ece-4125-93f5-9838a5560ef1	2026-04-18 20:23:40.086	2026-04-18 20:23:40.086
d6fc81a9-9805-483b-b305-f7e7c7ac613a	0.50	81a45612-532a-459c-890c-55d6d3391455	2026-05-02 07:07:14.122	2026-07-05 02:05:21.487
d8eefdfe-1492-4694-91e4-b8d06a3b7681	10.00	ea97602c-9fc5-4aca-b2e1-e1142507c775	2026-05-08 10:16:08.409	2026-05-08 10:16:08.409
93905e6b-6f55-4b97-8028-21c01a2ab250	10.00	5899b52e-6c02-4877-965d-0a4439257dae	2026-04-29 00:53:00.68	2026-04-29 00:53:00.68
1179a40e-baae-47b5-aed0-e57058b291b5	0.00	10f0f50b-675d-4fb9-bb15-b5e57bdbc52b	2026-05-15 01:22:45.819	2026-05-15 01:22:45.819
25ae882f-cc22-4056-a3e9-c7314d1972a5	5.50	a28528b4-e871-4137-a29b-b39f512397a6	2026-04-10 19:39:12.462	2026-04-10 20:35:50.412
2d3be2bc-79b9-40c0-bd15-098b5b858452	10.00	28a52218-067b-4816-ba7c-581f48308a23	2026-05-04 09:23:22.553	2026-05-04 09:23:22.553
27b448d2-f4ab-4cd8-b4bd-570c66de2407	10.00	0cdaf38d-21f5-47cf-9bfd-77386ea5a211	2026-05-04 11:22:27.071	2026-05-04 11:22:27.071
8696ba1e-eefc-40cc-aee7-e28618358b11	10.00	3eb8c9bf-adb0-40f3-bf0a-6d40339787ff	2026-05-08 13:42:13.384	2026-05-08 13:42:13.384
fc71e9fc-4e90-4e8d-a4a2-8ebc1b817971	10.00	bb724137-7699-4ec2-9aa5-c59c6bfbe416	2026-04-22 15:47:36.712	2026-04-22 15:47:36.712
5e60c948-4504-45ba-aff4-e277d7ece479	10.00	d8e760c1-588f-4c94-be2b-2ea00e428332	2026-05-04 14:21:27.808	2026-05-04 14:21:27.808
38f4d3d0-8d69-4837-89ba-f4681c2d81a4	10.00	579c6a3a-4186-4973-8522-bdebffcf304a	2026-05-04 17:41:24.121	2026-05-04 17:41:24.121
b97654f8-9829-4a98-a715-5b43d528501e	10.00	7ebc1ad1-7828-4ed9-8c70-0201bf0905a0	2026-05-04 20:02:38.73	2026-05-04 20:02:38.73
925dc47b-91c6-4a44-9233-de139f77a62d	1235.40	52c1851b-d920-4c8c-8c81-d23099affa0a	2026-03-21 18:58:11.413	2026-07-14 16:07:54.643
3e769054-9bc2-407b-8fae-178772a6ed17	10.00	0efe47ef-da7e-48d2-b1fa-3236019ba015	2026-05-08 14:48:19.369	2026-05-08 14:48:19.369
2f50129f-b320-4f6e-b556-1999bab4958e	10.00	e5c103a5-43e8-45fc-91fe-164692d790dd	2026-05-08 15:51:31.251	2026-05-08 15:51:31.251
b2880a36-9586-4d70-a943-ad9b3d4c109e	10.00	2c6d2131-3229-4cba-ae3c-794f14ca9580	2026-05-08 18:02:26.711	2026-05-08 18:02:26.711
1acea10f-5597-4b14-b762-9049f1c76a5c	10.00	5317732e-ec0a-4c09-ade5-d28c2289c8f1	2026-05-08 18:51:09.87	2026-05-08 18:51:09.87
c9cf469e-d763-4a54-be1d-2067c6289335	10.00	20de6987-2064-4d47-84ba-4d3763b67d51	2026-05-08 20:20:21.239	2026-05-08 20:20:21.239
afcdf53c-0d28-479b-8692-1db874838577	0.50	41e81b4b-c22c-40a2-9176-2546ccae0163	2026-04-10 00:18:46.469	2026-04-30 05:36:29.588
8be26779-39ce-4ea0-9b65-0a3e2a91408b	0.00	11f7cff7-cc4e-4973-b09c-b415f8a4393f	2026-05-10 01:50:15.25	2026-05-10 01:50:15.25
d776d9ec-11e2-4e80-9cde-804b7907b254	0.00	296837fd-6a53-4694-9b6c-20465408e9cd	2026-05-03 17:39:56.966	2026-05-03 17:39:56.966
0486dc35-ab49-4c28-baee-33d5f1268350	10.00	da92e284-f3ac-4797-a6d6-f2860ae59752	2026-05-12 19:51:58.23	2026-05-12 19:51:58.23
40c564dc-7611-4301-8cec-428287d7fe04	0.00	3e6953f8-8684-499e-8b22-d9c8f0403332	2026-05-13 13:23:46.786	2026-05-13 13:23:46.786
ced651e2-692f-45a9-858a-f90073c4ee65	0.00	370e5880-5ba0-4526-ba76-14f34e7dd92f	2026-05-13 20:33:41.245	2026-05-13 20:33:41.245
3ede643e-1e07-47ec-bc9c-2c750be10d01	0.00	a7cdc984-83f0-49e6-9351-53e0d7103501	2026-05-13 21:50:48.767	2026-05-13 21:50:48.767
4ee27cd6-db9c-464c-90ab-0a007d6fd634	0.00	c7d27475-082e-49f5-9810-2b87ed7428e0	2026-05-15 03:39:58.418	2026-05-15 03:39:58.418
78c1e70c-69c7-4888-825b-4a2283697e00	0.25	affb0349-62e6-46a4-b877-f5a0e5a60ca0	2026-04-05 04:33:11.141	2026-06-07 11:49:39.294
f70f19fa-0536-49a4-acbd-9ece582b8e8d	0.00	5927fde2-f73e-4a02-afcf-08212a5dd015	2026-05-15 21:37:26.565	2026-05-15 21:45:55.355
02eb5957-7267-4748-b226-ba853e4cb4c1	0.00	20f409ec-a9a0-4759-a2e0-841a58ad4583	2026-05-16 04:38:24.082	2026-05-18 19:53:15.299
44d0411e-7350-4122-a7cb-3262e14b2a26	0.50	92491ea2-42e2-4803-81f2-c9856f9503c1	2026-04-10 21:43:15.84	2026-05-16 02:47:07.514
259f93c2-0f18-466a-b54f-7c6b19685733	173.00	8378d82d-b63f-49d5-8856-f515f0e2ccd4	2026-05-11 20:16:47.164	2026-05-17 01:10:27.524
61afee71-c9c7-4aee-8504-9283cb18e738	15.00	1808fc9e-a96d-4dc0-a466-3e5445ff8abd	2026-05-16 01:26:45.344	2026-05-27 19:53:07.007
95bbc76e-0efb-434a-b179-452d4f47051f	0.00	bb77090c-f3fb-4421-851b-87649fdc9140	2026-05-17 00:27:54.21	2026-05-17 00:27:54.21
a98ef5ca-8868-422a-8317-b8a570f0b5fb	183.85	cadca8ec-879f-4f06-9295-1a9731149965	2026-04-04 03:03:42.953	2026-07-14 14:41:12.565
286aec54-3575-43d1-914e-533c7233427b	0.00	b3512702-02e5-4d5e-82e3-61c9c08973b5	2026-05-17 01:02:48.875	2026-05-17 01:02:48.875
d9a3c1ec-fe75-438e-a195-3c4801913da1	0.00	4166446a-428a-4e83-95a1-3491ff92f622	2026-05-17 07:59:14.617	2026-05-17 07:59:14.617
9f484004-a622-4a9a-bc11-8df10ffc0630	10.00	3f3ef803-d6af-45a6-84f4-2d22d89390dd	2026-04-05 19:56:12.553	2026-04-05 19:56:12.553
06ba9870-cb5c-48dd-9e6a-af1170c0edbf	10.00	a652dbc4-c42b-4f12-92bb-40ad705f0614	2026-04-05 22:02:17.182	2026-04-05 22:02:17.182
43120521-45bb-40e5-984b-980886f893e4	0.00	6aea1710-2fa4-4f91-9516-365e823a32d4	2026-04-08 00:04:01.275	2026-04-08 00:04:01.275
c8cc103f-6304-4fd7-a6e2-ca55b03e854f	10.00	1da91f79-a244-4896-a7d7-08e15a34564b	2026-04-06 01:30:04.019	2026-04-06 01:30:04.019
a0828f1c-d870-4b36-bc56-726d8f1539d6	10.00	d620ed02-c818-4d04-be91-d6814a76c7f3	2026-04-06 01:44:40.278	2026-04-06 01:44:40.278
a645f363-38fb-49ba-b5f1-b1cd4215bf2b	0.00	068de07b-6b37-4f64-9586-fb4196271108	2026-04-07 04:47:57.819	2026-04-07 04:47:57.819
abe83234-5fc6-4216-be92-adb5468ac6af	0.00	b20f5b97-e85a-46e0-a77e-7839a7c5641f	2026-04-07 05:21:36.357	2026-04-07 05:21:36.357
f273ac62-17ae-4ffd-9814-a2ad903a0f84	10.00	5e935756-3dc8-42e8-b732-ac2b40b5c053	2026-04-06 23:24:20.126	2026-04-06 23:24:20.126
2675fcdd-1a43-45e1-ae71-931bff04b532	10.00	69ae8322-3c79-47e8-9712-ee0f426bd787	2026-05-08 10:25:53.196	2026-05-08 10:25:53.196
2b2b78f6-7512-4550-bd64-967b27be6dfa	10.00	36e462f3-a9c2-4837-b8ac-481293147bae	2026-04-11 01:30:58.387	2026-04-11 01:30:58.387
796df305-f00c-4451-bc59-3d0996cd861a	10.00	c1c9af7f-cbd3-4e91-87e9-2d233baf7ad6	2026-04-11 03:56:02.213	2026-04-11 03:56:02.213
d13f5051-0ed1-438d-87ea-919135386b99	10.00	fa4d11c0-b6a4-43db-81e9-2a0b247af9ef	2026-04-06 17:52:40.618	2026-04-06 17:52:40.618
b6f3f06b-792b-41ce-8f3b-425d91e5d04e	10.00	59b401d0-9e20-4ada-82f4-ed81872c43d7	2026-04-06 20:13:49.981	2026-04-06 20:13:49.981
3a93055c-62ad-474a-8389-1eddff361dce	10.00	72ebb69d-756a-4924-8a1e-80d5b794c07b	2026-04-06 20:36:26.227	2026-04-06 20:36:26.227
2f9d1318-190c-4524-8689-23c048e9db13	10.00	740b94fc-cba0-44c8-8169-1f4c239f26fe	2026-04-11 05:32:26.257	2026-04-11 05:32:26.257
e3d22455-283a-47e3-9ab8-9515fde743fa	10.00	d3e37a3c-cc4d-4857-9d41-ecbaaa00d6bd	2026-04-06 21:02:02.109	2026-04-06 21:02:02.109
b4a76143-1e84-4b04-bc5b-8e4bb35819c1	10.00	04331537-fef9-439a-ab3e-c9ffbe3c2db4	2026-04-06 21:50:37.913	2026-04-06 21:50:37.913
31b2d11a-e69b-4659-a2a5-304a094f9908	0.00	71406cb8-fd46-4cae-bf3c-bfef2cbd50a0	2026-04-07 02:53:35.887	2026-04-07 02:53:35.887
5e1aa818-5a1a-4a86-8111-51fc57c4ce0d	0.00	1a689cb0-82e8-4344-87e3-82044bd26ee5	2026-04-07 16:33:38.686	2026-04-07 16:33:38.686
23b692b1-ac02-4d2f-8b9c-7030e62f3d24	10.00	9b580b58-46f3-4a8e-9319-7f3752ef92e2	2026-04-06 02:31:25.348	2026-04-06 02:31:25.348
675c9683-fc46-4019-a68b-8954ee27d03a	210.00	b6e54a63-4b05-46e5-8586-5f307f47006b	2026-04-04 17:12:51.603	2026-04-06 23:38:07.824
322f0c53-d630-4058-91a1-f2dc2e54fae0	10.00	3aadf9c4-2722-4419-82f2-74d00e6441e4	2026-04-11 16:59:10.66	2026-04-11 16:59:10.66
1b249206-d738-4a8b-a801-bd4aad067389	10.00	04c2d87e-d93c-4609-bac2-1c73d428a458	2026-04-12 02:45:09.567	2026-04-12 02:45:09.567
da151330-81c7-4046-9fc3-257b22854007	0.00	225a5f55-64fd-4ac1-8eb3-3d24fe0811c6	2026-04-07 20:08:39.244	2026-04-07 20:08:39.244
c3fae8af-f487-4e8f-b33b-132258791a41	10.00	81df7097-2602-495d-a2ec-408c60637ddc	2026-04-12 06:07:40.676	2026-04-12 06:07:40.676
22971249-5bfd-405a-9e1e-afbedcaea4a8	10.00	b32efeef-d31a-4665-b5ae-904cf68690cf	2026-04-12 19:29:39.204	2026-04-12 19:29:39.204
cf77f061-082f-476b-bb9f-378454d6ffa1	10.00	76f3797b-e979-4293-88ad-26d5757dd7a5	2026-04-15 09:20:26.716	2026-04-15 09:20:26.716
e0954f81-5373-429d-b9bc-b543f277aa81	0.00	178ced85-ad0e-4ba4-9cd7-27020fbd3777	2026-04-08 00:50:24.236	2026-04-08 00:50:24.236
46828d1e-e9b7-4d62-a925-de185db5beed	14.00	ed917127-6f95-432e-aed5-7c4a8cf4157f	2026-03-29 03:22:48.903	2026-05-30 23:00:12.178
f7345e7a-bb6f-45c2-88c6-d2b9ff667f36	10.00	f0dd8dc7-f8a8-4e9e-9652-fece4fe389c3	2026-04-06 14:31:13.429	2026-04-06 14:31:13.429
addd66da-5723-4339-8cf3-94e90821135b	0.00	30a3bae8-ee22-47df-aa5f-c50c2a90e629	2026-04-08 16:56:27.109	2026-04-08 16:56:27.109
7d7c8757-da85-4356-ad9f-0a748eb57681	10.00	67102934-186c-4281-8114-bfe9917fd8c0	2026-04-17 21:55:34.733	2026-04-17 21:55:34.733
046a2be3-c30d-4361-8278-ceda22bbaa73	0.00	30fba7af-7a9a-498d-b253-b9a14c17dae4	2026-04-08 04:11:46.443	2026-04-08 04:11:46.443
f57ba6ab-b2b6-4812-aead-3980807f8585	0.00	f5dafb55-6ad4-43f9-a8e2-8d2f29560c2a	2026-04-08 12:25:30.917	2026-04-08 12:25:30.917
1a3afd77-acec-4b85-8000-7cf1dc34fe56	10.00	70eaa20c-9ea3-4368-865b-e82cc82efa23	2026-04-06 04:49:48.19	2026-04-06 04:49:48.19
a4489c5a-2eea-4488-844d-234d3672b84e	10.00	e59bf2b9-b176-4799-8e53-4132c7b4a82e	2026-04-06 05:56:14.498	2026-04-06 05:56:14.498
0388a266-c7a8-4bcd-87e6-63c5624dae97	0.00	5a131531-7b19-4198-838d-eadbbd87d2bd	2026-04-08 02:14:52.835	2026-04-08 02:14:52.835
f8efac7f-ddac-491f-8758-4a7981a95608	0.00	d217a78d-603e-4ea9-82af-657d3cee1827	2026-04-08 04:21:45.44	2026-04-08 04:21:45.44
905ca705-e1ee-448e-9387-788ce154fc04	10.00	28ad9e87-7377-4515-ac11-5c14512a382b	2026-04-20 09:42:30.731	2026-04-20 09:42:30.731
6c004f7a-e6ea-41a4-8248-4245f84a994e	0.00	360a68ea-671e-492e-b56f-05b2000e671f	2026-04-07 09:59:24.349	2026-04-07 09:59:24.349
fe8437b7-fa63-48ef-9937-ff59806a26aa	10.00	01d48b51-6cb9-43ea-bfdc-5c2000af4fbe	2026-05-04 14:40:50.069	2026-05-04 14:40:50.069
9294d853-38ff-4244-8911-aba002f981cb	0.00	6976b2a1-97f6-48c8-8411-b4207c2f440a	2026-04-07 02:53:17.692	2026-04-07 02:53:17.692
d07ac447-434c-41d7-bb76-b58820d7d07a	0.00	8ac6615a-71e9-48ec-910b-244b661d4950	2026-04-07 03:44:23.957	2026-04-07 03:44:23.957
4982df1d-ea7b-45aa-957a-7ea77a84c055	10.00	dc98d365-4239-45a0-818f-52edb3411bf6	2026-05-03 01:38:04.917	2026-05-03 01:38:04.917
dee1213d-c2c5-48f3-97a0-813e65841d9e	10.00	fe63bb9a-4219-4da1-bf8f-c52412f6e801	2026-04-06 06:03:04.364	2026-04-06 06:03:04.364
ba4ca5d5-a56c-4b81-8482-cfe8e49067d8	10.00	8a76fc2a-6f8c-4264-89bd-9827763d0bdf	2026-04-06 06:59:08.766	2026-04-06 06:59:08.766
042aafc9-f3a0-47b1-aaaa-c77d9f1dfab1	10.00	56bc08e8-a2dd-4a71-b14b-6ea3daa38d69	2026-04-06 11:21:24.07	2026-04-06 11:21:24.07
a6c4f51d-8f49-4518-806d-eb89008afe31	0.00	9cfad3d0-e269-4d5e-adb2-1d745ab9d571	2026-04-08 00:39:03.544	2026-04-08 00:39:03.544
96b3816c-1db6-425c-90ae-5feab98021b0	0.00	169ae99c-219b-42dd-9089-3e58391b41be	2026-04-08 01:02:32.111	2026-04-08 01:02:32.111
4d3b20bb-76fa-4678-9cc4-78d7f339445d	10.00	198da2c0-0a8e-486d-b715-6cad34b02bc0	2026-05-04 17:44:33.78	2026-05-04 17:44:33.78
51273683-6f72-4375-88cd-34b981cff3b0	10.00	9e7ae97a-42e8-4c75-9b92-a4dbf954ce19	2026-05-04 20:17:01.776	2026-05-04 20:17:01.776
f2232ad0-5aef-4ad8-9350-c1c2fe9feade	3.50	fb41944b-5d8e-4c5e-8b9f-4e8661e007af	2026-05-04 04:34:24.703	2026-05-04 04:55:36.247
cab1a5bd-ecbd-404b-9047-c9c88bf0ce06	10.00	f6c000b1-9659-4fcb-b39b-d1f31258c870	2026-05-04 10:22:08.889	2026-05-04 10:22:08.889
13b61e92-6a92-4cea-b7f3-757a1165a237	10.00	585fe0ad-dc81-4fa4-b28f-c0ab16e62c25	2026-05-13 03:50:10.149	2026-05-13 03:50:10.149
c5a95e53-6e4f-45b6-b708-0068a0cdfe45	0.00	66d5c599-eca6-4dd4-80a9-ba19de3f0e22	2026-04-07 05:15:48.783	2026-04-07 05:15:48.783
9343ec66-a1eb-4917-a3f7-8e40fe1700db	10.00	4ecad286-a43a-4487-9957-8a9d3d2af52d	2026-04-22 20:35:31.49	2026-04-22 20:35:31.49
73728b85-71cc-4181-8da9-87e4ed8100c2	10.00	d19fae64-dba5-4f3b-b12d-52a085efa21f	2026-05-04 12:27:20.916	2026-05-04 12:27:20.916
0d712e78-f30c-41ea-82f1-fc3dc6ffe5b2	200.00	9164b5c0-ac8b-4a2e-9ec1-ad45fda5b316	2026-04-04 14:28:24.353	2026-04-26 03:48:22.853
aa551991-363b-4318-8b1d-84268dcddf49	0.00	93586e5a-4fd0-4bd2-9287-fa4f308af08b	2026-04-07 05:40:33.412	2026-04-07 05:40:33.412
c28b7df3-4124-4d35-92a4-fa3dda64e987	10.00	98a21c81-0a67-4b4c-8923-e06d43c844d8	2026-05-08 13:59:00.213	2026-05-08 13:59:00.213
66e62bc1-b4f4-45d7-8c0a-668e72cfb076	10.00	58c3b43f-2de4-4f0a-8d99-bb8c2605cc4d	2026-05-08 14:50:59.125	2026-05-08 14:50:59.125
95e03774-4c9a-4672-a0f7-cac1b7ca99c2	10.00	135181f0-4f89-46db-86a1-eb721cf3913d	2026-05-08 07:06:52.713	2026-05-08 07:06:52.713
8394b52b-c320-44d6-9978-0ff2f4c2d363	10.00	8d15ad5d-09a9-49d7-bcf2-5bb2261f0c32	2026-05-08 16:34:50.884	2026-05-08 16:34:50.884
715bda40-2016-458d-a33c-0378f48d9651	10.00	eebf9f36-165f-455b-a649-d5f55d69baa0	2026-05-08 18:10:33.511	2026-05-08 18:10:33.511
cd0d7d84-8b93-46d2-b5fb-48f896ba0dba	10.00	b075c824-5525-4904-8f72-e3812b41c53c	2026-05-08 19:35:16.282	2026-05-08 19:35:16.282
ee4456b2-a3c8-4034-8bed-23f693a35dc0	10.00	13a6bff7-f64a-401f-8ff8-efe774497c49	2026-05-08 20:44:55.729	2026-05-08 20:44:55.729
50d67188-43f1-4655-885d-d89a57b2aab9	10.00	d55352a5-24d8-4aa0-92ac-e47c2a8b8055	2026-05-10 04:11:24.627	2026-05-10 04:11:24.627
0b47883f-5066-42a1-93b8-23023a552b94	0.00	d2a7dadb-154c-442e-9806-bb52e9e380f1	2026-04-07 11:00:48.522	2026-04-07 11:00:48.522
489dab60-91ba-4d3f-b4b1-f917bf02dac8	10.00	c2e6c369-0649-46e8-a0e2-b888d83d131f	2026-04-05 17:49:11.966	2026-04-05 17:49:11.966
1743ab85-2b5f-4329-a6d3-ec908cee578a	10.00	ed57ec95-8351-4367-8d45-f4b91911a099	2026-04-05 19:18:04.038	2026-04-05 19:18:04.038
e237a3d5-93b4-4995-aa98-ad9927d0097e	10.00	e66556cc-de35-467c-bffb-2bb10f08adef	2026-04-05 22:51:46.116	2026-04-05 22:51:46.116
4684deb9-2d8d-4a06-8faa-12b9cc256597	10.00	8f36a80a-9e9c-4bc9-8603-72b22ae3c5f7	2026-04-06 01:34:56.231	2026-04-06 01:34:56.231
11bd09eb-ec41-42ef-b469-1469460178af	10.00	0f618476-9f1f-40d6-8e89-3f8e2554af13	2026-04-06 01:44:50.729	2026-04-06 01:44:50.729
bd55d9d8-60d7-4787-b3a8-076d0a71a288	10.00	e4264309-988e-468b-9f8b-868b750e973b	2026-04-06 14:37:51.119	2026-04-06 14:37:51.119
85d6b707-4506-4422-a9b7-63f3e7b33b76	8.00	1b80ea97-9a78-4674-804f-39ef05924c67	2026-04-07 08:35:35.065	2026-04-07 12:56:13.161
c2d91a5b-1510-4177-bcef-01c1d220cda5	0.00	8f939ead-58b8-4491-9485-1b885ad125b4	2026-04-07 16:01:35.87	2026-04-07 16:01:35.87
94f45a5c-2539-4176-85b8-6aa9a92f0f7a	0.00	b2351447-b63a-4e96-ab43-092fb29b8b06	2026-04-07 19:25:43.779	2026-04-07 19:25:43.779
3437c737-74ad-491e-bd62-5a6056e8b6c3	10.00	a0275649-e6f1-48d5-9774-de80f2dcfd06	2026-04-06 02:42:54.62	2026-04-06 02:42:54.62
304cc6b2-29d1-4d0b-8b93-5b82e4149f18	0.00	b843e168-1f1c-419d-b9b7-eefc7f7dc435	2026-04-08 03:27:54.104	2026-04-08 03:27:54.104
a12b5008-e2b1-4b62-bfe3-1d47a1b5a032	10.00	d2c48c15-9d40-47e7-ba16-12cb5d2ee4ca	2026-04-06 20:09:59.701	2026-04-06 20:09:59.701
a5e5ec20-47d0-43c8-a620-35a93ea87f23	10.00	26e11e57-9d55-4cbf-aed1-40adc9f3f410	2026-04-06 20:21:31.572	2026-04-06 20:21:31.572
c7e3f538-c232-42c2-a8a2-5826bb7609e9	10.00	954d4a1a-0d08-48de-813d-f5665b5968a8	2026-04-06 20:39:51.557	2026-04-06 20:39:51.557
9b7d7f18-80bd-424d-a825-0edcd142f8ed	10.00	17996dbb-d4ba-4bef-b265-115cb4a281aa	2026-04-06 21:01:21.235	2026-04-06 21:01:21.235
32917572-29e7-4406-bb24-de044538dd15	10.00	1d005ba4-b597-475f-964d-90ad921e9020	2026-04-06 21:27:26.764	2026-04-06 21:27:26.764
c4185f4e-c2ac-46e4-b03d-38e6d4066069	10.00	03daa672-341a-4cce-91ab-81f3159a7036	2026-04-06 21:53:22.336	2026-04-06 21:53:22.336
de8ceed7-9651-416f-8053-f14018b77ce0	0.00	9327dc29-688e-483c-a262-1fe1c180361b	2026-04-08 04:18:49.726	2026-04-08 04:18:49.726
a8988279-9f63-42df-9834-3834454b963c	10.00	ab44e481-2f7a-49ea-91f0-16be463368ec	2026-04-06 22:37:45.663	2026-04-06 22:37:45.663
e75a7f2f-acb3-459b-b7f6-b85c26a46529	0.00	eac25be7-9bea-446f-8546-ae3f5b312d71	2026-04-05 12:50:35.99	2026-04-05 12:50:35.99
0fc98fe9-376e-40ac-ad82-a9cd1b905ca4	0.00	2a051152-23c8-4597-a95a-cfbb96105715	2026-04-05 01:02:12.442	2026-04-05 01:02:12.442
9d693796-cee9-43e6-842e-3f527eef4f11	0.00	ada1e029-08db-472b-851e-5f1265a66fc5	2026-04-05 03:19:02.709	2026-04-05 03:19:02.709
06a5f072-9638-4a19-ab46-dadfe3a2de43	0.00	8b4647cf-a910-4878-9a1d-6849a7c8af42	2026-04-04 17:36:58.391	2026-04-04 17:36:58.391
b1636ac2-8d45-4595-880c-9cd14d8cf18d	10.00	da244740-12b0-4691-a6ca-280f6d83a716	2026-05-03 10:39:11.912	2026-05-03 10:39:11.912
69ae77b7-521a-4136-86a3-c42c58240802	9.50	9f83b658-6493-4a6a-931e-ccb6b8b7cad2	2026-03-31 19:29:12.247	2026-07-14 14:41:12.561
8fbe5f1b-b92a-4b5a-969f-ff0442f8a149	0.00	0d6251c4-0c8d-47e1-871f-d7446ce48732	2026-04-07 21:13:09.711	2026-04-08 02:48:05.557
5d68e083-119d-4f3f-bda5-7930d8e6e1bd	0.00	2e0740ed-8b4b-4f38-8c94-25812aff3cdf	2026-03-31 20:28:47.971	2026-04-08 01:53:23.1
02e80d56-639d-4aa4-a9df-aa7a6ba5804f	0.00	ce3225ba-19c4-42d9-a94e-547708f6d44a	2026-04-08 19:16:11.795	2026-04-08 19:16:11.795
3ad9de31-376c-4d5c-bc90-7194de10ae85	10.00	2456172b-6d96-4f6a-87be-dc9ff922f955	2026-04-11 02:27:51.689	2026-04-11 02:27:51.689
a59b1ffc-de01-43d2-8584-fe5806ec6c04	10.00	e082d771-fb3c-41e8-805f-052e544edcc6	2026-04-09 20:12:20.241	2026-04-09 20:12:20.241
408a8064-9ec9-416b-85ef-5f3c13271918	3.35	6f9dd63d-2ffa-4634-a840-0617804df6b7	2026-04-05 03:52:25.077	2026-04-10 00:27:28.749
395f8bc2-f2c5-4649-a454-28a4b678d7f2	10.00	906f801f-ad3d-44c7-9bb2-887351e8355b	2026-04-10 03:05:16.87	2026-04-10 03:05:16.87
19801a2a-f7b4-4cd8-a674-1adcbadc4308	10.00	1fb7991b-f01b-4132-8731-f6331aa2cb43	2026-04-10 14:43:57.578	2026-04-10 14:43:57.578
f5fb1632-d665-4d19-9759-e792df1be642	10.00	d1feff79-fbc1-4252-8f1e-0c9e58e7d531	2026-04-10 19:59:00.786	2026-04-10 19:59:00.786
1fb05900-f200-46e4-9947-69cac7fe2b47	10.00	7669d18c-044c-4528-9acd-be58bd8bb137	2026-04-11 04:00:22.944	2026-04-11 04:00:22.944
7335ba10-39fb-43d9-95dd-959b7b615afa	10.00	b475ab92-5be8-43e6-8091-633218517683	2026-04-11 05:50:35.782	2026-04-11 05:50:35.782
7b5e7dc7-4b5c-4113-84bd-d27e29ede744	10.00	c2491471-8a37-44f4-8d7e-66f9f4f567ca	2026-04-12 02:08:24.556	2026-04-12 02:08:24.556
452b9989-7986-4ca6-bbe2-2252a63f7f85	10.00	ead49473-ad37-4c04-8f18-29eee7e55171	2026-04-12 02:59:29.162	2026-04-12 02:59:29.162
785a7697-b20a-443b-a993-fcb7f7e49aa3	10.00	fb214014-a2a2-41df-950b-b3950525c4b5	2026-04-12 11:17:48.08	2026-04-12 11:17:48.08
6056daf2-0299-4fa3-8836-20e302d15989	10.00	162a0d88-4a0d-4f33-b394-d4a04f82da26	2026-04-13 23:12:51.348	2026-04-13 23:12:51.348
fc85ea8a-ada9-469f-b394-0390403badee	10.00	d112f25b-610a-445a-85a0-0d53c22168c2	2026-04-15 23:47:09.449	2026-04-15 23:47:09.449
f9b3937f-8f67-4ca8-a903-37d14eb0713f	10.00	0f7b4e7b-17f3-4d7c-878b-055ee8dac528	2026-04-18 00:45:12.736	2026-04-18 00:45:12.736
32971f14-ac14-4663-8ab4-28f7a77cbd78	10.00	b556b7a8-f229-47f0-9453-6106c9a68653	2026-04-21 02:22:56.96	2026-04-21 02:22:56.96
205eb312-2ee6-474f-9678-a81536e60bd5	0.00	b41ef399-b937-4fd5-b26c-258d14a5845a	2026-05-04 06:41:38.905	2026-05-04 06:41:38.905
350fb062-7ac0-4b90-9314-eb46acb8230b	10.00	f3391727-9c64-4ab4-9623-7c92862899c6	2026-05-04 10:23:03.039	2026-05-04 10:23:03.039
0625411e-3dd7-4a5b-94f9-9d308c6cd183	10.00	6af62b72-c49f-49b4-90c8-b3e3467cd6ae	2026-05-04 12:40:10.934	2026-05-04 12:40:10.934
2ef0d4b1-6d77-47f4-8592-b0ea783a6e82	0.00	fdd45029-8e81-4f0c-81a5-e58cbebd0385	2026-04-24 02:20:19.689	2026-04-24 02:20:19.689
72e11a49-52f2-47c8-8b81-0b9e81aaab91	10.00	86860ded-58e9-43db-9e8e-00f1d4161fab	2026-05-04 15:27:42.513	2026-05-04 15:27:42.513
22a5f861-7f80-4829-872b-cbc608353a8f	10.00	47339094-1daa-4449-9dce-843579263fe4	2026-05-04 17:52:05.134	2026-05-04 17:52:05.134
47f686d0-0a5b-46c7-9233-d8b8d7c893b2	10.00	25b2a762-7e47-4134-bf3c-c69ef581863b	2026-05-08 09:50:04.05	2026-05-08 09:50:04.05
989a3745-c34d-41b2-94b0-68bd8ac641d8	10.00	0d5b21f4-0dc6-466f-948f-9774bb5413f5	2026-05-08 11:28:39.196	2026-05-08 11:28:39.196
36a1e380-00d2-4bd7-821b-95823c86efef	789.20	43d8d8ee-1e3a-4bdd-8666-2ce66dfdf256	2026-03-21 19:07:07.781	2026-05-17 01:10:27.526
2ce32a5b-9b98-4323-ac4b-e8e0420f228e	10.00	e33e08f9-dc8a-48f1-810c-bfb657d9fd48	2026-05-08 14:06:09.13	2026-05-08 14:06:09.13
013d1c86-5c5f-4116-9a77-a48b602f95ec	10.00	c8717ec0-2459-4453-9e07-def794fce32f	2026-05-08 17:26:59.897	2026-05-08 17:26:59.897
cef12e4f-4618-426a-9101-1dae63e5a042	10.00	3ba3ccfc-600e-4690-a156-86ca7eb4aaba	2026-04-30 00:03:56.234	2026-04-30 00:03:56.234
f809df63-275b-4f69-8853-027f51570348	0.00	d3bea0b4-86a4-46be-8c56-1cdb09c7da7c	2026-05-06 04:35:42.342	2026-05-06 04:54:35.137
0132b524-ef91-46e2-8511-7774ff3a3136	10.00	a9aa889e-3c05-40b3-986b-cb4bd653f10e	2026-05-08 15:08:20.173	2026-05-08 15:08:20.173
65508e76-9565-420d-a23e-fe7c6bf89728	10.00	975162b0-1c94-4cc3-b740-b2b3a82c4870	2026-05-08 18:12:43.891	2026-05-08 18:12:43.891
55f6ccab-db6c-4e92-a60d-e40a6ba7cdc6	10.00	fe11c4ad-6c7a-41b2-ad11-84071a3914be	2026-05-08 20:11:19.564	2026-05-08 20:11:19.564
53fd50c9-9f94-44f0-99a5-e136b8ccffac	10.00	2b90c33b-af34-43b3-bec6-27c91d08d9e7	2026-05-08 20:58:40.539	2026-05-08 20:58:40.539
ff2c099b-6b9c-4133-9207-fcc068c01dd4	20.00	0986237c-cb80-4d13-a8aa-f86253b614a6	2026-05-10 05:06:41.992	2026-05-10 05:09:05.775
d28e6f57-17fa-40c2-8c4d-ccc3dc125b1d	300.00	16ebfe2f-d0fe-46c8-a6d0-0bc949f44b4c	2026-05-11 20:23:55.539	2026-05-11 20:37:20.166
73346749-a989-45dd-8cbd-d35c40ea850f	6.00	c66c79d2-b59e-41c3-aef0-ec1ce54c77d3	2026-04-05 20:33:49.169	2026-06-24 04:43:04.571
b6075930-69c8-48e6-a521-91b3f870a7bc	0.00	ba25f67a-9d84-4e41-b869-77062401666f	2026-05-17 22:28:46.545	2026-05-17 22:49:36.28
433ffd2b-aa10-4964-ab6c-382b106a35f2	0.00	48869768-30fb-48db-86b4-9dc9d45fe727	2026-06-16 23:38:16.446	2026-06-16 23:38:16.446
26d74556-b789-44d9-8181-cab8c817828e	0.00	e9f70fc1-a4b3-4ba7-aebe-80dd634a8d1e	2026-06-16 23:45:08.548	2026-06-16 23:45:08.548
7daaae45-7eed-4534-b147-45b6d51f4f07	0.00	dece3752-d51b-4d32-95ba-480d73b55db1	2026-05-19 06:50:49.835	2026-05-19 06:50:49.835
eba6f66f-b9e4-404b-8cb6-1aa0598c2040	0.00	940e28c5-35f3-41ba-b0bf-5d958a85fbf7	2026-05-20 03:42:47.447	2026-05-20 03:42:47.447
0f525ff7-98a2-4e72-8d97-56b699065fc6	0.00	a26f840d-db0d-40d8-b881-2005b8cf4473	2026-05-22 03:42:41.09	2026-05-22 03:42:41.09
82402f57-239d-46ef-a38d-ab2f5670a900	0.00	261efc59-4ced-447c-80d4-1070eada2618	2026-05-22 16:41:59.635	2026-05-22 16:41:59.635
65fd5f11-0797-42f7-a46b-172a64901dc6	500.00	b8f63138-a5ba-4b5c-b25c-ffd88ec1386b	2026-05-22 16:55:52.148	2026-05-22 17:02:58.191
4cd3e654-d4a7-4f0d-9c33-09ff31f30187	0.00	1ee9e50f-7fce-4125-ad85-c544b4ee68a4	2026-06-16 23:57:55.183	2026-06-16 23:57:55.183
06a1f467-82f0-4cc4-a33a-b5c9fc7aa9e8	0.00	b3e7b293-ecbb-4ebc-a5bd-97d820611660	2026-06-17 00:11:05.001	2026-06-17 00:11:05.001
7b4fd1eb-d25a-45da-ac05-59caba51649c	0.00	1bfee12b-3ef6-42f4-af35-a08473c4e0ca	2026-05-27 08:25:12.139	2026-05-27 09:26:04.581
57217e23-c622-462c-b159-124104e893d3	0.00	4e33169a-9f8c-4251-b531-fa7c38521bc7	2026-05-27 13:04:16.855	2026-05-27 13:05:21.106
3d573a86-28b5-43b5-9d7a-72fd8d86582e	0.00	b342bee4-6e60-4395-b242-1f939d7967ca	2026-05-28 01:49:54.386	2026-05-28 01:49:54.386
3b5a7a3e-52e5-4f23-a962-1aa40e33dd01	0.00	aa134fd6-6b30-4b19-844c-73d700d6800d	2026-06-17 00:16:00.257	2026-06-17 00:16:00.257
61938195-c331-46d0-960b-f0def9fe6a83	0.00	9900429a-7d71-4fb3-8919-a5e2bb7e1460	2026-06-17 00:18:54.325	2026-06-17 00:18:54.325
14a1a6cb-fa62-494a-9b09-0747af11b118	0.00	2ca49a07-c657-4a76-9898-8cee99b8bf5b	2026-06-20 05:16:10.033	2026-06-20 05:18:11.907
cdcacbf4-ce63-456b-a9c4-60a291ae0c78	0.00	ee1cafe5-bb22-426b-bfec-c0471f2cff7f	2026-06-21 21:47:28.829	2026-06-21 21:47:28.829
d1c75dab-c26f-48c6-b72f-ca56ab8e5800	0.00	01b121d2-a965-4ac2-bc8d-bde43303ad39	2026-06-22 07:49:15.993	2026-06-22 09:04:57.219
f36ee4d2-d7db-47ed-9271-29682696b8c7	0.00	a89853a8-82aa-4b46-9bf6-005479c699b6	2026-05-31 04:16:31.397	2026-05-31 04:49:48.955
2b8c3b22-1153-4358-8191-7eeb227b4b22	0.00	8b87715a-1a1b-42f2-a336-b106972cf7d0	2026-07-01 20:25:53.581	2026-07-01 20:25:53.581
08795492-f4a8-4827-8261-01d9dfa8601d	0.00	6885d8b2-726e-4e47-a1a5-b10d2234cd4d	2026-06-23 10:40:51.458	2026-06-24 10:50:34.324
d76a4120-edf5-4759-9fc6-16c9b2a6a02c	0.00	a63afb22-98a2-4499-ae4b-fc21ea76eed5	2026-05-29 19:19:18.649	2026-06-01 17:33:25.497
e66cbd2d-be1f-4f9b-95cb-c93d3e4100cf	0.00	2cabf7df-555a-467a-9cbd-3add658b68ce	2026-06-22 14:44:17.407	2026-06-22 14:44:17.407
8a23659a-780a-4068-8b03-7dc34c2bb04a	0.00	47aec11b-cf7d-4b92-81bc-70df20808a09	2026-06-01 23:41:55.221	2026-06-01 23:41:55.221
99dc0bc8-039f-410f-b0de-b90f268ed05b	0.00	b827b865-dde5-4384-9b10-cd7f858c4d0f	2026-06-04 06:12:31.703	2026-06-04 06:12:31.703
12322d25-1610-4e51-b7a5-e27dade2ea08	0.00	b3c3c1e3-2c07-4014-99fe-9e888da32da0	2026-06-07 05:17:14.285	2026-06-07 05:17:14.285
6da4826d-7bf6-4478-93c8-4a16ce88ae12	0.00	a8c3a75d-a86c-499e-9636-de4a14cdad5c	2026-05-27 15:45:01.95	2026-05-28 04:15:43.394
7002b627-2660-46f8-a62b-89308db4a170	0.00	64e07836-b136-45c5-87cf-41c14d10d114	2026-05-28 07:40:16.771	2026-05-28 07:40:16.771
153edde1-3570-41ec-ac7a-cac818a6dd63	0.50	8a3bb928-b6e1-4334-a038-55d49c49d7ce	2026-05-30 22:44:16.49	2026-05-30 23:00:12.181
8107b331-a695-46b6-ac68-e1d4c078f46a	0.00	58f02c46-5a60-47bf-b260-6935fba622d2	2026-05-31 03:53:25.851	2026-05-31 03:53:25.851
237deee9-1080-4eb8-af13-36c4dab4d240	0.00	dc74b107-7bd8-421a-b762-c5fd6977ccb0	2026-07-15 06:17:34.081	2026-07-15 06:18:34.908
debbceb6-c52f-47de-9ca1-01ff234aabc4	0.00	60ff77b5-54f8-434f-a918-2a981a03112c	2026-06-07 11:39:01.212	2026-06-07 11:49:39.292
9f59c0c4-276c-4be4-8bc0-4cd5259b30ad	0.00	a196b0f9-6e1a-41be-91df-cb19b320504a	2026-06-08 04:25:40.224	2026-06-08 04:25:40.224
566a8644-9a7a-42b3-861f-c6c9f959ae6b	0.00	56ebdbbb-8356-4503-89fa-791d55f200e5	2026-06-09 07:47:28.014	2026-06-09 07:47:28.014
0c7f8a82-622f-4dff-8484-770e2f99411b	0.00	07756b0f-e984-4beb-9fdd-1f03b3f9b811	2026-06-10 03:36:01.56	2026-06-10 03:36:01.56
c15c1f09-f391-49dc-9790-83383da9f2d0	0.00	189b0b52-fd73-470d-a4b2-b478b48d6868	2026-06-10 13:37:37.459	2026-06-10 13:37:37.459
7e028074-8947-46b0-82e8-0f3013678511	0.00	941d8710-2e84-45dc-a1a1-6bca465fb251	2026-06-10 16:43:19.622	2026-06-10 16:43:19.622
aeb93722-48b8-4216-8457-9050ad30ec10	0.00	6a5428d5-36cd-4d6e-ba3e-5977d06382ba	2026-06-11 01:12:17.813	2026-06-11 01:12:17.813
384c8e96-a4e4-47b2-ac19-8b19c5fb8082	0.00	dd378c51-dec5-4580-bdd5-5f6975e1a3c8	2026-06-11 02:53:02.784	2026-06-11 02:53:02.784
f7f99438-d15d-45c5-9ef6-4683c07bf592	0.00	10a7e4d8-d4d0-48f6-9b6f-9b5ff680f74e	2026-06-11 07:27:05.08	2026-06-11 07:27:05.08
3af0c2ce-ec67-438e-9654-c8fb66c6b4ff	0.00	9bad8d77-2bbd-40d7-b9a3-e4dc02b6b951	2026-06-13 20:25:46.216	2026-06-13 20:25:46.216
ca3258f0-1923-49b8-a5d0-6a5a41684752	0.00	8e66e230-01a8-4503-bcdf-d90b4e431843	2026-06-14 05:48:50.348	2026-06-14 05:48:50.348
eac70646-5007-408c-8564-6e5247eff1b3	0.00	b95dcaf7-1ecd-4989-9237-bf0fec59efa2	2026-06-15 20:26:57.805	2026-06-15 20:26:57.805
1133879d-970d-4a43-988e-79cc200be0bc	0.00	28fc4580-2010-4f0a-a39c-69cc54892617	2026-06-15 21:22:53.563	2026-06-15 21:22:53.563
4268cdb3-a51d-4597-81cf-9c8bc1942457	0.00	0bf540d7-7834-4bfc-ae21-aba70e72b5c4	2026-06-16 09:14:23.102	2026-06-16 09:14:23.102
1a299956-db90-4c25-80bf-a34c156c0ffa	0.00	b06e72ed-13c3-4cff-823d-7977816685bc	2026-06-16 18:22:28.752	2026-06-16 18:22:28.752
6cfbec0b-5c31-41ac-90fd-b7187a54c395	164.00	c61a6045-e7e9-44b2-93fb-ad367b08cb93	2026-06-17 00:06:32.118	2026-06-19 00:16:36.732
d693274d-4f13-42f7-8930-585fc6409e68	0.00	e9159f6f-711d-4404-bb6e-e789072b7281	2026-06-25 02:30:06.513	2026-06-25 02:30:06.513
01825159-4ab1-4b9d-ac3d-ea0bf379c1a7	0.00	74b016d6-a584-47a6-b95b-c754b24f07b1	2026-06-25 03:42:09.949	2026-06-25 03:42:09.949
f87c2747-ebbb-43e1-9bdd-5afb2a0be1e5	200.00	50953781-3741-4d74-82a3-e6f009e9b033	2026-06-16 21:34:02.189	2026-06-16 21:34:02.189
04444f32-7776-4ea1-89fb-95e9e60d7c6f	0.00	1e726e4e-83df-4f9f-b369-0d4e9e9d3b81	2026-06-16 21:49:06.602	2026-06-16 21:49:06.602
81a96941-8cf5-40a5-86ba-767b249fad0b	0.00	5833ebc0-98f0-4a13-88fe-da3b1bc5b694	2026-06-16 23:19:22.847	2026-06-16 23:19:22.847
75a80f0a-1963-4821-b3f8-cda1eaf3c910	0.00	624d8d60-25d1-4344-981f-4ead2477afea	2026-06-29 20:54:05.578	2026-06-29 20:54:05.578
7741d860-4af6-4f48-a156-308b0ed5b306	0.00	011655d4-c895-49d6-aedb-af203c5a274b	2026-06-24 05:59:08.581	2026-06-24 05:59:08.581
f7285756-9a3b-4c27-9c28-e35327ce702a	0.00	e9985fa3-2a2c-40a3-bdf6-a4c9feb9de42	2026-07-05 02:04:39.359	2026-07-05 02:05:21.479
9595ad2a-6303-4b1e-a40e-f7f5311096c4	9640.90	c6c9f4d8-c7db-401d-b15f-f9509a8089a2	2026-04-04 12:53:32.44	2026-07-14 16:07:54.639
d402737b-e875-4b00-b970-97d45bdb7308	343.00	fa82f190-e133-460e-a800-145362c903a5	2026-07-07 03:21:26.495	2026-07-14 05:12:17.146
2d7f1591-8c54-4b99-a09f-829d33daef81	402.00	4215b759-9065-4de2-8d20-6397fffac991	2026-06-17 00:39:20.315	2026-07-14 05:19:40.445
370113b5-f9c5-497f-8977-5190daa99e50	43.50	705bcf07-fd33-4f4d-a2c3-9fb8d2ab97c7	2026-06-17 01:12:33.955	2026-07-14 16:07:54.642
07dcb8be-87e3-4a7b-b697-937e9e48a819	0.00	2c406a15-425f-473a-aaca-1b04d8ecfd8f	2026-07-15 06:27:26.079	2026-07-15 06:28:20.969
8d2997a7-33ee-4418-9f65-d1653fd4658d	0.00	b4364d07-e796-45d1-9fd7-575a8ab796e7	2026-07-15 22:44:05.678	2026-07-15 22:44:05.678
cde483c5-df27-4db2-8001-d11d64547045	0.00	3c1870c9-d5d5-4c25-8c49-8a2d2fc6fcc9	2026-07-15 23:17:19.035	2026-07-15 23:17:19.035
635102de-7b62-4d03-8810-c99cbe802d5a	0.00	9e692bcf-dd5e-48c8-ba02-db1c5b03913f	2026-07-16 00:37:53.589	2026-07-16 00:37:53.589
e367a36e-5303-4513-bf8c-80f0f02a68a5	0.00	4a9df2ac-3b35-4baa-8725-e21c81398dd3	2026-07-16 00:49:24.725	2026-07-16 00:49:24.725
737e3a9b-a6ba-48c5-8d6e-6e4172669c0d	0.00	9c97906d-d2d7-4c7e-b796-ffaa83570eee	2026-07-16 03:42:46.05	2026-07-16 03:42:46.05
43e0f0ff-d9cf-4067-a897-23525e4a1164	0.00	ff84c1c6-7ffb-4c0e-8b6e-c1590c140b8a	2026-07-16 04:40:56.482	2026-07-16 04:40:56.482
e070b04f-ad78-40af-b8e8-f218437d259d	0.00	05c0a4ac-fe39-4689-90aa-c01f80b77da4	2026-07-16 04:59:29.866	2026-07-16 04:59:29.866
00cb0ea0-d78f-48f8-817d-c949d738d69d	0.00	8c116257-5c9a-44ab-9ed1-f5412bf989f8	2026-07-16 05:45:11.38	2026-07-16 05:45:11.38
fe158757-45ae-4560-996d-38aaba492d5c	0.00	20553dc3-047d-46f2-9ed3-c7419554a002	2026-07-16 05:49:41.466	2026-07-16 05:49:41.466
cb1d30db-5712-4cf0-8483-f8a043445c00	0.00	69273148-40bb-41b6-bea6-2c0a012528ef	2026-07-16 05:58:26.415	2026-07-16 05:58:26.415
7bbae033-8471-4208-8438-ff4e67686453	0.00	fa07b0b3-9d12-49f7-95ce-68db809ea86e	2026-07-17 22:30:37.477	2026-07-17 22:32:04.544
021c01e5-7b04-4f90-ad4f-776081e1bcae	34.75	bac87303-3c5f-4c06-aa9d-c2013ceeef53	2026-03-31 12:08:49.914	2026-07-22 03:01:09.634
04c1bbc5-2649-4bad-9477-16573dd6d795	0.00	6a84b80a-11f1-47a3-bb87-5e6e9097930d	2026-07-18 02:38:53.145	2026-07-18 02:41:21.534
c81c2e98-98bd-4489-a841-4d1bc4a8ad88	0.00	f7973d9c-5f40-4355-818b-27b87f63c686	2026-07-17 22:19:50.778	2026-07-18 17:58:04.178
09db833f-46c0-4fbe-a4d1-2b88e0d75c88	0.00	63e172c7-36e6-4c68-a980-fccc0bdece37	2026-07-22 03:00:13.086	2026-07-22 03:05:26.18
81371ef8-67a1-4269-ba95-8a70604e610a	0.00	a3c9346c-cf3d-4e7a-a154-bc66c067ffdd	2026-07-18 19:48:31.475	2026-07-18 19:48:31.475
a6e8ed2d-e944-4421-8cb0-fd04ed6950fd	0.00	d295a430-11b3-46fe-a706-1dab4a7771ac	2026-07-18 19:50:00.976	2026-07-18 19:50:00.976
5e72d5b6-980f-4171-b23e-e1e44f642bbc	0.00	25fb53a0-e8d3-40cf-97a0-1c629b8424a9	2026-07-18 20:05:39.275	2026-07-18 20:05:39.275
9de58b99-7a28-4dcd-a199-fc6ac5a9d532	0.00	417f8dec-d73d-4e55-a170-7fd05748b315	2026-07-18 20:09:10.143	2026-07-18 20:09:10.143
61ccd33e-8db9-400d-b5c9-d6f5bbac31d4	0.00	52ba6f5c-999b-4f9d-892a-6946c2e7fe85	2026-07-18 20:21:15.608	2026-07-18 20:21:15.608
0df302d6-5538-4965-bd18-1bca98a0a369	0.00	dfadeb82-59f5-4f2d-824d-a435e40d7484	2026-07-19 02:11:30.461	2026-07-19 02:11:42.872
64320730-2779-49ae-92e7-e6314f8a33bc	0.00	ef1d27b4-7719-4bd7-89c3-c5b0f128bfee	2026-07-20 22:49:30.756	2026-07-20 22:49:39.67
2f5ece13-f215-45a3-b425-1fd0c799b2cf	0.00	3ad0785e-adca-4cbb-bfa3-c91ec50cf8bf	2026-07-21 01:21:21.112	2026-07-21 01:21:21.112
e9b512f1-642f-4a74-8d04-e049e0c17181	0.00	26f4ea3d-ad31-4cdb-bea7-87388d707507	2026-07-21 02:01:42.328	2026-07-21 02:01:42.328
c43a4434-3d42-4353-a88d-7e70bd2173d8	0.00	a8a1d046-f4c5-431c-939a-f68bfe2cf274	2026-07-21 02:03:11.539	2026-07-21 02:03:11.539
603c0536-0091-4695-bd21-97996992ae3a	0.00	1b001974-feef-4faf-8237-45118c83847f	2026-07-21 02:04:14.734	2026-07-21 02:04:14.734
94e492e4-cd32-4208-82ff-43012f035d4c	0.00	9c6ea184-db3d-471f-b8bf-a55877ee1ca7	2026-07-21 04:36:41.964	2026-07-21 04:38:10.246
87356618-dae9-4161-b1e5-a4a3e8276db5	0.00	8eefeb9e-8d9e-4278-b904-778e5727cfb9	2026-07-21 05:05:21.762	2026-07-21 05:06:30.19
7d5c84c4-68c9-4a4c-87af-c3479991ec46	0.00	3a144e76-42a6-4a5f-b1e6-bac39df8c8a0	2026-07-21 05:27:05.939	2026-07-21 05:28:54.171
1f777b18-665d-4762-97c5-bd6eeebbf76b	0.00	c1d487fe-ca5d-4d9f-9bf7-5b85c3b96121	2026-07-21 15:08:33.41	2026-07-21 15:08:44.997
9bd720ad-e2ff-456b-956c-2938c71d8c14	0.00	4ab63f64-58fa-437c-85fb-ade3dcc9dca6	2026-07-22 01:36:01.466	2026-07-22 01:48:02.868
\.


--
-- Data for Name: web_push_credentials; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.web_push_credentials (id, "userId", token, "userAgent", "lastSeenAt", "createdAt") FROM stdin;
26c76d1c-c38b-4a23-9c4a-d283160cd7e4	05c0a4ac-fe39-4689-90aa-c01f80b77da4	cG4RykojVGJESn4YckhBfM:APA91bEG7R-GkGw-UA-Xc4YRl3FGzEsw3cX3ZowyWRLCBQA7H0JxRIJDH5V7ydF8YviuIrkID029Q7hfeq9k3_GH7VsBOamhcglLivPG-8s3k1AfKL8o3ng	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-16 05:26:44.035	2026-07-16 05:26:44.035
e99ec0c3-7363-464b-87de-2537e08c523f	05c0a4ac-fe39-4689-90aa-c01f80b77da4	cG4RykojVGJESn4YckhBfM:APA91bEoxza1-TWWHK3zIXFABG5UWLHVMddlV3mEUZLRJ7icYyPHFmzjz1ajcqe6u_xPSghxSxZYNw_f2PmZgJAudykGc7unukNBltcOLyGYwd2nmBU5tfo	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-16 05:26:44.04	2026-07-16 05:26:44.04
6cdd4041-fb5f-424b-a095-2c06ee021c15	05c0a4ac-fe39-4689-90aa-c01f80b77da4	cG4RykojVGJESn4YckhBfM:APA91bFtxzm5w3wNigWH8k1YUBL8_v4oD_-KlP8I41Nuw30gBVvKQ6rODeVx9yOy-QM9UsyKCfQXNJZOvj-um2kv_x-fdDAGumViVHQUzdLTcREVFeGkXg8	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-16 05:27:30.677	2026-07-16 05:26:44.049
4db85680-8003-4565-b92f-35f27013f36a	69273148-40bb-41b6-bea6-2c0a012528ef	f5rZ7m6FQ0h2jGdqHgOe7V:APA91bE8gjYPwnxn0l-84oZ9c-V_NsE8gKSKaBBiCDANGuEmIxnRZ2I4JLmY3mL1jtOoRgWXgu0YHzPV0Hg3sr0WQmgoMq-7DDLJD5ox_XcwPLzAMaP7sMI	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-16 06:01:23.307	2026-07-16 05:59:32.365
e2055253-2f88-4147-b463-f872867e10b8	3c1870c9-d5d5-4c25-8c49-8a2d2fc6fcc9	fna64gc9BPRRGWqQMcdDTC:APA91bErFD1pnL4nlKiyKDeY9jucPJziu7uINcXvUy_TcPksDvrfcDMpMubOoRBfRSxIIAkNfUGTvyRRjF3RbCGbuDf2MT7z3mvB0BVf9HJohNtydrve9MQ	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-17 22:18:54.019	2026-07-15 23:18:19.247
856b41b3-c4dd-4958-b98c-82f64a1050e8	4a9df2ac-3b35-4baa-8725-e21c81398dd3	dMLvp_cE22dWdmZ0zAj0KM:APA91bFBGW0TAIcpofDqtRan-ePLkCRuZN9fbR1dHHRNDGNTC9xAxkUzUzvgvIGU9uUSns-S0hNIQJjT5_JUgLIc_rANhEm10btPSd_KE71mhwSUsQuyg_4	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-18 00:42:19.494	2026-07-16 00:49:26.98
bdd2e950-d8a8-4ec0-aa6b-d1e84145f7cd	6e276e63-0515-4855-95b6-f65ff85dbf24	csRtT2ASbsFLWe1AHbq86L:APA91bF_Ocs4P9dkq6Pxi8Xq3hVQITYCX2MQXsAPMYddrpvIfUh6rsH_QZoTm0bZF4q0ApRcT8as7uFT4avCKOOtPQiIxCO_frxBlRX2Afaw6jIunlF2Bhs	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-18 02:37:27.744	2026-07-16 05:43:29.886
b3f861d2-b8d0-4f0d-a6bf-75428d8830ea	705bcf07-fd33-4f4d-a2c3-9fb8d2ab97c7	emfcDg3jvs67681iSA83O6:APA91bHWu9-vjnqd7orFEGZKHwuuHuTZ6z83DV9HkU32INv88pkmJXorrPBEqi-szJagQdeNq1mri2FsbW9JIpvtKi3M7C4Pr9bz2pSku1vBJE0Iqkpvt4o	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-19 00:41:19.816	2026-07-19 00:41:19.816
efb407f8-c49d-4e49-9e8b-8441d1f4e8fb	1e726e4e-83df-4f9f-b369-0d4e9e9d3b81	eD6y6ZhJNDRLPx2Z9n3Tf8:APA91bFxwXv3ipnpe5eemp0u9HvTxyrv8JyNtB_XMNLydNhSAymA1NToBniuxEifoPw8DeHmmGyTzssXv0LwLFZHD-YPJ8yZ6Jg0jbmsE8FfCPMIj7vTNLw	Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Mobile Safari/537.36	2026-07-19 00:43:38.095	2026-07-18 00:58:06.444
d442a854-6ca2-4589-a3b4-5d31969cb5ee	f7973d9c-5f40-4355-818b-27b87f63c686	fSKXYbiScRdJy2FXLbe13z:APA91bFmDHUVO30Gb5UEFGFx1UztCrDQWxpCcBDR1R7eU7qg2V021gzLc0c_uWFcgWa96ihuCzvqXgjOwhJaghL7gpbSBZd0MxdxpFrLqU2Xvnfy-iet3lY	Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-21 07:04:58.756	2026-07-17 22:20:08.318
b662f695-baf1-468e-b5d8-456ff0b618cb	c1d487fe-ca5d-4d9f-9bf7-5b85c3b96121	cANfIPq-I1cQu9ngkj23Wd:APA91bE77obUoOLwZK9myQExQl-cVnmIb9oO3nfU0bqThSviOMzK7-BcQZesf3L0joZDlKulUP5nFn-PTstVIJe13WR4F6PWNowCfbSILCLUcp30t-gfelg	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-21 15:08:45	2026-07-21 15:08:45
aaede1bc-593b-4ecc-aa97-b9e77380368d	c1d487fe-ca5d-4d9f-9bf7-5b85c3b96121	cANfIPq-I1cQu9ngkj23Wd:APA91bEsQh8_eySAs5T9I0Hu3GUw7EzCPOSZ8IH4UqNONtlQFEBPQZD3lm3_DVs2mB6j-Ztu2e3XbPtzwgrNUtWqfwX2GzXw8iSQTV80W6n2LCQuCKpdHrM	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36	2026-07-21 15:08:45.209	2026-07-21 15:08:45.209
\.


--
-- Data for Name: withdrawal_requests; Type: TABLE DATA; Schema: public; Owner: pacha
--

COPY public.withdrawal_requests (id, "walletId", "bankAccountId", credits, soles, status, notes, "createdAt", "updatedAt", "receiptPublicId", "receiptUrl", "rejectionReason", "payoutCurrency") FROM stdin;
05f33bca-095a-4639-811d-28b150ef5ba1	36a1e380-00d2-4bd7-821b-95823c86efef	1	16.00	14.40	REJECTED	\N	2026-03-26 14:32:56.032	2026-04-02 00:21:29.203	\N	\N	monto invalido cobras mucho jhaseft, y manana no hay fuchi	PEN
137856f5-7926-4590-ac4f-a1b20c236cf7	36a1e380-00d2-4bd7-821b-95823c86efef	1	13.00	11.70	REJECTED	\N	2026-03-26 14:32:00.37	2026-04-02 00:28:44.647	\N	\N	monto invalido cobras mucho jhaseft, y manana no hay fuchi	PEN
404c3b96-69d0-4717-97cf-87d88fc96400	36a1e380-00d2-4bd7-821b-95823c86efef	1	50.00	45.00	PENDING	\N	2026-04-04 16:17:25.903	2026-04-04 16:17:25.903	\N	\N	\N	PEN
dc03eca2-e7a0-4570-b76a-0162a102adb8	36a1e380-00d2-4bd7-821b-95823c86efef	3	20.00	18.00	PENDING	\N	2026-04-04 16:18:08.957	2026-04-04 16:18:08.957	\N	\N	\N	PEN
9517a502-cb73-41e1-9897-80a1387b6235	36a1e380-00d2-4bd7-821b-95823c86efef	1	15.00	13.50	PENDING	\N	2026-04-04 16:18:37.255	2026-04-04 16:18:37.255	\N	\N	\N	PEN
e39dd2f4-d2f2-4e06-ad9d-f9cb8198b8f8	36a1e380-00d2-4bd7-821b-95823c86efef	3	12.00	10.80	PENDING	\N	2026-04-04 16:54:47.333	2026-04-04 16:54:47.333	\N	\N	\N	PEN
3224ecb4-d0b2-4067-830e-71a976edb01f	89c57cc7-01f7-4e3c-9bb2-f79e92418a66	5	60.00	60.00	PENDING	\N	2026-04-05 08:43:23.499	2026-04-05 08:43:23.499	\N	\N	\N	PEN
886bd2a2-ece0-4e3c-b276-4376772e8419	d402737b-e875-4b00-b970-97d45bdb7308	16	200.00	200.00	PENDING	\N	2026-07-13 22:43:10.388	2026-07-13 22:43:10.388	\N	\N	\N	PEN
70a5e00e-a9e3-47f5-b2d3-e90da27c102f	36a1e380-00d2-4bd7-821b-95823c86efef	1	10.00	9.00	APPROVED	\N	2026-03-26 14:31:29.252	2026-03-28 03:49:28.782	pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/70a5e00e-a9e3-47f5-b2d3-e90da27c102f/proof_1774669766374	https://res.cloudinary.com/dai7rtja6/image/upload/v1774669767/pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/70a5e00e-a9e3-47f5-b2d3-e90da27c102f/proof_1774669766374.jpg	\N	PEN
a9189a69-90b9-41d4-9484-71c3f79f450e	36a1e380-00d2-4bd7-821b-95823c86efef	1	15.00	13.50	REJECTED	\N	2026-03-26 14:32:28.402	2026-03-28 04:27:35.34	\N	\N	Monto no valido	PEN
b1147295-8a4b-462f-a31b-14a7c0183fb5	36a1e380-00d2-4bd7-821b-95823c86efef	1	14.00	12.60	APPROVED	\N	2026-03-26 14:32:19.16	2026-03-28 04:29:36.048	pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/b1147295-8a4b-462f-a31b-14a7c0183fb5/proof_1774672173415	https://res.cloudinary.com/dai7rtja6/image/upload/v1774672174/pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/b1147295-8a4b-462f-a31b-14a7c0183fb5/proof_1774672173415.jpg	\N	PEN
c66d5266-b3a2-4803-ad92-a2713d1f6ed1	36a1e380-00d2-4bd7-821b-95823c86efef	1	2.00	1.80	APPROVED	\N	2026-03-27 15:46:00.177	2026-03-28 14:37:04.651	pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/c66d5266-b3a2-4803-ad92-a2713d1f6ed1/proof_1774708622247	https://res.cloudinary.com/dai7rtja6/image/upload/v1774708623/pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/c66d5266-b3a2-4803-ad92-a2713d1f6ed1/proof_1774708622247.jpg	\N	PEN
fa7e88a7-795f-42ed-82cc-eb3b6c5acfab	36a1e380-00d2-4bd7-821b-95823c86efef	1	20.00	18.00	APPROVED	\N	2026-03-27 15:40:53.496	2026-03-28 15:14:06.652	pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/fa7e88a7-795f-42ed-82cc-eb3b6c5acfab/proof_1774710844153	https://res.cloudinary.com/dai7rtja6/image/upload/v1774710845/pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/fa7e88a7-795f-42ed-82cc-eb3b6c5acfab/proof_1774710844153.jpg	\N	PEN
4fed2bbe-7138-477b-8f73-848a8e65a0c5	36a1e380-00d2-4bd7-821b-95823c86efef	1	18.00	16.20	REJECTED	\N	2026-03-26 14:33:14.892	2026-03-28 15:14:37.869	\N	\N	re	PEN
e5c6f272-0e9b-473f-abde-34cccd5b13a7	36a1e380-00d2-4bd7-821b-95823c86efef	1	10.00	9.00	APPROVED	\N	2026-03-26 14:31:40.202	2026-03-28 23:22:20.428	pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/e5c6f272-0e9b-473f-abde-34cccd5b13a7/proof_1774740136012	https://res.cloudinary.com/dai7rtja6/image/upload/v1774740136/pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/e5c6f272-0e9b-473f-abde-34cccd5b13a7/proof_1774740136012.jpg	\N	PEN
e0d4af73-28d3-4a14-87fd-4e7bcb05fb0e	36a1e380-00d2-4bd7-821b-95823c86efef	1	17.00	15.30	REJECTED	\N	2026-03-26 14:33:06.136	2026-04-02 00:19:03.335	\N	\N	monto invalido	PEN
7c8ba41e-2e06-40ce-ae76-49a3248e6d30	36a1e380-00d2-4bd7-821b-95823c86efef	1	13.00	11.70	REJECTED	\N	2026-03-26 14:32:08.9	2026-04-02 00:25:12.219	\N	\N	monto invalido cobras mucho jhaseft, y manana no hay fuchi	PEN
57cd5429-b097-4952-9cce-eaec1c95bbfd	36a1e380-00d2-4bd7-821b-95823c86efef	1	12.00	10.80	REJECTED	\N	2026-03-26 14:31:51.481	2026-04-02 00:40:06.412	\N	\N	monto invalido cobras mucho jhaseft, y manana no hay fuchi	PEN
2cad3aae-14e9-409e-81d1-cb79dffde307	36a1e380-00d2-4bd7-821b-95823c86efef	1	10.00	9.00	REJECTED	\N	2026-03-26 14:31:19.526	2026-04-02 00:44:27.319	pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/2cad3aae-14e9-409e-81d1-cb79dffde307/proof_1774627499296	https://res.cloudinary.com/dai7rtja6/image/upload/v1774627500/pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/2cad3aae-14e9-409e-81d1-cb79dffde307/proof_1774627499296.jpg	monto invalido cobras mucho jhaseft, y manana no hay fuchi	PEN
1a292051-9852-4c29-9acb-7e3e982c0003	36a1e380-00d2-4bd7-821b-95823c86efef	1	50.00	45.00	REJECTED	\N	2026-03-26 14:30:30.627	2026-04-02 02:57:04.37	\N	\N	monto invalido cobras mucho jhaseft, y manana no hay fuchi	PEN
e8f56a5f-3ed6-45ed-a794-6b46324f4c33	36a1e380-00d2-4bd7-821b-95823c86efef	1	10.00	9.00	REJECTED	\N	2026-03-26 14:31:07.669	2026-04-04 15:57:00.426	\N	\N	Monto no válido 	PEN
87d33db0-8f5c-4172-8916-5952abd8f0b9	36a1e380-00d2-4bd7-821b-95823c86efef	1	50.00	45.00	APPROVED	\N	2026-03-26 14:10:10.23	2026-04-04 15:58:04.606	pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/87d33db0-8f5c-4172-8916-5952abd8f0b9/proof_1775318280800	https://res.cloudinary.com/dai7rtja6/image/upload/v1775318280/pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/87d33db0-8f5c-4172-8916-5952abd8f0b9/proof_1775318280800.jpg	\N	PEN
56e017af-d7b7-4a40-a0e6-28f4467fe9e2	36a1e380-00d2-4bd7-821b-95823c86efef	3	10.00	9.00	PENDING	\N	2026-04-04 16:17:49.003	2026-04-04 16:17:49.003	\N	\N	\N	PEN
8ed4e1b7-2ee3-4fd9-a4ad-fa8be9dbcc4f	36a1e380-00d2-4bd7-821b-95823c86efef	3	10.00	9.00	PENDING	\N	2026-04-04 16:18:22.715	2026-04-04 16:18:22.715	\N	\N	\N	PEN
1b3cfb60-94ac-4e1e-922d-0a954f4fe68c	36a1e380-00d2-4bd7-821b-95823c86efef	1	50.00	45.00	PENDING	\N	2026-04-04 16:54:13.713	2026-04-04 16:54:13.713	\N	\N	\N	PEN
c66e81db-502e-4883-8a82-7b392314f0b3	36a1e380-00d2-4bd7-821b-95823c86efef	1	25.00	22.50	REJECTED	\N	2026-04-04 16:56:33.732	2026-04-08 05:15:29.784	\N	\N	monto insuficiente	PEN
a810041c-8cad-4f7a-bc6b-19b27f713083	36a1e380-00d2-4bd7-821b-95823c86efef	1	20.00	18.00	APPROVED	\N	2026-04-04 16:56:15.526	2026-04-08 05:16:07.903	pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/a810041c-8cad-4f7a-bc6b-19b27f713083/proof_1775625366073	https://res.cloudinary.com/dai7rtja6/image/upload/v1775625366/pachamama/users/52c1851b-d920-4c8c-8c81-d23099affa0a/withdrawals/a810041c-8cad-4f7a-bc6b-19b27f713083/proof_1775625366073.jpg	\N	PEN
be26a4b4-e347-467b-bfb2-dea8e140b4a4	021c01e5-7b04-4f90-ad4f-776081e1bcae	7	39.00	39.00	PENDING	\N	2026-04-09 21:38:46.646	2026-04-09 21:38:46.646	\N	\N	\N	PEN
\.


--
-- Name: Banks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pacha
--

SELECT pg_catalog.setval('public."Banks_id_seq"', 2, true);


--
-- Name: bank_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: pacha
--

SELECT pg_catalog.setval('public.bank_accounts_id_seq', 18, true);


--
-- Name: Banks Banks_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public."Banks"
    ADD CONSTRAINT "Banks_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: anfitrione_images anfitrione_images_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.anfitrione_images
    ADD CONSTRAINT anfitrione_images_pkey PRIMARY KEY (id);


--
-- Name: anfitrione_profile_social_links anfitrione_profile_social_links_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.anfitrione_profile_social_links
    ADD CONSTRAINT anfitrione_profile_social_links_pkey PRIMARY KEY (id);


--
-- Name: anfitrione_profiles anfitrione_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.anfitrione_profiles
    ADD CONSTRAINT anfitrione_profiles_pkey PRIMARY KEY (id);


--
-- Name: anfitrione_subscriptions anfitrione_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.anfitrione_subscriptions
    ADD CONSTRAINT anfitrione_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: bank_accounts bank_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.bank_accounts
    ADD CONSTRAINT bank_accounts_pkey PRIMARY KEY (id);


--
-- Name: binance_deposit_intents binance_deposit_intents_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.binance_deposit_intents
    ADD CONSTRAINT binance_deposit_intents_pkey PRIMARY KEY (id);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: creator_referral_reward_events creator_referral_reward_events_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referral_reward_events
    ADD CONSTRAINT creator_referral_reward_events_pkey PRIMARY KEY (id);


--
-- Name: creator_referral_settings creator_referral_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referral_settings
    ADD CONSTRAINT creator_referral_settings_pkey PRIMARY KEY (id);


--
-- Name: creator_referrals creator_referrals_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referrals
    ADD CONSTRAINT creator_referrals_pkey PRIMARY KEY (id);


--
-- Name: deposit_requests deposit_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.deposit_requests
    ADD CONSTRAINT deposit_requests_pkey PRIMARY KEY (id);


--
-- Name: histories histories_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.histories
    ADD CONSTRAINT histories_pkey PRIMARY KEY (id);


--
-- Name: history_views history_views_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.history_views
    ADD CONSTRAINT history_views_pkey PRIMARY KEY (id);


--
-- Name: image_unlocks image_unlocks_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.image_unlocks
    ADD CONSTRAINT image_unlocks_pkey PRIMARY KEY (id);


--
-- Name: likes likes_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT likes_pkey PRIMARY KEY (id);


--
-- Name: message_image_unlocks message_image_unlocks_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.message_image_unlocks
    ADD CONSTRAINT message_image_unlocks_pkey PRIMARY KEY (id);


--
-- Name: message_unlocks message_unlocks_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.message_unlocks
    ADD CONSTRAINT message_unlocks_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: packages packages_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (id);


--
-- Name: payment_methods payment_methods_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT payment_methods_pkey PRIMARY KEY (id);


--
-- Name: saved_anfitrionas saved_anfitrionas_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.saved_anfitrionas
    ADD CONSTRAINT saved_anfitrionas_pkey PRIMARY KEY (id);


--
-- Name: service_prices service_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.service_prices
    ADD CONSTRAINT service_prices_pkey PRIMARY KEY (id);


--
-- Name: social_networks social_networks_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.social_networks
    ADD CONSTRAINT social_networks_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: user_profile user_profile_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT user_profile_pkey PRIMARY KEY (id);


--
-- Name: user_subscriptions user_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.user_subscriptions
    ADD CONSTRAINT user_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- Name: web_push_credentials web_push_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.web_push_credentials
    ADD CONSTRAINT web_push_credentials_pkey PRIMARY KEY (id);


--
-- Name: withdrawal_requests withdrawal_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.withdrawal_requests
    ADD CONSTRAINT withdrawal_requests_pkey PRIMARY KEY (id);


--
-- Name: anfitrione_profile_social_links_anfitrionaProfileId_socialN_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "anfitrione_profile_social_links_anfitrionaProfileId_socialN_key" ON public.anfitrione_profile_social_links USING btree ("anfitrionaProfileId", "socialNetworkId");


--
-- Name: anfitrione_profiles_cedula_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX anfitrione_profiles_cedula_key ON public.anfitrione_profiles USING btree (cedula);


--
-- Name: anfitrione_profiles_userId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "anfitrione_profiles_userId_key" ON public.anfitrione_profiles USING btree ("userId");


--
-- Name: anfitrione_profiles_username_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX anfitrione_profiles_username_key ON public.anfitrione_profiles USING btree (username);


--
-- Name: anfitrione_subscriptions_profileId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "anfitrione_subscriptions_profileId_key" ON public.anfitrione_subscriptions USING btree ("profileId");


--
-- Name: bank_accounts_bankId_idx; Type: INDEX; Schema: public; Owner: pacha
--

CREATE INDEX "bank_accounts_bankId_idx" ON public.bank_accounts USING btree ("bankId");


--
-- Name: bank_accounts_userId_idx; Type: INDEX; Schema: public; Owner: pacha
--

CREATE INDEX "bank_accounts_userId_idx" ON public.bank_accounts USING btree ("userId");


--
-- Name: binance_deposit_intents_status_expiresAt_idx; Type: INDEX; Schema: public; Owner: pacha
--

CREATE INDEX "binance_deposit_intents_status_expiresAt_idx" ON public.binance_deposit_intents USING btree (status, "expiresAt");


--
-- Name: binance_deposit_intents_txid_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX binance_deposit_intents_txid_key ON public.binance_deposit_intents USING btree (txid);


--
-- Name: binance_deposit_intents_userId_status_idx; Type: INDEX; Schema: public; Owner: pacha
--

CREATE INDEX "binance_deposit_intents_userId_status_idx" ON public.binance_deposit_intents USING btree ("userId", status);


--
-- Name: conversations_user1Id_user2Id_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "conversations_user1Id_user2Id_key" ON public.conversations USING btree ("user1Id", "user2Id");


--
-- Name: creator_referral_reward_events_referralId_idx; Type: INDEX; Schema: public; Owner: pacha
--

CREATE INDEX "creator_referral_reward_events_referralId_idx" ON public.creator_referral_reward_events USING btree ("referralId");


--
-- Name: creator_referral_reward_events_referredCreatorId_idx; Type: INDEX; Schema: public; Owner: pacha
--

CREATE INDEX "creator_referral_reward_events_referredCreatorId_idx" ON public.creator_referral_reward_events USING btree ("referredCreatorId");


--
-- Name: creator_referral_reward_events_referredUserId_idx; Type: INDEX; Schema: public; Owner: pacha
--

CREATE INDEX "creator_referral_reward_events_referredUserId_idx" ON public.creator_referral_reward_events USING btree ("referredUserId");


--
-- Name: creator_referral_reward_events_referrerCreatorId_idx; Type: INDEX; Schema: public; Owner: pacha
--

CREATE INDEX "creator_referral_reward_events_referrerCreatorId_idx" ON public.creator_referral_reward_events USING btree ("referrerCreatorId");


--
-- Name: creator_referral_reward_events_rewardTransactionId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "creator_referral_reward_events_rewardTransactionId_key" ON public.creator_referral_reward_events USING btree ("rewardTransactionId");


--
-- Name: creator_referral_reward_events_sourceTransactionId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "creator_referral_reward_events_sourceTransactionId_key" ON public.creator_referral_reward_events USING btree ("sourceTransactionId");


--
-- Name: creator_referral_settings_creatorId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "creator_referral_settings_creatorId_key" ON public.creator_referral_settings USING btree ("creatorId");


--
-- Name: creator_referrals_referredCreatorId_idx; Type: INDEX; Schema: public; Owner: pacha
--

CREATE INDEX "creator_referrals_referredCreatorId_idx" ON public.creator_referrals USING btree ("referredCreatorId");


--
-- Name: creator_referrals_referredCreatorId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "creator_referrals_referredCreatorId_key" ON public.creator_referrals USING btree ("referredCreatorId");


--
-- Name: creator_referrals_referredUserId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "creator_referrals_referredUserId_key" ON public.creator_referrals USING btree ("referredUserId");


--
-- Name: creator_referrals_referrerCreatorId_idx; Type: INDEX; Schema: public; Owner: pacha
--

CREATE INDEX "creator_referrals_referrerCreatorId_idx" ON public.creator_referrals USING btree ("referrerCreatorId");


--
-- Name: history_views_userId_historyId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "history_views_userId_historyId_key" ON public.history_views USING btree ("userId", "historyId");


--
-- Name: image_unlocks_imageId_userId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "image_unlocks_imageId_userId_key" ON public.image_unlocks USING btree ("imageId", "userId");


--
-- Name: image_unlocks_transactionId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "image_unlocks_transactionId_key" ON public.image_unlocks USING btree ("transactionId");


--
-- Name: likes_userId_anfitrionaId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "likes_userId_anfitrionaId_key" ON public.likes USING btree ("userId", "anfitrionaId");


--
-- Name: message_image_unlocks_messageId_userId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "message_image_unlocks_messageId_userId_key" ON public.message_image_unlocks USING btree ("messageId", "userId");


--
-- Name: message_image_unlocks_transactionId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "message_image_unlocks_transactionId_key" ON public.message_image_unlocks USING btree ("transactionId");


--
-- Name: message_unlocks_messageId_userId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "message_unlocks_messageId_userId_key" ON public.message_unlocks USING btree ("messageId", "userId");


--
-- Name: message_unlocks_transactionId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "message_unlocks_transactionId_key" ON public.message_unlocks USING btree ("transactionId");


--
-- Name: saved_anfitrionas_userId_anfitrionaId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "saved_anfitrionas_userId_anfitrionaId_key" ON public.saved_anfitrionas USING btree ("userId", "anfitrionaId");


--
-- Name: service_prices_profileId_serviceType_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "service_prices_profileId_serviceType_key" ON public.service_prices USING btree ("profileId", "serviceType");


--
-- Name: social_networks_name_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX social_networks_name_key ON public.social_networks USING btree (name);


--
-- Name: transactions_depositRequestId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "transactions_depositRequestId_key" ON public.transactions USING btree ("depositRequestId");


--
-- Name: user_profile_userId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "user_profile_userId_key" ON public.user_profile USING btree ("userId");


--
-- Name: user_subscriptions_userId_subscriptionId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "user_subscriptions_userId_subscriptionId_key" ON public.user_subscriptions USING btree ("userId", "subscriptionId");


--
-- Name: users_email_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX users_email_key ON public.users USING btree (email);


--
-- Name: users_phoneNumber_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "users_phoneNumber_key" ON public.users USING btree ("phoneNumber");


--
-- Name: users_referralCode_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "users_referralCode_key" ON public.users USING btree ("referralCode");


--
-- Name: wallets_userId_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX "wallets_userId_key" ON public.wallets USING btree ("userId");


--
-- Name: web_push_credentials_token_key; Type: INDEX; Schema: public; Owner: pacha
--

CREATE UNIQUE INDEX web_push_credentials_token_key ON public.web_push_credentials USING btree (token);


--
-- Name: web_push_credentials_userId_idx; Type: INDEX; Schema: public; Owner: pacha
--

CREATE INDEX "web_push_credentials_userId_idx" ON public.web_push_credentials USING btree ("userId");


--
-- Name: anfitrione_images anfitrione_images_profileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.anfitrione_images
    ADD CONSTRAINT "anfitrione_images_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES public.anfitrione_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: anfitrione_profile_social_links anfitrione_profile_social_links_anfitrionaProfileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.anfitrione_profile_social_links
    ADD CONSTRAINT "anfitrione_profile_social_links_anfitrionaProfileId_fkey" FOREIGN KEY ("anfitrionaProfileId") REFERENCES public.anfitrione_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: anfitrione_profile_social_links anfitrione_profile_social_links_socialNetworkId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.anfitrione_profile_social_links
    ADD CONSTRAINT "anfitrione_profile_social_links_socialNetworkId_fkey" FOREIGN KEY ("socialNetworkId") REFERENCES public.social_networks(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: anfitrione_profiles anfitrione_profiles_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.anfitrione_profiles
    ADD CONSTRAINT "anfitrione_profiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: anfitrione_subscriptions anfitrione_subscriptions_profileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.anfitrione_subscriptions
    ADD CONSTRAINT "anfitrione_subscriptions_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES public.anfitrione_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bank_accounts bank_accounts_anfitrionaProfileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.bank_accounts
    ADD CONSTRAINT "bank_accounts_anfitrionaProfileId_fkey" FOREIGN KEY ("anfitrionaProfileId") REFERENCES public.anfitrione_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: bank_accounts bank_accounts_bankId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.bank_accounts
    ADD CONSTRAINT "bank_accounts_bankId_fkey" FOREIGN KEY ("bankId") REFERENCES public."Banks"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: binance_deposit_intents binance_deposit_intents_packageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.binance_deposit_intents
    ADD CONSTRAINT "binance_deposit_intents_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES public.packages(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: binance_deposit_intents binance_deposit_intents_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.binance_deposit_intents
    ADD CONSTRAINT "binance_deposit_intents_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: conversations conversations_user1Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT "conversations_user1Id_fkey" FOREIGN KEY ("user1Id") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: conversations conversations_user2Id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT "conversations_user2Id_fkey" FOREIGN KEY ("user2Id") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creator_referral_reward_events creator_referral_reward_events_purchaseCreatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referral_reward_events
    ADD CONSTRAINT "creator_referral_reward_events_purchaseCreatorId_fkey" FOREIGN KEY ("purchaseCreatorId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: creator_referral_reward_events creator_referral_reward_events_referralId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referral_reward_events
    ADD CONSTRAINT "creator_referral_reward_events_referralId_fkey" FOREIGN KEY ("referralId") REFERENCES public.creator_referrals(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creator_referral_reward_events creator_referral_reward_events_referredCreatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referral_reward_events
    ADD CONSTRAINT "creator_referral_reward_events_referredCreatorId_fkey" FOREIGN KEY ("referredCreatorId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: creator_referral_reward_events creator_referral_reward_events_referredUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referral_reward_events
    ADD CONSTRAINT "creator_referral_reward_events_referredUserId_fkey" FOREIGN KEY ("referredUserId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creator_referral_reward_events creator_referral_reward_events_referrerCreatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referral_reward_events
    ADD CONSTRAINT "creator_referral_reward_events_referrerCreatorId_fkey" FOREIGN KEY ("referrerCreatorId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creator_referral_reward_events creator_referral_reward_events_rewardTransactionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referral_reward_events
    ADD CONSTRAINT "creator_referral_reward_events_rewardTransactionId_fkey" FOREIGN KEY ("rewardTransactionId") REFERENCES public.transactions(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: creator_referral_reward_events creator_referral_reward_events_sourceTransactionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referral_reward_events
    ADD CONSTRAINT "creator_referral_reward_events_sourceTransactionId_fkey" FOREIGN KEY ("sourceTransactionId") REFERENCES public.transactions(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: creator_referral_settings creator_referral_settings_creatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referral_settings
    ADD CONSTRAINT "creator_referral_settings_creatorId_fkey" FOREIGN KEY ("creatorId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creator_referrals creator_referrals_referredCreatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referrals
    ADD CONSTRAINT "creator_referrals_referredCreatorId_fkey" FOREIGN KEY ("referredCreatorId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creator_referrals creator_referrals_referredUserId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referrals
    ADD CONSTRAINT "creator_referrals_referredUserId_fkey" FOREIGN KEY ("referredUserId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: creator_referrals creator_referrals_referrerCreatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.creator_referrals
    ADD CONSTRAINT "creator_referrals_referrerCreatorId_fkey" FOREIGN KEY ("referrerCreatorId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: deposit_requests deposit_requests_packageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.deposit_requests
    ADD CONSTRAINT "deposit_requests_packageId_fkey" FOREIGN KEY ("packageId") REFERENCES public.packages(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: deposit_requests deposit_requests_paymentMethodId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.deposit_requests
    ADD CONSTRAINT "deposit_requests_paymentMethodId_fkey" FOREIGN KEY ("paymentMethodId") REFERENCES public.payment_methods(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: deposit_requests deposit_requests_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.deposit_requests
    ADD CONSTRAINT "deposit_requests_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: histories histories_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.histories
    ADD CONSTRAINT "histories_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: history_views history_views_historyId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.history_views
    ADD CONSTRAINT "history_views_historyId_fkey" FOREIGN KEY ("historyId") REFERENCES public.histories(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: history_views history_views_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.history_views
    ADD CONSTRAINT "history_views_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: image_unlocks image_unlocks_imageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.image_unlocks
    ADD CONSTRAINT "image_unlocks_imageId_fkey" FOREIGN KEY ("imageId") REFERENCES public.anfitrione_images(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: image_unlocks image_unlocks_transactionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.image_unlocks
    ADD CONSTRAINT "image_unlocks_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES public.transactions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: image_unlocks image_unlocks_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.image_unlocks
    ADD CONSTRAINT "image_unlocks_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: likes likes_anfitrionaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT "likes_anfitrionaId_fkey" FOREIGN KEY ("anfitrionaId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: likes likes_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.likes
    ADD CONSTRAINT "likes_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: message_image_unlocks message_image_unlocks_messageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.message_image_unlocks
    ADD CONSTRAINT "message_image_unlocks_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES public.messages(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: message_image_unlocks message_image_unlocks_transactionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.message_image_unlocks
    ADD CONSTRAINT "message_image_unlocks_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES public.transactions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: message_image_unlocks message_image_unlocks_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.message_image_unlocks
    ADD CONSTRAINT "message_image_unlocks_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: message_unlocks message_unlocks_messageId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.message_unlocks
    ADD CONSTRAINT "message_unlocks_messageId_fkey" FOREIGN KEY ("messageId") REFERENCES public.messages(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: message_unlocks message_unlocks_transactionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.message_unlocks
    ADD CONSTRAINT "message_unlocks_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES public.transactions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: message_unlocks message_unlocks_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.message_unlocks
    ADD CONSTRAINT "message_unlocks_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: messages messages_conversationId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT "messages_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES public.conversations(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: messages messages_senderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT "messages_senderId_fkey" FOREIGN KEY ("senderId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: saved_anfitrionas saved_anfitrionas_anfitrionaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.saved_anfitrionas
    ADD CONSTRAINT "saved_anfitrionas_anfitrionaId_fkey" FOREIGN KEY ("anfitrionaId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: saved_anfitrionas saved_anfitrionas_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.saved_anfitrionas
    ADD CONSTRAINT "saved_anfitrionas_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: service_prices service_prices_profileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.service_prices
    ADD CONSTRAINT "service_prices_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES public.anfitrione_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transactions transactions_depositRequestId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT "transactions_depositRequestId_fkey" FOREIGN KEY ("depositRequestId") REFERENCES public.deposit_requests(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: transactions transactions_walletId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT "transactions_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES public.wallets(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_profile user_profile_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.user_profile
    ADD CONSTRAINT "user_profile_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_subscriptions user_subscriptions_subscriptionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.user_subscriptions
    ADD CONSTRAINT "user_subscriptions_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES public.anfitrione_subscriptions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_subscriptions user_subscriptions_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.user_subscriptions
    ADD CONSTRAINT "user_subscriptions_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wallets wallets_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT "wallets_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: web_push_credentials web_push_credentials_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.web_push_credentials
    ADD CONSTRAINT "web_push_credentials_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.users(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: withdrawal_requests withdrawal_requests_bankAccountId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.withdrawal_requests
    ADD CONSTRAINT "withdrawal_requests_bankAccountId_fkey" FOREIGN KEY ("bankAccountId") REFERENCES public.bank_accounts(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: withdrawal_requests withdrawal_requests_walletId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: pacha
--

ALTER TABLE ONLY public.withdrawal_requests
    ADD CONSTRAINT "withdrawal_requests_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES public.wallets(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

\unrestrict 4F67rIa9bfaeWjAxPTWUdFX3nzveksfwaHj3XDhUjrEgLpkxqeIxW1sbFtuoSkr

