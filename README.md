DB (Database)
	데이터가 모여있는 기지

DBMS(Database Management System)
	DB를 관리할 수 있는 구체적인 시스템	
	오라클, MySQL, MariaDB, MS-SQL, MongoDB, .....
	
MySQL
	웹 사이트와 다양한 애플리케이션에서 사용되는 DBMS이다.
	오라클은 관리 비용이 고가이지만 MYSQL은 저가형 데이터베이스이다.
	문법이 간결하고 쉬우며, 메모리 사용량이 현저히 낮아서 부담없이 사용가능하다.

DBMS 소통 방식

-----------------------------------------------------
        		       사용자
-----------------------------------------------------
 	  ↕            	 	 ↕
고객 관리 응용프로그램      ↕   주문 관리 응용프로그램
   	↕             		 ↕
-----------------------------------------------------
       		       DBMS
-----------------------------------------------------

RDBMS(관계형 데이터베이스 관리 시스템)
	테이블끼리 서로 관계를 맺는다.
   Table A(TBL_user)        		              Table B(TBL_order)
   번호(PK)   이름     나이     아이디(UK)            주문번호(PK)        번호(FK)         날짜         상품수량
   1   	 이기영    20     lky1234                   20240114001         2            20240114         5
   2   	 장상화    21     jsh5555                   20240114002         2            20240114         20
   3   	 조은종    22     jej9999                   20240114003          1            20240114        100
   4   	 서경덕    45     sgd7777                 20240115001          4            20240115          1
   5   	 문우람    78     mor4444                20240115002           3            20240115         45

	이러한 구조를 가지는 것을 Table이라고 부른다.
	column(열, 속성, 필도)
		공통된 값들의 주제(집합)
	row(행, 레코드, 튜플)
		하나의 정보
	Primary Key(PK)
		고유한 값, 테이블 당 1개씩만 존재한다.
		각 정보의 구분점으로 사용된다.
		중복은 없고 Null값을 허용하지 않는다.
	Foreing Key(FK)
		다른 테이블의 PK를 의미한다.
		보통 테이블끼리 관계를 맺을 때 사용한다.
		중복이 가능하고 NULL도 허용한다.
	Unique Key(Unique)
		NULL은 허용하지만 중복은 허용하지 않는다.

SQL문(쿼리문) - DDL, DML, DCL, TCL
	스트립트 언어(인터프리터 언어)
	DBMS와 소통하는 언어.

MySQL 설치

MySQL 기본셋팅
	1. 로그인
		1) mysql -u root -p
		2) 1234

	2. 기본 데이터베이스 선택
		1) use mysql;

	3. 로컬에서만 접속 가능한 계정 생성
		1) create user 'userid'@localhost identified by '비밀번호';

	4. 원격으로도 접속 가능한 계정 생성
		1) create user 'userid'@'%' identified by '비밀번호';exiy


	5. 데이터베이스 생성
		1) create datadase [데이터베이스 이름];

	6. 데이터베이스 사용
		1) use [데이터베이스];

	7. 데이터베이스 삭제
		1) drop database[데이터베이스 이름];

	8. 사용자 비밀번호 변경
		1) set password for 'userid'@'%' = '신규 비밀번호';

	9. 사용자 삭제
		1) drop user 'userid'@'%';

	10. 연결권한
		1) grant all privileges on *.* to 'mysql'@'%' with grant option;

                            grant all privileges on *.* to 'mysql'@'%' with grant option;

	11. 권한 관련 명령어 확정
		1) flush provoleges;


DDL(Data Definition Language) : 데이타 정의어
	- 테이블을 조작하거나 제어할 수 있는 쿼리문
자료형
   - 정수
      tinyint
      smallint
      mediumint
      int
      bigint

   - 실수
      decimal(m, d) : m자리 정수, d자리 소수점으로 표현

   - 날짜
      date : 1000-01-01 ~ 9999-12-31(3byte)
      time : -838:59:59 ~ 838:59:59(3byte)
      datetime : 1000-01-01 00:00:00 ~ 9999-12-31 23:59:59(8byte)

   - 문자
      char(m) : 고정 길이 문자열(0~255)
      varchar(m) : 가변 길이 문자열(0~65535)

   - Boolean
	MySQL에서는 tinyint를 사용하는것이 가장 좋다.
	bit(1)로 설정해도 오차피 byte 단위로 데이터를 저장하고,
	bool, boolean으로 설정해도 자동으로 tinyint로 병경된다.
	만약 값에 의미부여를 하고 싶다면, varchar로 설정한 뒤
	check 제약조건으로 이상 데이터 삽입을 막아주면 된다.
	eunm을 사용하면 정규화를 위반하게 되며, 설정해놓은 데이터 수정이 어렵고
	다른 DBMS로 이관할 경우, MySQL에만 존재하는 enum을 모두 다른 타입으로 변경해야한다.
	만약 enum을 사용하고자 한다면, 정규화 위반이 가능하도록 약속했고, 유일하고 변하지 않는 값이며,
	2~10개의 값일 경우에만 사용한다.



	1. create : 테이블 생성
		create table [테이블명] ([컬럼명] [자료형(용량)] [제약조건], ....);

	2. drop : 테이블 날리기
		drop table [테이블명];
	3. alter : 테이블 수정
		- 테이블명 수정
		alter table [테이블명] rename [새로운 테이블명]
		 - 컬럼 맨 뒤에 추가
		alter table [테이블명] add [컬럼명] [자료형] [제약조건];
		- 컬럼 맨 앞에 추가
		alter table [테이블명] add [컬럼명] [자료형] [제약조건] first;
		- 컬럼 지정 위치에 추가
		alter table [테이블명] add [컬럼명] [자료형] [제약조건] after [기존 컬럼명];
		- 컬럼 삭제
		 alter table [테이블명] drop [컬럼명];
		- 컬럼명 변경
		 alter table [테이블명] change [기존컬럼명] [변경할 컬럼명] [컬럼타입];
		 - 컬럼 타입 변경
		alter table [테이블명] modify [컬럼명] [변경할 컬럼타입];
		- 제약 조건 확인
		desc [데이터베이스명].[테이블명];
		- 제약 조건 추가
		 alter table [테이블명] add constraint [제약조건 이름];
		- 제약 조건 삭제
		alter table [테이블명] drop constraint [제약조건 이름];



				
	4. truncate : 테이블 내용 전체삭제
		truncate table [테이블명];


무결성
	데이터의 정확성, 일관성, 유효성이 유지되는 것.
	
	정확성 : 데이터는 애매하지 않아야 한다.

	일관성 : 각 사용자가 일관된 데이터를 볼 수 있어야 한다.

	유효성 : 데이터가 실제 존재하는 데이터여야 한다.

	1. 개체 무결성
		모든 테이블이 PK로 선택된 컬럼을 가져야한다.
	
	2. 참조 무결성
		두 테이블의 데이터가 항상 일관된 값을 가지도록 유지한다.

	3. 도메인 무결성
		컬럼의 타입, NULL값의 허용 등에 대한 사항을 정의하고
		올바른 데이터가 입력되었는지를 확인하는 것.



-----------------------------------------------------------------------------------------------------------------------------

모델링(기획)
	추상적인 주제를 DB에 맞게 설계하는 것

1. 요구사항 분석
	회원, 주문, 상품 : 3가지를 관리하고자 한다.

2. 개념적 설계(개념 모델링)
	회원		주문		상품
----------------------------------------------------------------------
	번호		번호		번호
--------------------------------------------------------------
	생일		주문날짜		이름	
	아이디		회원번호		가격
	비밀번호		상품번호		재고
	이름
	주소
	이메일
	2
3. 논리적 설계(논리 모델링)
	회원		주문		상품
----------------------------------------------------------------------
	번호PK		번호PK		번호PK
--------------------------------------------------------------
	생일		주문날짜NN	이름NN	
	아이디NN,U	회원번호FK,NN	가격 D=0
	비밀번호NN	상품번호FK,NN	재고 D=0
	이름NN
	주소NN
	이메일

4. 물리적 설계(물리 모델링)
	tbl_user
	-----------
	id : bigint primary eky
	-----------
	user_id : varchar(255) unipue not NULL
	password : varchar(255) not null
	name : varchar(255) not null
	address : varchar(255)
	birth : date

5. 구현


-----------------------------------------------------------------------------------------------------------------------------
정규화
   삽입/수정/삭제의 이상현상을 제거하기 위한 작업.
   데이터의 중복을 최소화하는 데에 목적이 있다.
   5차 정규화까지 있으나 3차 정규화까지만 진행한다.

1차 정규화
   같은 성격과 내용의 컬럼이 연속적으로 나타나거나
   하나의 컬럼에 여러 값이 연속적으로 나타날 경우

   상품명
   와이셔츠1, 와이셔츠2, 와이셔츠3

   상품명1   상품명2   상품명3
   와이셔츠1   와이셔츠2   와이셔츠3

   * 조회가 힘들다.

   ▶ 1차 정규화 진행
   
      상품명
      와이셔츠1
      와이셔츠2
      와이셔츠3


2차 정규화
   조합키(복합키)로 구성되었을 경우 조합키의 일부분에만 종속되는 속성이 있는 경우(부분 종속).

   꽃
   이름   색상   꽃말   과
   해바라기   노란색   행운   국화
   장미   빨간색   사랑   장미

   "과" 속성(컬럼)은 부분종속이다.

   ▶ 2차 정규화 진행
   
      꽃
      이름   색상   꽃말
      해바라기   노란색   행운
      장미   빨간색   사랑

      과
      이름   과
      해바라기   국화
      장미   장미

3차 정규화
   PK가 아닌 컬럼이 다른 컬럼을 결정하는 경우.
   이행함수 종속 제거.

   회원번호   이름   시   구   동   우편번호
   1   한동석   경기도   남양주   화도   12345
   2   홍길동   서울   강남   역삼   56466

   * 우편번호로 시, 구, 동을 알 수 있다.
   * 중복된 데이터가 생길 가능성이 있다.

   
   ▶ 3차 정규화 진행

      회원번호   이름   우편번호
      1   한동석   12345
      2   홍길동   56466

      우편번호   시   구   동
      12345   경기도   남양주   화도
      56466   서울   강남   역삼

데이터베이스에서 정규화가 필요한 이유
   데이터베이스를 잘못 설계하면 불필요한 데이터 중복으로 인해 공간이 낭비된다.
   이런 현상을 이상(Anomaly)현상이라고 한다.


   회원번호와 프로젝트코드 두 컬럼의 조합키로 설정되어 있는 테이블이고
   한 사람은 하나의 부서만 가질 수 있다.

   회원번호      이름   부서   프로젝트코드   급여   부서별 명수
   22080101   한동석   개발팀   ABC0001      3000   4
   22080101   한동석   개발팀   DEF1112      2000   4
   22080101   한동석   개발팀   CBA9474      4000   4
   22080104   홍길동   기획팀   EFG0881      5000   2
   22081106   이순신   디자인팀   GHI9991      6000   3


이상 현상의 종류
   - 삽입 이상
      새 데이터를 삽입하기 위해 불필요한 데이터도 삽입해야하는 문제
   
      담당 프로젝트가 정해지지 않은 사원이 있다면,
      프로젝트 코드에 NULL을 작성할 수 없으므로 이 사원은 테이블에 추가될 수 없다.
      따라서 '미정'이라는 프로젝트 코드를 따로 만들어서 삽입해야 한다.

   - 갱신 이상
      중복 행 중에서 일부만 변경하여 데이터가 불일치하게 되는 모순의 문제

      한 명의 사원은 반드시 하나의 부서에만 속할 수 있다.
      만약 "한동석"이 보안팀으로 부서를 옮길 시 3개 모두 갱신해주지 않는다면
      개발팀인지 보안팀인지 알 수 없다.


   - 삭제 이상
      행을 삭제하면 꼭 필요한 데이터까지 함께 삭제되는 문제
   
      "이순신"이 담당한 프로젝트를 박살내서 드랍된다면 "이순신" 행을 모두 삭제하게 된다.
      따라서 프로젝트에서 드랍되면 정보를 모두 드랍하게 된다.

   ▶ 2차 정규화

      회원번호      프로젝트코드   급여
      22080101   ABC0001      3000
      22080101   DEF1112      2000
      22080101   CBA9474      4000
      22080104   EFG0881      5000
      22081106   GHI9991      6000


      회원번호      이름   부서   부서별 명수
      22080101   한동석   개발팀   4
      22080104   홍길동   기획팀   2
      22081106   이순신   디자인팀   3


   ▶ 3차 정규화 진행

      회원번호      이름   부서   
      22080101   한동석   개발팀   
      22080104   홍길동   기획팀   
      22081106   이순신   디자인팀   
      22080103   장보고   개발팀

      부서   부서별 명수
      개발팀   4
      기획팀   2
      디자인팀   3



-----------------------------------------------------------------------------------------------------------------------------

DML (Data Maniqulation langiage) : 데이터 조작어

	1. select : 조회(검색)
		select [컬럼명1, ....]
		from [테이블명]
		where [조건식];
	2. insert
		1) 컬럼을 생략할 수 있다.
			insert into [테이블명]
			([컬럼명1] [컬럼명2], ...)
			values([값1], [값2], ....);
		2) 모든 값을 전부 작성한다.
			insert into [테이블명]
			values ([값1], [값2], ...);
	3. update
		update [컬럼명]
		set [기존 컬럼명1] = [새로운 컬럼1]. [새로운컬럼2] = [새로운값2], ....
		where [조건식];
	4. delete
		delete from [테이블명]
		where [조건식];


-----------------------------------------------------------------------------------------------------------------------------

조건식 - where절에서 사용 가능

	<,>		: 초과, 미만
	<=,>=		: 이상, 이하
	<>,!=,^=		: 같이 않다
	AND		: 둘 다 참이면 
	OR		: 둘 중 하나라도 참이면 참
-----------------------------------------------------------------------------------------------------------------------------
join
	여러 테이블에 흩어져 있는 정보 중
	사용자가 필요한 저보만 가져와서 가상의 테이블처럼 만들고 결과를 보여주는 것.
	정규화를 통해 조회테이블이 너무 많이 쪼개져 있으면, 
	작업이 불편하기 때문에 조회의 성능을 향상시키고자 join을 사용한다.
	
	- 내부조인 (inner join)
		조건에 일치하는 값만 합쳐서 조회

		from [테이블명]
		innder join [테이블명]
		on 조건식 (등가 or 비등가)
		innder join [테이블명]
		on 조건식 
		innder join [테이블명]
		on 조건식 
		innder join [테이블명]
		on 조건식 
		... 

		- 등가 조인
			on절에 등호가 있을 때, 서로 관계를 맺고 있는 테이블끼리 join할 때 자주 사용된다.
		
		- 비등가 조인
			on절에 등호가 없을 때, 서로 관계를 맺지 않고 있는 테이블끼리 join할 때 주로 사용된다

	- 외부조인 (outer join)
		조건에 일치하지 않아도 원하는 정보까지 합쳐서 조회

		-left outer join
			선행 테이블의 모든 정보를 가져오고 싶을 때 사용한다.

		-right outer join
			후행 테이블의 모든 정보를 가져오고 싶을 때 사용한다. 

-----------------------------------------------------------------------------------------------------------------------------
옵티마이저(Optimizer)
	SQL을가장 빠르고 효율적으로 수행할 최적의 처리경로(최저비용)을 생성해주는 DBMS 내부의 핵심엔진
	사용자가 쿼리문(SQL)으로 결과를 요청하면, 이를 생성하는데 필요한 처리경로는 DBMS에 내장된
	옵티마이저가 자동으로 생성한다. 옵티마이저가 생성한 SQL 처리경로를 실행 경로(Exeution Plan)이라고 한다.

	COST : 예상수행시간, 쿼리를 수행하는데 소요되는 일량 또는 시간

	CARDINALITY : 실행결과의 건수

옵티마이저의 SQL 최적화 과정
	사용자가 작성한 쿼리 수행하기 위해, 실행 계획을 찾는다.
	데이터 딕셔너리에 미리 수집해 놓은 오브젝트 통계 및 시스템 통계 정보를 이용해서
	각 실행 계획의 예상 비용을 산정한다.
	각 실행 계획을 비교해서 치저 비용을 갖는 하나를 선택하여실행한다. 

옵티마이저의 종류

	1. 규칙기반 옵티마이저 (RBO)
		미리 정해진 규칙에 따라 실행


	2. 비용기반 옵티마이저 (CBO)
		비용이 가장 낮은 실행계획을 선택

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
PASER			OPTIMIZER		ROW_SOURE		SQL_ENGINE
						GENERATOR

문법오류검사		총 비용계산		실행가능코드로 변경	실행
코드로 변경		실행계획 생성		

-----------------------------------------------------------------------------------------------------------------------------
TCL(Tramsaction Control Language) : 트랜잭션 제어어
	
	트랜잭션
		하나의 작업(서비스)에 필요한 쿼리를 묶은 단위
	
	commit
		모든 작업을 확정하는 명령어		
	rollback	
		이전 커밋 시점으로 이동


-----------------------------------------------------------------------------------------------------------------------------
VIEW
	기존의 테이블은 그대로 놔둔 채 필요한 컬럼들 및 새로운 컬럼을 만든 가상 테이블.
	실제 데이터가 저장되는 것은 아니지만 view를 통해서 충분히 데이터를 관리할 수 있다.
	
	독립성 : 다른 곳에서 접근하지 못하도록 하는 성질

	편리성 : 긴 쿼리문을 짧게 만드는 성질

	보안성 : 기존의 쿼리문이 보이지 않는다.

view 문법
	create view [뷰 이름] as (select 쿼리문)

atto commit 설정법


   > show variables like '%autocommit%';

      +---------------+-------+
      | Variable_name | Value |
      +---------------+-------+
      | autocommit    | OFF   |
      +---------------+-------+

   > set autocommit = true;
   > set autocommit = false;




