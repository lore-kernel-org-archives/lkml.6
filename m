Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED8FC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3240206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="YYXXU0Zo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3240206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeLEH7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:59:43 -0500
Received: from mail-eopbgr1410118.outbound.protection.outlook.com ([40.107.141.118]:24555
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbeLEH7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67YAq4Xuwwgs7kSEKdy/obP1KeFxxNNxTyXsVWwzZPY=;
 b=YYXXU0ZoSrth2B/S1BwBfyoO6o0wlfaLUh92fRPZ9D8YsjHrVBkY5WHsU10UX3s9z313bHualoTBZpNRvYnjJKGzZI3QlJEODbjMzvGDXY5FNWL2F3GZR2TwXwLs0amd5JMeCYalTW4COFqeoSzDQ4WClKuf1kSMAWfaUNKQOgE=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB4158.jpnprd01.prod.outlook.com (20.178.140.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.19; Wed, 5 Dec 2018 07:59:35 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 07:59:35 +0000
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
Subject: [PATCH 02/13] sh: drivers: convert to SPDX identifiers
Thread-Topic: [PATCH 02/13] sh: drivers: convert to SPDX identifiers
Thread-Index: AQHUjHB2x2ixZ0CVv0yCMw/NzWPWYQ==
Date:   Wed, 5 Dec 2018 07:59:35 +0000
Message-ID: <87h8fsct0a.wl-kuninori.morimoto.gx@renesas.com>
References: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KAXPR01CA0007.jpnprd01.prod.outlook.com
 (2603:1096:402:19::17) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB4158;20:7Ec6faIGVdYSL7Y3kGTXI5CZjbkMAcAHQQxlZhqRRW78j4ADDy/WIt1CHRN+6q3TbLpxkBWAshEu79s2wgVMrCYFTes3jDBjahKqG4PpXtDe6Kdzqy4gkN67QXLnrV14mHxnaDud0Q+T+qknZkgkY4a7KlJirfgK99F/JLBEcD4=
x-ms-office365-filtering-correlation-id: ee56c0e0-2459-4f9c-3c8b-08d65a879903
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB4158;
x-ms-traffictypediagnostic: TYAPR01MB4158:
x-microsoft-antispam-prvs: <TYAPR01MB4158FF5A4A1D3FBE76245B01D4A80@TYAPR01MB4158.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB4158;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB4158;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(346002)(376002)(136003)(199004)(189003)(8676002)(53936002)(52116002)(53946003)(575784001)(86362001)(105586002)(106356001)(8936002)(4326008)(478600001)(6116002)(316002)(81156014)(81166006)(54906003)(110136005)(25786009)(68736007)(6512007)(3846002)(102836004)(66066001)(186003)(5660300001)(6506007)(26005)(386003)(4744004)(486006)(14454004)(76176011)(476003)(71190400001)(71200400001)(305945005)(7736002)(99286004)(36756003)(6486002)(256004)(6436002)(2906002)(11346002)(446003)(97736004)(2616005)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB4158;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AW3iOfzvBq5VJH4lw/ntTxNIammtNa4dS4yeRw3hmQ4awl6uwz9xOMKQC6hNrotGsqizKcSU9jHmq9mvpPDaSWIdjHZUAF6I6FMjol1RCZME1hWFsxgT7hKVQFrseMnsP7GEy560KQee6n/bMU3Ehp1RWFdNVda/cDfNyf+EVRZHI6Fwy3JmGvmm86/Rra0f/A1NIKWTIXdMtBhmb45cva3ZPH7v5Mnw+ZakjlhX8HhyFUMH2ZMjEGT0HTHNtTEMizVGdVZwoMBMzuziUJBaCss+gettcM2VWnJAO6FhEHHD3MIfjYv39oHDkosvS0ciNleORPC8/GG9H1hc9wO+fd9ivdB3TuGWAwEYeajfRNw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7CB610FEA6561C45BE1F01EF3A1C5F15@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee56c0e0-2459-4f9c-3c8b-08d65a879903
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 07:59:35.6006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates license to use SPDX-License-Identifier
instead of verbose license text.

As original license mentioned, it is GPL-2.0 in SPDX.
Then, MODULE_LICENSE() should be "GPL v2" instead of "GPL".
See ${LINUX}/include/linux/module.h

	"GPL"		[GNU Public License v2 or later]
	"GPL v2"	[GNU Public License v2]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/sh/drivers/dma/Makefile             | 1 +
 arch/sh/drivers/dma/dma-api.c            | 7 ++-----
 arch/sh/drivers/dma/dma-g2.c             | 7 ++-----
 arch/sh/drivers/dma/dma-pvr2.c           | 7 ++-----
 arch/sh/drivers/dma/dma-sh.c             | 7 ++-----
 arch/sh/drivers/dma/dma-sysfs.c          | 5 +----
 arch/sh/drivers/dma/dmabrg.c             | 3 +--
 arch/sh/drivers/heartbeat.c              | 5 +----
 arch/sh/drivers/pci/fixups-dreamcast.c   | 5 +----
 arch/sh/drivers/pci/fixups-landisk.c     | 4 +---
 arch/sh/drivers/pci/fixups-r7780rp.c     | 5 +----
 arch/sh/drivers/pci/fixups-rts7751r2d.c  | 5 +----
 arch/sh/drivers/pci/fixups-sdk7780.c     | 5 +----
 arch/sh/drivers/pci/fixups-sdk7786.c     | 5 +----
 arch/sh/drivers/pci/fixups-snapgear.c    | 4 +---
 arch/sh/drivers/pci/fixups-titan.c       | 4 +---
 arch/sh/drivers/pci/ops-dreamcast.c      | 5 +----
 arch/sh/drivers/pci/ops-sh4.c            | 5 +----
 arch/sh/drivers/pci/ops-sh5.c            | 4 +---
 arch/sh/drivers/pci/ops-sh7786.c         | 5 +----
 arch/sh/drivers/pci/pci-dreamcast.c      | 5 +----
 arch/sh/drivers/pci/pci-sh5.c            | 4 +---
 arch/sh/drivers/pci/pci-sh5.h            | 6 ++----
 arch/sh/drivers/pci/pci-sh7751.c         | 5 +----
 arch/sh/drivers/pci/pci-sh7751.h         | 7 ++-----
 arch/sh/drivers/pci/pci-sh7780.c         | 5 +----
 arch/sh/drivers/pci/pci-sh7780.h         | 7 ++-----
 arch/sh/drivers/pci/pci.c                | 5 +----
 arch/sh/drivers/pci/pcie-sh7786.c        | 5 +----
 arch/sh/drivers/pci/pcie-sh7786.h        | 7 ++-----
 arch/sh/drivers/push-switch.c            | 5 +----
 arch/sh/drivers/superhyway/Makefile      | 1 +
 arch/sh/drivers/superhyway/ops-sh4-202.c | 5 +----
 33 files changed, 41 insertions(+), 124 deletions(-)

diff --git a/arch/sh/drivers/dma/Makefile b/arch/sh/drivers/dma/Makefile
index d88c948..d2fdd56 100644
--- a/arch/sh/drivers/dma/Makefile
+++ b/arch/sh/drivers/dma/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the SuperH DMA specific kernel interface routines under Lin=
ux.
 #
diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index b05be59..ab91704 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/dma/dma-api.c
  *
  * SuperH-specific DMA management API
  *
  * Copyright (C) 2003, 2004, 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/module.h>
@@ -417,4 +414,4 @@ subsys_initcall(dma_api_init);
=20
 MODULE_AUTHOR("Paul Mundt <lethal@linux-sh.org>");
 MODULE_DESCRIPTION("DMA API for SuperH");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/sh/drivers/dma/dma-g2.c b/arch/sh/drivers/dma/dma-g2.c
index e1ab6eb..52a8ae5 100644
--- a/arch/sh/drivers/dma/dma-g2.c
+++ b/arch/sh/drivers/dma/dma-g2.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/dma/dma-g2.c
  *
  * G2 bus DMA support
  *
  * Copyright (C) 2003 - 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -197,4 +194,4 @@ module_exit(g2_dma_exit);
=20
 MODULE_AUTHOR("Paul Mundt <lethal@linux-sh.org>");
 MODULE_DESCRIPTION("G2 bus DMA driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/sh/drivers/dma/dma-pvr2.c b/arch/sh/drivers/dma/dma-pvr2.=
c
index 706a343..b5dbd1f 100644
--- a/arch/sh/drivers/dma/dma-pvr2.c
+++ b/arch/sh/drivers/dma/dma-pvr2.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/dma/dma-pvr2.c
  *
  * NEC PowerVR 2 (Dreamcast) DMA support
  *
  * Copyright (C) 2003, 2004  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -105,4 +102,4 @@ module_exit(pvr2_dma_exit);
=20
 MODULE_AUTHOR("Paul Mundt <lethal@linux-sh.org>");
 MODULE_DESCRIPTION("NEC PowerVR 2 DMA driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index afde2a7..96c626c 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/dma/dma-sh.c
  *
@@ -6,10 +7,6 @@
  * Copyright (C) 2000 Takashi YOSHII
  * Copyright (C) 2003, 2004 Paul Mundt
  * Copyright (C) 2005 Andriy Skulysh
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -414,4 +411,4 @@ module_exit(sh_dmac_exit);
=20
 MODULE_AUTHOR("Takashi YOSHII, Paul Mundt, Andriy Skulysh");
 MODULE_DESCRIPTION("SuperH On-Chip DMAC Support");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysf=
s.c
index 4b15fed..8ef3181 100644
--- a/arch/sh/drivers/dma/dma-sysfs.c
+++ b/arch/sh/drivers/dma/dma-sysfs.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/dma/dma-sysfs.c
  *
  * sysfs interface for SH DMA API
  *
  * Copyright (C) 2004 - 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/sh/drivers/dma/dmabrg.c b/arch/sh/drivers/dma/dmabrg.c
index e5a57a1..5b2c1fd 100644
--- a/arch/sh/drivers/dma/dmabrg.c
+++ b/arch/sh/drivers/dma/dmabrg.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH7760 DMABRG IRQ handling
  *
  * (c) 2007 MSC Vertriebsges.m.b.H, Manuel Lauss <mlau@msc-ge.com>
- *  licensed under the GPLv2.
- *
  */
=20
 #include <linux/interrupt.h>
diff --git a/arch/sh/drivers/heartbeat.c b/arch/sh/drivers/heartbeat.c
index e8af2ff..cf2fccc 100644
--- a/arch/sh/drivers/heartbeat.c
+++ b/arch/sh/drivers/heartbeat.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic heartbeat driver for regular LED banks
  *
@@ -13,10 +14,6 @@
  * traditionally used for strobing the load average. This use case is
  * handled by this driver, rather than giving each LED bit position its
  * own struct device.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/f=
ixups-dreamcast.c
index 48aaefd..dfdbd05 100644
--- a/arch/sh/drivers/pci/fixups-dreamcast.c
+++ b/arch/sh/drivers/pci/fixups-dreamcast.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/fixups-dreamcast.c
  *
@@ -9,10 +10,6 @@
  * This file originally bore the message (with enclosed-$):
  *	Id: pci.c,v 1.3 2003/05/04 19:29:46 lethal Exp
  *	Dreamcast PCI: Supports SEGA Broadband Adaptor only.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/sched.h>
diff --git a/arch/sh/drivers/pci/fixups-landisk.c b/arch/sh/drivers/pci/fix=
ups-landisk.c
index db5b40a..53fa2fc 100644
--- a/arch/sh/drivers/pci/fixups-landisk.c
+++ b/arch/sh/drivers/pci/fixups-landisk.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/fixups-landisk.c
  *
@@ -5,9 +6,6 @@
  *
  * Copyright (C) 2006 kogiidena
  * Copyright (C) 2010 Nobuhiro Iwamatsu
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
 #include <linux/kernel.h>
 #include <linux/types.h>
diff --git a/arch/sh/drivers/pci/fixups-r7780rp.c b/arch/sh/drivers/pci/fix=
ups-r7780rp.c
index 2c9b58f..3c9139c 100644
--- a/arch/sh/drivers/pci/fixups-r7780rp.c
+++ b/arch/sh/drivers/pci/fixups-r7780rp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/fixups-r7780rp.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2003  Lineo uSolutions, Inc.
  * Copyright (C) 2004 - 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/pci.h>
 #include <linux/io.h>
diff --git a/arch/sh/drivers/pci/fixups-rts7751r2d.c b/arch/sh/drivers/pci/=
fixups-rts7751r2d.c
index 358ac10..3f0a6fe 100644
--- a/arch/sh/drivers/pci/fixups-rts7751r2d.c
+++ b/arch/sh/drivers/pci/fixups-rts7751r2d.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/fixups-rts7751r2d.c
  *
@@ -6,10 +7,6 @@
  * Copyright (C) 2003  Lineo uSolutions, Inc.
  * Copyright (C) 2004  Paul Mundt
  * Copyright (C) 2007  Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/pci.h>
 #include <mach/lboxre2.h>
diff --git a/arch/sh/drivers/pci/fixups-sdk7780.c b/arch/sh/drivers/pci/fix=
ups-sdk7780.c
index 24e96df..c306040 100644
--- a/arch/sh/drivers/pci/fixups-sdk7780.c
+++ b/arch/sh/drivers/pci/fixups-sdk7780.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/fixups-sdk7780.c
  *
@@ -6,10 +7,6 @@
  * Copyright (C) 2003  Lineo uSolutions, Inc.
  * Copyright (C) 2004 - 2006  Paul Mundt
  * Copyright (C) 2006  Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/pci.h>
 #include <linux/io.h>
diff --git a/arch/sh/drivers/pci/fixups-sdk7786.c b/arch/sh/drivers/pci/fix=
ups-sdk7786.c
index 36eb6fc..8cbfa531 100644
--- a/arch/sh/drivers/pci/fixups-sdk7786.c
+++ b/arch/sh/drivers/pci/fixups-sdk7786.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SDK7786 FPGA PCIe mux handling
  *
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define pr_fmt(fmt) "PCI: " fmt
=20
diff --git a/arch/sh/drivers/pci/fixups-snapgear.c b/arch/sh/drivers/pci/fi=
xups-snapgear.c
index a931e59..317225c 100644
--- a/arch/sh/drivers/pci/fixups-snapgear.c
+++ b/arch/sh/drivers/pci/fixups-snapgear.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/ops-snapgear.c
  *
@@ -7,9 +8,6 @@
  *
  * Highly leveraged from pci-bigsur.c, written by Dustin McIntire.
  *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
  * PCI initialization for the SnapGear boards
  */
 #include <linux/kernel.h>
diff --git a/arch/sh/drivers/pci/fixups-titan.c b/arch/sh/drivers/pci/fixup=
s-titan.c
index a9d563e..b5bb65c 100644
--- a/arch/sh/drivers/pci/fixups-titan.c
+++ b/arch/sh/drivers/pci/fixups-titan.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/pci/ops-titan.c
  *
@@ -6,9 +7,6 @@
  * Modified from ops-snapgear.c written by  David McCullough
  * Highly leveraged from pci-bigsur.c, written by Dustin McIntire.
  *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
  * PCI initialization for the Titan boards
  */
 #include <linux/kernel.h>
diff --git a/arch/sh/drivers/pci/ops-dreamcast.c b/arch/sh/drivers/pci/ops-=
dreamcast.c
index 16e0a1b..517a8a97 100644
--- a/arch/sh/drivers/pci/ops-dreamcast.c
+++ b/arch/sh/drivers/pci/ops-dreamcast.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * PCI operations for the Sega Dreamcast
  *
  * Copyright (C) 2001, 2002  M. R. Brown
  * Copyright (C) 2002, 2003  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/sched.h>
diff --git a/arch/sh/drivers/pci/ops-sh4.c b/arch/sh/drivers/pci/ops-sh4.c
index b623420..a205be3 100644
--- a/arch/sh/drivers/pci/ops-sh4.c
+++ b/arch/sh/drivers/pci/ops-sh4.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic SH-4 / SH-4A PCIC operations (SH7751, SH7780).
  *
  * Copyright (C) 2002 - 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License v2. See the file "COPYING" in the main directory of this archiv=
e
- * for more details.
  */
 #include <linux/pci.h>
 #include <linux/io.h>
diff --git a/arch/sh/drivers/pci/ops-sh5.c b/arch/sh/drivers/pci/ops-sh5.c
index 4536194..9fbaf72 100644
--- a/arch/sh/drivers/pci/ops-sh5.c
+++ b/arch/sh/drivers/pci/ops-sh5.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Support functions for the SH5 PCI hardware.
  *
  * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
  * Copyright (C) 2003, 2004 Paul Mundt
  * Copyright (C) 2004 Richard Curnow
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
 #include <linux/kernel.h>
 #include <linux/rwsem.h>
diff --git a/arch/sh/drivers/pci/ops-sh7786.c b/arch/sh/drivers/pci/ops-sh7=
786.c
index 1284210..a10f9f4 100644
--- a/arch/sh/drivers/pci/ops-sh7786.c
+++ b/arch/sh/drivers/pci/ops-sh7786.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic SH7786 PCI-Express operations.
  *
  *  Copyright (C) 2009 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License v2. See the file "COPYING" in the main directory of this archiv=
e
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/sh/drivers/pci/pci-dreamcast.c b/arch/sh/drivers/pci/pci-=
dreamcast.c
index 6336941..4cff2a8 100644
--- a/arch/sh/drivers/pci/pci-dreamcast.c
+++ b/arch/sh/drivers/pci/pci-dreamcast.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * PCI support for the Sega Dreamcast
  *
@@ -7,10 +8,6 @@
  * This file originally bore the message (with enclosed-$):
  *	Id: pci.c,v 1.3 2003/05/04 19:29:46 lethal Exp
  *	Dreamcast PCI: Supports SEGA Broadband Adaptor only.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/sched.h>
diff --git a/arch/sh/drivers/pci/pci-sh5.c b/arch/sh/drivers/pci/pci-sh5.c
index 8229114c..49303fa 100644
--- a/arch/sh/drivers/pci/pci-sh5.c
+++ b/arch/sh/drivers/pci/pci-sh5.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
  * Copyright (C) 2003, 2004 Paul Mundt
  * Copyright (C) 2004 Richard Curnow
  *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
  * Support functions for the SH5 PCI hardware.
  */
=20
diff --git a/arch/sh/drivers/pci/pci-sh5.h b/arch/sh/drivers/pci/pci-sh5.h
index 3f01dec..91348af 100644
--- a/arch/sh/drivers/pci/pci-sh5.h
+++ b/arch/sh/drivers/pci/pci-sh5.h
@@ -1,8 +1,6 @@
-/*
- * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
+/* SPDX-License-Identifier: GPL-2.0
  *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
+ * Copyright (C) 2001 David J. Mckay (david.mckay@st.com)
  *
  * Definitions for the SH5 PCI hardware.
  */
diff --git a/arch/sh/drivers/pci/pci-sh7751.c b/arch/sh/drivers/pci/pci-sh7=
751.c
index 86adb1e..1b9e5ca 100644
--- a/arch/sh/drivers/pci/pci-sh7751.c
+++ b/arch/sh/drivers/pci/pci-sh7751.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Low-Level PCI Support for the SH7751
  *
@@ -5,10 +6,6 @@
  *  Copyright (C) 2001  Dustin McIntire
  *
  *  With cleanup by Paul van Gool <pvangool@mimotech.com>, 2003.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/pci.h>
diff --git a/arch/sh/drivers/pci/pci-sh7751.h b/arch/sh/drivers/pci/pci-sh7=
751.h
index 5ede38c..d1951e5 100644
--- a/arch/sh/drivers/pci/pci-sh7751.h
+++ b/arch/sh/drivers/pci/pci-sh7751.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  *	Low-Level PCI Support for SH7751 targets
  *
  *  Dustin McIntire (dustin@sensoria.com) (c) 2001
  *  Paul Mundt (lethal@linux-sh.org) (c) 2003
- *
- *  May be copied or modified under the terms of the GNU General Public
- *  License.  See linux/COPYING for more information.
- *
  */
=20
 #ifndef _PCI_SH7751_H_
diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7=
780.c
index 5a6dab6..3fd0f39 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Low-Level PCI Support for the SH7780
  *
  *  Copyright (C) 2005 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/types.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/drivers/pci/pci-sh7780.h b/arch/sh/drivers/pci/pci-sh7=
780.h
index 1742e2c..e2ac770 100644
--- a/arch/sh/drivers/pci/pci-sh7780.h
+++ b/arch/sh/drivers/pci/pci-sh7780.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  *	Low-Level PCI Support for SH7780 targets
  *
  *  Dustin McIntire (dustin@sensoria.com) (c) 2001
  *  Paul Mundt (lethal@linux-sh.org) (c) 2003
- *
- *  May be copied or modified under the terms of the GNU General Public
- *  License.  See linux/COPYING for more information.
- *
  */
=20
 #ifndef _PCI_SH7780_H_
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 8256626..c7784e1 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * New-style PCI core.
  *
@@ -6,10 +7,6 @@
  *
  * Modelled after arch/mips/pci/pci.c:
  *  Copyright (C) 2003, 04 Ralf Baechle (ralf@linux-mips.org)
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/mm.h>
diff --git a/arch/sh/drivers/pci/pcie-sh7786.c b/arch/sh/drivers/pci/pcie-s=
h7786.c
index 3d81a8b..a58b77c 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.c
+++ b/arch/sh/drivers/pci/pcie-sh7786.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Low-Level PCI Express Support for the SH7786
  *
  *  Copyright (C) 2009 - 2011  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define pr_fmt(fmt) "PCI: " fmt
=20
diff --git a/arch/sh/drivers/pci/pcie-sh7786.h b/arch/sh/drivers/pci/pcie-s=
h7786.h
index 4a6ff55..ffe3836 100644
--- a/arch/sh/drivers/pci/pcie-sh7786.h
+++ b/arch/sh/drivers/pci/pcie-sh7786.h
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * SH7786 PCI-Express controller definitions.
  *
  * Copyright (C) 2008, 2009 Renesas Technology Corp.
  * All rights reserved.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #ifndef __PCI_SH7786_H
 #define __PCI_SH7786_H
diff --git a/arch/sh/drivers/push-switch.c b/arch/sh/drivers/push-switch.c
index 762bc56..2813140 100644
--- a/arch/sh/drivers/push-switch.c
+++ b/arch/sh/drivers/push-switch.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic push-switch framework
  *
  * Copyright (C) 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/arch/sh/drivers/superhyway/Makefile b/arch/sh/drivers/superhyw=
ay/Makefile
index 5b8e0c7..aa6e326 100644
--- a/arch/sh/drivers/superhyway/Makefile
+++ b/arch/sh/drivers/superhyway/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the SuperHyway specific kernel interface routines under Lin=
ux.
 #
diff --git a/arch/sh/drivers/superhyway/ops-sh4-202.c b/arch/sh/drivers/sup=
erhyway/ops-sh4-202.c
index 6da62e9..4901422 100644
--- a/arch/sh/drivers/superhyway/ops-sh4-202.c
+++ b/arch/sh/drivers/superhyway/ops-sh4-202.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/drivers/superhyway/ops-sh4-202.c
  *
  * SuperHyway bus support for SH4-202
  *
  * Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU
- * General Public License.  See the file "COPYING" in the main
- * directory of this archive for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
--=20
2.7.4

