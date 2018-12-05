Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE197C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E96206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="FLnpOZrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E96206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeLEIBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:01:55 -0500
Received: from mail-eopbgr1410137.outbound.protection.outlook.com ([40.107.141.137]:28904
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbeLEIBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlVFFbyrR/uDpAIKhh3vbZWBaf635x6A3PlVdl2bz3Q=;
 b=FLnpOZrwWhJIOlZpGETHZuvdgqHnv8ZyOwv+1CMEvm/6m7QgGLsgKeDq+bL8CmFZ/pQH747pao8reNxmce+rf6SIV4/ecF3zwz4UjiYo/JTxIpI0gKlZ6i4Q5bRfJQaRboUvhAAeWs3ZiXetsGzPQhPGdNDgPhysKpQVyx7RQ5w=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB1998.jpnprd01.prod.outlook.com (52.133.178.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 08:01:47 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:01:47 +0000
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
Subject: [PATCH 12/13] sh: kernel: convert to SPDX identifiers
Thread-Topic: [PATCH 12/13] sh: kernel: convert to SPDX identifiers
Thread-Index: AQHUjHDEAakE6b6RJE+7H6vBAAPamQ==
Date:   Wed, 5 Dec 2018 08:01:46 +0000
Message-ID: <8736rccswn.wl-kuninori.morimoto.gx@renesas.com>
References: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY1PR01CA0136.jpnprd01.prod.outlook.com
 (2603:1096:402:1::12) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB1998;20:ZAEb073GJvEHIJyjq+vWFSyVFYDopslGZHG4s/GkW6bkHyxnKqD/K/nf7gJQHOICJIeSnhe3p9OTYApPxJ6QeTga88aEpoeOlKKPkW+74CahRvvE+NdkDNlbD+kekf90I1aGCsZ2H9q7K0my2hTBCMoSz3W5U0cYJ5ctVjXjH00=
x-ms-office365-filtering-correlation-id: cdd4e466-ea6d-46a7-5b5e-08d65a87e74f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB1998;
x-ms-traffictypediagnostic: TYAPR01MB1998:
x-microsoft-antispam-prvs: <TYAPR01MB1998133CF5888CEF798EF78FD4A80@TYAPR01MB1998.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(4982022)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB1998;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB1998;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(346002)(39860400002)(396003)(199004)(189003)(8676002)(26005)(186003)(476003)(102836004)(478600001)(6116002)(2906002)(3846002)(446003)(81166006)(11346002)(81156014)(6506007)(386003)(2616005)(8936002)(76176011)(71190400001)(256004)(4744004)(71200400001)(52116002)(14454004)(86362001)(5660300001)(575784001)(486006)(36756003)(54906003)(110136005)(66066001)(99286004)(25786009)(97736004)(68736007)(305945005)(7736002)(4326008)(966005)(6436002)(105586002)(53946003)(6512007)(6306002)(316002)(106356001)(53936002)(6486002)(2004002)(579004)(559001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB1998;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Lg3CNwIv6iRCWGhTSx3itactN303NpBYHJ/Sik6jJt2ggyDbQKtRVH0LDhmJMzGzwBsNoWlrr15jRrXLRcIp86ncyZJABTfeDyMCOaCkjWUBxWI9G1I3HLHf8SB08LuUSS1wljkQ5YCue/6f7Dy7wXHXZ/QOL1km7wWEz3cE3iciOR85lMKhySIsbnjoJie+8cU0bkafb/+z19/O44J8Esrfi6kvPUasWVHmg0jwrC6vH4bfd+4+z7FS9/sNNrgPlAQwEY6VCaspJBUdBqHoyMry20uiC4EnP9JKTixwap/DsR9DBk3mLVThaAorWjNxVGeQ0BMu5Pp1FhX/FzlUyuGmZBD2MMrdm9oADI7SRLA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA7D86C527E32C41B21E9332A201F12F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd4e466-ea6d-46a7-5b5e-08d65a87e74f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:01:46.9898
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
 arch/sh/kernel/debugtraps.S        |  7 ++-----
 arch/sh/kernel/disassemble.c       |  5 +----
 arch/sh/kernel/dma-coherent.c      |  5 +----
 arch/sh/kernel/dumpstack.c         |  5 +----
 arch/sh/kernel/dwarf.c             |  5 +----
 arch/sh/kernel/entry-common.S      |  8 ++------
 arch/sh/kernel/head_32.S           |  7 ++-----
 arch/sh/kernel/head_64.S           |  7 ++-----
 arch/sh/kernel/hw_breakpoint.c     |  5 +----
 arch/sh/kernel/idle.c              |  5 +----
 arch/sh/kernel/io.c                |  5 +----
 arch/sh/kernel/io_trapped.c        |  5 +----
 arch/sh/kernel/iomap.c             |  5 +----
 arch/sh/kernel/ioport.c            |  5 +----
 arch/sh/kernel/irq_32.c            |  5 +----
 arch/sh/kernel/irq_64.c            |  5 +----
 arch/sh/kernel/kgdb.c              |  5 +----
 arch/sh/kernel/kprobes.c           |  5 +----
 arch/sh/kernel/machine_kexec.c     |  4 +---
 arch/sh/kernel/machvec.c           |  5 +----
 arch/sh/kernel/module.c            | 15 +--------------
 arch/sh/kernel/nmi_debug.c         |  5 +----
 arch/sh/kernel/perf_callchain.c    |  5 +----
 arch/sh/kernel/perf_event.c        |  5 +----
 arch/sh/kernel/process_32.c        |  5 +----
 arch/sh/kernel/process_64.c        |  5 +----
 arch/sh/kernel/ptrace_32.c         |  5 +----
 arch/sh/kernel/ptrace_64.c         |  5 +----
 arch/sh/kernel/relocate_kernel.S   |  6 ++----
 arch/sh/kernel/return_address.c    |  5 +----
 arch/sh/kernel/sh_bios.c           |  5 +----
 arch/sh/kernel/sh_ksyms_64.c       |  5 +----
 arch/sh/kernel/signal_64.c         |  5 +----
 arch/sh/kernel/smp.c               |  5 +----
 arch/sh/kernel/stacktrace.c        |  5 +----
 arch/sh/kernel/swsusp.c            |  5 +----
 arch/sh/kernel/syscalls_32.S       |  8 ++------
 arch/sh/kernel/syscalls_64.S       |  7 ++-----
 arch/sh/kernel/time.c              |  5 +----
 arch/sh/kernel/topology.c          |  5 +----
 arch/sh/kernel/traps_32.c          |  5 +----
 arch/sh/kernel/traps_64.c          |  5 +----
 arch/sh/kernel/unwinder.c          |  1 +
 arch/sh/kernel/vsyscall/vsyscall.c |  5 +----
 44 files changed, 51 insertions(+), 189 deletions(-)

diff --git a/arch/sh/kernel/debugtraps.S b/arch/sh/kernel/debugtraps.S
index 7a1b46f..ad07527 100644
--- a/arch/sh/kernel/debugtraps.S
+++ b/arch/sh/kernel/debugtraps.S
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/debugtraps.S
  *
  * Debug trap jump tables for SuperH
  *
  *  Copyright (C) 2006 - 2008  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/sys.h>
 #include <linux/linkage.h>
diff --git a/arch/sh/kernel/disassemble.c b/arch/sh/kernel/disassemble.c
index 015fee5..defebf1 100644
--- a/arch/sh/kernel/disassemble.c
+++ b/arch/sh/kernel/disassemble.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Disassemble SuperH instructions.
  *
  * Copyright (C) 1999 kaz Kojima
  * Copyright (C) 2008 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/string.h>
diff --git a/arch/sh/kernel/dma-coherent.c b/arch/sh/kernel/dma-coherent.c
index a0021ee..b175146 100644
--- a/arch/sh/kernel/dma-coherent.c
+++ b/arch/sh/kernel/dma-coherent.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2004 - 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/mm.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index b564b1e..93c6c0e 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *  Copyright (C) 2000, 2001, 2002 Andi Kleen, SuSE Labs
  *  Copyright (C) 2009  Matt Fleming
  *  Copyright (C) 2002 - 2012  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kallsyms.h>
 #include <linux/ftrace.h>
diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index bb511e2..9e1d26c 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2009 Matt Fleming <matt@console-pimps.org>
  *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * This is an implementation of a DWARF unwinder. Its main purpose is
  * for generating stacktrace information. Based on the DWARF 3
  * specification from http://www.dwarfstd.org.
diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index 28cc612..d31f66e 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -1,11 +1,7 @@
-/*=20
+/* SPDX-License-Identifier: GPL-2.0
+ *
  *  Copyright (C) 1999, 2000, 2002  Niibe Yutaka
  *  Copyright (C) 2003 - 2008  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
=20
 ! NOTE:
diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
index 4e352c3..4adbd4a 100644
--- a/arch/sh/kernel/head_32.S
+++ b/arch/sh/kernel/head_32.S
@@ -1,14 +1,11 @@
-/* $Id: head.S,v 1.7 2003/09/01 17:58:19 lethal Exp $
+/* SPDX-License-Identifier: GPL-2.0
+ * $Id: head.S,v 1.7 2003/09/01 17:58:19 lethal Exp $
  *
  *  arch/sh/kernel/head.S
  *
  *  Copyright (C) 1999, 2000  Niibe Yutaka & Kaz Kojima
  *  Copyright (C) 2010  Matt Fleming
  *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Head.S contains the SH exception handlers and startup code.
  */
 #include <linux/init.h>
diff --git a/arch/sh/kernel/head_64.S b/arch/sh/kernel/head_64.S
index cca4913..67685e1 100644
--- a/arch/sh/kernel/head_64.S
+++ b/arch/sh/kernel/head_64.S
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/head_64.S
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003, 2004  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/init.h>
diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.=
c
index d9ff3b4..bc96b16 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/hw_breakpoint.c
  *
  * Unified kernel/user-space hardware breakpoint facility for the on-chip =
UBC.
  *
  * Copyright (C) 2009 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/perf_event.h>
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index be616ee..c20fc54 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * The idle loop for all SuperH platforms.
  *
  *  Copyright (C) 2002 - 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/io.c b/arch/sh/kernel/io.c
index 5c51b79..da22f3b 100644
--- a/arch/sh/kernel/io.c
+++ b/arch/sh/kernel/io.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/io.c - Machine independent I/O functions.
  *
  * Copyright (C) 2000 - 2009  Stuart Menefy
  * Copyright (C) 2005  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/arch/sh/kernel/io_trapped.c b/arch/sh/kernel/io_trapped.c
index 4d4e7a2..bacad6d 100644
--- a/arch/sh/kernel/io_trapped.c
+++ b/arch/sh/kernel/io_trapped.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Trapped io support
  *
  * Copyright (C) 2008 Magnus Damm
  *
  * Intercept io operations by trapping.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/mm.h>
diff --git a/arch/sh/kernel/iomap.c b/arch/sh/kernel/iomap.c
index 2e8e8b9..ef9e2c9 100644
--- a/arch/sh/kernel/iomap.c
+++ b/arch/sh/kernel/iomap.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/iomap.c
  *
  * Copyright (C) 2000  Niibe Yutaka
  * Copyright (C) 2005 - 2007 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/module.h>
 #include <linux/io.h>
diff --git a/arch/sh/kernel/ioport.c b/arch/sh/kernel/ioport.c
index cca14ba..34f8cdb 100644
--- a/arch/sh/kernel/ioport.c
+++ b/arch/sh/kernel/ioport.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/ioport.c
  *
  * Copyright (C) 2000  Niibe Yutaka
  * Copyright (C) 2005 - 2007 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/module.h>
 #include <linux/io.h>
diff --git a/arch/sh/kernel/irq_32.c b/arch/sh/kernel/irq_32.c
index e5a755b..e09cdc4 100644
--- a/arch/sh/kernel/irq_32.c
+++ b/arch/sh/kernel/irq_32.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SHcompact irqflags support
  *
  * Copyright (C) 2006 - 2009 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/irqflags.h>
 #include <linux/module.h>
diff --git a/arch/sh/kernel/irq_64.c b/arch/sh/kernel/irq_64.c
index 8fc05b9..7a1f504 100644
--- a/arch/sh/kernel/irq_64.c
+++ b/arch/sh/kernel/irq_64.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SHmedia irqflags support
  *
  * Copyright (C) 2006 - 2009 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/irqflags.h>
 #include <linux/module.h>
diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
index 4f04c66..d24bd2d 100644
--- a/arch/sh/kernel/kgdb.c
+++ b/arch/sh/kernel/kgdb.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH KGDB support
  *
  * Copyright (C) 2008 - 2012  Paul Mundt
  *
  * Single stepping taken from the old stub by Henry Bell and Jeremy Siegel=
.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kgdb.h>
 #include <linux/kdebug.h>
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 241e903..1f8c0d3 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Kernel probes (kprobes) for SuperH
  *
  * Copyright (C) 2007 Chris Smith <chris.smith@st.com>
  * Copyright (C) 2006 Lineo Solutions, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kprobes.h>
 #include <linux/extable.h>
diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.=
c
index 9fea49f..b9f9f1a 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * machine_kexec.c - handle transition of Linux booting another kernel
  * Copyright (C) 2002-2003 Eric Biederman  <ebiederm@xmission.com>
  *
  * GameCube/ppc32 port Copyright (C) 2004 Albert Herranz
  * LANDISK/sh4 supported by kogiidena
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2.  See the file COPYING for more details.
  */
 #include <linux/mm.h>
 #include <linux/kexec.h>
diff --git a/arch/sh/kernel/machvec.c b/arch/sh/kernel/machvec.c
index ec05f49..beadbbd 100644
--- a/arch/sh/kernel/machvec.c
+++ b/arch/sh/kernel/machvec.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/machvec.c
  *
@@ -5,10 +6,6 @@
  *
  *  Copyright (C) 1999  Niibe Yutaka
  *  Copyright (C) 2002 - 2007 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/string.h>
diff --git a/arch/sh/kernel/module.c b/arch/sh/kernel/module.c
index 1b525de..bbc78d1 100644
--- a/arch/sh/kernel/module.c
+++ b/arch/sh/kernel/module.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*  Kernel module help for SH.
=20
     SHcompact version by Kaz Kojima and Paul Mundt.
@@ -9,20 +10,6 @@
=20
 	Based on the sh version, and on code from the sh64-specific parts of
 	modutils, originally written by Richard Curnow and Ben Gaster.
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  =
USA
 */
 #include <linux/moduleloader.h>
 #include <linux/elf.h>
diff --git a/arch/sh/kernel/nmi_debug.c b/arch/sh/kernel/nmi_debug.c
index 730d928..1177786 100644
--- a/arch/sh/kernel/nmi_debug.c
+++ b/arch/sh/kernel/nmi_debug.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2007 Atmel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include <linux/delay.h>
 #include <linux/kdebug.h>
diff --git a/arch/sh/kernel/perf_callchain.c b/arch/sh/kernel/perf_callchai=
n.c
index fa2c0cd..6281f2f 100644
--- a/arch/sh/kernel/perf_callchain.c
+++ b/arch/sh/kernel/perf_callchain.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Performance event callchain support - SuperH architecture code
  *
  * Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/sched.h>
diff --git a/arch/sh/kernel/perf_event.c b/arch/sh/kernel/perf_event.c
index ba3269a..445e3ec 100644
--- a/arch/sh/kernel/perf_event.c
+++ b/arch/sh/kernel/perf_event.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Performance event support framework for SuperH hardware counters.
  *
@@ -15,10 +16,6 @@
  *
  * ppc:
  *  Copyright 2008-2009 Paul Mackerras, IBM Corporation.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/process_32.c b/arch/sh/kernel/process_32.c
index 27fddb5..a094633 100644
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/process.c
  *
@@ -8,10 +9,6 @@
  *  SuperH version:  Copyright (C) 1999, 2000  Niibe Yutaka & Kaz Kojima
  *		     Copyright (C) 2006 Lineo Solutions Inc. support SH4A UBC
  *		     Copyright (C) 2002 - 2008  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/module.h>
 #include <linux/mm.h>
diff --git a/arch/sh/kernel/process_64.c b/arch/sh/kernel/process_64.c
index ee2abe96..c2844a2 100644
--- a/arch/sh/kernel/process_64.c
+++ b/arch/sh/kernel/process_64.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/process_64.c
  *
@@ -12,10 +13,6 @@
  *
  *   In turn started from i386 version:
  *     Copyright (C) 1995  Linus Torvalds
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/mm.h>
 #include <linux/fs.h>
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 5fc3ff6..d5052c3 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SuperH process tracing
  *
@@ -5,10 +6,6 @@
  * Copyright (C) 2002 - 2009  Paul Mundt
  *
  * Audit support by Yuichi Nakamura <ynakam@hitachisoft.jp>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/sched.h>
diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index 1e0656d..3390349 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/ptrace_64.c
  *
@@ -10,10 +11,6 @@
  *   Original x86 implementation:
  *	By Ross Biro 1/23/92
  *	edited by Linus Torvalds
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/rwsem.h>
diff --git a/arch/sh/kernel/relocate_kernel.S b/arch/sh/kernel/relocate_ker=
nel.S
index fcc9934..d9bf2b7 100644
--- a/arch/sh/kernel/relocate_kernel.S
+++ b/arch/sh/kernel/relocate_kernel.S
@@ -1,13 +1,11 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * relocate_kernel.S - put the kernel image in place to boot
  * 2005.9.17 kogiidena@eggplant.ddo.jp
  *
  * LANDISK/sh4 is supported. Maybe, SH archtecture works well.
  *
  * 2009-03-18 Magnus Damm - Added Kexec Jump support
- *
- * This source code is licensed under the GNU General Public License,
- * Version 2.  See the file COPYING for more details.
  */
 #include <linux/linkage.h>
 #include <asm/addrspace.h>
diff --git a/arch/sh/kernel/return_address.c b/arch/sh/kernel/return_addres=
s.c
index 5124aeb..8838094 100644
--- a/arch/sh/kernel/return_address.c
+++ b/arch/sh/kernel/return_address.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/return_address.c
  *
  * Copyright (C) 2009  Matt Fleming
  * Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/arch/sh/kernel/sh_bios.c b/arch/sh/kernel/sh_bios.c
index fe584e5..250dbdf 100644
--- a/arch/sh/kernel/sh_bios.c
+++ b/arch/sh/kernel/sh_bios.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  C interface for trapping into the standard LinuxSH BIOS.
  *
@@ -5,10 +6,6 @@
  *  Copyright (C) 1999, 2000  Niibe Yutaka
  *  Copyright (C) 2002  M. R. Brown
  *  Copyright (C) 2004 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/module.h>
 #include <linux/console.h>
diff --git a/arch/sh/kernel/sh_ksyms_64.c b/arch/sh/kernel/sh_ksyms_64.c
index 6ee3740..9de1706 100644
--- a/arch/sh/kernel/sh_ksyms_64.c
+++ b/arch/sh/kernel/sh_ksyms_64.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/sh_ksyms_64.c
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/rwsem.h>
 #include <linux/module.h>
diff --git a/arch/sh/kernel/signal_64.c b/arch/sh/kernel/signal_64.c
index 7b77f18..76661de 100644
--- a/arch/sh/kernel/signal_64.c
+++ b/arch/sh/kernel/signal_64.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/signal_64.c
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003 - 2008  Paul Mundt
  * Copyright (C) 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/rwsem.h>
 #include <linux/sched.h>
diff --git a/arch/sh/kernel/smp.c b/arch/sh/kernel/smp.c
index c483422..372acdc 100644
--- a/arch/sh/kernel/smp.c
+++ b/arch/sh/kernel/smp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/smp.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2002 - 2010 Paul Mundt
  * Copyright (C) 2006 - 2007 Akio Idehara
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/err.h>
 #include <linux/cache.h>
diff --git a/arch/sh/kernel/stacktrace.c b/arch/sh/kernel/stacktrace.c
index 7a73d27..f3cb2cc 100644
--- a/arch/sh/kernel/stacktrace.c
+++ b/arch/sh/kernel/stacktrace.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/stacktrace.c
  *
  * Stack trace management functions
  *
  *  Copyright (C) 2006 - 2008  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
diff --git a/arch/sh/kernel/swsusp.c b/arch/sh/kernel/swsusp.c
index 12b64a0..0b772d6 100644
--- a/arch/sh/kernel/swsusp.c
+++ b/arch/sh/kernel/swsusp.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * swsusp.c - SuperH hibernation support
  *
  * Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/mm.h>
diff --git a/arch/sh/kernel/syscalls_32.S b/arch/sh/kernel/syscalls_32.S
index 254bc22..94b088d 100644
--- a/arch/sh/kernel/syscalls_32.S
+++ b/arch/sh/kernel/syscalls_32.S
@@ -1,15 +1,11 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/syscalls.S
  *
  * System call table for SuperH
  *
  *  Copyright (C) 1999, 2000, 2002  Niibe Yutaka
  *  Copyright (C) 2003  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <linux/sys.h>
 #include <linux/linkage.h>
diff --git a/arch/sh/kernel/syscalls_64.S b/arch/sh/kernel/syscalls_64.S
index d6a27f7..1bcb86f 100644
--- a/arch/sh/kernel/syscalls_64.S
+++ b/arch/sh/kernel/syscalls_64.S
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/syscalls_64.S
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2004 - 2007  Paul Mundt
  * Copyright (C) 2003, 2004 Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/sys.h>
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index fcd5e41..6742d6e 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  arch/sh/kernel/time.c
  *
@@ -5,10 +6,6 @@
  *  Copyright (C) 2000  Philipp Rumpf <prumpf@tux.org>
  *  Copyright (C) 2002 - 2009  Paul Mundt
  *  Copyright (C) 2002  M. R. Brown  <mrbrown@linux-sh.org>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/sh/kernel/topology.c b/arch/sh/kernel/topology.c
index c82912a..7a989ee 100644
--- a/arch/sh/kernel/topology.c
+++ b/arch/sh/kernel/topology.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/topology.c
  *
  *  Copyright (C) 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 60709ad..f2a18b5 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * 'traps.c' handles hardware traps and faults after we have saved some
  * state in 'entry.S'.
@@ -6,10 +7,6 @@
  *                  Copyright (C) 2000 Philipp Rumpf
  *                  Copyright (C) 2000 David Howells
  *                  Copyright (C) 2002 - 2010 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/kernel.h>
 #include <linux/ptrace.h>
diff --git a/arch/sh/kernel/traps_64.c b/arch/sh/kernel/traps_64.c
index 014fb08..c52bda4 100644
--- a/arch/sh/kernel/traps_64.c
+++ b/arch/sh/kernel/traps_64.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/traps_64.c
  *
  * Copyright (C) 2000, 2001  Paolo Alberelli
  * Copyright (C) 2003, 2004  Paul Mundt
  * Copyright (C) 2003, 2004  Richard Curnow
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
diff --git a/arch/sh/kernel/unwinder.c b/arch/sh/kernel/unwinder.c
index 521b543..7a54b72 100644
--- a/arch/sh/kernel/unwinder.c
+++ b/arch/sh/kernel/unwinder.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2009  Matt Fleming
  *
diff --git a/arch/sh/kernel/vsyscall/vsyscall.c b/arch/sh/kernel/vsyscall/v=
syscall.c
index cc0cc5b..9849448 100644
--- a/arch/sh/kernel/vsyscall/vsyscall.c
+++ b/arch/sh/kernel/vsyscall/vsyscall.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/vsyscall/vsyscall.c
  *
@@ -5,10 +6,6 @@
  *
  * vDSO randomization
  * Copyright(C) 2005-2006, Red Hat, Inc., Ingo Molnar
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/mm.h>
 #include <linux/kernel.h>
--=20
2.7.4

