Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235492-2-14543991027505279843
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
    1523235491; b=hFuvRMF2kEFgmFvxzfJeWyyP+BGxpq8qIEPYMnfjz9ICNFy1Ud
    jbieXAsp6jlUIp8Cyope5XA9dT2oZd5keME+120Ok5ec//Cdd9yGNfL47IU3XfZf
    phMZ3uYtdzl74RkQ/610p2TlYCNRBNaKreAOU0PCHxAsO7NjLisVwyIrC4eM6lMA
    alyE4Zh9rSl4jnRAfuh4gv3hFdGzQTIGeSxu78ultUQLZgixlO/+7zyPQZBJ5BWZ
    IflCIrYY83npC0QxG0dA4KePkuasMVb8uf/vMYoYEwKAx7Wl8+32QLdkcgt0Rh25
    Yim6kRmZ6+Pt+mDiKR0yUj3tjT4bGx+mYN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235491; bh=MWr4Uvk5cP
    tarwuYvgxlyy5BeEf+qFGWiaD/kyuimLk=; b=UDkPkcCTLh6WdHFlGsQEGDExO+
    N5HoepIFfhY361s5hMObY38YusBMpGUaopQv5Lo72v1ZL63YTSVR/WRCLVu3+1Dw
    PGZVdHTAmhOK5qDz40NCaqEz1LNB4t1P/AV2an9RkQo7BPTbnL4in7Cu2qEHOgWO
    agh3VvEiXsBv7cyPriroakPbT7TOMoBYReQCNtFagh+SmJbIkr5yWO45Q2JRGfQ3
    r3dJvHOib62T6KF1Wx4sX4OUDCVL3k3rTGkb/F5mZi9HnFQcJRb/sDBHjKRgLvul
    bHWDt2zpnsUwgkcfSNq61JLfw/TBW332Stk3hFA/Cw90tcVibHfL+zIv79lQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ktDCjx2J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=ktDCjx2J x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ4B6E+mJ5uP+IlyyDoYcF1QdOXyliL5g5LO6bK2z2jAebro0ZGKmUXilx3LyZ5N16gYgD2pMsi/5UlQNqJV0uSkP4DVtZh8VZ2qSnyqMVsk09FIWYmz
    CqO7vmFB7qYnt03WVL5lBlrvJ6RHsf76qhakZbgRWSnPjK2hPkf+0QRmLUpsBib2Qfo17FZYFASgZu3F0LumLXcqOPXVexvN2xGtM8lsvuP4gZHAt7vZuzec
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=uP1ucDPQAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8
    a=-ITEmu96tX6iv3YGRBYA:9 a=wPNLvfGTeEIA:10 a=X3ieE3onHXUA:10
    a=9a9ggB8z3XFZH39hjkD6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932463AbeDIAkE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:40:04 -0400
Received: from mail-bn3nam01on0094.outbound.protection.outlook.com ([104.47.33.94]:21055
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933230AbeDIAjt (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:49 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Brian Norris <computersforpeace@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 026/101] mtd: handle partitioning on devices
 with 0 erasesize
Thread-Topic: [PATCH AUTOSEL for 3.18 026/101] mtd: handle partitioning on
 devices with 0 erasesize
Thread-Index: AQHTz5qtDJkQLV1e7Umshm9nDCCNjw==
Date: Mon, 9 Apr 2018 00:35:36 +0000
Message-ID: <20180409003505.164715-26-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0966;7:9zl3D/ONy9Rax2bjV7xvlvtAj07GRsPPWhECuIU4uDAYv4f5KBCP9o00ovZ4VBJ/XJIYPmSDURkrN12SDDxtp23HKRLS1pnEa/HowEuA+ylCipGsJUkYKl73qMfdTuG2jk1s6zlytLj/EznUWhUGtiS6PuQHgvoq71P6E2Olj1+CBuqnAskeXwELw8RLuS8e0bP1TEyT7LcNnON//DsA+CILB5dqnwAuiYHenSt8NayBXG80OG+1KrrYfOBswdbU;20:Xu1u57X33ZCdZMMA4w7RIbLoj6Dsd5Qr2a9OthkYJcCZcGP56A/bASI2g7QahPF3nlgQS6Cg2j8m7nO+NZNNimZn50bdEgEEX+0hzRuWrOXLqBZ17E1HqUn+wV5Fxt3pTb1xa4zQzNHBWc7LIaXvPgGT6rSo9uu1fm8apEr2y6Q=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa7b1e7d-0209-491f-90c9-08d59db2623e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0966;
x-ms-traffictypediagnostic: DM5PR2101MB0966:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB096631DD4C0A795607A312BDFBBF0@DM5PR2101MB0966.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(58145275503218);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0966;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0966;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(376002)(346002)(39860400002)(189003)(199004)(5660300001)(26005)(6116002)(305945005)(3846002)(2616005)(68736007)(72206003)(86612001)(476003)(446003)(36756003)(66066001)(2501003)(99286004)(86362001)(478600001)(11346002)(7736002)(105586002)(3280700002)(97736004)(14454004)(110136005)(2906002)(54906003)(4326008)(3660700001)(6486002)(8936002)(486006)(22452003)(10290500003)(6506007)(81166006)(6436002)(316002)(6512007)(59450400001)(6666003)(2900100001)(186003)(76176011)(8676002)(10090500001)(39060400002)(107886003)(5250100002)(81156014)(1076002)(25786009)(106356001)(53936002)(102836004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0966;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: yFqzwKiv5YA0WcH+4Q0UrEIj1+gqWIYVWSTalDYDxuLFWhVsnI8muxRlpiRkFu62kkDrRSYQpTyjujqTuuky+kJmr4mwqwUaYpcOKTZaTECxMX2mvRW6xbvcNaeNrBhxrX7EgzyWRz2liHvbnxsPG39ynBJb8CA8NDKChQ2DYvdOBgQbKxYjvZRKwdF92Bivgpp/efUABN089nPw/lys6fEtm5KH2xnMB42Hmi4mVZmwWiKuHxXOsyLUJsnFQ8bWQjtaxCEBCWpjYUPzSYkTZlb6zrXbwLeh+CoKr2axRQXjHrpBn8WGqfdA6LhDBJI5NaFJf8gA0p89LSuRHNae5UfgmhCjp1ESh8lIa590LgL1X4ZMdbqBDydUKGw9pam/QvX22o3xNo1hj7ZqXKk+O+38QHeYBHaXXCc5lJurGvM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7b1e7d-0209-491f-90c9-08d59db2623e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:36.0485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0966
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

[ Upstream commit 1eeef2d7483a7e3f8d2dd2a5b9939b3b814dc549 ]

erasesize is meaningful for flash devices but for SRAM there is no
concept of an erase block so erasesize is set to 0. When partitioning
these devices instead of ensuring partitions fall on erasesize
boundaries we ensure they fall on writesize boundaries.

Helped-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mtd/mtdpart.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index a3e3a7d074d5..48806da082b2 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -352,8 +352,12 @@ static struct mtd_part *allocate_partition(struct mtd_=
info *master,
 			const struct mtd_partition *part, int partno,
 			uint64_t cur_offset)
 {
+	int wr_alignment =3D (master->flags & MTD_NO_ERASE) ? master->writesize:
+							    master->erasesize;
 	struct mtd_part *slave;
+	u32 remainder;
 	char *name;
+	u64 tmp;
=20
 	/* allocate the partition structure */
 	slave =3D kzalloc(sizeof(*slave), GFP_KERNEL);
@@ -442,10 +446,11 @@ static struct mtd_part *allocate_partition(struct mtd=
_info *master,
 	if (slave->offset =3D=3D MTDPART_OFS_APPEND)
 		slave->offset =3D cur_offset;
 	if (slave->offset =3D=3D MTDPART_OFS_NXTBLK) {
+		tmp =3D cur_offset;
 		slave->offset =3D cur_offset;
-		if (mtd_mod_by_eb(cur_offset, master) !=3D 0) {
-			/* Round up to next erasesize */
-			slave->offset =3D (mtd_div_by_eb(cur_offset, master) + 1) * master->era=
sesize;
+		remainder =3D do_div(tmp, wr_alignment);
+		if (remainder) {
+			slave->offset +=3D wr_alignment - remainder;
 			printk(KERN_NOTICE "Moving partition %d: "
 			       "0x%012llx -> 0x%012llx\n", partno,
 			       (unsigned long long)cur_offset, (unsigned long long)slave->offse=
t);
@@ -510,19 +515,22 @@ static struct mtd_part *allocate_partition(struct mtd=
_info *master,
 		slave->mtd.erasesize =3D master->erasesize;
 	}
=20
-	if ((slave->mtd.flags & MTD_WRITEABLE) &&
-	    mtd_mod_by_eb(slave->offset, &slave->mtd)) {
+	tmp =3D slave->offset;
+	remainder =3D do_div(tmp, wr_alignment);
+	if ((slave->mtd.flags & MTD_WRITEABLE) && remainder) {
 		/* Doesn't start on a boundary of major erase size */
 		/* FIXME: Let it be writable if it is on a boundary of
 		 * _minor_ erase size though */
 		slave->mtd.flags &=3D ~MTD_WRITEABLE;
-		printk(KERN_WARNING"mtd: partition \"%s\" doesn't start on an erase bloc=
k boundary -- force read-only\n",
+		printk(KERN_WARNING"mtd: partition \"%s\" doesn't start on an erase/writ=
e block boundary -- force read-only\n",
 			part->name);
 	}
-	if ((slave->mtd.flags & MTD_WRITEABLE) &&
-	    mtd_mod_by_eb(slave->mtd.size, &slave->mtd)) {
+
+	tmp =3D slave->mtd.size;
+	remainder =3D do_div(tmp, wr_alignment);
+	if ((slave->mtd.flags & MTD_WRITEABLE) && remainder) {
 		slave->mtd.flags &=3D ~MTD_WRITEABLE;
-		printk(KERN_WARNING"mtd: partition \"%s\" doesn't end on an erase block =
-- force read-only\n",
+		printk(KERN_WARNING"mtd: partition \"%s\" doesn't end on an erase/write =
block -- force read-only\n",
 			part->name);
 	}
=20
--=20
2.15.1
