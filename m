Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8593AC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0D720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="PoYjnMpR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0D720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeLEIAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:00:45 -0500
Received: from mail-eopbgr1400111.outbound.protection.outlook.com ([40.107.140.111]:1472
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbeLEIAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jfan7lqTaUqW7Q1Mk9BUDDexVHeVwj5EuhlAppo6yVk=;
 b=PoYjnMpRvcHhC24j3vnSKpT+dUNMZaapWeVDi/+Ry7oiXq98qOUpA0GahISucywxMV5xnPjJ/K37NXAQHF6FEc5aEmPmfh8kCBQuHVpUp+5AaghTIwg6wy/JOauh/4uiQaLrdyWTybOvLZ3byH0bd2iKJ+s322PM0w7aH3m/jGI=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2254.jpnprd01.prod.outlook.com (52.133.179.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 08:00:37 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:00:36 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>
CC:     "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/13] sh: sh3: convert to SPDX identifiers
Thread-Topic: [PATCH 06/13] sh: sh3: convert to SPDX identifiers
Thread-Index: AQHUjHCbmlXZCjOJvUG/p/RamPszkA==
Date:   Wed, 5 Dec 2018 08:00:36 +0000
Message-ID: <87bm60csyl.wl-kuninori.morimoto.gx@renesas.com>
References: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KAWPR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:402:c::31) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2254;20:CwtzwPfIi8AEny7A8qRFelgkwIeov3PsjL1fJZQlsn85f/zBTRbzVS0ssjAVm/5Ywg0cbonHqjntIPKoq4i/ypg3nZ8ch2sKTMLg96Pkvp2IOPHKswTWRw0rUifssErx2cAEeLFxsE8Dy84+vHhw0kdemimx+MCzmBmdarFYPhc=
x-ms-office365-filtering-correlation-id: 55446c54-3ea1-434a-158b-08d65a87bd7f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2254;
x-ms-traffictypediagnostic: TYAPR01MB2254:
x-microsoft-antispam-prvs: <TYAPR01MB2254FB0997514E33AD95630AD4A80@TYAPR01MB2254.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2254;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2254;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(53936002)(6436002)(6512007)(7736002)(305945005)(71190400001)(316002)(54906003)(110136005)(71200400001)(14454004)(99286004)(4744004)(86362001)(575784001)(2906002)(68736007)(5660300001)(97736004)(66066001)(8936002)(26005)(106356001)(6506007)(386003)(105586002)(6116002)(186003)(25786009)(256004)(52116002)(3846002)(8676002)(486006)(476003)(4326008)(478600001)(2616005)(446003)(11346002)(36756003)(102836004)(81156014)(76176011)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2254;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fpP+REDZG2hLxFJLLFXT7kEMy2YCJq5rty7l5U6zz02rBu8XIXvBa/CeZI1PW5I+2U3XMSVTMG6lu6qNyZ89Vvcy35GD2u5z+j/pQxOkrdRjumCtXwd4h41kDmiS+HC4i6fkiyN+fCbfbw+y3eOhelUH60toG4ITH/Wdr2NsgYAAY23NDo68E7YQEtWbO+V8Tkr0plCYEq8ipIPwr6o4And14UHB2nksIZaE7HpZoBJSpw0tKqKaBm4Kvj60BH1qqPdQzoI8HH3YTVSzd5vUL8A4ShYiuusSacbXjQAjd/wBI+EvnCH+//2no6s5Py4zONIA+WQXR4jfFp3zIGFZac+SsWvT80AEOOGnqkydfcE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5CBA493CDFBBB649B3841F62796F5480@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55446c54-3ea1-434a-158b-08d65a87bd7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:00:36.7952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2254
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/kernel/cpu/sh3/clock-sh3.c     | 5 +----
 arch/sh/kernel/cpu/sh3/clock-sh7705.c  | 5 +----
 arch/sh/kernel/cpu/sh3/clock-sh7706.c  | 5 +----
 arch/sh/kernel/cpu/sh3/clock-sh7709.c  | 5 +----
 arch/sh/kernel/cpu/sh3/clock-sh7710.c  | 5 +----
 arch/sh/kernel/cpu/sh3/clock-sh7712.c  | 5 +----
 arch/sh/kernel/cpu/sh3/entry.S         | 7 ++-----
 arch/sh/kernel/cpu/sh3/ex.S            | 9 +++------
 arch/sh/kernel/cpu/sh3/pinmux-sh7720.c | 5 +----
 arch/sh/kernel/cpu/sh3/probe.c         | 5 +----
 arch/sh/kernel/cpu/sh3/setup-sh3.c     | 5 +----
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  | 5 +----
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  | 5 +----
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  | 5 +----
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  | 5 +----
 arch/sh/kernel/cpu/sh3/swsusp.S        | 7 ++-----
 16 files changed, 20 insertions(+), 68 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh3/clock-sh3.c b/arch/sh/kernel/cpu/sh3/cl=
ock-sh3.c
index 90faa44..d776572 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh3.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/clock-sh3.c
  *
@@ -11,10 +12,6 @@
  *  Copyright (C) 2000  Philipp Rumpf <prumpf@tux.org>
  *  Copyright (C) 2002, 2003, 2004  Paul Mundt
  *  Copyright (C) 2002  M. R. Brown  <mrbrown@linux-sh.org>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7705.c b/arch/sh/kernel/cpu/sh3=
/clock-sh7705.c
index a8da4a9..4947114 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7705.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/clock-sh7705.c
  *
@@ -11,10 +12,6 @@
  *  Copyright (C) 2000  Philipp Rumpf <prumpf@tux.org>
  *  Copyright (C) 2002, 2003, 2004  Paul Mundt
  *  Copyright (C) 2002  M. R. Brown  <mrbrown@linux-sh.org>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7706.c b/arch/sh/kernel/cpu/sh3=
/clock-sh7706.c
index a4088e5..1785502 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7706.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7706.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/clock-sh7706.c
  *
@@ -7,10 +8,6 @@
  *
  * Based on arch/sh/kernel/cpu/sh3/clock-sh7709.c
  *  Copyright (C) 2005  Andriy Skulysh
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7709.c b/arch/sh/kernel/cpu/sh3=
/clock-sh7709.c
index 54a6d4b..54701bb 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7709.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7709.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/clock-sh7709.c
  *
@@ -7,10 +8,6 @@
  *
  * Based on arch/sh/kernel/cpu/sh3/clock-sh7705.c
  *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7710.c b/arch/sh/kernel/cpu/sh3=
/clock-sh7710.c
index ce601b2..e60d0bc 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7710.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/clock-sh7710.c
  *
@@ -11,10 +12,6 @@
  *  Copyright (C) 2000  Philipp Rumpf <prumpf@tux.org>
  *  Copyright (C) 2002, 2003, 2004  Paul Mundt
  *  Copyright (C) 2002  M. R. Brown  <mrbrown@linux-sh.org>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh3/clock-sh7712.c b/arch/sh/kernel/cpu/sh3=
/clock-sh7712.c
index 21438a9..5af553f 100644
--- a/arch/sh/kernel/cpu/sh3/clock-sh7712.c
+++ b/arch/sh/kernel/cpu/sh3/clock-sh7712.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/clock-sh7712.c
  *
@@ -7,10 +8,6 @@
  *
  * Based on arch/sh/kernel/cpu/sh3/clock-sh3.c
  *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh3/entry.S b/arch/sh/kernel/cpu/sh3/entry.=
S
index 262db6e..25eb809 100644
--- a/arch/sh/kernel/cpu/sh3/entry.S
+++ b/arch/sh/kernel/cpu/sh3/entry.S
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh3/entry.S
  *
  *  Copyright (C) 1999, 2000, 2002  Niibe Yutaka
  *  Copyright (C) 2003 - 2012  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/sys.h>
 #include <linux/errno.h>
diff --git a/arch/sh/kernel/cpu/sh3/ex.S b/arch/sh/kernel/cpu/sh3/ex.S
index 99b4d02..ee2113f 100644
--- a/arch/sh/kernel/cpu/sh3/ex.S
+++ b/arch/sh/kernel/cpu/sh3/ex.S
@@ -1,14 +1,11 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  *  arch/sh/kernel/cpu/sh3/ex.S
  *
  *  The SH-3 and SH-4 exception vector table.
-
+ *
  *  Copyright (C) 1999, 2000, 2002  Niibe Yutaka
  *  Copyright (C) 2003 - 2008  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/linkage.h>
=20
diff --git a/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c b/arch/sh/kernel/cpu/sh=
3/pinmux-sh7720.c
index 26e90a6..34015e6 100644
--- a/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/pinmux-sh7720.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7720 Pinmux
  *
  *  Copyright (C) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/bug.h>
diff --git a/arch/sh/kernel/cpu/sh3/probe.c b/arch/sh/kernel/cpu/sh3/probe.=
c
index 426e1e1..5e7ad59 100644
--- a/arch/sh/kernel/cpu/sh3/probe.c
+++ b/arch/sh/kernel/cpu/sh3/probe.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh3/probe.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 1999, 2000  Niibe Yutaka
  * Copyright (C) 2002  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh3.c b/arch/sh/kernel/cpu/sh3/se=
tup-sh3.c
index 53be70b..8058c01 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh3.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh3.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Shared SH3 Setup code
  *
  *  Copyright (C) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7705.c b/arch/sh/kernel/cpu/sh3=
/setup-sh7705.c
index f6e392e..e19d1ce 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7705.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7705 Setup
  *
  *  Copyright (C) 2006 - 2009  Paul Mundt
  *  Copyright (C) 2007  Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh770x.c b/arch/sh/kernel/cpu/sh3=
/setup-sh770x.c
index 59a8861..5c5144b 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh770x.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH3 Setup code for SH7706, SH7707, SH7708, SH7709
  *
@@ -7,10 +8,6 @@
  * Based on setup-sh7709.c
  *
  *  Copyright (C) 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7710.c b/arch/sh/kernel/cpu/sh3=
/setup-sh7710.c
index ea52410..4776e24 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7710.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH3 Setup code for SH7710, SH7712
  *
  *  Copyright (C) 2006 - 2009  Paul Mundt
  *  Copyright (C) 2007  Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh3/setup-sh7720.c b/arch/sh/kernel/cpu/sh3=
/setup-sh7720.c
index bf34b4e..1d4c34e 100644
--- a/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ b/arch/sh/kernel/cpu/sh3/setup-sh7720.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Setup code for SH7720, SH7721.
  *
@@ -8,10 +9,6 @@
  *
  *  Copyright (C) 2006  Paul Mundt
  *  Copyright (C) 2006  Jamie Lenehan
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh3/swsusp.S b/arch/sh/kernel/cpu/sh3/swsus=
p.S
index 0114542..dc111c4 100644
--- a/arch/sh/kernel/cpu/sh3/swsusp.S
+++ b/arch/sh/kernel/cpu/sh3/swsusp.S
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh3/swsusp.S
  *
  * Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/sys.h>
 #include <linux/errno.h>
--=20
2.7.4

