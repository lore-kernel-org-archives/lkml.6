Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F6EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94EA3206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="CCXwNLLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94EA3206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbeLEIBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:01:17 -0500
Received: from mail-eopbgr1400093.outbound.protection.outlook.com ([40.107.140.93]:6223
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeLEIBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:01:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhPg95JoE1a8ZjHzK0l9W6NlxAzWz5KWMTLz5WWuzF4=;
 b=CCXwNLLapPHr+s+WXDMYegqnCNz3DdlngG65yF8Z2UwPT6rXr6NP5yH4tRdqD0vlmFKZZhPLb0CBMqKuRFbzxgqW82TX6BZgqwp9IIFXehMV4Desml4tsEBpijCAPCVI9U1hj0AFzj8ddewWWJmoMIrQKR+ynYNXbgcId49dUOI=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2254.jpnprd01.prod.outlook.com (52.133.179.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 08:01:12 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:01:12 +0000
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
Subject: [PATCH 09/13] sh: sh5: convert to SPDX identifiers
Thread-Topic: [PATCH 09/13] sh: sh5: convert to SPDX identifiers
Thread-Index: AQHUjHCw7qLB49nwdkWTWmTZOhYfeg==
Date:   Wed, 5 Dec 2018 08:01:12 +0000
Message-ID: <877egocsxl.wl-kuninori.morimoto.gx@renesas.com>
References: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR03CA0014.apcprd03.prod.outlook.com
 (2603:1096:404:14::26) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2254;20:D3PXIknRxF99h3Fxq9zT0wpWW+wjy+IB0+XYUMu3xqIEyDU/cT6vh13G9u3wax60E7jrvjF1IC/YqkhB+CViHI6fSDHYKhlTxajKKoC4GmkKFhvly9laQ6HVpmQDZrWdpa+2sn46xeyPFvdanp9h/aw1UQ1wiLX0aMuZNbcPqMU=
x-ms-office365-filtering-correlation-id: 3c12626c-ab9d-4d3f-8252-08d65a87d2c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2254;
x-ms-traffictypediagnostic: TYAPR01MB2254:
x-microsoft-antispam-prvs: <TYAPR01MB2254AC6B9D3CC80388B56BF0D4A80@TYAPR01MB2254.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2254;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2254;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(53936002)(6436002)(6512007)(7736002)(305945005)(71190400001)(316002)(54906003)(110136005)(71200400001)(14454004)(99286004)(86362001)(575784001)(2906002)(68736007)(5660300001)(97736004)(66066001)(8936002)(26005)(106356001)(6506007)(386003)(105586002)(6116002)(186003)(25786009)(256004)(52116002)(3846002)(8676002)(486006)(476003)(4326008)(478600001)(2616005)(446003)(11346002)(36756003)(102836004)(81156014)(76176011)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2254;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2x6Ly9GWIsFj+t8GJlMxYMX2py8oQQ/r36OQEC0D2Bnur02dOI434W8fgDv++qJcRGQr/fV8w05qA4JCkevwhsdLZNRMYqxGXA31t1IAiNPcc9CPJWfk9opl2fhUiDWrQgt3tSLH+aqVRoH7I+RPta40pJ5e1jtV+LRtsd7nkv54bWtPv9RQH8mYNXv6xTonDN8oWgzhIR3zNaONxqZAP0amJQxBlJWGp+QiDXopCTOlRrcUmhlIxU8p9rfY3hQP969DjWJR5KuZ/0dUNZBLGN5Qqp7fat91TgZIJLxAjQpitQoDUSf6+mK05UP8aMX2HZG3tOXprIOabRDk1xZUJ3WKt9k83Aj/DhZmITuzMyE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11FDE4AC4C80AE4A93E39835E56E6F6D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c12626c-ab9d-4d3f-8252-08d65a87d2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:01:12.4678
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
 arch/sh/kernel/cpu/sh5/clock-sh5.c | 5 +----
 arch/sh/kernel/cpu/sh5/entry.S     | 7 ++-----
 arch/sh/kernel/cpu/sh5/fpu.c       | 5 +----
 arch/sh/kernel/cpu/sh5/probe.c     | 5 +----
 arch/sh/kernel/cpu/sh5/setup-sh5.c | 5 +----
 arch/sh/kernel/cpu/sh5/switchto.S  | 7 ++-----
 arch/sh/kernel/cpu/sh5/unwind.c    | 5 +----
 7 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh5/clock-sh5.c b/arch/sh/kernel/cpu/sh5/cl=
ock-sh5.c
index c48b93d..43763c2 100644
--- a/arch/sh/kernel/cpu/sh5/clock-sh5.c
+++ b/arch/sh/kernel/cpu/sh5/clock-sh5.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh5/clock-sh5.c
  *
  * SH-5 support for the clock framework
  *
  *  Copyright (C) 2008  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/sh5/entry.S b/arch/sh/kernel/cpu/sh5/entry.=
S
index 0c8d037..de68ffd 100644
--- a/arch/sh/kernel/cpu/sh5/entry.S
+++ b/arch/sh/kernel/cpu/sh5/entry.S
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh5/entry.S
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2004 - 2008  Paul Mundt
  * Copyright (C) 2003, 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/errno.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh5/fpu.c b/arch/sh/kernel/cpu/sh5/fpu.c
index 9f8713a..9218d9e 100644
--- a/arch/sh/kernel/cpu/sh5/fpu.c
+++ b/arch/sh/kernel/cpu/sh5/fpu.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh5/fpu.c
  *
@@ -7,10 +8,6 @@
  *
  * Started from SH4 version:
  *   Copyright (C) 1999, 2000  Kaz Kojima & Niibe Yutaka
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/sched.h>
 #include <linux/signal.h>
diff --git a/arch/sh/kernel/cpu/sh5/probe.c b/arch/sh/kernel/cpu/sh5/probe.=
c
index eca427c..9472501 100644
--- a/arch/sh/kernel/cpu/sh5/probe.c
+++ b/arch/sh/kernel/cpu/sh5/probe.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh5/probe.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003 - 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/sh/kernel/cpu/sh5/setup-sh5.c b/arch/sh/kernel/cpu/sh5/se=
tup-sh5.c
index 084a9cc..41c1673 100644
--- a/arch/sh/kernel/cpu/sh5/setup-sh5.c
+++ b/arch/sh/kernel/cpu/sh5/setup-sh5.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH5-101/SH5-103 CPU Setup
  *
  *  Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/platform_device.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/sh5/switchto.S b/arch/sh/kernel/cpu/sh5/swi=
tchto.S
index 45c351b0..d1beff7 100644
--- a/arch/sh/kernel/cpu/sh5/switchto.S
+++ b/arch/sh/kernel/cpu/sh5/switchto.S
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh5/switchto.S
  *
  * sh64 context switch
  *
  * Copyright (C) 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
 */
=20
 	.section .text..SHmedia32,"ax"
diff --git a/arch/sh/kernel/cpu/sh5/unwind.c b/arch/sh/kernel/cpu/sh5/unwin=
d.c
index 3a4fed4..3cb0cd9 100644
--- a/arch/sh/kernel/cpu/sh5/unwind.c
+++ b/arch/sh/kernel/cpu/sh5/unwind.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/sh5/unwind.c
  *
  * Copyright (C) 2004  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kallsyms.h>
 #include <linux/kernel.h>
--=20
2.7.4

