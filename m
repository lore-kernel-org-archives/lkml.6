Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB6DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B8F20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="fDqPI1FQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B8F20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbeLEIAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:00:06 -0500
Received: from mail-eopbgr1400123.outbound.protection.outlook.com ([40.107.140.123]:50788
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbeLEIAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:00:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OldED1gkzqf9FJ3nehPTjjJWLsssp5ny3n/5zRzJytw=;
 b=fDqPI1FQBLIM3lnIsxL3SD3+9+PVpXiBcP7x+80bKwQrORGgq8LeYi2eckyr1MpgEcX99lJxUrHFQyRdZ10YzfN5fi+lHOzjNQT2Ui5+XOnDCaCFnUJiHqD8tTmJ6P+7L2+Jw8pRkq0tChLyEgIGGrJmJ2lvu1fnIeAlXV0xL3s=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2254.jpnprd01.prod.outlook.com (52.133.179.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 08:00:01 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:00:01 +0000
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
Subject: [PATCH 04/13] sh: sh2: convert to SPDX identifiers
Thread-Topic: [PATCH 04/13] sh: sh2: convert to SPDX identifiers
Thread-Index: AQHUjHCGib5jtO3it0KEHea/lx4O2A==
Date:   Wed, 5 Dec 2018 08:00:01 +0000
Message-ID: <87efawcszk.wl-kuninori.morimoto.gx@renesas.com>
References: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY1PR01CA0135.jpnprd01.prod.outlook.com
 (2603:1096:402:1::11) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2254;20:3e+jLUToqUPy9sGK8tQbWF0PCT+SzomgGC8HQJ+cz2bCP1TEENL0Nj6PQD+bnHbwRmegq4RGTXH3Rawh3n8ToCUW/mEuXR12RR4c9bpkzDApWtf14k0sy3NlbJNmDPfiqn/OsESX2Qrcuhz8gFUsxkGe05ri1gWPKGzLtblut3w=
x-ms-office365-filtering-correlation-id: 6db7fcfd-f961-403a-839c-08d65a87a871
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2254;
x-ms-traffictypediagnostic: TYAPR01MB2254:
x-microsoft-antispam-prvs: <TYAPR01MB225433656F1B77B88D1F15A0D4A80@TYAPR01MB2254.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2254;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2254;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(53936002)(6436002)(6512007)(7736002)(305945005)(71190400001)(316002)(54906003)(110136005)(71200400001)(14454004)(99286004)(86362001)(575784001)(2906002)(68736007)(5660300001)(97736004)(66066001)(8936002)(26005)(106356001)(6506007)(386003)(105586002)(6116002)(186003)(25786009)(256004)(52116002)(3846002)(8676002)(486006)(476003)(4326008)(478600001)(2616005)(446003)(11346002)(36756003)(102836004)(81156014)(76176011)(81166006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2254;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 950UsFOHGvd7nFxhcoIHVXEqs4s0AWUw4CkMP+yokIumIzrOd0a9TYXmFaLrOHr1SFz0F4Gl9viZWX0LoMPQ67dKReReNPR/Cq+XX/LprMZz79z3BqjRWYTJntUZmYxOnxj0X74qBu2T+N1/1cKMBzqn/LLrVVz7zn70JpzPwMU2ypo5ZU0xHwU40QUd4jNydjFwTPeFFMfufvblEYe2+UYi1lr4U2WPJZgdfwUVnA8zgDczsZ/D9dGxp6EltIoKyEeJ6owkd9Jk8CSg8fcaYk0yqZdIVRJ9Z5SULBC+nsPLjZeDuM9N68x9lsFseUuFmkJjgqnWawBAk4NPaX9F6L268hCvQrszfs1ikKc2kaU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1F56E2BB18D9B45816C3F9FE916DC52@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db7fcfd-f961-403a-839c-08d65a87a871
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:00:01.4811
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
 arch/sh/kernel/cpu/sh2/Makefile       | 1 +
 arch/sh/kernel/cpu/sh2/clock-sh7619.c | 5 +----
 arch/sh/kernel/cpu/sh2/entry.S        | 7 ++-----
 arch/sh/kernel/cpu/sh2/ex.S           | 7 ++-----
 arch/sh/kernel/cpu/sh2/probe.c        | 5 +----
 arch/sh/kernel/cpu/sh2/setup-sh7619.c | 5 +----
 arch/sh/kernel/cpu/sh2/smp-j2.c       | 5 +----
 7 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2/Makefile b/arch/sh/kernel/cpu/sh2/Makef=
ile
index 904c428..214c3a5 100644
--- a/arch/sh/kernel/cpu/sh2/Makefile
+++ b/arch/sh/kernel/cpu/sh2/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Linux/SuperH SH-2 backends.
 #
diff --git a/arch/sh/kernel/cpu/sh2/clock-sh7619.c b/arch/sh/kernel/cpu/sh2=
/clock-sh7619.c
index e80252a..d66d194c 100644
--- a/arch/sh/kernel/cpu/sh2/clock-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/clock-sh7619.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2/clock-sh7619.c
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
diff --git a/arch/sh/kernel/cpu/sh2/entry.S b/arch/sh/kernel/cpu/sh2/entry.=
S
index 1ee0a6e..0a1c2bf 100644
--- a/arch/sh/kernel/cpu/sh2/entry.S
+++ b/arch/sh/kernel/cpu/sh2/entry.S
@@ -1,14 +1,11 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh2/entry.S
  *
  * The SH-2 exception entry
  *
  * Copyright (C) 2005-2008 Yoshinori Sato
  * Copyright (C) 2005  AXE,Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/linkage.h>
diff --git a/arch/sh/kernel/cpu/sh2/ex.S b/arch/sh/kernel/cpu/sh2/ex.S
index 85b0bf8..dd0cc88 100644
--- a/arch/sh/kernel/cpu/sh2/ex.S
+++ b/arch/sh/kernel/cpu/sh2/ex.S
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh2/ex.S
  *
  * The SH-2 exception vector table
  *
  * Copyright (C) 2005 Yoshinori Sato
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/linkage.h>
diff --git a/arch/sh/kernel/cpu/sh2/probe.c b/arch/sh/kernel/cpu/sh2/probe.=
c
index a5bd036..d342ea0 100644
--- a/arch/sh/kernel/cpu/sh2/probe.c
+++ b/arch/sh/kernel/cpu/sh2/probe.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh2/probe.c
  *
  * CPU Subtype Probing for SH-2.
  *
  * Copyright (C) 2002 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/of_fdt.h>
diff --git a/arch/sh/kernel/cpu/sh2/setup-sh7619.c b/arch/sh/kernel/cpu/sh2=
/setup-sh7619.c
index d08db08..f5b6841 100644
--- a/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ b/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7619 Setup
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
diff --git a/arch/sh/kernel/cpu/sh2/smp-j2.c b/arch/sh/kernel/cpu/sh2/smp-j=
2.c
index 6ccd7e4..ae44dc2 100644
--- a/arch/sh/kernel/cpu/sh2/smp-j2.c
+++ b/arch/sh/kernel/cpu/sh2/smp-j2.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SMP support for J2 processor
  *
  * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/smp.h>
--=20
2.7.4

