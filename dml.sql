create table tbl_parent(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    age tinyint default 1,
    gender varchar(255) default '선택안함',
    address varchar(255) not null,
    phone varchar(255) not null,
    constraint check_gender check ( gender in ('선택안함', '여자', '남자') )
);

/*전체를 의미한 *은 직접 컬럼을 작성한 것보다 더 많은 연산이 필요하기 때문에
  대량의 데이터 조회 시 사용을 지양한다.
select * from tbl_parent;
  */

/*select id, name, age, gender, address, phone
from tbl_parent;

insert into tbl_parent
(name, age, address, phone)
values ('cho',20,'강동구','112');

update tbl_parent
set age = 40
where id = 1;

delete from tbl_parent
where id = 1;*/

/*
1. 2명의 학부모 정보 추가
2. 부모 중, 나이가 51세 이상인 부모의 이름 조화
경기도 남양주에 살고 있는 부모 핸드폰 번호 조회
성별이 남자인 학부모를 선택안함을 변경
성별이 선택안함인 학부모를 모두 삭제
*/

select id, name, age, gender, address, phone from tbl_parent;

insert into tbl_parent
(name, age, address, phone,gender)
values ('cho' ,27,'강동구', '112','남자');
insert into tbl_parent
(name, age, address, phone)
values ('kim', 55, '서울시 강동구', '1303');

select name from tbl_parent
where 51<=age;

select phone from tbl_parent
where address = '남양주';

update tbl_parent
set gender = '선택안함'
where gender = '남자';

delete from tbl_parent
where gender = '선택안함';

/*
    as(Alias) : 별칭
    select id,name as 이름, age,address from tbl_parent
*/
/*
    concatenation(연결)
    concat([string1],[string2], ....)
    select concat('안녕하세요 제 이름은' , name ,'입니다') as intro from tbl_parent
*/
/*
    like
        포함된 문자열 값을 찾을때 사용한다.

    ex)
    '%A' : A로 끝나는 모든 값(SFDA, FASDQFA, ...)
    'A%' : A로 시작하는 모든값(ASDSD,AFWSC)
    '%A%' : A가 포함되는 모든 값 (ASdas,ASDQc)
*/
/*
select id, name, age, gender, address, phone from tbl_parent:
where address like '%남양주%'
*/
/*
1. 핸드폰 번호에 5가 들어간 학부모 정보 전체조회
2. 주소에 서울이 들어간 학부모 정보 전체조회
*/
# select * from tbl_parent/*
/*where gender like '%1%';

select id, name, age, gender, address, phone from tbl_parent;
where address like %5%*/


/*
    집계함수

    평균 avg()
    최대값 max()
    최소값 min()
    총합 sum()
    개수 count(0
*/
create table tbl_field_trip(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    count tinyint default 0
);
insert into tbl_field_trip (title, content, count)
values ('어서와 매미농장', '매미 잡자 어서와', 20);

insert into tbl_field_trip (title, content, count)
values ('아이스크림 빨리 먹기 대회', '아이스크림 누가 더 잘먹나', 100);

insert into tbl_field_trip (title, content, count)
values ('고구마 심기', '고구마가 왕 커요', 10);

insert into tbl_field_trip (title, content, count)
values ('숭어 얼음 낚시', '숭어 잡자 추워도 참아', 80);

insert into tbl_field_trip (title, content, count)
values ('커피 체험 공장', '커비 빈 객체화', 60);

insert into tbl_field_trip (title, content, count)
values ('치즈 제작하기', '여기 치즈 저기 치즈 전부 다 치즈', 5);

insert into tbl_field_trip (title, content, count)
values ('동물 타보기', '이리야!', 9);


select  sum(count) as total from tbl_field_trip;
select  avg(count) as average from tbl_field_trip;
select  max(count) as max_count from tbl_field_trip;
select  min(count) as min_count from tbl_field_trip;
select  round((avg(count))) as total from tbl_field_trip;

   /*
   order by : 정렬

   order by [컬럼명] asc : 오름차순 asc 생략가능
   order by [컬럼명] desc: 내림차순


   */

select id, title, content, count from tbl_field_trip
order by count;

/* 실행순서
   1. from
   2. where
   3. select
   4. order by
   5. select
   6. order by
   */

/*
    group by : ~별

*/





create table tbl_order(
    id bigint auto_increment primary key,
    name varchar(255),
    price int default 0
);

insert into tbl_order (name, price)
values ('자두', 3000);
insert into tbl_order (name, price)
values ('지우개', 3000);
insert into tbl_order (name, price)
values ('자두', 3000);
insert into tbl_order (name, price)
values ('자두', 3000);
insert into tbl_order (name, price)
values ('마우스', 15000);
insert into tbl_order (name, price)
values ('마우스', 15000);
insert into tbl_order (name, price)
values ('키보드', 5000);
insert into tbl_order (name, price)
values ('키보드', 5000);
insert into tbl_order (name, price)
values ('키보드', 5000);
select * from tbl_order;
select name,count(name) total from tbl_order
group by name;
/*
주문된 상품별 평균 가격 조회

*/

select name,sum(price)/count(name) '가격' from tbl_order
group by name;


/*
    서브 쿼리 (Sub Query)

    from 절
    select 절
    where 절
*/

select name,sum(price)/count(name) '가격' from tbl_order
group by name
having avg(price) >= 5000;

/* 상품별 가격 총 합과 전체 상품의 총 합 조회

*/
select name,sum(price) total, (select sum(price) from tbl_order) from tbl_order
group by name;


/* 상품 중 "우"가 들어간 상품별 총 합 조회
*/

select o.name, sum(o.price) from

(select name,price
 from tbl_order
where name like '%우%') o
group by o.name;

/* 상품의 평균 가격이 1000원 이하인 상품의 개별가격 조회
*/
select id, name, price from tbl_order
where name in
(select name
 from tbl_order
group by name
having avg(price) <= 1000);


create table tbl_user(
    id bigint auto_increment primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255) not null,
    address varchar(255) not null,
    email varchar(255),
    birth date
);

create table tbl_post(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    create_date datetime default current_timestamp,
    user_id bigint not null,
    constraint fk_post_user foreign key(user_id)
                     references tbl_user(id)
);

create table tbl_reply(
    id bigint auto_increment primary key,
    content varchar(255) not null,
    user_id bigint not null,
    post_id bigint not null,
    constraint fk_reply_user foreign key(user_id)
                     references tbl_user(id),
    constraint fk_reply_post foreign key(post_id)
                     references tbl_post(id));



insert into tbl_user (user_id, password, name, address, email, birth)
values ('hds1234', '1234', '한동석', '경기도', 'test1234@gmail.com', '2000-12-04');

insert into tbl_user (user_id, password, name, address, email, birth)
values ('hgd3333', '3333', '홍길동', '서울', 'hgd1234@gmail.com', '1920-11-25');

select * from tbl_user;


insert into tbl_post (title, content, user_id)
values ('테스트 제목1', '테스트 내용1', 1);

insert into tbl_post (title, content, user_id)
values ('테스트 제목2', '테스트 내용2', 2);

insert into tbl_post (title, content, user_id)
values ('테스트 제목3', '테스트 내용3', 1);

insert into tbl_post (title, content, user_id)
values ('테스트 제목4', '테스트 내용4', 1);

select * from tbl_post;

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 1', 2, 1);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 1', 2, 2);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 2', 1, 1);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 2', 2, 1);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 1', 1, 2);

insert into tbl_reply (content, user_id, post_id)
values ('테스트 댓글 1', 1, 2);

select * from tbl_reply;

/*3이 포함된 게시글 제목을 조회한 뒤 작성자 전체 정보 조회*/

/*  유저 테이블이랑 포스트 테이블 전체값 중에서 밑에조건만 가져고오 그중에 유저에 전체값을 출력*/
select u.* from tbl_user u join tbl_post p
    /*p중에 타이틀 중에 3이라는게 들어가는지 확인 and 유저아이디랑 p에서 가지고있는 유저아이디PK랑같은거찾기*/
on p.title like '%3%' and u.id = p.user_id;

/*게시글 내용이 "테스트 내용4"의 작성자가 작성한 댓글 전체 정보 조회*/

/*   게시글 테이블 x 댓글 테이블 한거중에 밑에내용만 걸러내고 걸리는것들 다 출력*/
select * from tbl_post p join tbl_reply r
    /*p중 콘텐츠 내용중에 테스트 내용4 을 포함 and p.유저아이디랑 r.유저아이디 같은애들*/
on p.content like '%테스트 내용4%' and p.user_id = r.post_id;

/*게시글 별 댓글 개수*/

/*  게시글별로 나타내고 댓글은 있는만큼 숫자로 (count)로 나타낸다. */
select p.title, count(r.id)
/*1. 게시글 타이틀 x 댓글 타이틀 총량 만들고*/
from tbl_post p join tbl_reply r
    /*2. 그중에 댓글쓴사람 = 게시글 쓴사람 -> 게시글 + 댓글등등 / 게시글 + 댓글등등의 경우의수 나옴*/
on p.id = r.post_id
/*3. 지금까지 만들것들중 게시글중 타이틀을 메인으로 잡고*/
group by p.title;

/*회원 중 gmail을 사용하는 회원이 작성한 게시글 정보 중 제목 조회*/

/*3. 2번중에서 게시글의 타이틀만 뽑아준다.*/
select p.title
/*1, 유저테이블 x 게시글타이틀 경우의수 만들어준다.*/
from tbl_user u join tbl_post p
    /*2. 이메일중에 gmail이들어감 and 유저 아이디랑 유저아이디(작성자)가 같은사람만 묶어준다*/
on u.email like '%gmail%' and u.id = p.user_id;

/*회원 중 "서울"거주자가 작성한 댓글 조회 */

/*3. 2번에 경우에수 중에서 댓글 관련된 것만 보여준다. */
select r.*
/* 1. 유저테이블 x 댓글테이블 경우의수 만들어주고*/
from tbl_user u join tbl_reply r
    /*2. 1번중에서 유저테이블 서울이고, 댓글을 작성한적 있는사람을 묶어준다.*/
on u.address like '%서울%' and u.id = r.user_id;


/*댓글 중 같은 게시글에 작성된 댓글 내용 조회*/
/*게시글 넘버, 이름 ,  댓글 내용 출력*/
select p.id, p.title, r.content
/* 1.게시물테이블 x 댓글 테이블 경우의수 만들어주고 */
from tbl_post p join tbl_reply r
/*2. 그중에 게시물 게시물넘버와 게시물넘어에 댓글이있는거 즉 댓글이있는 게시물을 리스트?를 만들고*/
on p.id = r.post_id
/*그중에 게시글 넘버랑 댓글내용을 기준점 잡고*/
group by p.id,r.content;


/*댓글 개수가 3개 이상인  /////  게시글 전체 내용 조회 및 회원 이름 조회*/

/* 6.즉 게시물중 댓글이 3개이상인것만 살아남고 그중 게시글정보, 유저이름 출력*/
select p.*, u.name
/*4. 유저테이블 x 게시글테이블 경우의수중에 게시글 넘버(3에서 살아온것만) 남김*/
from tbl_user u join tbl_post p on p.id in
/*1. 댓글달린 게시글넘버 알려줌 */
(select post_id from tbl_reply
/*2. 그중에서 중복없앰*/
group by post_id
/*3. 근데 3개이상 달려있어야지 살아남음 */
having count(id) >= 3)
/*5. 근데 그중에 게시물들만 남김 (유저넘버, 게시글 만든사람 조합)*/
and u.id = p.user_id;

/*게시글 전체정보와 회원의 이메일 조회*/

/* 3.게시물 전체정보 , 유저 이메일 출력*/
select p.*,u.email
/*1. 유저테이블 x 게시물 테이블 총 경우의 수*/
from tbl_user u join tbl_post p
    /* 2. 사실상 게시물리스트*/
on u.id = p.user_id;

/*댓글 작성자 중 게시글을 등록한 회원*/


/*5. 유저 전체정보를 나타낸다.*/
select u.* from
/*2. 유저테이블 x 게시물 테이블 중에 ((댓글작성자)게시물작성자)를 골라줍니다. */
tbl_user u join tbl_post p on p.user_id in
/*1. 댓글 작성한적 있는 사람들을 골라준다*/
(select user_id from tbl_reply)
/*3. 근데 그 사람들은 게시글을 쓴적 있는사람들이고*/
and p.user_id = u.id
/*4. 유저 이름을 기준으로 해서 중복을 없애준다.*/
group by u.name;


/*댓글 작성자 중 게시글을 2번 이상 작성한 회원의  ///// 게시글 제목과 게시글 내용 조회*/
/*1. 결국 마지막으로 나타낼것  ////  9 다 결합하고 제목, 내용 출력*/
select title,content from tbl_post
/*8. 최초로 만들어 준거랑 연결해줍니다.*/
where user_id in
/*4.게시글 작성자를 만들어주고*/
(select user_id from tbl_post
/*5. 지금까지 만든거를 합쳐주고(댓글 작성자 + 게시글 작성자)*/
where user_id in
/*2.댓글작성자 만들어주고*/
(select user_id from tbl_reply
/*3. 중복을 없애줍니다.*/
group by user_id)
/*6. 또 중복 없애주고*/
group by user_id
/*7. 작성자가 게시글 2개이상 썻는지 걸러줍니다.*/
having count(id)>=2);


/*게시글 작성자 중 댓글을 2번 이상 작성한 //////회원의 정보와 작성한 댓글의 전체 정보 조회*/

/*7. 회원정보, 댓글정보 전부다 담아줍니다..*/
select * from tbl_user u join tbl_reply r
/*8, 아래조건들을 위로 넘겨줍니다.*/
on u.id in
/*3. 댓글 작성자 만들어주고*/
(select user_id from tbl_reply
/*4. 연결해주는 친구 만들어주고*/
where user_id in
/* 1. 게시글 작성자 만들어주기*/
(select user_id from tbl_post
/*2. 중복을 제거해줍니다.*/
group by user_id)
/*5. 중복을 제거해줍니다.*/
group by user_id
/*6. 댓글을 2개이상 적은사람만 걸러주고*/
having count(tbl_reply.id) >=2)
       /*9.유저넘버 댓글쓴 사람들만 골라줍니다 / 사실상 중복제거*/
and u.id = r.user_id;











/*실행순서
   1. from
   2. join
   3. on
   4. where
   5. select
   6. order by
   7. select
   8. order by
 */
create table tbl_parent(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    age tinyint default 1,
    gender varchar(255) not null,
    address varchar(255) not null,
    phone varchar(255) not null,
    constraint check_gender check ( gender in ('선택안함', '여자', '남자') )
);

create table tbl_child(
    id bigint auto_increment primary key,
    name varchar(255) not null,
    age tinyint default 1,
    gender varchar(255) not null,
    parent_id bigint not null,
    constraint check_child_gender check ( gender in ('선택안함', '여자', '남자') ),
    constraint fk_child_parent foreign key (parent_id)
                      references tbl_parent(id)
);

create table tbl_field_trip(
    id bigint auto_increment primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    count tinyint default 0
);

create table tbl_file(
    /* 슈퍼키 */
    id bigint auto_increment primary key,
    file_path varchar(255) not null,
    file_name varchar(255) not null
);

create table tbl_field_trip_file(
    /* 서브키 */
    id bigint primary key,
    field_trip_id bigint not null,
    constraint fk_field_trip_file_file foreign key (id)
    references tbl_file(id),
    constraint fk_field_trip_file_field_trip foreign key (field_trip_id)
    references tbl_field_trip(id)
);

create table tbl_apply(
    id bigint auto_increment primary key,
    child_id bigint not null,
    field_trip_id bigint not null,
    constraint fk_apply_child foreign key (child_id)
    references tbl_child(id),
    constraint fk_apply_field_trip foreign key (field_trip_id)
    references tbl_field_trip(id)
);

insert into tbl_field_trip (title, content, count)
values ('매미 잡기 체험학습', '매미 잡으러 떠나자!', 5);

insert into tbl_field_trip (title, content, count)
values ('메뚜기 때려 잡기 체험학습', '메뚜기 다 잡자!', 50);

insert into tbl_field_trip (title, content, count)
values ('물놀이 체험학습', '한강 수영장으로 퐁당!', 20);

insert into tbl_field_trip (title, content, count)
values ('블루베리 채집 체험학습', '맛있어 블루베리 냠냠!', 25);

insert into tbl_field_trip (title, content, count)
values ('코딩 체험학습', '나도 빌게이츠!', 20);

select * from tbl_field_trip;

insert into tbl_parent (name, age, address, phone, gender)
values ('한동석', '40', '경기도 남양주', '01012341234', '남자');

insert into tbl_parent (name, age, address, phone, gender)
values ('홍길동', '50', '서울시 강남구', '01055556666', '여자');

insert into tbl_parent (name, age, address, phone, gender)
values ('이순신', '55', '서울시 강남구', '01077778888', '여자');

select * from tbl_parent;

insert into tbl_child (name, age, gender, parent_id)
values ('김철수', 4, '남자', 1);

insert into tbl_child (name, age, gender, parent_id)
values ('김훈이', 5, '남자', 2);

insert into tbl_child (name, age, gender, parent_id)
values ('이유리', 7, '여자', 1);

insert into tbl_child (name, age, gender, parent_id)
values ('김사자', 4, '남자', 3);

insert into tbl_child (name, age, gender, parent_id)
values ('김영희', 4, '여자', 3);

select * from tbl_child;

insert into tbl_apply (child_id, field_trip_id)
values (1, 1);

insert into tbl_apply (child_id, field_trip_id)
values (2, 1);

insert into tbl_apply (child_id, field_trip_id)
values (3, 2);

insert into tbl_apply (child_id, field_trip_id)
values (4, 3);

insert into tbl_apply (child_id, field_trip_id)
values (4, 5);

insert into tbl_apply (child_id, field_trip_id)
values (5, 5);

insert into tbl_apply (child_id, field_trip_id)
values (5, 4);

insert into tbl_apply (child_id, field_trip_id)
values (5, 4);

insert into tbl_apply (child_id, field_trip_id)
values (5, 4);

insert into tbl_apply (child_id, field_trip_id)
values (5, 3);

select * from tbl_apply;

/*매미 체험학습에 신청한 ////  아이의 전체 정보*/

/*1. 서브쿼리만 사용*/

/*5아이의 대한 전체정보를 출력합니다*/
select * from tbl_child c
/*6. 연결목적이고 아이.넘버 = 신청.아이넘버는 사실상 같고 중복되는 친구들을 넘겨줍니다.*/
where c.id in
/*3.신청한 목록중에서 아이들 넘버를 가져옵니다*/
(select a.child_id from tbl_apply a
/*4. 사실상 체험학습 고유넘버 = 신청.체험학습넘버는 같음 근데 제목에 매미가 들어간이 조건이라 조건에 맞는거 넣어줌*/
where a.field_trip_id in
/*1.체험학습에서 고유?넘버만 뽑아옵니다*/
(select f.id from tbl_field_trip f
/*2. 근데 제목에 매미가 들어간*/
where f.title like '%매미%'));
/*매미 체험학습에 신청한 ////  아이의 전체 정보*/
/*2. join만 사용*/

/*5. 체험학습 타이틀 등 잡다한 정보가 많아 아이정보만 나오게 만들어준다.*/
select c.*
/*1. 먼저 아이의 정보를 뽑기위해 신청, 아이의 정보를 뽑습니다.*/
from tbl_child c join tbl_apply a
/*2.뽑은 아이의 필요한 정보인 신청한 전체정보를 뽑아줍니다*/
on c.id = a.child_id
    /*3.위에 값에 체험학습의 대한 내용을 추가해줍니다.*/
join tbl_field_trip f
/*4. 연결겸, 제목에는 매미가 들어가고 // 체험학습 고유넘버 = 신청.고유넘버는 같으니
  매미라는 제목이 들어가고 체험학습 고유넘버만 남기고 나머지는 날린다.*/
on f.title like '%매미%' and field_trip_id = a.id;

/*체험학습을 2개 이상 신청한 (아이) /////아이의 정보와 부모의 정보 모두 조회*/

/*4.어머니와 아이 같이 정보 나와야하기때문에 다 묶어서 소환해줍니다*/
select c.*,p.* from tbl_child c join tbl_parent p
/*5, 연결 겸 // 체험학습2번이상 살아남은거랑 아이 넘버랑 연결해준다.*/
on c.id in
/*1.신청목록중에 아이가 신청한 체험학습목록을 나타낸다*/
(select child_id from tbl_apply
/*2. 중복을 제거한다.*/
group by child_id
/*3. 체험학습 목록중에서 번호가 2번이상 불린것들만 살려둔다.*/
having count(field_trip_id) >=2);



/*참가자(지원자) 수가 가장 적은 ////체험학습의 제목과 내용 조회*/

/*원하는 제목, 내용 출력*/
select f.title, f.content from tbl_field_trip f
where f.id =

/*가장 적게 생성된 체험학습을 찾음*/
(SELECT field_trip_id
FROM tbl_apply
GROUP BY field_trip_id
HAVING COUNT(child_id) =
       (
    /* 그중 최소값을 찾아요 ((체험학습 아이디들 중에 /./ 신청중 아이들이 고른 갯수)) */
    SELECT MIN(total_number.find_min)

    /*최소값을 찾아주는 컬럼*/
    FROM (
        SELECT COUNT(child_id) as find_min
        FROM tbl_apply
        GROUP BY field_trip_id
        /*()안의 별칭*/
    ) total_number
));

/*평균 참가자(지원자) 수보다 적은 체험학습의 제목과 내용 조회*/

/*원하는 제목, 내용만 출력*/
select f.title, f.content from tbl_field_trip f
where f.id in
/*여기는 밑에는 평균이 나와있고 여기는 모두가 있지만
  평균보다 높거나 같은애들은 걸러줌*/
(select field_trip_id from tbl_apply
group by field_trip_id
having count(child_id) <
        /*참가하는 인원수분에 참여하는 인원으로 나눠줌 */
(select round(avg(total_number.find_avg),0) from
(
/*체험학습 가는 인원별로 종합*/
select count(child_id) find_avg from tbl_apply
group by field_trip_id) total_number));

create view view_target_field_trip as
    (select * from tbl_field_trip
where id in (
    select ft.id from tbl_apply a
    right outer join tbl_field_trip ft
    on a.field_trip_id = ft.id
    group by ft.id
    having count(child_id) < (
    select floor(avg(ac.apply_count)) from (
        select field_trip_id, count(child_id) apply_count from tbl_apply
        group by field_trip_id) ac)
));

select * from view_target_field_trip;












