Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3550853-1523233373-2-3245886976882066224
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523233373; b=YyG3tAa0xdIZAcnXjDvrg1mFvsG31ETZ+93xU/d5CGRfGrVG5H
    a59Y0hAcqiPZ5w/ouYYRRVZlL+JgthmkY7Cz2kC0IshiteF7/ffktqKCpoHflf9f
    IMnyBrtC9EiQiJwk7h2zObJiDxQoF3PO/ZFisSnePh1RzqAE9p3f7Jb+CLeS+aWj
    ekNst7E0APv3Y36tMHqDrqoNI0QTstVccoUseP3R3vu9JSxsThSPMozdQc+B7syL
    /cts8uwVPb7WSTtPZ0B5Zlf5meUNQ/kJzeKJCaeEvBbXczReeYLlKnIwQ+hyw9MX
    kfTq6P6FKzyesxhkpFSKi27clwCLvBMRFfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523233373; bh=BGZGKVLPX2
    ozJv971rgLYMF9s565z/nxvw5lRzjb+VE=; b=kpr2QwqbeV6IToWAxMCG16Sz5c
    J3tYiwRgJDtiqeLfE75Xmcklo9DJwTczmNtvxzTsomGFfjxNXFQ5mEbBemmVolG7
    HYtMzViPpnWs8ESZtD/p5P9GfjABs8rxkXzRbzNmVtOrcT1UP6CcU9wqDRtIDzf4
    njAg6bBaMu2lJR560Gid7AlzVbeF+CWh8BH45aJ4gZuQqY/MQU1y7fx14mVWt5wd
    bXlIuVrxoJIvkwpfL1MvI6f3aSd5cBIzTE2E+QTHl5SgYSNdfhnbbEbJpBkH5uyq
    YkVSph0dR7x2xLNLmsqiW9lje3GyJxTWmRSueH7hZBNz0RSlv0ix48MOXMxA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N+sTqj+t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=N+sTqj+t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfET4FqsE9HDVwndtu7I+ici21sJRkT67QpEruZNhpqmem0xn+NBWHHvzCUIoo1E7C95PRekNeXO8ptvdktDDbQVXc4i7r+ClJlYZOBNZEt/muzR9Cj+z
    MCO5QUXCmpbaFWtiejHbsQpEVR2OgQklnybB/UGPs12bWPC0N0fgTHZ/TgDih7erl+O1HIPs87cz0r6JmYY7uUuV10H/BjXvhCi+yXvT+KXkXEEEk40oAi52
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=CjxXgO3LAAAA:8 a=VwQbUJbxAAAA:8
    a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=AihKrKVWWoDczpLLqEoA:9
    a=wPNLvfGTeEIA:10 a=2JgSa4NbpEOStq-L5dxp:22 a=AjGcO6oz07-iQ99wixmX:22
    a=HkZW87K1Qel5hWWM3VKY:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754717AbeDIAWr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:22:47 -0400
Received: from mail-sn1nam01on0122.outbound.protection.outlook.com ([104.47.32.122]:20813
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754709AbeDIAWp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:22:45 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 027/161] tools lib traceevent: Fix
 get_field_str() for dynamic strings
Thread-Topic: [PATCH AUTOSEL for 4.14 027/161] tools lib traceevent: Fix
 get_field_str() for dynamic strings
Thread-Index: AQHTz5iBseTYaFK83EiS8Sj85X11Zg==
Date: Mon, 9 Apr 2018 00:20:04 +0000
Message-ID: <20180409001936.162706-27-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:a8bzHjgvH69zk2OOEHOfR6mAnNoWIIEGQUnbGvOpF8bewW/Ipc4FIv0icGvSZbLYF/kA5xTCvNopM73PgZhuDy+fHqYnQByNEqiHBlOWllJBxPtYg9oyaI0wZ+XaDGXsi+gCFAATXW+gPdTK8BRJFlwXIGOGI126CE7YAbKA+zxBU8kNmIcEIYqFWH2rO6zs4uro7ZSedWAHf2YK8OJOviJPlrPLdleyFqKVEh7r5oD1xF6G7GMWUaR9Fquj79pB;20:Ldq5Xni0gwj/+o6i+dsKM11Wj7HpVeGMtbvH4sNTV1msDS8WHv1D+jUz7fVoOwT7qEJWkdQpOjIDNevWn370K0xzpHfHfz/D71cI6nnRfic9sGWUOQPiaBVLeDGmZTLE3Z3eK8xknUJaBB6JvGn2PeIXtWRu9oZI/OFTb0Jpxzw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f3f9a87-0387-4ff3-9e4d-08d59db00212
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0966BE4FB79DA4B97585AEA1FBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(42068640409301)(201166117486090);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(39380400002)(396003)(366004)(199004)(189003)(6512007)(316002)(59450400001)(6436002)(186003)(6306002)(6666003)(2900100001)(966005)(8936002)(486006)(6486002)(6506007)(10290500003)(81166006)(22452003)(25786009)(1076002)(81156014)(53936002)(106356001)(10090500001)(5250100002)(107886003)(102836004)(76176011)(8676002)(66066001)(2501003)(446003)(476003)(36756003)(99286004)(575784001)(478600001)(86362001)(72206003)(2616005)(68736007)(5660300001)(305945005)(3846002)(6116002)(26005)(86612001)(14454004)(97736004)(3660700001)(4326008)(2906002)(110136005)(54906003)(3280700002)(105586002)(7736002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 0XJPHY7phJNVRy6+KRWkA/e+UceXFRgZ+Xz5Q565CrTHuSrUcxTJwQLlU0UXoWE7Sgs7jWb5hZLezrsrQiGUNIC/+I/BwAyrVCuijqFo0MIoeq87oBgI9S6emFnUwcfwrqD9YKZHjALF+WTTtnGYOj71mK9YTrZ5RG5LccjnvTcfM1uAAdLuPuWvD4pNKsje/mQYRYMiBeNM1EvldbKbWCUg8wU2yHXu5vscsCXI1oOJE38WESvdNTh8Y1iQXKLiZqOIFERDasKvVpLOWZK9FOG/hYOuXUo1/BxKV2mytvHTid7UUEL+AwdNeWGtlvm2+Ixr6MHTKuufbyFSXCul+ZARysmTZolAvW9QiGKP9XUIehYFFMUlOB5EPmm7mAsCnwfcIQlSfMhjASJUnajoYePLIh7BrbqoNfq8opiys7k=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3f9a87-0387-4ff3-9e4d-08d59db00212
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:04.2229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

[ Upstream commit d777f8de99b05d399c0e4e51cdce016f26bd971b ]

If a field is a dynamic string, get_field_str() returned just the
offset/size value and not the string. Have it parse the offset/size
correctly to return the actual string. Otherwise filtering fails when
trying to filter fields that are dynamic strings.

Reported-by: Gopanapalli Pradeep <prap_hai@yahoo.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20180112004823.146333275@goodmis.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/lib/traceevent/parse-filter.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/par=
se-filter.c
index 7c214ceb9386..5e10ba796a6f 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -1879,17 +1879,25 @@ static const char *get_field_str(struct filter_arg =
*arg, struct pevent_record *r
 	struct pevent *pevent;
 	unsigned long long addr;
 	const char *val =3D NULL;
+	unsigned int size;
 	char hex[64];
=20
 	/* If the field is not a string convert it */
 	if (arg->str.field->flags & FIELD_IS_STRING) {
 		val =3D record->data + arg->str.field->offset;
+		size =3D arg->str.field->size;
+
+		if (arg->str.field->flags & FIELD_IS_DYNAMIC) {
+			addr =3D *(unsigned int *)val;
+			val =3D record->data + (addr & 0xffff);
+			size =3D addr >> 16;
+		}
=20
 		/*
 		 * We need to copy the data since we can't be sure the field
 		 * is null terminated.
 		 */
-		if (*(val + arg->str.field->size - 1)) {
+		if (*(val + size - 1)) {
 			/* copy it */
 			memcpy(arg->str.buffer, val, arg->str.field->size);
 			/* the buffer is already NULL terminated */
--=20
2.15.1
