Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B40C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A17206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="cA7FakPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26A17206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbeLEIBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:01:40 -0500
Received: from mail-eopbgr1410137.outbound.protection.outlook.com ([40.107.141.137]:65152
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbeLEIBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FavRdDddj9OUi5kSBH4GixMAp90S4L96Iz1IxFUpsCI=;
 b=cA7FakPJSZZVvFYOTGa62RL9xVD3Qai+m1paOOA9RTKFGRS8S9hOjqbkIjwCdwbOslLMIyExE0KYRkFR2Ly+nubt+OoLXTIM4mNFAUaHQybFrH51d9tJPxyASaLZkLK4npfje7nruPK0K4HX0uwgt8uRDeILWDs8exLoKUzTXVM=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB1998.jpnprd01.prod.outlook.com (52.133.178.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 08:01:35 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:01:35 +0000
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
Subject: [PATCH 11/13] sh: cpu: convert to SPDX identifiers
Thread-Topic: [PATCH 11/13] sh: cpu: convert to SPDX identifiers
Thread-Index: AQHUjHC+uGu9EkAmAUyFN9v7qMyklA==
Date:   Wed, 5 Dec 2018 08:01:35 +0000
Message-ID: <874lbscswy.wl-kuninori.morimoto.gx@renesas.com>
References: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY1PR01CA0148.jpnprd01.prod.outlook.com
 (2603:1096:402:1::24) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB1998;20:tdgnYiwotfsttVg551/4/AJnjuwPEVLNWEJpxhERxqEm8uZL9WF6tc+i2obSnj2+Usiatp40mI6QQB5UgXGHs/YNydzPMbiTdf4eQGDHJ/O1uCTRsa5TTmWOj+6QU3CuPlCA7dmOB4pnz0XH0tcQh4/pBWSKVuOY3ZfVTYsIT1E=
x-ms-office365-filtering-correlation-id: 76ca209e-4cd6-46a3-0a6e-08d65a87e099
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB1998;
x-ms-traffictypediagnostic: TYAPR01MB1998:
x-microsoft-antispam-prvs: <TYAPR01MB1998748F55E35726B46528EDD4A80@TYAPR01MB1998.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB1998;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB1998;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(346002)(39860400002)(396003)(199004)(189003)(8676002)(26005)(186003)(476003)(102836004)(478600001)(6116002)(2906002)(3846002)(446003)(81166006)(11346002)(81156014)(6506007)(386003)(2616005)(8936002)(76176011)(71190400001)(256004)(71200400001)(52116002)(14454004)(86362001)(5660300001)(486006)(36756003)(54906003)(110136005)(66066001)(99286004)(25786009)(97736004)(68736007)(305945005)(7736002)(4326008)(6436002)(105586002)(6512007)(316002)(106356001)(53936002)(6486002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB1998;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: d9MtQTlhFmbwOJdR9Z/My1Y3AycFqF1vAR3ffFwWFr7J8glK/+zdjg08GWQjIK3H5W4SMfeKviDiDVOI2SpMEFDS3ntf5zCwGd550SLkHmF/2hbJAZDKvrvUPie5PU9YxBN3Uz1VNUDMUWk4xc1E29dF7vfoGFf0qaJd9nSdVz99lO3S4seBAiEuDEEVS0TPs38lEIxBteT9ysb7Atp2qYK52FhZPnKeCOQtZMIhG/c9P3o3Px1RGTnQ51mwzuh+4MCCqtEi45ELyvBsr3U+mrTJYH38tRZXDl9X4WZZ/AX2XY3wPRozOkZaXSMdnWHbPo9TRSe4hAQGv6GaES7NL60fmV4QRQOwaNo+p2jQfFA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21DC6957BF5C9049B21303115E7B7684@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ca209e-4cd6-46a3-0a6e-08d65a87e099
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:01:35.6776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1998
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
 arch/sh/kernel/cpu/clock.c        |  5 +----
 arch/sh/kernel/cpu/init.c         |  5 +----
 arch/sh/kernel/cpu/irq/Makefile   |  1 +
 arch/sh/kernel/cpu/irq/intc-sh5.c |  5 +----
 arch/sh/kernel/cpu/irq/ipr.c      |  5 +----
 arch/sh/kernel/cpu/pfc.c          | 10 +---------
 6 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/arch/sh/kernel/cpu/clock.c b/arch/sh/kernel/cpu/clock.c
index fca9b1e7..6fb3441 100644
--- a/arch/sh/kernel/cpu/clock.c
+++ b/arch/sh/kernel/cpu/clock.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/clock.c - SuperH clock framework
  *
@@ -9,10 +10,6 @@
  *	Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
  *
  *  Modified for omap shared clock framework by Tony Lindgren <tony@atomid=
e.com>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/cpu/init.c b/arch/sh/kernel/cpu/init.c
index c4f01c5..ce7291e 100644
--- a/arch/sh/kernel/cpu/init.c
+++ b/arch/sh/kernel/cpu/init.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/init.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2002 - 2009  Paul Mundt
  * Copyright (C) 2003  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/irq/Makefile b/arch/sh/kernel/cpu/irq/Makef=
ile
index 3f8e794..8b91cb9 100644
--- a/arch/sh/kernel/cpu/irq/Makefile
+++ b/arch/sh/kernel/cpu/irq/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Linux/SuperH CPU-specific IRQ handlers.
 #
diff --git a/arch/sh/kernel/cpu/irq/intc-sh5.c b/arch/sh/kernel/cpu/irq/int=
c-sh5.c
index 9e056a3..744f903 100644
--- a/arch/sh/kernel/cpu/irq/intc-sh5.c
+++ b/arch/sh/kernel/cpu/irq/intc-sh5.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/irq/intc-sh5.c
  *
@@ -9,10 +10,6 @@
  * Per-interrupt selective. IRLM=3D0 (Fixed priority) is not
  * supported being useless without a cascaded interrupt
  * controller.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/sh/kernel/cpu/irq/ipr.c b/arch/sh/kernel/cpu/irq/ipr.c
index 5de6dff5..d41bce7 100644
--- a/arch/sh/kernel/cpu/irq/ipr.c
+++ b/arch/sh/kernel/cpu/irq/ipr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Interrupt handling for IPR-based IRQ.
  *
@@ -11,10 +12,6 @@
  *	On-chip supporting modules for SH7709/SH7709A/SH7729.
  *	Hitachi SolutionEngine external I/O:
  *		MS7709SE01, MS7709ASE01, and MS7750SE01
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/sh/kernel/cpu/pfc.c b/arch/sh/kernel/cpu/pfc.c
index d766564..062056e 100644
--- a/arch/sh/kernel/cpu/pfc.c
+++ b/arch/sh/kernel/cpu/pfc.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH Pin Function Control Initialization
  *
  * Copyright (C) 2012  Renesas Solutions Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
=20
 #include <linux/init.h>
--=20
2.7.4

