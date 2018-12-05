Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45C0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65ABF20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="SIz7vYhx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65ABF20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeLEIAy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:00:54 -0500
Received: from mail-eopbgr1400123.outbound.protection.outlook.com ([40.107.140.123]:45472
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727173AbeLEIAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKGKLQ4aG5GxaXXBHGyA4tpcR17UY7Kn+O7QFkZCbA4=;
 b=SIz7vYhxxeuRKUZ8anxhYr7C76u8094JEqWfXkJU/Z+8cdkkA/IBKnrU1u0bRCBFkO0Fq/RuOHPXYqgtRg9nJOD/y9trMg4Qn05VxnB8JoB9NnWnpWf2RRO/V0pjLI2zjm7qQ3FxuoJH0aOZt16nRcmuUbB8tVBdisGHqetSDgo=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2254.jpnprd01.prod.outlook.com (52.133.179.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 08:00:48 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:00:48 +0000
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
Subject: [PATCH 07/13] sh: sh4: convert to SPDX identifiers
Thread-Topic: [PATCH 07/13] sh: sh4: convert to SPDX identifiers
Thread-Index: AQHUjHChWu3jnXjyJ0e4ePNt4p26xQ==
Date:   Wed, 5 Dec 2018 08:00:48 +0000
Message-ID: <87a7lkcsya.wl-kuninori.morimoto.gx@renesas.com>
References: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KAWPR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:402:c::20) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2254;20:uqg1oKyqAvspQDgyEuty2vw3fBazC1qmuuRYJhChdTRQGai1csz/uQ60Ry6m5SYdrp1jKHHYIsKI0PdtXxRaxHEE2A22j2N8H7L9pTWFHs4SchFXv0nhe6jxKBz66bJ3pC0RQfIi8ThAUwCcGMpDJQqnJsh8q+7p2DpCadak8pw=
x-ms-office365-filtering-correlation-id: 6520dc90-34f7-4f31-854d-08d65a87c442
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2254;
x-ms-traffictypediagnostic: TYAPR01MB2254:
x-microsoft-antispam-prvs: <TYAPR01MB2254DDCE1CD4433E3BAC8D29D4A80@TYAPR01MB2254.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2254;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2254;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(53936002)(6436002)(6512007)(7736002)(305945005)(71190400001)(316002)(54906003)(110136005)(71200400001)(14454004)(99286004)(86362001)(2906002)(68736007)(5660300001)(97736004)(66066001)(8936002)(26005)(106356001)(6506007)(386003)(105586002)(6116002)(14444005)(186003)(25786009)(256004)(52116002)(3846002)(8676002)(486006)(476003)(4326008)(478600001)(2616005)(446003)(11346002)(36756003)(102836004)(81156014)(76176011)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2254;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: t+O6NJZ/2nL8Y09830zXOj0F3LgJtKm2Vf2X4VPvSq/+MKBC/81Gl9rE/zHLEe0ZgyroKCZEjn7No9JJv9DYuFDgaWdXuXvxwWbs9Y7J+ejGFIxd/+VSCcuHZZd2Cm8MioKGjfgC+ho13wKRNJ57pmqKQ1cW2dIkaWtZ+JvVDuCQeLe3pFQz1MYjBorecN+UvUAots2RdlT0ZotrP+uQtUAKjTWoGKvcaYRSfSPf6c7LGGeDotgS0D6RzSK8p/zLM/jlrriOfkTZ+Ui1tmNYtorI+oCHjWKXUtY1uBBA2Td9+HcXTjx3eh+EctLqAXBhX41BFt3MB8tZglZ+dD1PxOwCWuwhxCt7b/Mh5O4C/uc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <42968598D92A3B47BD30A6D669CBC81C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6520dc90-34f7-4f31-854d-08d65a87c442
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:00:48.1353
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
instead of verbose license text,
excepting ${LINUX}/arch/sh/kernel/cpu/sh4/softfloat.c
which is not GPL license

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c | 5 +----
 arch/sh/kernel/cpu/sh4/clock-sh4.c     | 5 +----
 arch/sh/kernel/cpu/sh4/fpu.c           | 5 +----
 arch/sh/kernel/cpu/sh4/perf_event.c    | 5 +----
 arch/sh/kernel/cpu/sh4/probe.c         | 5 +----
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c | 5 +----
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  | 5 +----
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  | 5 +----
 arch/sh/kernel/cpu/sh4/sq.c            | 5 +----
 9 files changed, 9 insertions(+), 36 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c b/arch/sh/kernel/cpu/sh=
4/clock-sh4-202.c
index 4b5bab5..c1cdef7 100644
--- a/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4/clock-sh4-202.c
  *
  * Additional SH4-202 support for the clock framework
  *
  *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh4/clock-sh4.c b/arch/sh/kernel/cpu/sh4/cl=
ock-sh4.c
index 99e5ec8..ee3c553 100644
--- a/arch/sh/kernel/cpu/sh4/clock-sh4.c
+++ b/arch/sh/kernel/cpu/sh4/clock-sh4.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4/clock-sh4.c
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
diff --git a/arch/sh/kernel/cpu/sh4/fpu.c b/arch/sh/kernel/cpu/sh4/fpu.c
index 95fd2dcb..1ff56e5 100644
--- a/arch/sh/kernel/cpu/sh4/fpu.c
+++ b/arch/sh/kernel/cpu/sh4/fpu.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Save/restore floating point context for signal handlers.
  *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Copyright (C) 1999, 2000  Kaz Kojima & Niibe Yutaka
  * Copyright (C) 2006  ST Microelectronics Ltd. (denorm support)
  *
diff --git a/arch/sh/kernel/cpu/sh4/perf_event.c b/arch/sh/kernel/cpu/sh4/p=
erf_event.c
index fa4f724..db5847b 100644
--- a/arch/sh/kernel/cpu/sh4/perf_event.c
+++ b/arch/sh/kernel/cpu/sh4/perf_event.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Performance events support for SH7750-style performance counters
  *
  *  Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4/probe.c b/arch/sh/kernel/cpu/sh4/probe.=
c
index a521bcf..ef4dd62 100644
--- a/arch/sh/kernel/cpu/sh4/probe.c
+++ b/arch/sh/kernel/cpu/sh4/probe.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4/probe.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2001 - 2007  Paul Mundt
  * Copyright (C) 2003  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c b/arch/sh/kernel/cpu/sh=
4/setup-sh4-202.c
index 2623f82..a40ef35 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH4-202 Setup
  *
  *  Copyright (C) 2006  Paul Mundt
  *  Copyright (C) 2009  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4=
/setup-sh7750.c
index 57d3068..b37bda6 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7091/SH7750/SH7750S/SH7750R/SH7751/SH7751R Setup
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
diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7760.c b/arch/sh/kernel/cpu/sh4=
/setup-sh7760.c
index e51fe17..86845da 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7760.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7760 Setup
  *
  *  Copyright (C) 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index 4ca78ed..934ff84 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh4/sq.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2001 - 2006  Paul Mundt
  * Copyright (C) 2001, 2002  M. R. Brown
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/cpu.h>
--=20
2.7.4

