Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4+E3rpT2aJszXc5r4MX1exHxQc1+YKUPWMYb3s9HBQOi4rIuwEmpZ+/doMxWymfN9ekaSne
ARC-Seal: i=1; a=rsa-sha256; t=1523233157; cv=none;
        d=google.com; s=arc-20160816;
        b=Xnm9rLyP5QsELYsj8LjFe+NT0xPSF4Zchby6gLmqvDU/16G/A7mXkcQhc9G14L9zKm
         y+JxXhktMr+bkys/WGU4Cu9FW+HNgTxyucSDtvK9T93xztOWC4/LXHaCSNCvhbnSPMPU
         o0E4r/Kva56QToEUveUD3bYGEn507J1xLh77TfJWkzVz8I3pV/8mcD01u5Be+zW2dPLD
         aw1KYB7Q8UEI+xv1Esv1w2Xcge8cDc9bpdqZxf72Qggzu4iczpNo4gOmnGE45fpHBYlQ
         HBNeWX5P7Lc1cfKBarneBilhzQ+HXTFrhj6dTrZbbQFy1FCuOkn61aFL/JeH1WchOGtq
         ev0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=f2vjgcbUyTHDdOMSMdh3QXoSwSUWuqoimVhm2PS+2NQ=;
        b=UY71CJwK32GmWtIzGtiLOSD4puu8dPt5JtZ4M6FpQdcyMMRCdV/AzRzh9kY5paYpXr
         LyS1LaUOnPFC/sresShDyKtvJbrCxDQvkatxyz+XaEUv4DjzuriDk6uNE+Fsm6886w1Z
         6GrehURGIGlo0SUNGyyBVvgm62p5OM6goevhEeZr+PrTvBcCwZSVzHxL7on8O6UmtgTU
         XT4IfWmJ1sEahCHdI3zHe9M+2zVRFKrBRZc+/GFzIZbFg8Iy1BhbiHe+YSvyAz4QT4qe
         DZzmQTH+03hy7Nv3Bbz4AM/UGc9/elCiw22N58Y9ZS6bpWwQdbFpe8LxoOIYVyptezr2
         GnGg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=YD1c5hQH;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.131 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=YD1c5hQH;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.131 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Corey Minyard
	<minyard@acm.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha
 Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 093/189] device property: Define type of
 PROPERTY_ENRTY_*() macros
Thread-Topic: [PATCH AUTOSEL for 4.15 093/189] device property: Define type of
 PROPERTY_ENRTY_*() macros
Thread-Index: AQHTz5g3ihNIvEFGuUeajcY+VqmGzQ==
Date: Mon, 9 Apr 2018 00:17:59 +0000
Message-ID: <20180409001637.162453-93-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1063;7:r9plUxNbL6U4ODJwoVbj7e0Kx97lTw77kZTeA4wQIC9F2ski9/Z896NwcTD3V42djerQrvssPdhWWkAIxU0bKly1zjGe3qcoMXLyziaMlbhejtAk2nQXGuqoLRmSJm9+p9fpQX0oWpFpGyUWeAok2jRVPsxXW4xl2LAKgdBCzLLPcx69HuZcZ1JDNLhlkxzP8RvFNk642/GgSjlZg8SjhALBpI/CYhnvPHpcYiewiNY1zrM2T/NjN9VavF/HGYpl;20:3FFbqVqdUXDmhCo+i80UEAkT6DTg7ZPpU3a7gv33eQdWV01hjNtAoE5d1Pb2DRK2z1f12y/G/FbPCCYXv0BTaqpnn/mhHh33tQBEXge3g5wZKm70LrUOj62E4up/yiNWCPXOBDU90z2Y5VuqwgF38VGTpuCdZqlJ61h3ZN+YJSQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97ba5598-443f-42bc-f66f-08d59daf8746
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1063;
x-ms-traffictypediagnostic: DM5PR2101MB1063:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1063A9020F86007432BD659CFBBF0@DM5PR2101MB1063.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(213716511872227)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1063;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1063;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(396003)(366004)(189003)(199004)(2900100001)(6436002)(7736002)(10090500001)(102836004)(3660700001)(6506007)(76176011)(305945005)(4326008)(5250100002)(97736004)(26005)(25786009)(6512007)(2906002)(81166006)(106356001)(107886003)(68736007)(14454004)(86612001)(66066001)(10290500003)(6666003)(5660300001)(81156014)(478600001)(476003)(486006)(6486002)(72206003)(3280700002)(99286004)(105586002)(36756003)(1076002)(2616005)(11346002)(53936002)(446003)(8676002)(186003)(3846002)(54906003)(6116002)(2501003)(8936002)(316002)(110136005)(86362001)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1063;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: xvlmbXtC7yVSMZdjvT2NvV6bNt/6IeO6ctoKIP1pQ1tz4W/U2s1pQfyg5ANxyf5gD0j9KB8dqJgsnhA+n5xiP5/4dxP2Py93suB15R1PttgE2UTB26/gGX60pn7KOhe0OmFrhe0Y9P4INqRVeNHgNOP/P4cPrdu+irmdiMpjRV+aGmACHBwu56bunJk75LiOCmBCXMU3p1HlsdfIy9PILw3cVnPY9HqwecDamvhilfH0/22ff50XX9oFYnilgQ6/rVh6ME0vVQGIT9tb09CkbLSsM50hwgLctxJprft8VjAxJafTBJZJHi5kA4FMR2fYUz/4o5UIsZ1zkjmAXdnasAo8HbUvccQa5oYy+Nl8lrwuIgiwg/qaXy6Wut7LRDXXKY9htAuGkttfhcEK2KAvyfuhzzBXb2+CMbFXLJ+m3WI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ba5598-443f-42bc-f66f-08d59daf8746
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:59.3820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1063
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597225731447440120?=
X-GMAIL-MSGID: =?utf-8?q?1597225731447440120?=
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
index f6189a3ac63c..2e3a7c24659e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -206,7 +206,7 @@ struct property_entry {
  */
=20
 #define PROPERTY_ENTRY_INTEGER_ARRAY(_name_, _type_, _val_)	\
-{								\
+(struct property_entry) {					\
 	.name =3D _name_,						\
 	.length =3D ARRAY_SIZE(_val_) * sizeof(_type_),		\
 	.is_array =3D true,					\
@@ -224,7 +224,7 @@ struct property_entry {
 	PROPERTY_ENTRY_INTEGER_ARRAY(_name_, u64, _val_)
=20
 #define PROPERTY_ENTRY_STRING_ARRAY(_name_, _val_)		\
-{								\
+(struct property_entry) {					\
 	.name =3D _name_,						\
 	.length =3D ARRAY_SIZE(_val_) * sizeof(const char *),	\
 	.is_array =3D true,					\
@@ -233,7 +233,7 @@ struct property_entry {
 }
=20
 #define PROPERTY_ENTRY_INTEGER(_name_, _type_, _val_)	\
-{							\
+(struct property_entry) {				\
 	.name =3D _name_,					\
 	.length =3D sizeof(_type_),			\
 	.is_string =3D false,				\
@@ -250,7 +250,7 @@ struct property_entry {
 	PROPERTY_ENTRY_INTEGER(_name_, u64, _val_)
=20
 #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
-{							\
+(struct property_entry) {				\
 	.name =3D _name_,					\
 	.length =3D sizeof(_val_),			\
 	.is_string =3D true,				\
@@ -258,7 +258,7 @@ struct property_entry {
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
