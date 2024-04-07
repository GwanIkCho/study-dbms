# # 전체 데이터베이스 조회
# show databases;
#
# # test 데이터베이스 사용
# use test;
#
# # 회원 테이블 생성
# create table tbl_member(
#     member_name varchar(255),
#     member_age int
# );
#
# # 현재 database에 생성된 테이블 전체 조회
# show tables;
#
# # 테이블 삭제
# drop table tbl_member;
#
# /*
#     자동차 테이블 생성
#     1. 자동차 번호
#     2. 자동차 브랜드
#     3. 출시 날짜
#     4. 색상
#     5. 가격
# */
# create table tbl_car(
#     number bigint primary key,
#     brand varchar(255),
#     release_date date,
#     color varchar(255),
#     price int
# );
#
# show tables;
#
# drop table tbl_car;
#
# /*
#     동물 테이블 생성
#     1. 번호
#     2. 종류
#     3. 먹이
# */
# create table tbl_animal(
#     number bigint primary key,
#     type varchar(255) not null unique,
#     feed varchar(255)
# );
#
# show tables;
#
# drop table tbl_animal;


/*
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

*/

create table tbl_user(
    id bigint primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255)not null ,
    adress varchar(255)not null,
    mail varchar(255)
);

create table  tbl_product(
    id bigint primary key ,
    name varchar(255) not null ,
    price int default 0,
    stock int default 0
);

create table tbl_order(
    id bigint primary key ,
    order_date datetime default current_timestamp,
    user_id bigint,
    product_id bigint,
    constraint fk_order_user foreign key(user_id)
    references tbl_user(id),
    constraint fk_order_product foreign key(product_id)
    references tbl_product(id)
);

/*
 1. 요구사항 분석
        꽃 테이블과 화분테이블 2개가 필요하고
        꽃을 구매할 때 화분도 같이 구매합니다.
        꽃은 이름과 색상, 가격이 있고
        화분은 제품번호 색상 모양이 있습니다.
        화분은 모든 꽃을 담을 수 없고 정해진 꽃을 담아야합니다.


    2. 개념 모델링
        꽃                     화분
        번호                   제품번호
        색상                   색상
        가격                   모양
        화분제품번호            담을 꽃
        이름



    3. 논리 모델링

        꽃                     화분


        번호  PK                 제품번호PK
        색상 NN                색상 NN
        가격 d =0,nn           모양 NN
        화분제품번호 FK,NN       담을 꽃 FK,NN
        이름




    4. 물리 모델링
        create table fbl_flower(
        id  bigint primary key,
        name varchar(255) not null,
        flower_color  varchar(255) not null,
        price  int default 0
        );
,

        create table fbl_pot(
        pot_id  bigint primary key,
        pot_color  varchar(255) not null,
        form  varchar(255) not null,
        flower_id  bigint,
        constraint fk_pot_flower foreign key(flower_id)
        references fbl_flower(id));


    5. 구현
*/



/*복합키(조합키) 하나의 PK에 여러 컬럼을 설정한다. */
create table tbl_flower(
        name varchar(255) not null,
        color  varchar(255) not null,
        price  int default 0,
        primary key(name,color)
        );


create table tbl_pot(
        pot_id  bigint primary key,
        pot_color  varchar(255) not null,
        form  varchar(255) not null,
        flower_name  bigint not null ,
        flower_color bigint not null ,
        constraint fk_pot_flower foreign key(flower_name,flower_color)
        references tbl_flower(name,color));



/*
    1. 요구사항 분석
        안녕하세요, 동물병원 곧 개원합니다.
        동물은 보호자랑 항상 같이 옵니다. 가끔 보호소에서 오는 동물도 있습니다.
        보호자가 여러마리 동물을 데리고 올 수 있습니다.
        보호자는 이름, 나이, 전화번호, 주소가 필요하고
        동물은 병명, 이름, 나이. 몸무게가 필요합니다.

    2. 개념 모델링
            동물                  보호자
            넘버                  넘버
            병명                  이름
            이름                  나이
            나이                  전화번호
            몸무게                 주소


    3. 논리 모델링
            동물                  보호자
            넘버 PK               넘버pk
            병명 NN                 이름 NN
            이름 NN                 나이 NN
            나이 NN                 전화번호 NN
            몸무게 NN               주소 NN
            보호자 넘버


    4. 물리 모델링
    tbl_animal
    id bigint primary key
    disease varchar(255) not null
    name varchar(255) not null
    age varchar(255) not null
    kg varchar(255) not null
    person_id bigint

    tbl_person
    id bigint primary key
    name varchar(255) not null
    age varchar(255) not null
    phone varchar(255) not null
    adress varchar(255) not null
    5. 구현
*/
# create table tbl_animal(
#     id bigint primary key,
#     disease varchar(255) not null,
#     name varchar(255) default '구름',
#     age int default 0,
#     kg decimal(3,2) default 0.0,
#     person_id bigint,
#     constraint fk_animal_person foreign key(person_id)
#     references tbl_person(id));
#
# create table tbl_person(
#     id bigint primary key,
#     name varchar(255) not null,
#     age int default 0,
#     phone varchar(255) not null,
#     address varchar(255) not null);


/*
    1.안녕하세요 중고차 딜러입니다.
    이번에 자동차와 차주를 관리하고자 방문했습니다.
    자동차는 여러명의 차주로 히스토리에 남겨야하고
    차주는 여러대의 자동차를 소유할 수있습니다.
    그래서 우리는 항상 등록증(Registration)을 작성합니다.
    자동차는 브랜드, 모델명, 가격, 출시날짜가 필요하고
    차주는 이름, 전화번호, 주소가 필요합니다.

    2. 개념적 설계

    차           차주          등록증
    넘버          넘버          넘버
    브랜드        이름           차 넘버
    모델명        전화번호       차주 넘버
    가격          주소
    출시날자

    3. 논리적 설계

    차           차주          등록증
    넘버 PK       넘버 PK       넘버PK
    브랜드NN        이름 NN          차 넘버FK
    모델명NN        전화번호 NN      차주 넘버FK
    가격 int D=0         주소 NN
    출시날자 date NN

    4.물리적 설계

    tbl_car
    id bigint primary key
    brand varchar(255) not null
    model_name varchar(255) not null
    price int default 0
    day date

    tbl_car_owner
    id bigint primary key
    name varchar(255) not null
    phone varchar(255) not null
    address varchar(255) not null

    tbl_registration
    car_id bigint not null
    car_owner_id bigint not null
    constraint fk_registration_car foreign key(car_id)
    references tbl_car(id)
    constraint fk_registration_car_owner foreign key(car_owner_id)
    references tbl_car_owner(id))

*/

create table tbl_car(
    id bigint primary key,
    brand varchar(255) not null,
    model_name varchar(255) not null,
    price int default 0,
    launch date default (current_date));

create table tbl_car_owner(
    id bigint primary key,
    name varchar(255) not null,
    phone varchar(255) not null,
    address varchar(255) not null
);

create table tbl_registration(
    id bigint primary key,
    car_id bigint not null,
    car_owner_id bigint not null,
    constraint fk_registration_car foreign key(car_id)
    references tbl_car(id),
    constraint fk_registration_car_owner foreign key(car_owner_id)
    references tbl_car_owner(id));


/*
    요구 사항
    커뮤니티 게시판을 만들고 싶어요.
    게시판에는 게시글 제목과 게시글 내용, 작성한 시간, 작성자가 있고,
    게시글에는 댓글이 있어서 댓글 내용들이 나와야 해요.
    작성자는 회원(TBL_USER)정보를 그대로 사용해요.
    댓글에도 작성자가 필요해요.

    2.개념적 설계
        게시판         댓글          회원
        넘버           넘버          넘버
        제목           내용         이름
        내용
        시간
        작성자
        댓글


    3. 논리적 설계
        게시판         댓글          회원
        넘버  pK       넘버    pK      넘버pK
        제목           내용          이름
        내용           회원FK
        시간
        작성자 FK
        댓글 FK
    4. 물리적 설계

    tbl_board
    id bigint primary key
    title varchar(255)
    content varchar(255)
    time datetime
    writer_id bigint
    comment_id bigint
    constraint fk_board_comment key(comment_id)
    references tbl_car(id),
    constraint fk_board_user key(writer_id)
    references tbl_user(id)

    tbl_user
    id bigint primary key
    name varchar(255)

    tbl_comment
    id bigint primary key
    writer_id bigint
    constraint fk_comment_user key(writer_id)
    references tbl_user(id)
*/


create table tbl_board(
    id bigint primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    time datetime default(current_timestamp),
    user_id bigint,
    constraint fk_board_user foreign key(user_id)
    references tbl_user(id)
                      );

create table tbl_comment(
    id bigint primary key,
    user_id bigint,
    borad bigint,
    constraint fk_comment_borad foreign key(borad)
    references tbl_user(id),
    constraint fk_comment_user foreign key(user_id)
    references tbl_user(id)
);

create table tbl_user(
    id bigint primary key,
    user_id varchar(255) not null unique,
    password varchar(255) not null,
    name varchar(255)not null ,
    adress varchar(255)not null,
    mail varchar(255)
                     );



/*
    요구사항

    마이페이지에서 회원 프로필을 구현하고 싶습니다.
    회원당 프로필을 여러 개 설정할 수 있고,
    대표 이미지로 선택된 프로필만 화면에 보여주고 싶습니다.

    2. 개념적 모델링


    마이페이지

    회원

 */
create table my_page(
    id bigint primary key,
    user bigint,
    profile bigint,
    constraint fk_my_page_profile foreign key(profile)
    references tbl_profile(id),
    constraint fk_my_page_user foreign key(user)
    references tbl_user(id)
);

create table tbl_user(
    id bigint primary key,
    name varchar(255),
    profile bigint,
    constraint fk_user_profile foreign key(profile)
    references tbl_profile(id)
);

create table tbl_profile(
    id bigint primary key,
    file_path varchar(255) default '/upload',
    file_name varchar(255),
    is_main varchar(255) default 'ELSE',
    user bigint,
    constraint tbl_profile_user foreign key(user)
    references tbl_profile(id)
);

/*
    요구사항

    학사 관리 시스템에 학생과 교수, 과목을 관리합니다.
    학생은 학번, 이름, 전공 학년이 필요하고
    교수는 교수 번호, 이름, 전공, 직위가 필요합니다.
    과목은 고유한 과목 번호와 과목명, 학점이 필요합니다.
    학생은 여러 과목을 수강할 수 있으며,
    교수는 여러 과목을 강의할 수 있습니다.
    학생이 수강한 과목은 성적이 모두 기록됩니다.

    2. 개념적 설계

    학생      교수          과목               성적                강의
    넘버      넘버          넘버               넘버                넘버
    학번      교수고유번호    고유번호            학생넘버             교슈넘버
    이름      이름          과목명              과목넘버             과목넘버
    전공      전공          학점
    학년      직위
    과목넘버    과목넘버

    3
    학생      교수                과목               성적                강의
    넘버 PK   넘버PK              넘버PK              넘버PK              넘버PK
    학번NN      교수고유번호NN     고유번호 NN           학생넘버 KF          교슈넘버KF
    이름NN      이름NN            과목명  NN            과목넘버KF         과목넘버KF
    전공NN      전공NN              학점 d =0
    학년NN      직위NN
    과목넘버FK    과목넘버FK

    4.
    tbl_student
    id bigint primary key
    person_id int not null unique
    name varchar(255) not null
    major varchar(255) not null
    grade int default 1
    subject bigint not null
    constraint fk_student_subject foreign key(subject)
    references tbl_profile(id)

    tbl_professor
    id bigint primary key
    professor int not null unique
    name varchar(255) not null
    major varchar(255) not null
    position varchar(255) not null
    subject bigint not null
    constraint fk_professor_subject foreign key(subject)
    references tbl_profile(id)

    tbl_subject
    id bigint primary key
    subject_id int not null unique
    name varchar(255) not null
    credit int default 0

    tbl_record
    id bigint primary key
    student bigint not null
    professor bigint not null
    constraint fk_record_student foreign key(student)
    references tbl_student(id)
    constraint fk_record_professor foreign key(subject)
    references tbl_professor(id)

    */
create table tbl_student(
    id bigint auto_increment primary key,
    person_id int not null unique,
    name varchar(255) not null,
    major varchar(255) not null,
    grade int default 1
 );

create table tbl_professor(
    id bigint primary key,
    professor int not null unique,
    name varchar(255) not null,
    major varchar(255) not null,
    position varchar(255) not null);


create table tbl_subject(
    id bigint primary key,
    subject_id int not null unique,
    credit int default 0);


create table tbl_record(
    id bigint primary key,
    grade varchar(255),
    status varchar(255),
    student bigint not null,
    subject bigint not null,
    professor bigint not null,
    constraint fk_record_student foreign key(student)
    references tbl_student(id),
    constraint fk_record_subject foreign key(subject)
    references tbl_subject(id),
    constraint fk_record_student foreign key(student)
    references tbl_student(id),
    constraint fk_record_professor foreign key(professor)
    references tbl_professor(id),
    constraint check_status check (status in('수강중', '수강완료')));

create table tbl_lecture(
    id bigint primary key,
    professor bigint not null,
    subject bigint not null,
    constraint fk_lecture_professor foreign key(professor)
    references tbl_professor(id),
    constraint fk_lecture_subject foreign key(subject)
    references tbl_subject(id));


/*
    요구사항

    대카테고리, 소카테고리가 필요해요.

    2. 개념적 설계

        대카테고리       소카테고리
        넘버            넘버
        타이틀          타이틀
                        내용
                        대카테고리


    3. 논리적 설계

        대카테고리      소카테고리
        넘버 PK           넘버PK
        타이틀NN,u        타이틀NN,u
                         내용  NN
                        대 카테고리 FK

    4. 물리적 설계

       tbl1_first_category
    id bigint not null
    second_category bigint not null


    tbl1_second-category
    id bigint not null
    title varchar(255) not null unique
    content varchar(255)
    first_category bigint not null
    constraint kf_second_category_first_category foreign key(first_category)
    references tbl1_first_category(id)
*/

create table tbl1_first_category(
    id bigint primary key,
    title varchar(255) not null unique
                               );

create table tbl1_second_category(
    id bigint primary key,
    title varchar(255) not null unique,
    content varchar(255),
    first_category bigint not null,
    constraint kf_second_category_first_category foreign key(first_category)
    references tbl1_first_category(id));


/*
    요구 사항

    회의실 예약 서비스를 제작하고 싶습니다.
    회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
    회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.

    2. 개념적 설계

    회원          사무실          사용하기
        회원          사무실         회의실        사용하기      사용시간
        넘버         넘버           넘버            넘버          넘버
        이름         회의실넘버    회의실이름       회원정보       시작시간
        등급                     이용시간          회의실        끝시간
        핸드폰                    사무실넘버                    회의실넘버

    3. 논리적 설계
        회원          사무실         회의실           사용하기         사용시간
        넘버 PK       넘버PK        넘버 PK           넘버PK           넘버PK
        이름 NN       회의실넘버 NN  회의실이름 NN      회원정보NN        시작시간 NN
        등급 NN                    사무실넘버 KF       회의실 KF         끝시간 NN
        핸드폰 NN                                    회의실넘버KF


    4. 물리적 설계
    tbl2_user
    id bigint primary key
    name varchar(255) not null
    rating varchar(255) not null
    phone varchar(255) not null
    birth date
    address varchar(255) not null
    email varchar(255) not null

    tbl2_office
    id bigint primary key
    name varchar(255) not null
    address varchar(255) not null

    tbl2_meeting_room
    id bigint primary key
    office bigint not null
    constraint fk_meeting_office foreign key(office)
    references tbl2_office(id)

    tbl2_reservation
    id bigint primary key
    user_id bigint not null
    meeting_room bigint not null
    constraint fk_reservation_user foreign key(user_id)
    references tbl2_user(id)
    constraint fk_reservation_meeting_room foreign key(meeting_room)
    references tbl2_meeting_room(id)

    tbl2_part_time
    id bigint primary key
    start_date date
    end_date date
    meeting_room bigint
    constraint fk_part_time_meeting_room foreign key(meeting_room)
    references tbl2_meeting_room(id)


*/
create table tbl2_user(
    id varchar(255) primary key,
    name varchar(255) not null,
    rating varchar(255) default  '기본',
    constraint check_rating check (rating in('기본','중간')),
    phone varchar(255) not null,
    birth date,
    address varchar(255) not null,
    email varchar(255) not null
                      );

create table tbl2_office(
    id bigint primary key,
    name varchar(255) not null,
    address varchar(255) not null
                        );

create table tbl2_meeting_room(
    id bigint primary key,
    office bigint not null,
    constraint fk_meeting_office foreign key(office)
    references tbl2_office(id));

create table tbl2_reservation(
    id bigint primary key,
    time time not null ,
    created_date datetime default (current_timestamp),
    user_id varchar(255) not null,
    meeting_room bigint not null,
    constraint fk_reservation_user foreign key(user_id)
    references tbl2_user(id),
    constraint fk_reservation_meeting_room foreign key(meeting_room)
    references tbl2_meeting_room(id));

create table tbl2_part_time(
    id bigint primary key,
    time time not null ,
    meeting_room bigint,
    constraint fk_part_time_meeting_room foreign key(meeting_room)
    references tbl2_meeting_room(id));

/*
    요구사항

    유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
    아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
    체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
    아이들은 여러 번 체험학습에 등록할 수 있어요.

    2. 개념적 설계
    아이들             학부모           체험학습           이벤트이미지     체험학습신청
    넘버             넘버              넘버              넘버            넘버
    이름             이름              제목              제목            체험학습
    나이             나이              내용                             아이들
    성별              주소              이벤트이미지
                      전화번호
                    성별

    3. 논리적 설계
    아이들             학부모                체험학습           이벤트이미지     체험학습신청
    넘버 PK            넘버 PK               넘버 PK            넘버PK         넘버  PK
    이름  NN            이름 NN             제목  NN          제목 NN,u       체험학습FK
    나이  NN default 0  나이  NN default 20 내용  NN           체험학습FK      아이들FK
    성별  NN            주소  NN
    학부모 FK            전화번호 NN
                       성별 NN

    4. 물리적 설계

    tbl3_child
    id bigint primary key
    name varchar(255) not null
    age int default 0
    gender varchar(255) not null
    parents bigint,
    constraint fk_child_parents foreign key(parents)
    references tbl3_parents(id)

    tbl3_parents
    id bigint primary key
    name varchar(255) not null
    age int default 20
    address varchar(255) not null
    phone varchar(255) not null
    gender varchar(255) not null

    tbl3_field_trip
    id bigint primary key
    title varchar(255) not null
    content varchar(255) not null


    tbl3_event_image
    id bigint primary key
    image_path varchar(255) default '/upload'
    image_name varchar(255) not null
    field_trip bigint not null
    constraint fk_event_image_field_trip foreign key(field_trip)
    references tbl3_field_trip(id)

    tbl3_apply_trip
    id bigint primary key
    field_trip bigint not null
    child bigint not null
    constraint fk_apply_trip_field_trip foreign key(field_trip)
    references tbl3_field_trip(id)
    constraint fk_apply_trip_child foreign key(child)
    references tbl3_field_trip(id)
*/

create table tbl3_child(
    id bigint primary key,
    name varchar(255) not null,
    age int default 1,
    gender varchar(255) not null,
    constraint check_gender check (gender in('남자', '여자','선택안함')),
    parents bigint,
    constraint fk_child_parents foreign key(parents)
    references tbl3_parents(id)
                       );

create table tbl3_parents(
    id bigint primary key,
    name varchar(255) not null,
    age int default 20,
    address varchar(255) not null,
    phone varchar(255) not null,
    gender varchar(255) not null,
    constraint check_gender check (gender in('남자', '여자','선택안함'))
                         );


create table tbl3_field_trip(
    id bigint primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    count tinyint default 0
                            );

create table tbl3_event_image(
    id bigint primary key,
    image_path varchar(255) not null ,
    image_name varchar(255) not null,
    field_trip bigint not null,
    constraint fk_event_image_field_trip foreign key(field_trip)
    references tbl3_field_trip(id)
                             );

create table tbl3_apply_trip(
    id bigint primary key,
    field_trip bigint not null,
    child bigint not null,
    constraint fk_apply_trip_field_trip foreign key(field_trip)
    references tbl3_field_trip(id),
    constraint fk_apply_trip_child foreign key(child)
    references tbl3_child(id));
/*

create table tbl_file
    슈퍼키
    id bigint primary key
    image_path varchar(255) not null ,
    image_name varchar(255) not null,


create table tbl3_event_image
    서브키
    id bigint primary key,
    field_trip bigint not null,
    constraint fk_event_image_field_trip foreign key(id)

    references tbl_file(id)
    constraint fk_event_image_field_trip foreign key(field_trip)
    references tbl3_field_trip(id)
                             );



*/

/*
    요구사항

    안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
    광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
    광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
    기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.

    2. 개념적 설계
         광고주(기업)          신청하기               광고
          넘버                 넘버                 넘버
         이름                  기업                 제목
         주소                  광고                 내용
          대표번호                                소카테고리
          기업종류

    ------------------------------------------------------------------
    대카테고리           중카테고리           소카테고리
    넘버PK                넘버PK               넘버PK
    제목                제목                   제목
                       대카테고리              내용
                                            중카테고리


    3. 논리적 설계
         광고주(기업)          신청하기            광고
          넘버 PK             넘버 PK            넘버 PK
         이름 NN              기업 FK           제목 NN
         주소  NN             광고  FK           내용 NN
          대표번호 NN                            소카테고리 FK
          기업종류 NN

    ------------------------------------------------------------------
    대카테고리           중카테고리           소카테고리
    넘버PK                넘버PK               넘버PK
    제목                제목                   제목
                       대카테고리              내용
                                            중카테고리



    4. 물리적 설계

    tbl4_company
    id bigint primary key
    name varchar(255) not null
    address varchar(255) not null
    main_phone varchar(255) not null
    company_type varchar(255) not null

    tbl4_request
    id bigint primary key
    company bigint not null
    advertisement bigint not null
    constraint fk_request_company(company)
    references tbl4_request_company(id))
    constraint fk_company_company_scale(advertisement)
    references tbl4_request_advertisement(id))

    tbl4_advertisement
    id bigint primary key
    title varchar(255) not null
    content varchar(255) not null
    category_3 bigint
    constraint fk_advertisement_category(category_3)
    references tbl4_category_3(id))

    tbl4_category_1
    id bigint primary key
    title varchar(255) not null


    tbl4_category_2
    id bigint primary key
    title varchar(255) not null
    category_1 bigint
    constraint fk_category_2_category_3(category_1)
    references tbl4_category_1(id))


    tbl4_category_3
    id bigint primary key
    title varchar(255) not null
    category_2 bigint
    constraint fk_category_2_category_3(category_2)
    references tbl4_category_2(id))

*/



create table tbl4_company(
    id bigint primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    main_phone varchar(255) not null,
    company_type varchar(255) not null
    );

create table tbl4_request(
    id bigint primary key,
    created_date datetime default (current_timestamp),
    updated_date datetime default (current_timestamp) on update (current_timestamp),
    company bigint not null,
    advertisement bigint not null,
    constraint fk_request_company foreign key(company)
    references tbl4_company(id),
    constraint fk_company_company_scale foreign key(advertisement)
    references tbl4_advertisement(id)
    );

create table tbl4_advertisement(
    id bigint primary key,
    title varchar(255) not null,
    content varchar(255) not null,
    category_3 bigint,
    constraint fk_advertisement_category foreign key(category_3)
    references tbl4_category_3(id));

create table tbl4_category_1(
    id bigint primary key,
    title varchar(255) not null
                            );

create table tbl4_category_2(
    id bigint primary key,
    title varchar(255) not null,
    category_1 bigint,
    constraint fk_category_2_category_3 foreign key(category_1)
    references tbl4_category_1(id)
    );

create table tbl4_category_3(
    id bigint primary key,
    title varchar(255) not null,
    category_2 bigint,
    constraint fk_category_3_category_2 foreign key(category_2)
    references tbl4_category_2(id));

/*
    요구사항

    음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다.
    음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
    당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.

    2. 개념적 설계
    당첨              움료         결합상품             배송                당첨자 정보
    번호              이름           당첨                결합상품               이름
    상품              가격            음료               당첨자 이름             주소
    당첨번호          당첨번호                             배송상태               전화번호

    3. 논리적 설계
    당첨              움료             결합상품                 배송                     당첨자 정보
    번호PK            번호 PK           번호 PK              번호 PK                번호PK
    상품 NN           가격 default 0    당첨 FK                당첨자 이름 FK           주소 NN
                      이름 NN           음료 FK               배송상태 NN            전화번호 NN
                                                           결합상품 FK                이름 NN


    4. 물리적 설계

    tbl5_product
    id bigint primary key
    name varchar(255) not null

    tbl5_drink
    id bigint primary key
    lotto_number varchar(255) not null
    name varchar(255) not null
    price int default 0

    tbl5_jackpot
    id bigint primary key
    product bigint not null
    drink bigint not null
    constraint fk_jackpot_product foreign key(product)
    references tbl5_product(id)
    constraint fk_jackpot_drink foreign key(drink)
    references tbl5_drink(id)

    tbl5_delivery
    id bigint primary key
    delivery_status varchar(255) default '배송 시작 전'
    customer bigint not null
    jackpot bigint not null
    constraint fk_delivery_jackpot foreign key(jackpot)
    references tbl5_jackpot(id)
    constraint fk_delivery_customer foreign key(customer)
    references tbl5_customer(id)

    tb5_customer
    id bigint primary key
    address varchar(255) not null
    phone varchar(255) not null
    name varchar(255) not null
    age int default 0

*/

create table tbl5_product(
    id bigint primary key,
    drink bigint not null,
    jackpot bigint,
    constraint fk_delivery_drink foreign key(drink)
    references tbl5_drink(id),
    constraint fk_delivery_jackpot foreign key(jackpot)
    references tbl5_jackpot(id)
                     );

create table tbl5_drink(
    id bigint primary key,
    name varchar(255) not null,
    price int default 0
                      );

create table tbl5_jackpot(
    id bigint primary key,
    gift varchar(255),
    lotto_number int not null
                         );


create table tbl5_delivery(
    id bigint primary key,
    delivery_status varchar(255) ,
    constraint check_delivery_status check (status in('상품준비중','배송중','배송완료')),
    customer bigint not null,
    product bigint not null,
    constraint fk_delivery_product foreign key(product)
    references tbl5_product(id),
    constraint fk_delivery_customer foreign key(customer)
    references tbl5_customer(id)
                         );


create table tbl5_customer(
    id bigint primary key,
    address varchar(255) not null,
    phone varchar(255) not null,
    name varchar(255) not null,
    age int default 0
                         );

/*
    요구사항



    이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
    기업의 정보는 기업 이름, 주소, 대표번호가 있고
    사용자 정보는 이름, 주소, 전화번호가 있습니다. 결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,
    상품의 정보도 필요합니다. 상품의 정보는 이름, 가격, 재고입니다.
    사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.


    2. 개념적 설계
    기업          사용자정보           상품           카드
    이름          이름               이름            카드번호
    주소          주소                가격           카드사
    대표번호       전화번호             재고
    ---------------------------------------------------
    결제                   결제카드 정보
    사용자정보               사용자정보
    기업정보                 카드정보
    상품정보
    결제카드정보


    3. 논리적 설계

    기업            사용자정보              상품           카드
    넘버pK          넘버pK                넘버pK            넘버pK
    이름 NN          이름 NN             이름 NN u          카드번호NN
    주소 NN          주소  NN            가격 d =0          카드사NN
    대표번호 NN       전화번호  NN         재고 d =1
    ---------------------------------------------------
    결제                     결제카드 정보
    사용자정보FK               사용자정보FK
    기업정보FK                 카드정보FK
    상품정보FK
    결제카드정보FK

    4. 물리적 설계

    tbl6_company
    id bigint primary key
    name varchar(255) not null
    address varchar(255) not null
    main_phone varchar(255) not null

    tbl6_user
    id bigint primary key
    name varchar(255) not null
    address varchar(255) not null
    phone varchar(255) not null

    tbl6_product
    id bigint primary key
    name varchar(255) not null unique
    price int default 0
    stock int default 1

    tbl6_card
    id bigint primary key
    card_number varchar(255) not null
    card_company varchar(255) not null


    tbl6_card_info
    id bigint primary key
    user bigint not null
    card bigint not null
    constraint fk_card_info_user(user)
    references tbl6_user(id)
    constraint fk_card_info_card(card)
    references tbl6_card(id)

    tbl6_purchase
    id bigint primary key
    user bigint not null
    product bigint not null
    company bigint not null
    card_info bigint not null
    constraint fk_card_info_user(user)
    references tbl6_user(id)
    constraint fk_card_info_user(product)
    references tbl6_product(id)
    constraint fk_card_info_user(company)
    references tbl6_company(id)
    constraint fk_card_info_user(card_info)
    references tbl6_card_info(id)

 */



create table tbl6_company(
    id bigint primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    main_phone varchar(255) not null
                         );

create table tbl6_user(
    id bigint primary key,
    name varchar(255) not null,
    address varchar(255) not null,
    phone varchar(255) not null
                      );


create table tbl6_product(
    id bigint primary key,
    name varchar(255) not null unique,
    price int default 0,
    stock int default 1,
    company bigint not null,
    constraint fk_product_company foreign key(company)
                         references tbl6_company(id)
                         );


create table tbl6_card(
    id bigint primary key,
    card_number varchar(255) not null unique ,
    card_company varchar(255) not null,
    user bigint not null,
    constraint fk_card_user foreign key(user)
    references tbl6_user(id)
                      );


create table tbl6_card_info(
    id bigint primary key,
    user bigint not null,
    card bigint not null,
    constraint fk_card_info_user foreign key(user)
    references tbl6_user(id),
    constraint fk_card_info_card foreign key(card)
    references tbl6_card(id));

create table tbl_sequence(
    id bigint auto_increment primary key ,
    sequence bigint default 0
);

create table tbl6_purchase(
    id bigint,
    created_date date default (current_date),
    primary key (id,created_date),
    user bigint not null,
    product bigint not null,
    company bigint not null,
    card_info bigint not null,
    constraint fk_purchase_user foreign key(user)
    references tbl6_user(id),
    constraint fk_purchase_product foreign key(product)
    references tbl6_product(id),
    constraint fk_purchase_company foreign key(company)
    references tbl6_company(id),
    constraint fk_purchase_card_info foreign key(card_info)
    references tbl6_card_info(id));















