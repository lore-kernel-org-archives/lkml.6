Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx49wZSMNfWHQFIu2StH2sLlSTN6xGFOK+3yJ4InEr6f45X450LMgkA1EFKyTBWylK1e8pwIK
ARC-Seal: i=1; a=rsa-sha256; t=1523234025; cv=none;
        d=google.com; s=arc-20160816;
        b=aXBdi78jCtXBoeiWSBv9k6+QjGCxhQQU2b7dEDSIC6Dtlgt+PoaC92t6Uou58Bjdum
         6o7aFQUjd0Sg9kmqvpHc3LwSlV2w5r+903T/3i4ovvSExC5tgPoCqFmDxWIm4XeKkaxl
         c89VmbljN+vtEL2Fpb4+bshy+hkpb7hWi+RnXmgnMaJeNYeAwWib30ffRnxGA4yJh7dU
         13tPfRDVTWXL1dknzw9lpODylQbLGAjVoQchJRF5qojoM98VkdHpHHeSkwalFx4KMHrn
         B6lFY5/1cIR1VI/JxmQpE+FMvUUSFBNS33nj01o7g7AZoKUNWXOa0Gd89tDw39nn8VpG
         H9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=yEDW0jrsfW7/cQmHpeL7KF6TqDwzm+xRiMF/fNxDGIQ=;
        b=jKA+7TCLcUd2ZfFq4zgoDR40Q6ac/QlZKSAvK/9kRXWDtZiTUR5kPGzESVFwEWwe6G
         BtjJdbWGq3Ug9ojWsfT8qM/PKhul75BqadgpJSnQJGiZSyxIOGY9jxYbhpnKZ2KNTXJu
         UY0ik4P1iGrq2gPEvTQiBQYqiqe+BbRl5OlhXOsOe97AwhnIapPPfpmQfJI0bc3q9n6l
         bQI0lcTsU5Lr2uo0oaxZ/rsMi/GYIpJKFjqFv8o5mQ9Boz2Qt7EcZcBAbYAgFRhHoKdM
         hGRxTc87IePPcraLnGZ/IskIoDv1Mz2C77oDGqZzDV+ZGEZnyOeC8VOPPzHoU+mP9Onn
         Wyaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=BWhw8NJG;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.105 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=BWhw8NJG;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.34.105 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Corey Minyard
	<minyard@acm.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha
 Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 245/293] device property: Define type of
 PROPERTY_ENRTY_*() macros
Thread-Topic: [PATCH AUTOSEL for 4.9 245/293] device property: Define type of
 PROPERTY_ENRTY_*() macros
Thread-Index: AQHTz5lYNAlSHOGbNkC96ywKEQC0LQ==
Date: Mon, 9 Apr 2018 00:26:04 +0000
Message-ID: <20180409002239.163177-245-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0998;7:Ohhg7oaF5z3NHC0ZASzDAMzsC4hc8+cCjFr3087St449hn4NrqnE6Sb73jyNffFB8lwvE4e/DOxQ//BEq4d9d9SPEHeE9IpQ8nnN9+anwru+46Sw1BBc1f146uju5F2ioSlXNUHdl1M4pGHXP5lWD26z6Dz7Uz9AJf2gGSoZfUSZJTQLzu3jqs1ZgzXGKKMnJD7LD0HUFZW4TKKOD3VHqHLlGL3OxaKpopKkpJ5wobXKkLmwUxKcIlXKmX5EMV7T;20:/hxXQV1aqtwuz+BAN2ftocH2oMCBNhqnDI/EqbyOYeEnbIzlwRCHhy3sPoE6PvDL08onLEvNSiMJHgKdAnDbGd+w4skT5ocyFTwOB53LDEIyW+UT4A74f55SZMeWK1tElAJ5QQbaJXz5ouUMzPLrSIEzifiwHF+YYEgi3bze7is=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 764bd7de-e76a-4472-1599-08d59db18c62
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0998;
x-ms-traffictypediagnostic: DM5PR2101MB0998:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09981A87A8FD37A1C0601AC2FBBF0@DM5PR2101MB0998.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(213716511872227)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0998;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0998;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(376002)(396003)(366004)(39860400002)(189003)(199004)(25786009)(105586002)(14454004)(76176011)(68736007)(2906002)(316002)(97736004)(8676002)(86612001)(3660700001)(3280700002)(102836004)(6116002)(4326008)(8936002)(36756003)(22452003)(81166006)(81156014)(54906003)(6506007)(10090500001)(2501003)(6512007)(186003)(6666003)(3846002)(486006)(5660300001)(26005)(7736002)(5250100002)(305945005)(99286004)(2900100001)(110136005)(1076002)(6436002)(53936002)(106356001)(107886003)(72206003)(86362001)(476003)(446003)(66066001)(11346002)(478600001)(10290500003)(2616005)(6486002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0998;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 624ABOGul0zkqmD8inloM7Jh8cSJTR98+QYpPQ31398Vv39jyMuoYQieyM954iIWs5hd1Z3ZHRxVNoHMms/S60im0wK23HrUn9UHie9drTEYEp1SM2QhY2kTs02EfMWRH0+5+jSdNJpt6rZxXZlD6mTXZLvdQNFZl5YqOgZqZ583PnbPv/50eli034I+Gi7pIiwcM0I7WUdofB848Ddtl3d8DJn98WVOrYTASOob9m6B87WPsEKP21iC3uqWq5TDTzqL73UDN6ypKhziPrJEA3NL/XxEqSwzyp44rb6g6BmjOpYd8qm18Elz4XsqJ9ww3TuhzRSn/+hJhFvou2NeHwFBOVG2JUiH6RRYwpzFahlSQcwXn6j6BheXzGxTfwUjBMbUIUWsWunoDX+JP5g6+ht9ZRvZsOffToaKpRFdKQM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764bd7de-e76a-4472-1599-08d59db18c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:26:04.1599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0998
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597225731447440120?=
X-GMAIL-MSGID: =?utf-8?q?1597226641214399076?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit c505cbd45f6e9c539d57dd171d95ec7e5e9f9cd0 ]

Some of the drivers may use the macro at runtime flow, like

  struct property_entry p[10];
...
  p[index++] =3D PROPERTY_ENTRY_U8("u8 property", u8_data);

In that case and absence of the data type compiler fails the build:

drivers/char/ipmi/ipmi_dmi.c:79:29: error: Expected ; at end of statement
drivers/char/ipmi/ipmi_dmi.c:79:29: error: got {

Acked-by: Corey Minyard <cminyard@mvista.com>
Cc: Corey Minyard <minyard@acm.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 include/linux/property.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 338f9b76914b..459337fb44d0 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -187,7 +187,7 @@ struct property_entry {
  */
=20
 #define PROPERTY_ENTRY_INTEGER_ARRAY(_name_, _type_, _val_)	\
-{								\
+(struct property_entry) {					\
 	.name =3D _name_,						\
 	.length =3D ARRAY_SIZE(_val_) * sizeof(_type_),		\
 	.is_array =3D true,					\
@@ -205,7 +205,7 @@ struct property_entry {
 	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u64, _val_)
=20
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)		\
-{								\
+(struct property_entry) {					\
 	.name =3D _name_,						\
 	.length =3D ARRAY_SIZE(_val_) * sizeof(const char *),	\
 	.is_array =3D true,					\
@@ -214,7 +214,7 @@ struct property_entry {
 }
=20
 #define PROPERTY_ENTRY_INTEGER(_name_, _type_, _val_)	\
-{							\
+(struct property_entry) {				\
 	.name =3D _name_,					\
 	.length =3D sizeof(_type_),			\
 	.is_string =3D false,				\
@@ -231,7 +231,7 @@ struct property_entry {
 	PROPERTY_ENTRY_INTEGER(_name_, u64, _val_)
=20
 #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
-{							\
+(struct property_entry) {				\
 	.name =3D _name_,					\
 	.length =3D sizeof(_val_),			\
 	.is_string =3D true,				\
@@ -239,7 +239,7 @@ struct property_entry {
 }
=20
 #define PROPERTY_ENTRY_BOOL(_name_)		\
-{						\
+(struct property_entry) {			\
 	.name =3D _name_,				\
 }
=20
--=20
2.15.1
