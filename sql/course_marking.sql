--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Postgres.app)
-- Dumped by pg_dump version 16.2 (Postgres.app)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: cakeal
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    course_id integer NOT NULL,
    user_id integer NOT NULL,
    comment character varying(233),
    up_votes integer DEFAULT 0,
    down_votes integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    username character varying(20)
);


ALTER TABLE public.comments OWNER TO cakeal;

--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: cakeal
--

CREATE SEQUENCE public.comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comments_id_seq OWNER TO cakeal;

--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cakeal
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- Name: course_info; Type: TABLE; Schema: public; Owner: cakeal
--

CREATE TABLE public.course_info (
    id integer NOT NULL,
    course_code character varying(10) NOT NULL,
    course_name character varying(50) NOT NULL,
    teacher character varying(10),
    credits integer,
    course_type character varying(20),
    marking double precision,
    is_attendance character varying(50),
    homework character varying(100),
    exam character varying(100)
);


ALTER TABLE public.course_info OWNER TO cakeal;

--
-- Name: course_information_id_seq; Type: SEQUENCE; Schema: public; Owner: cakeal
--

CREATE SEQUENCE public.course_information_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.course_information_id_seq OWNER TO cakeal;

--
-- Name: course_information_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cakeal
--

ALTER SEQUENCE public.course_information_id_seq OWNED BY public.course_info.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: cakeal
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(20) NOT NULL,
    student_id character varying(15) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    password character varying(32)
);


ALTER TABLE public.users OWNER TO cakeal;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: cakeal
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO cakeal;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cakeal
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: cakeal
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- Name: course_info id; Type: DEFAULT; Schema: public; Owner: cakeal
--

ALTER TABLE ONLY public.course_info ALTER COLUMN id SET DEFAULT nextval('public.course_information_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: cakeal
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: cakeal
--

COPY public.comments (id, course_id, user_id, comment, up_votes, down_votes, created_at, username) FROM stdin;
12	39	1	不打算听课的慎选，慎选！\r	0	0	2024-03-17 04:01:56.106197	test_user
10	35	1	第一节课老师会说具体要在哪几周点到，易过\r	0	0	2024-03-17 04:01:56.106197	test_user
16	50	1	每道题目论述较多，老师很好，上课生动有趣\r	0	0	2024-03-17 04:01:56.106197	test_user
8	21	1	答辩完整，点名都在，容易拿高分\r	0	0	2024-03-17 04:01:56.106197	test_user
13	42	1	老师很风趣，上课很幽默\r	0	0	2024-03-17 04:01:56.106197	test_user
11	36	1	两次大作业和课上作业手写考试允许带作业不允许带打印的资料\r	0	0	2024-03-17 04:01:56.106197	test_user
9	34	1	考试不难，会告知是哪两周点名，但是对作业要求很高，作业占比很大，给分不高\r	0	0	2024-03-17 04:01:56.106197	test_user
15	45	1	一定要听课学会如何打\r	0	0	2024-03-17 04:01:56.106197	test_user
23	151	1	给分很高	0	0	2024-03-17 04:02:56.106	test_user
22	116	1	有趣，好过，给分高\r	0	0	2024-03-17 04:01:56.106197	test_user
21	108	1	给分高，推荐，经常提前下课\r	0	0	2024-03-17 04:01:56.106197	test_user
20	75	1	整体课堂轻松，推荐英语好或要刷英语公选分的同学去，老师人很好\r	0	0	2024-03-17 04:01:56.106197	test_user
19	71	1	老师人很好，可以纠正口语\r	0	0	2024-03-17 04:01:56.106197	test_user
17	52	1	老师好说话，易得高分。点名不去容易扣分\r	0	0	2024-03-17 04:01:56.106197	test_user
18	69	1	纯英课堂，上课很有趣，给分也挺好， 但是不建议英语稍差的去\r	0	0	2024-03-17 04:01:56.106197	test_user
14	44	1	考试共8道大题，感觉偏难\r	0	0	2024-03-17 04:01:56.106197	test_user
4	5	1	易过\r	0	0	2024-03-17 04:01:56.106197	test_user
2	1	1	老师相对来说比较严格，也比较认真，期末开卷考试，分数尚可\r	0	0	2024-03-17 04:01:56.106197	test_user
5	12	1	上课轻松，极易得高分\r	0	0	2024-03-17 04:01:56.106197	test_user
6	16	1	给分挺高\r	0	0	2024-03-17 04:01:56.106197	test_user
7	20	1	给分较高\r	0	0	2024-03-17 04:01:56.106197	test_user
3	3	1	老师上课特别幽默，课堂氛围还是不错的，分数也还可以，开卷闭卷由学生定可带手机\r	0	0	2024-03-17 04:01:56.106197	test_user
1	3	1	非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我的课表旋转. 非常好课程，使我	25	6	2024-03-17 04:01:56.106197	test_user
\.


--
-- Data for Name: course_info; Type: TABLE DATA; Schema: public; Owner: cakeal
--

COPY public.course_info (id, course_code, course_name, teacher, credits, course_type, marking, is_attendance, homework, exam) FROM stdin;
1	1019003	深海矿产资源开发与利用	冯雅丽	2	科学素养	\N	基本每节课都有小测以次点名	小组自制PPT答辩	平时成绩＋大作业成绩＋期末考试（开卷）\r
3	1019030	安全工程与科学导论	刘建	2	科学素养	\N	每节课至少两次	无	平时成绩＋期末考试\r
4	1029005	世界科技文明史	潜伟	2	人文素养	\N	点	无	开卷考试或者论文\r
5	1029007	工业生态学—工业文明向生态文明的转化	李素琴	1	科学素养	\N	否	论文	开卷考试\r
6	1029011	中国科学技术史	\N	2	科学素养	\N	\N	\N	\r
7	1029013	普通生态学	\N	2	科学素养	\N	\N	\N	\r
8	1029015	文化遗产概论	\N	2	人文素养	\N	\N	\N	\r
9	1029018	中国冶金史	\N	1	人文素养	\N	\N	\N	\r
10	1029025	中国古代壁画艺术	\N	2	科学素养	\N	\N	\N	\r
11	1039028	中国陶瓷赏析	\N	1	科学素养	\N	\N	\N	\r
12	1039033	电子信息材料	常永勤	2	科学素养	\N	是(不定期签到，次数较少)	无	论文\r
13	1039034	实验方案设计与数据处理	\N	1	创新创业课程	\N	\N	\N	\r
14	1039035	玉和中国文化	\N	2	人文素养	\N	\N	\N	\r
15	1039039	汽车材料与零部件加工技术	\N	1	科学素养	\N	\N	\N	\r
16	1039046	材料成形与控制	刘雪锋	2	科学素养	\N	偶尔点	无	论文\r
17	1039047	世界军事概论	\N	2	人文素养	\N	\N	\N	\r
18	1039048	材料基因组工程	\N	1	科学素养	\N	\N	\N	\r
19	1039051	科研方法实践导论	\N	1	创新创业课程	\N	\N	\N	\r
20	1039052	材料加工概论	石章智	2	科学素养	\N	签到或点名	无	开卷考\r
21	1039055	钢铁生产概论	蒋波	1	科学素养	\N	点名	PPT答辩，或者交一份报告	不考试\r
22	1039056	新能源材料导论	\N	1	科学素养	\N	\N	\N	\r
23	1039058	材料成形与控制概论	\N	1	科学素养	\N	\N	\N	\r
24	1039059	柔性材料与器件发展概论	\N	1	科学素养	\N	\N	\N	\r
25	1039060	材料成形工艺导论	\N	1	科学素养	\N	\N	\N	\r
26	1039066	神奇的金属材料	\N	2	科学素养	\N	\N	\N	\r
27	1039068	材料加工智能化数值模拟	\N	1	科学素养	\N	\N	\N	\r
28	1039076	新型功能材料与结构	\N	2	科学素养	\N	\N	\N	\r
29	1039077	储能电池前沿创新研究与应用	\N	2	科学素养	\N	\N	\N	\r
30	1039078	多孔材料制备与应用前沿	\N	1	科学素养	\N	\N	\N	\r
31	1039079	功能薄膜材料及应用	\N	1	科学素养	\N	\N	\N	\r
32	1039084	计算材料学导论	\N	1	科学素养	\N	\N	\N	\r
33	1039085	结构陶瓷	\N	1	科学素养	\N	\N	\N	\r
34	1049027	设计摄影	魏东	2	人文素养	\N	2次点名	4-5张自己拍摄的照片	开卷考试\r
35	1049042	机器人创意设计与实践	刘涛	1	创新创业课程	\N	是	无	论文\r
36	1049049	工程材料的力学行为	0	2	科学素养	\N	否	有	半开卷\r
37	1049072	增材制造技术原理及应用	\N	2	科学素养	\N	\N	\N	\r
38	1049074	飞行汽车	\N	1	科学素养	\N	\N	\N	\r
39	1069014	组合与计数	丁军	2	科学素养	\N	否	无	开卷考试\r
40	1069017	大学物理演示实验1	\N	1	科学素养	\N	\N	\N	\r
41	1069050	基因工程导论	\N	2	科学素养	\N	\N	\N	\r
42	1069052	自然科学史	季燕江	2	科学素养	\N	无	无	闭卷考试\r
43	1069057	生物入侵	\N	2	人文素养	\N	\N	\N	\r
44	1069058	工科数学分析选讲	李为东	2	科学素养	\N	否	基本没有	平时成绩＋期末考试\r
45	1069065	桥牌	李为东	2	人文素养	\N	是（以比赛方式）	一周一次比赛	比赛排名计成绩\r
46	1079048	财务思维	\N	2	人文素养	\N	\N	\N	\r
47	1079052	电子商务（双语）	\N	2	人文素养	\N	\N	\N	\r
48	1079053	应用Stata做统计分析	\N	2	科学素养	\N	\N	\N	\r
49	1089059	服饰与中国文化	\N	2	人文素养	\N	\N	\N	\r
50	1089064	中国古典小说鉴赏	张梅	2	人文素养	\N	是（点名未到扣分很严重）无	无	闭卷考试（有原题）\r
51	1089077	人与社会——社会学入门	\N	2	人文素养	\N	\N	\N	\r
52	1089099	知识产权案与法	徐家力	2	创新创业课程	\N	是(点名，较为频繁)	一次小组作业，课堂展示	无\r
53	1089103	中西方歌剧赏析	\N	2	人文素养	\N	\N	\N	\r
54	1089108	创新与专利	\N	1	创新创业课程	\N	\N	\N	\r
55	1089109	人际沟通的艺术	\N	2	人文素养	\N	\N	\N	\r
56	1089119	基本乐理	\N	2	人文素养	\N	\N	\N	\r
57	1089120	交响音乐欣赏	\N	2	人文素养	\N	\N	\N	\r
58	1089122	校园歌曲创作与实践	\N	2	人文素养	\N	\N	\N	\r
59	1089123	中国古代绘画艺术鉴赏	\N	2	美育	\N	\N	\N	\r
60	1089126	大学语文	\N	2	人文素养	\N	\N	\N	\r
61	1089129	四大名著鉴赏	\N	2	人文素养	\N	\N	\N	\r
62	1089131	中国文学史	\N	2	人文素养	\N	\N	\N	\r
63	1089135	古琴艺术十三讲	\N	2	美育	\N	\N	\N	\r
64	1089138	可视化人文	\N	2	人文素养	\N	\N	\N	\r
65	1089140	科学创造方法论	\N	2	人文素养	\N	\N	\N	\r
66	1089141	歌曲欣赏	\N	2	人文素养	\N	\N	\N	\r
67	1089145	东方舞蹈剧赏析	\N	2	美育	\N	\N	\N	\r
68	1089151	社会生活与现代伦理	\N	2	人文素养	\N	\N	\N	\r
69	1099021	英语议会制辩论	张丹丹	2	外语	\N	无	每次有作业（辩论稿）	课堂辩论\r
70	1099025	大学英语6级听力词汇	\N	2	外语	\N	\N	\N	\r
71	1099080	英语语音与实践	满海霞	2	外语	\N	是(每节课点名) 	口语练习	口语\r
72	1099091	英语（美语）语音语调	\N	2	外语	\N	\N	\N	\r
73	1099093	美国类型电影与文化	\N	2	外语	\N	\N	\N	\r
74	1099096	英文演讲入门	\N	2	外语	\N	\N	\N	\r
154	M159003	百年风流人物：曾国藩	\N	1	人文素养	\N	\N	\N	\r
75	1099110	英语语音与公共演讲	魏志萍	2	外语	\N	点名	有日常作业，两到三次小演讲	期中考试是单人3分钟双人5分钟英语电影电视剧配音，期末是3分钟脱稿演讲\r
76	1099117	影视作品中的生死学	\N	2	外语	\N	\N	\N	\r
77	1099118	美国文学简史	\N	2	外语	\N	\N	\N	\r
78	1099122	日本文学名著赏析	\N	2	外语	\N	\N	\N	\r
79	1099128	公共法语I	\N	2	外语	\N	\N	\N	\r
80	1099131	时代中国	\N	1	外语	\N	\N	\N	\r
81	1099132	与名人有约：查尔斯·狄更斯	\N	2	外语	\N	\N	\N	\r
82	1099150	中华典籍欣赏与翻译	\N	2	外语	\N	\N	\N	\r
83	1099153	日语入门	\N	2	外语	\N	\N	\N	\r
84	1099160	日本名著与电影美学	\N	2	外语	\N	\N	\N	\r
85	1099163	日本推理小说选读	\N	2	外语	\N	\N	\N	\r
86	1099166	英译汉翻译基础	\N	2	外语	\N	\N	\N	\r
87	1099169	日本企业文化	\N	2	外语	\N	\N	\N	\r
88	1099170	语料库翻译学入门	\N	2	外语	\N	\N	\N	\r
89	1119008	体育锻炼与竞赛（定向越野与健身素养）	\N	2	人文素养	\N	\N	\N	\r
90	1119009	体育锻炼与竞赛（毽球与跳绳）	\N	2	人文素养	\N	\N	\N	\r
91	1119010	体育锻炼与竞赛（田径投掷项目）	\N	2	人文素养	\N	\N	\N	\r
92	1119011	体育锻炼与竞赛（女子篮球）	\N	2	人文素养	\N	\N	\N	\r
93	1119012	体育锻炼与竞赛（男子排球）	\N	2	人文素养	\N	\N	\N	\r
94	1119013	体育锻炼与竞赛（空竹与健身气功）	\N	2	人文素养	\N	\N	\N	\r
95	1119015	体育锻炼与竞赛（排舞）	\N	2	人文素养	\N	\N	\N	\r
96	1119016	体育锻炼与竞赛（柔道）	\N	2	人文素养	\N	\N	\N	\r
97	1119017	体育锻炼与竞赛（高尔夫）	\N	2	人文素养	\N	\N	\N	\r
98	1119018	体育锻炼与竞赛（男子田径）	\N	2	人文素养	\N	\N	\N	\r
99	1119019	体育锻炼与竞赛（女子田径）	\N	2	人文素养	\N	\N	\N	\r
100	1119020	体育锻炼与竞赛（女子排球）	\N	2	人文素养	\N	\N	\N	\r
101	1119021	体育锻炼与竞赛（男子篮球）	\N	2	人文素养	\N	\N	\N	\r
102	1119022	体育锻炼与竞赛（乒乓球）	\N	2	人文素养	\N	\N	\N	\r
103	1119023	体育锻炼与竞赛（羽毛球）	\N	2	人文素养	\N	\N	\N	\r
104	1119024	体育锻炼与竞赛（网球）	\N	2	人文素养	\N	\N	\N	\r
105	1119025	体育锻炼与竞赛（足球）	\N	2	人文素养	\N	\N	\N	\r
106	1129001	新时代国家安全概述	\N	1	人文素养	\N	\N	\N	\r
107	1159003	科技文献检索与计算机应用	\N	2	科学素养	\N	\N	\N	\r
108	1159004	大学生医学卫生保健基础	李素君	2	人文素养	\N	2次点名	无	闭卷（和开卷没区别），给100题题库\r
109	1159062	合唱艺术与实践	\N	2	人文素养	\N	\N	\N	\r
110	1159066	化学魔术	\N	1	科学素养	\N	\N	\N	\r
111	1159067	大学生创新创业指导：从创意走向创业	\N	1	创新创业课程	\N	\N	\N	\r
112	1159068	材料综合分析方法	\N	2	科学素养	\N	\N	\N	\r
113	1159069	跟党学创业	\N	1	创新创业课程	\N	\N	\N	\r
114	1189002	工程材料优选	\N	1	科学素养	\N	\N	\N	\r
115	1189009	大国钢铁	\N	2	人文素养	\N	\N	\N	\r
116	1229006	回到未来：基因组时代的生命科学	宋青	2	科学素养	\N	否	无	论文\r
117	1229012	食品安全监测技术	\N	2	科学素养	\N	\N	\N	\r
118	1229019	医学-生物学绽放的美丽	\N	2	科学素养	\N	\N	\N	\r
119	1229020	药用高分子材料	\N	2	科学素养	\N	\N	\N	\r
120	1229023	多孔材料化学导论	\N	2	科学素养	\N	\N	\N	\r
121	1249010	大数据与数据科学基础	\N	2	科学素养	\N	\N	\N	\r
122	1259006	科技与社会	\N	1	人文素养	\N	\N	\N	\r
123	1259014	社会创新案例分析	\N	2	创新创业课程	\N	\N	\N	\r
124	1259018	网络安全与国家战略	\N	1	人文素养	\N	\N	\N	\r
125	1279002	建筑环境与中国居家理念	\N	1	科学素养	\N	\N	\N	\r
126	1279004	生物电信号与安全人行为	\N	1	科学素养	\N	\N	\N	\r
127	1279006	创新思维与创新方法概论	\N	2	科学素养	\N	\N	\N	\r
128	1289001	日常礼仪与商务礼仪	\N	2	人文素养	\N	\N	\N	\r
129	1289002	国乐赏析	\N	2	美育	\N	\N	\N	\r
130	1289003	诸子百家思想释读	\N	2	人文素养	\N	\N	\N	\r
131	1289005	现代舞形体训练	\N	2	人文素养	\N	\N	\N	\r
132	1289006	民乐合奏艺术实践	\N	2	美育	\N	\N	\N	\r
133	1289008	电影赏析	\N	2	美育	\N	\N	\N	\r
134	1289012	中外知识产权史	\N	1	人文素养	\N	\N	\N	\r
135	1289013	中国古代青铜器	\N	2	人文素养	\N	\N	\N	\r
136	1289014	经典音乐剧鉴赏	\N	2	人文素养	\N	\N	\N	\r
137	1289016	扬琴演奏与赏析	\N	2	美育	\N	\N	\N	\r
138	1289018	笛子演奏与赏析	\N	2	美育	\N	\N	\N	\r
139	1289019	打击乐演奏与赏析	\N	2	美育	\N	\N	\N	\r
140	1289020	唢呐演奏与赏析	\N	2	美育	\N	\N	\N	\r
141	1289021	二胡演奏与赏析	\N	2	美育	\N	\N	\N	\r
142	1289022	笙演奏与赏析	\N	2	美育	\N	\N	\N	\r
143	1289023	琵琶演奏与赏析	\N	2	美育	\N	\N	\N	\r
144	1289024	中阮演奏与赏析	\N	2	美育	\N	\N	\N	\r
145	1289026	现代舞赏析	\N	2	美育	\N	\N	\N	\r
146	1289028	西方美术史	\N	2	美育	\N	\N	\N	\r
147	1289029	中国工艺美学史	\N	2	美育	\N	\N	\N	\r
148	1289030	中国美术史	\N	2	美育	\N	\N	\N	\r
149	1289031	中国画鉴赏	\N	2	美育	\N	\N	\N	\r
150	1289035	世界民族音乐与文化	\N	2	人文素养	\N	\N	\N	\r
151	M089008	艺术与审美	王立群 	3	人文素养	\N	\N	无	要刷慕课和考试（小组展示）\r
152	M159001	中国历史人文地理（下）	\N	1	人文素养	\N	课表2节课只要上一个半小时，每节课签到无	\N	\r
153	M159002	中国历史人文地理（上）	\N	1	人文素养	\N	\N	\N	\r
155	M159004	欧洲文明概论	\N	2	人文素养	\N	\N	\N	\r
156	M159005	考古与人类	\N	2	人文素养	\N	\N	\N	\r
157	M159006	中国近代人物研究	\N	1	人文素养	\N	\N	\N	\r
158	M159007	西方文化名著导读	\N	1	人文素养	\N	\N	\N	\r
159	M159008	带您走进西藏	\N	2	人文素养	\N	\N	\N	\r
160	M159010	逻辑学导论	\N	2	人文素养	\N	\N	\N	\r
161	M159011	伦理学概论	\N	2	人文素养	\N	\N	\N	\r
162	M159012	美的历程：美学导论	\N	1	人文素养	\N	\N	\N	\r
163	M159013	幸福心理学	\N	1	人文素养	\N	\N	\N	\r
164	M159014	中华诗词之美（新版）	\N	2	人文素养	\N	\N	\N	\r
165	M159015	艺术鉴赏	\N	1	人文素养	\N	\N	\N	\r
166	M159016	中国现代文学名家名作	\N	2	人文素养	\N	\N	\N	\r
167	M159017	美术概论	\N	2	人文素养	\N	\N	\N	\r
168	M159018	园林艺术概论	\N	2	人文素养	\N	\N	\N	\r
169	M159019	中国古建筑欣赏与设计	\N	2	人文素养	\N	\N	\N	\r
170	M159020	漫画艺术欣赏与创作	\N	1	人文素养	\N	\N	\N	\r
171	M159021	书法鉴赏	\N	3	人文素养	\N	\N	\N	\r
172	M159022	舌尖上的植物学	\N	2	人文素养	\N	\N	\N	\r
173	M159023	科幻中的物理学	\N	1	人文素养	\N	\N	\N	\r
174	M159024	奇异的仿生学	\N	1	人文素养	\N	\N	\N	\r
175	M159026	生命科学与伦理	\N	1	人文素养	\N	\N	\N	\r
176	M159028	星海求知：天文学的奥秘	\N	2	人文素养	\N	\N	\N	\r
177	M159029	魅力科学	\N	1	人文素养	\N	\N	\N	\r
178	M159031	微生物与人类健康	\N	1	人文素养	\N	\N	\N	\r
179	M159033	创新、发明与专利实务	\N	2	人文素养	\N	\N	\N	\r
180	M159034	《论语》导论	\N	2	人文素养	\N	\N	\N	\r
181	M159035	走进《黄帝内经》	\N	1	人文素养	\N	\N	\N	\r
182	M159036	中国茶道	\N	1	人文素养	\N	\N	\N	\r
183	M159037	易学与中国传统文化	\N	1	人文素养	\N	\N	\N	\r
184	M159038	情绪管理	\N	1	人文素养	\N	\N	\N	\r
185	M159039	生命安全与救援	\N	1	人文素养	\N	\N	\N	\r
186	M159040	人力资源招聘与选拔	\N	3	人文素养	\N	\N	\N	\r
187	M159042	创业人生	\N	1	创新创业课程	\N	\N	\N	\r
188	M159043	创新思维训练《学生版》	\N	1	创新创业课程	\N	\N	\N	\r
189	M159044	大学生创业基础	\N	2	创新创业课程	\N	\N	\N	\r
190	M159045	创业创新执行力	\N	1	创新创业课程	\N	\N	\N	\r
191	M159046	创业创新领导力	\N	2	人文素养	\N	\N	\N	\r
192	M159047	大学启示录：如何读大学	\N	1	人文素养	\N	\N	\N	\r
193	M159048	《大学国文》	\N	3	人文素养	\N	\N	\N	\r
194	M159049	商业计划书制作与演示	\N	1	创新创业课程	\N	\N	\N	\r
195	M159050	创新创业	\N	2	创新创业课程	\N	\N	\N	\r
196	M159051	创业管理实战	\N	1	创新创业课程	\N	\N	\N	\r
197	M159052	大学生创业导论	\N	2	创新创业课程	\N	\N	\N	\r
198	M159055	大学生创新基础	\N	2	创新创业课程	\N	\N	\N	\r
199	M159056	经济与社会：如何用决策思维洞察生活	\N	2	人文素养	\N	\N	\N	\r
200	M159057	从爱因斯坦到霍金的宇宙	\N	2	人文素养	\N	\N	\N	\r
201	M159059	穿T恤听古典音乐	\N	1	人文素养	\N	\N	\N	\r
202	M159060	创新中国	\N	1	人文素养	\N	\N	\N	\r
203	M159061	情商与智慧人生	\N	1	人文素养	\N	\N	\N	\r
204	M159062	创新工程实践	\N	3	创新创业课程	\N	\N	\N	\r
205	M159063	创造性思维与创新方法	\N	2	创新创业课程	\N	\N	\N	\r
206	M159064	创践——大学生创新创业实务	\N	2	创新创业课程	\N	\N	\N	\r
207	M159065	公共关系与人际交往能力	\N	2	创新创业课程	\N	\N	\N	\r
208	M159066	创新设计前沿	\N	2	创新创业课程	\N	\N	\N	\r
209	M159067	从创意到创业	\N	2	创新创业课程	\N	\N	\N	\r
210	M159068	创业+智能设备	\N	2	创新创业课程	\N	\N	\N	\r
211	M159069	创业管理（上海财经大学）	\N	2	创新创业课程	\N	\N	\N	\r
212	M159070	创业机会与创业选择	\N	2	创新创业课程	\N	\N	\N	\r
213	M159072	大学生创新创业基础（广西师范大学）	\N	2	创新创业课程	\N	\N	\N	\r
214	M159073	名企之魂	\N	2	创新创业课程	\N	\N	\N	\r
215	M159075	设计创意生活	\N	1	创新创业课程	\N	\N	\N	\r
216	M159077	创业管理：创业者的十八般武艺	\N	2	创新创业课程	\N	\N	\N	\r
217	M159079	如何赢得大学生创新创业大赛	\N	2	创新创业课程	\N	\N	\N	\r
218	M159080	创业营销——创业新手营销实战指南	\N	2	创新创业课程	\N	\N	\N	\r
219	M159081	大学生创新创业法律实务	\N	1	创新创业课程	\N	\N	\N	\r
220	M159083	创新创业学	\N	2	创新创业课程	\N	\N	\N	\r
221	M159084	创业必备-人力资源管理金钥匙	\N	2	创新创业课程	\N	\N	\N	\r
222	M159085	创新思维与创新技法	\N	2	创新创业课程	\N	\N	\N	\r
223	M159086	社会创新创业	\N	2	创新创业课程	\N	\N	\N	\r
224	M159087	电商创业初养成	\N	2	创新创业课程	\N	\N	\N	\r
225	M159089	创新创业：理论实践与应用	\N	2	创新创业课程	\N	\N	\N	\r
226	M159090	创造性思维与创新方法(Triz版）	\N	2	创新创业课程	\N	\N	\N	\r
227	M159091	基于创新的创业	\N	2	创新创业课程	\N	\N	\N	\r
228	M159092	创意改变生活	\N	1	创新创业课程	\N	\N	\N	\r
229	M159093	大学生创新、创造和实践方法	\N	1	创新创业课程	\N	\N	\N	\r
230	M159094	大学生创业法律服务	\N	1	创新创业课程	\N	\N	\N	\r
231	M159095	大学生创业英语	\N	1	创新创业课程	\N	\N	\N	\r
232	M159096	创课：大学生创新创业基础	\N	2	创新创业课程	\N	\N	\N	\r
233	M159097	文化创意产品设计	\N	1	创新创业课程	\N	\N	\N	\r
234	M159098	创新思维与教育领域创新创业	\N	1	创新创业课程	\N	\N	\N	\r
235	M159099	创新创业创造：职场竞争力密钥	\N	2	创新创业课程	\N	\N	\N	\r
236	M289038	世界著名博物馆艺术经典	\N	2	美育	\N	\N	\N	\r
237	M289039	敦煌的艺术	\N	2	美育	\N	\N	\N	\r
238	M289040	外国建筑赏析	\N	2	美育	\N	\N	\N	\r
239	M289041	“非遗”之首——昆曲经典艺术欣赏	\N	2	美育	\N	\N	\N	\r
240	M289042	电影作品读解	\N	2	美育	\N	\N	\N	\r
241	M289043	走近山水画	\N	2	美育	\N	\N	\N	\r
242	M289044	笔墨时空——解读中国书法文化基因	\N	2	美育	\N	\N	\N	\r
243	M289046	水彩绘堂	\N	2	美育	\N	\N	\N	\r
244	M289047	中国武侠电影	\N	2	美育	\N	\N	\N	\r
245	M289048	20世纪西方音乐	\N	2	美育	\N	\N	\N	\r
246	M289049	大学美育（华南理工大学）	\N	1	美育	\N	\N	\N	\r
247	M289050	视觉与艺术	\N	2	美育	\N	\N	\N	\r
248	M289051	电影叙事与美学	\N	2	美育	\N	\N	\N	\r
249	M289052	中国画与线的情节	\N	2	美育	\N	\N	\N	\r
250	M289053	中外美术评析与欣赏	\N	2	美育	\N	\N	\N	\r
251	M289054	中国陶瓷欣赏	\N	2	美育	\N	\N	\N	\r
252	M289055	让音乐走进你的世界	\N	2	美育	\N	\N	\N	\r
253	M289056	书法创作与欣赏	\N	2	美育	\N	\N	\N	\r
254	M289057	电影中的悲剧美学	\N	2	美育	\N	\N	\N	\r
255	M289058	美术鉴赏-绘画篇	\N	2	美育	\N	\N	\N	\r
256	M289059	美的必修课	\N	2	美育	\N	\N	\N	\r
257	M289060	园林艺术赏析	\N	2	美育	\N	\N	\N	\r
258	M289061	生活色彩美学	\N	2	美育	\N	\N	\N	\r
259	M289062	形式基础	\N	2	美育	\N	\N	\N	\r
260	M289063	建筑艺术与赏析	\N	2	美育	\N	\N	\N	\r
261	M289064	西方传统艺术	\N	1	美育	\N	\N	\N	\r
262	M289065	设计审美与文化	\N	2	美育	\N	\N	\N	\r
263	M289066	中国历代服饰赏析	\N	1	美育	\N	\N	\N	\r
264	M289067	中国艺术史	\N	2	美育	\N	\N	\N	\r
265	M289068	中国青瓷艺术鉴赏	\N	2	美育	\N	\N	\N	\r
266	M289069	中国木雕艺术	\N	2	美育	\N	\N	\N	\r
267	M289070	走进歌剧世界	\N	2	美育	\N	\N	\N	\r
268	M289071	莎士比亚戏剧赏析	\N	2	美育	\N	\N	\N	\r
269	M289072	经典影视片解读	\N	2	美育	\N	\N	\N	\r
270	M289073	从文学到电影	\N	2	美育	\N	\N	\N	\r
271	M289074	珠宝鉴赏	\N	2	美育	\N	\N	\N	\r
272	M289075	音乐的美及其鉴赏	\N	2	美育	\N	\N	\N	\r
273	M289076	美术鉴赏通识教育	\N	1	美育	\N	\N	\N	\r
274	M289077	古典音乐欣赏	\N	2	美育	\N	\N	\N	\r
275	M289078	中国画基础——梅兰竹菊	\N	2	美育	\N	\N	\N	\r
276	M289079	素描基础	\N	2	美育	\N	\N	\N	\r
277	M289080	石文化与宝玉石鉴赏	\N	3	美育	\N	\N	\N	\r
278	M289081	影视鉴赏	\N	2	美育	\N	\N	\N	\r
279	10390027	创造训练	\N	2	创新创业课程	\N	\N	\N	\r
280	10390028	创造训练	\N	2	创新创业课程	\N	\N	\N	\r
281	1229031	纳米材料与现实生活	\N	2	科学素养	\N	\N	\N	\r
282	1099176	学术英语论文写作与发表	\N	1	外语	\N	\N	\N	\r
283	M159103	伟大智慧：大学生学习毛泽东	\N	1	创新创业课程	\N	\N	\N	\r
284	1249011	基于人工智能的数字图像处理及应用	\N	2	科学素养	\N	\N	\N	\r
285	1099075	英语泛读与分析性阅读	\N	2	外语	\N	\N	\N	\r
286	1269001	串口通信与程序设计	\N	2	科学素养	\N	\N	\N	\r
287	M159105	中国共产党的创业思维与方法	\N	2	创新创业课程	\N	\N	\N	\r
288	1259031	党内法规导论	\N	1	人文素养	\N	\N	\N	\r
289	1309002	智慧桥梁工程创新创业	\N	1	创新创业课程	\N	\N	\N	\r
290	1099072	纪录片英语	\N	1	外语	\N	\N	\N	\r
291	1039093	荧光探针技术及应用	\N	2	科学素养	\N	\N	\N	\r
292	1049004	中国传统艺术赏析	\N	2	人文素养	\N	\N	\N	\r
293	M159102	公益创业学	\N	2	创新创业课程	\N	\N	\N	\r
294	1119030	体育锻炼与竞赛（瑜伽）	\N	2	人文素养	\N	\N	\N	\r
295	M289082	中国电影史	\N	2	美育	\N	\N	\N	\r
296	1289056	知识产权理论与典型案例分析	\N	2	人文素养	\N	\N	\N	\r
297	1099175	英语经典短篇小说赏析	\N	2	外语	\N	\N	\N	\r
298	1229029	影视作品中的生命科学	\N	2	科学素养	\N	\N	\N	\r
299	1049003	汽车安全概论	\N	1	科学素养	\N	\N	\N	\r
300	1159016	国际跨学科交叉前沿课程（文商）	\N	2	人文素养	\N	\N	\N	\r
301	1289043	中国近现代科技人物	\N	2	人文素养	\N	\N	\N	\r
302	1289053	中国精神发展史	\N	1	人文素养	\N	\N	\N	\r
303	1039031	智能高分子材料	\N	1	科学素养	\N	\N	\N	\r
304	1289040	文物保护与传承	\N	2	人文素养	\N	\N	\N	\r
305	1279007	世界火山之旅	\N	1	科学素养	\N	\N	\N	\r
306	1099071	外语学习者的幸福学	\N	2	外语	\N	\N	\N	\r
307	1099174	媒体话语与思辨写作	\N	1	外语	\N	\N	\N	\r
308	1039019	你未必了解的核能	\N	1	科学素养	\N	\N	\N	\r
309	1219007	研究性设计性物理实验	\N	2	科学素养	\N	\N	\N	\r
310	1279012	城市可持续发展	\N	1	科学素养	\N	\N	\N	\r
311	M159101	创新设计梦工场	\N	2	创新创业课程	\N	\N	\N	\r
312	1039016	核能与材料	\N	2	科学素养	\N	\N	\N	\r
313	1159011	国际跨学科交叉前沿课程（理工）	\N	2	科学素养	\N	\N	\N	\r
314	1119028	体育锻炼与竞赛（武术）	\N	2	人文素养	\N	\N	\N	\r
315	1289041	指挥理论与技法	\N	2	美育	\N	\N	\N	\r
316	1099001	美国社会与文化	\N	1	外语	\N	\N	\N	\r
317	1289042	明清法律文化	\N	2	人文素养	\N	\N	\N	\r
318	M159104	跟党学三创	\N	2	创新创业课程	\N	\N	\N	\r
319	1119027	体育锻炼与竞赛（素质拓展训练）	\N	2	人文素养	\N	\N	\N	\r
320	1039015	神奇的纳米纤维材料	\N	2	科学素养	\N	\N	\N	\r
321	1079002	生活中的因果推断	\N	1	科学素养	\N	\N	\N	\r
322	1099010	中日社会文化比较	\N	2	外语	\N	\N	\N	\r
323	1289057	素描理论与技法	\N	2	人文素养	\N	\N	\N	\r
324	1289047	西方绘画与艺术哲学	\N	2	美育	\N	\N	\N	\r
325	1289059	文艺作品中的科技与社会	\N	2	人文素养	\N	\N	\N	\r
326	1249012	嵌入式系统原理及实训	\N	2	科学素养	\N	\N	\N	\r
327	1279011	矿物与岩石（双语）	\N	1	科学素养	\N	\N	\N	\r
328	1099002	英文讲述中国故事	\N	2	外语	\N	\N	\N	\r
329	M289083	世界电影中的文字经典	\N	2	美育	\N	\N	\N	\r
330	M159106	设计思维与精益创业	\N	2	创新创业课程	\N	\N	\N	\r
331	1309003	减污降碳与创新创业	\N	1	创新创业课程	\N	\N	\N	\r
332	1289061	健身操舞	\N	2	人文素养	\N	\N	\N	\N
2	1019023	ASP网络数据库		2	科学素养	\N			
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: cakeal
--

COPY public.users (id, username, student_id, created_at, password) FROM stdin;
2	test_user2	U020240320	2024-03-20 07:17:12.875754	efed2d8c757e5690baeb9216f501cf69
1	test_user	U020240317	2024-03-17 02:59:31.637524	9CAFBE75F9AA82ED7344E1006B66DD16
\.


--
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cakeal
--

SELECT pg_catalog.setval('public.comments_id_seq', 23, true);


--
-- Name: course_information_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cakeal
--

SELECT pg_catalog.setval('public.course_information_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cakeal
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: cakeal
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: course_info course_information_pkey; Type: CONSTRAINT; Schema: public; Owner: cakeal
--

ALTER TABLE ONLY public.course_info
    ADD CONSTRAINT course_information_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: cakeal
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: comments comments_course_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cakeal
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.course_info(id);


--
-- Name: comments comments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: cakeal
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

