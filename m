Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73024C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B07206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="mz2GX93V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B07206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeLEIAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:00:20 -0500
Received: from mail-eopbgr1410091.outbound.protection.outlook.com ([40.107.141.91]:1600
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbeLEIAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/E4uf2xCs+hW781U6hLNwyqcJ0MTB4bwJKau64PrWE=;
 b=mz2GX93VNM6Vga6IuC2/2NPMnBCQQWn1WqiVQ18Zqv32unrDH2LxezxVwxUrJnkc9r07AoW+S19ijEnFx84tX9nFtP+H500BuhgSvNIQSsMe7JIrKqsHZM6YzF3Ys/G99DUeEPlFL/iKCEvyIZ5w/ucJUt5Wx8yMjVsL/XlELkw=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2254.jpnprd01.prod.outlook.com (52.133.179.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 08:00:14 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:00:14 +0000
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
Subject: [PATCH 05/13] sh: sh2a: convert to SPDX identifiers
Thread-Topic: [PATCH 05/13] sh: sh2a: convert to SPDX identifiers
Thread-Index: AQHUjHCNTz2eW7eUTES7utqCpq5WNg==
Date:   Wed, 5 Dec 2018 08:00:14 +0000
Message-ID: <87d0qgcsz8.wl-kuninori.morimoto.gx@renesas.com>
References: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KAXPR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:402:19::23) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2254;20:fvq5p8DI2LQ962sQ385rFFLyoK44U9IiKnvmxw/T8QhzTftxt7KE577w1dDOJZKnBKs0/Kvk7r5gFns8GdHgxccp1uRR3wrvnN+xN5BWkgiU70fgMOR/6RAPD/6AbJ/WjDUhVljBb5KsdLTkN/FnZsnQbV1udokqWJvVeDVYh+Y=
x-ms-office365-filtering-correlation-id: 057b0d7f-e6a5-4fc1-94a7-08d65a87b013
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2254;
x-ms-traffictypediagnostic: TYAPR01MB2254:
x-microsoft-antispam-prvs: <TYAPR01MB22545D5DBE32D1D18A2F90BED4A80@TYAPR01MB2254.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2254;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2254;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(53936002)(6436002)(6512007)(7736002)(305945005)(71190400001)(316002)(54906003)(110136005)(71200400001)(14454004)(99286004)(4744004)(86362001)(575784001)(2906002)(68736007)(5660300001)(97736004)(66066001)(8936002)(26005)(106356001)(6506007)(386003)(105586002)(6116002)(14444005)(186003)(25786009)(256004)(52116002)(3846002)(8676002)(486006)(476003)(4326008)(478600001)(2616005)(446003)(11346002)(36756003)(102836004)(81156014)(76176011)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2254;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: SndPJmiJWrInxSBzxlj+o/q8eqzcqPBgTfGS7BAKVDGGTWRCjwCC1kO07XW0jTsYvnz+DfEQD0WX7/hznTMGip3pucldtoOg5NunPPnwHHEAwJ2eeiYcI/kpyxUvlFrszS+PArRu34WaW8Q6t6uwlDLiV/7nx+jgN/DUEIaWRvp4oKcZGEpkkuUk56ifa6oY9Dgj4NRn+iSq2tRlpd5ilAKaAgyY3ThpuXJepkpVWGkkw+yxT+xnagXPVPC//KicmId8M+vxuKLLQ6A+J4bS3wM25AbIlmijqmyAUjAobaO+K0Jqji8D89CVJr0MSUKqOXI0OzeQQfs6beXU2fq7C/i2B2oHQEff16vBmttUn+E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7BCB18673558264D9F565F2176A91D60@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 057b0d7f-e6a5-4fc1-94a7-08d65a87b013
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:00:14.2643
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
 arch/sh/kernel/cpu/sh2a/clock-sh7201.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/clock-sh7203.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/clock-sh7206.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/clock-sh7269.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/entry.S         | 7 ++-----
 arch/sh/kernel/cpu/sh2a/ex.S            | 7 ++-----
 arch/sh/kernel/cpu/sh2a/fpu.c           | 5 +----
 arch/sh/kernel/cpu/sh2a/opcode_helper.c | 5 +----
 arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c | 5 +----
 arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c | 5 +----
 arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c | 5 +----
 arch/sh/kernel/cpu/sh2a/probe.c         | 5 +----
 arch/sh/kernel/cpu/sh2a/setup-mxg.c     | 5 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c  | 5 +----
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c  | 5 +----
 19 files changed, 21 insertions(+), 78 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7201.c b/arch/sh/kernel/cpu/sh=
2a/clock-sh7201.c
index 532a36c..5a5daaa 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7201.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/clock-sh7201.c
  *
@@ -7,10 +8,6 @@
  *
  * Based on clock-sh4.c
  *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7203.c b/arch/sh/kernel/cpu/sh=
2a/clock-sh7203.c
index 529f719..c620539 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7203.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/clock-sh7203.c
  *
@@ -10,10 +11,6 @@
  *
  * Based on clock-sh4.c
  *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7206.c b/arch/sh/kernel/cpu/sh=
2a/clock-sh7206.c
index 1777898..d286d7b 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7206.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/clock-sh7206.c
  *
@@ -7,10 +8,6 @@
  *
  * Based on clock-sh4.c
  *  Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7264.c b/arch/sh/kernel/cpu/sh=
2a/clock-sh7264.c
index 7e06e39..d9acc1e 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7264.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/clock-sh7264.c
  *
  * SH7264 clock framework support
  *
  * Copyright (C) 2012  Phil Edworthy
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh2a/clock-sh7269.c b/arch/sh/kernel/cpu/sh=
2a/clock-sh7269.c
index 663a97b..c17ab0d 100644
--- a/arch/sh/kernel/cpu/sh2a/clock-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/clock-sh7269.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/clock-sh7269.c
  *
  * SH7269 clock framework support
  *
  * Copyright (C) 2012  Phil Edworthy
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh2a/entry.S b/arch/sh/kernel/cpu/sh2a/entr=
y.S
index da77a8e..9f11fc8 100644
--- a/arch/sh/kernel/cpu/sh2a/entry.S
+++ b/arch/sh/kernel/cpu/sh2a/entry.S
@@ -1,14 +1,11 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh2a/entry.S
  *
  * The SH-2A exception entry
  *
  * Copyright (C) 2008 Yoshinori Sato
  * Based on arch/sh/kernel/cpu/sh2/entry.S
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/linkage.h>
diff --git a/arch/sh/kernel/cpu/sh2a/ex.S b/arch/sh/kernel/cpu/sh2a/ex.S
index 4568066..ed91996 100644
--- a/arch/sh/kernel/cpu/sh2a/ex.S
+++ b/arch/sh/kernel/cpu/sh2a/ex.S
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh2a/ex.S
  *
  * The SH-2A exception vector table
  *
  * Copyright (C) 2008 Yoshinori Sato
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/linkage.h>
diff --git a/arch/sh/kernel/cpu/sh2a/fpu.c b/arch/sh/kernel/cpu/sh2a/fpu.c
index 352f894..74b48db 100644
--- a/arch/sh/kernel/cpu/sh2a/fpu.c
+++ b/arch/sh/kernel/cpu/sh2a/fpu.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Save/restore floating point context for signal handlers.
  *
  * Copyright (C) 1999, 2000  Kaz Kojima & Niibe Yutaka
  *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * FIXME! These routines can be optimized in big endian case.
  */
 #include <linux/sched/signal.h>
diff --git a/arch/sh/kernel/cpu/sh2a/opcode_helper.c b/arch/sh/kernel/cpu/s=
h2a/opcode_helper.c
index 72aa61c..c509081 100644
--- a/arch/sh/kernel/cpu/sh2a/opcode_helper.c
+++ b/arch/sh/kernel/cpu/sh2a/opcode_helper.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/opcode_helper.c
  *
  * Helper for the SH-2A 32-bit opcodes.
  *
  *  Copyright (C) 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
=20
diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c b/arch/sh/kernel/cpu/s=
h2a/pinmux-sh7203.c
index eef17dc..a6777e6 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7203.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7203 Pinmux
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
diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c b/arch/sh/kernel/cpu/s=
h2a/pinmux-sh7264.c
index 569decb..7a103e1 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7264 Pinmux
  *
  *  Copyright (C) 2012  Renesas Electronics Europe Ltd
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/bug.h>
diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c b/arch/sh/kernel/cpu/s=
h2a/pinmux-sh7269.c
index 4c17fb6..4da432e 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7269.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7269 Pinmux
  *
  * Copyright (C) 2012  Renesas Electronics Europe Ltd
  * Copyright (C) 2012  Phil Edworthy
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/bug.h>
diff --git a/arch/sh/kernel/cpu/sh2a/probe.c b/arch/sh/kernel/cpu/sh2a/prob=
e.c
index 3f87971..c66a3bc 100644
--- a/arch/sh/kernel/cpu/sh2a/probe.c
+++ b/arch/sh/kernel/cpu/sh2a/probe.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2a/probe.c
  *
  * CPU Subtype Probing for SH-2A.
  *
  * Copyright (C) 2004 - 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <asm/processor.h>
diff --git a/arch/sh/kernel/cpu/sh2a/setup-mxg.c b/arch/sh/kernel/cpu/sh2a/=
setup-mxg.c
index 060fdd3..52350ad 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-mxg.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-mxg.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas MX-G (R8A03022BG) Setup
  *
  *  Copyright (C) 2008, 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c b/arch/sh/kernel/cpu/sh=
2a/setup-sh7201.c
index c1301f6..b51ed76 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  SH7201 setup
  *
  *  Copyright (C) 2008  Peter Griffin pgriffin@mpc-data.co.uk
  *  Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c b/arch/sh/kernel/cpu/sh=
2a/setup-sh7203.c
index 32ec732..89b3e49 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7203 and SH7263 Setup
  *
  *  Copyright (C) 2007 - 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c b/arch/sh/kernel/cpu/sh=
2a/setup-sh7206.c
index 8d8d354..36ff3a3 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7206 Setup
  *
  *  Copyright (C) 2006  Yoshinori Sato
  *  Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c b/arch/sh/kernel/cpu/sh=
2a/setup-sh7264.c
index ab71eab..d199618 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7264.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7264 Setup
  *
  * Copyright (C) 2012  Renesas Electronics Europe Ltd
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c b/arch/sh/kernel/cpu/sh=
2a/setup-sh7269.c
index c7e81b2..9095c96 100644
--- a/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
+++ b/arch/sh/kernel/cpu/sh2a/setup-sh7269.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7269 Setup
  *
  * Copyright (C) 2012  Renesas Electronics Europe Ltd
  * Copyright (C) 2012  Phil Edworthy
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
--=20
2.7.4

