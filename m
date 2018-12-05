Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1704C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A7820850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="AsHhye0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A7820850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeLEH7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:59:42 -0500
Received: from mail-eopbgr1400091.outbound.protection.outlook.com ([40.107.140.91]:43355
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeLEH7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rowbz7QYvF14HtnFIEc3m2oPYbsXDR1FRlbkOu8hxRQ=;
 b=AsHhye0ttaSafegZ8ABRLwrtX1VknkzpsFmIYJO+RiLfFpOV47j1x/B5f9YNYGsqOMGRmuBAdh+ZPlA8fQa3Ct2Mw+5IbexAsGwQXPhPlD6eeoqPMol8d5uF5MmxWIu3qyJMB1Ay8TI8Aq4Rz4OI4YFXGFkWIYZdojdATTFfJQw=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2430.jpnprd01.prod.outlook.com (20.177.103.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.18; Wed, 5 Dec 2018 07:59:22 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 07:59:22 +0000
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
Subject: [PATCH 01/13] sh: boards: convert to SPDX identifiers
Thread-Topic: [PATCH 01/13] sh: boards: convert to SPDX identifiers
Thread-Index: AQHUjHBujb0Cde+UO0eUpn5XQYdJOQ==
Date:   Wed, 5 Dec 2018 07:59:22 +0000
Message-ID: <87in08ct0n.wl-kuninori.morimoto.gx@renesas.com>
References: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TYAPR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:404:14::19) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2430;20:OygFGQSWAp7fymGcTKPYmAmNsso7AcpnlfFOzShU3IabqA2msABBIl4hf1gftmpEgeJGYIiWymAtFG+hEG9xvQVVMYYbsKSPxTk2M3NG0ZU3bFtc3ERHxpQ7cp1YYT3z5wx5b46XjWMgAEco6SFDjH5Jo6d8Yk2Kv9V10znsXkk=
x-ms-office365-filtering-correlation-id: d0b353c3-61fe-4ee6-dc51-08d65a879119
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2430;
x-ms-traffictypediagnostic: TYAPR01MB2430:
x-microsoft-antispam-prvs: <TYAPR01MB2430509A4D073F723379C493D4A80@TYAPR01MB2430.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231455)(999002)(944501520)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2430;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2430;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39860400002)(366004)(136003)(199004)(189003)(3846002)(6506007)(97736004)(476003)(386003)(5660300001)(8936002)(81156014)(81166006)(52116002)(6116002)(8676002)(76176011)(36756003)(2616005)(4326008)(86362001)(256004)(575784001)(99286004)(316002)(2906002)(25786009)(110136005)(54906003)(186003)(14454004)(478600001)(6512007)(446003)(6486002)(7736002)(105586002)(53946003)(486006)(106356001)(6436002)(53936002)(11346002)(305945005)(66066001)(71200400001)(71190400001)(4744004)(68736007)(102836004)(26005)(2004002)(559001)(569006);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2430;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: T3EOn4jY0+5B3cKb15tCpVF5U4KjvonsY4HjY2AZbLQpE+Oq1i+BHROY9tuCTQ00JKZCIoiq0YowaACZWohsL/1n5NzcdJMxBQYBsoDBAYBayWghhR7TSJlL7jNfeGv6pxxk5+MNuYTXtWohWXt20kaf5zc57WrjtHRLUJoZF5p+cVUVwpJ+eNC65vUHEReQkl3F1xKmujvmUchZwuzChHhEq+EYpk1YoBsJHJF3+oK5eAOnwaw/6GAQFX4gcGQvyszt4zdJEXfATAI1xqX4qnXnMGE8c0W6umsZ3Th5ucS/2i0Q8VpWKMEItrVEaUwErxNu5EAWCt5usZDmk4XZuXpWVTyfGRTlRHHKMHmClmA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <25480E3054DCAF479765608D436662E2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b353c3-61fe-4ee6-dc51-08d65a879119
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 07:59:22.3681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2430
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
 arch/sh/boards/board-apsh4a3a.c                 |  5 +----
 arch/sh/boards/board-apsh4ad0a.c                |  5 +----
 arch/sh/boards/board-edosk7760.c                | 15 +--------------
 arch/sh/boards/board-espt.c                     |  5 +----
 arch/sh/boards/board-magicpanelr2.c             |  5 +----
 arch/sh/boards/board-sh7757lcr.c                |  5 +----
 arch/sh/boards/board-sh7785lcr.c                |  5 +----
 arch/sh/boards/board-titan.c                    |  5 +----
 arch/sh/boards/board-urquell.c                  |  5 +----
 arch/sh/boards/mach-ap325rxa/Makefile           |  1 +
 arch/sh/boards/mach-ap325rxa/sdram.S            |  7 ++-----
 arch/sh/boards/mach-cayman/Makefile             |  1 +
 arch/sh/boards/mach-cayman/irq.c                |  5 +----
 arch/sh/boards/mach-cayman/panic.c              |  5 +----
 arch/sh/boards/mach-cayman/setup.c              |  5 +----
 arch/sh/boards/mach-dreamcast/Makefile          |  1 +
 arch/sh/boards/mach-dreamcast/irq.c             |  2 +-
 arch/sh/boards/mach-dreamcast/rtc.c             |  4 +---
 arch/sh/boards/mach-dreamcast/setup.c           |  3 +--
 arch/sh/boards/mach-ecovec24/Makefile           |  3 ++-
 arch/sh/boards/mach-ecovec24/sdram.S            |  7 ++-----
 arch/sh/boards/mach-ecovec24/setup.c            |  5 +----
 arch/sh/boards/mach-highlander/irq-r7780mp.c    |  5 +----
 arch/sh/boards/mach-highlander/irq-r7780rp.c    |  5 +----
 arch/sh/boards/mach-highlander/irq-r7785rp.c    |  5 +----
 arch/sh/boards/mach-highlander/pinmux-r7785rp.c |  5 +----
 arch/sh/boards/mach-highlander/psw.c            |  5 +----
 arch/sh/boards/mach-highlander/setup.c          |  5 +----
 arch/sh/boards/mach-hp6xx/Makefile              |  1 +
 arch/sh/boards/mach-hp6xx/hp6xx_apm.c           |  4 +---
 arch/sh/boards/mach-hp6xx/pm.c                  |  4 +---
 arch/sh/boards/mach-hp6xx/pm_wakeup.S           |  8 ++------
 arch/sh/boards/mach-hp6xx/setup.c               |  4 +---
 arch/sh/boards/mach-kfr2r09/Makefile            |  1 +
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c         |  5 +----
 arch/sh/boards/mach-kfr2r09/sdram.S             |  7 ++-----
 arch/sh/boards/mach-landisk/Makefile            |  1 +
 arch/sh/boards/mach-landisk/gio.c               |  6 +-----
 arch/sh/boards/mach-landisk/irq.c               |  5 +----
 arch/sh/boards/mach-landisk/psw.c               |  5 +----
 arch/sh/boards/mach-landisk/setup.c             |  5 +----
 arch/sh/boards/mach-lboxre2/Makefile            |  1 +
 arch/sh/boards/mach-lboxre2/irq.c               |  6 +-----
 arch/sh/boards/mach-lboxre2/setup.c             |  6 +-----
 arch/sh/boards/mach-microdev/Makefile           |  1 +
 arch/sh/boards/mach-microdev/fdc37c93xapm.c     |  5 +----
 arch/sh/boards/mach-microdev/io.c               |  4 +---
 arch/sh/boards/mach-microdev/irq.c              |  4 +---
 arch/sh/boards/mach-microdev/setup.c            |  4 +---
 arch/sh/boards/mach-migor/Makefile              |  1 +
 arch/sh/boards/mach-migor/lcd_qvga.c            |  5 +----
 arch/sh/boards/mach-migor/sdram.S               |  7 ++-----
 arch/sh/boards/mach-r2d/Makefile                |  1 +
 arch/sh/boards/mach-r2d/setup.c                 |  5 +----
 arch/sh/boards/mach-rsk/Makefile                |  1 +
 arch/sh/boards/mach-rsk/devices-rsk7203.c       |  5 +----
 arch/sh/boards/mach-rsk/devices-rsk7264.c       |  5 +----
 arch/sh/boards/mach-rsk/devices-rsk7269.c       |  5 +----
 arch/sh/boards/mach-rsk/setup.c                 |  5 +----
 arch/sh/boards/mach-sdk7780/Makefile            |  1 +
 arch/sh/boards/mach-sdk7780/irq.c               |  5 +----
 arch/sh/boards/mach-sdk7780/setup.c             |  5 +----
 arch/sh/boards/mach-sdk7786/Makefile            |  1 +
 arch/sh/boards/mach-sdk7786/fpga.c              |  5 +----
 arch/sh/boards/mach-sdk7786/gpio.c              |  5 +----
 arch/sh/boards/mach-sdk7786/irq.c               |  5 +----
 arch/sh/boards/mach-sdk7786/nmi.c               |  5 +----
 arch/sh/boards/mach-sdk7786/setup.c             |  5 +----
 arch/sh/boards/mach-sdk7786/sram.c              |  5 +----
 arch/sh/boards/mach-se/7206/Makefile            |  1 +
 arch/sh/boards/mach-se/7343/Makefile            |  1 +
 arch/sh/boards/mach-se/7343/irq.c               |  5 +----
 arch/sh/boards/mach-se/770x/Makefile            |  1 +
 arch/sh/boards/mach-se/7721/Makefile            |  1 +
 arch/sh/boards/mach-se/7721/irq.c               |  5 +----
 arch/sh/boards/mach-se/7721/setup.c             |  6 +-----
 arch/sh/boards/mach-se/7722/Makefile            |  1 +
 arch/sh/boards/mach-se/7722/irq.c               |  5 +----
 arch/sh/boards/mach-se/7722/setup.c             |  6 +-----
 arch/sh/boards/mach-se/7724/Makefile            |  1 +
 arch/sh/boards/mach-se/7724/irq.c               |  5 +----
 arch/sh/boards/mach-se/7724/sdram.S             |  7 ++-----
 arch/sh/boards/mach-se/7751/Makefile            |  1 +
 arch/sh/boards/mach-se/7780/Makefile            |  1 +
 arch/sh/boards/mach-se/7780/irq.c               |  5 +----
 arch/sh/boards/mach-se/7780/setup.c             |  5 +----
 arch/sh/boards/mach-sh03/Makefile               |  1 +
 arch/sh/boards/mach-sh7763rdp/Makefile          |  1 +
 arch/sh/boards/mach-sh7763rdp/irq.c             |  5 +----
 arch/sh/boards/mach-sh7763rdp/setup.c           |  5 +----
 arch/sh/boards/mach-x3proto/Makefile            |  1 +
 arch/sh/boards/mach-x3proto/gpio.c              |  5 +----
 arch/sh/boards/mach-x3proto/ilsel.c             |  5 +----
 arch/sh/boards/mach-x3proto/setup.c             |  5 +----
 arch/sh/boards/of-generic.c                     |  5 +----
 95 files changed, 102 insertions(+), 291 deletions(-)

diff --git a/arch/sh/boards/board-apsh4a3a.c b/arch/sh/boards/board-apsh4a3=
a.c
index 0a39c24..346eda7 100644
--- a/arch/sh/boards/board-apsh4a3a.c
+++ b/arch/sh/boards/board-apsh4a3a.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ALPHAPROJECT AP-SH4A-3A Support.
  *
  * Copyright (C) 2010 ALPHAPROJECT Co.,Ltd.
  * Copyright (C) 2008  Yoshihiro Shimoda
  * Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/board-apsh4ad0a.c b/arch/sh/boards/board-apsh4a=
d0a.c
index 92eac3a..4efa9c5 100644
--- a/arch/sh/boards/board-apsh4ad0a.c
+++ b/arch/sh/boards/board-apsh4ad0a.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ALPHAPROJECT AP-SH4AD-0A Support.
  *
  * Copyright (C) 2010 ALPHAPROJECT Co.,Ltd.
  * Copyright (C) 2010  Matt Fleming
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/board-edosk7760.c b/arch/sh/boards/board-edosk7=
760.c
index bab5b95..0fbe91c 100644
--- a/arch/sh/boards/board-edosk7760.c
+++ b/arch/sh/boards/board-edosk7760.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Renesas Europe EDOSK7760 Board Support
  *
  * Copyright (C) 2008 SPES Societa' Progettazione Elettronica e Software L=
td.
  * Author: Luca Santini <luca.santini@spesonline.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/arch/sh/boards/board-espt.c b/arch/sh/boards/board-espt.c
index 4d6be53..f478fee 100644
--- a/arch/sh/boards/board-espt.c
+++ b/arch/sh/boards/board-espt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Data Technology Inc. ESPT-GIGA board support
  *
  * Copyright (C) 2008, 2009 Renesas Solutions Corp.
  * Copyright (C) 2008, 2009 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.c=
om>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/board-magicpanelr2.c b/arch/sh/boards/board-mag=
icpanelr2.c
index 2050085..56bd386 100644
--- a/arch/sh/boards/board-magicpanelr2.c
+++ b/arch/sh/boards/board-magicpanelr2.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/magicpanel/setup.c
  *
  *  Copyright (C) 2007  Markus Brunner, Mark Jonas
  *
  *  Magic Panel Release 2 board setup
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757=
lcr.c
index 1bde08d..c32b4c6 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R0P7757LC0012RL Support.
  *
  * Copyright (C) 2009 - 2010  Renesas Solutions Corp.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/init.h>
diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785=
lcr.c
index 3cba60f..d964c4d 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Technology Corp. R0P7785LC0011RL Support.
  *
  * Copyright (C) 2008  Yoshihiro Shimoda
  * Copyright (C) 2009  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/board-titan.c b/arch/sh/boards/board-titan.c
index 94c36c7b..074a848 100644
--- a/arch/sh/boards/board-titan.c
+++ b/arch/sh/boards/board-titan.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/titan/setup.c - Setup for Titan
  *
  *  Copyright (C) 2006  Jamie Lenehan
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/board-urquell.c b/arch/sh/boards/board-urquell.=
c
index b52abcc..799af57 100644
--- a/arch/sh/boards/board-urquell.c
+++ b/arch/sh/boards/board-urquell.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Technology Corp. SH7786 Urquell Support.
  *
@@ -6,10 +7,6 @@
  *
  * Based on board-sh7785lcr.c
  * Copyright (C) 2008  Yoshihiro Shimoda
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-ap325rxa/Makefile b/arch/sh/boards/mach-ap=
325rxa/Makefile
index 4cf1774..dba5d0c 100644
--- a/arch/sh/boards/mach-ap325rxa/Makefile
+++ b/arch/sh/boards/mach-ap325rxa/Makefile
@@ -1,2 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y	 :=3D setup.o sdram.o
=20
diff --git a/arch/sh/boards/mach-ap325rxa/sdram.S b/arch/sh/boards/mach-ap3=
25rxa/sdram.S
index db24fbe..541c82c 100644
--- a/arch/sh/boards/mach-ap325rxa/sdram.S
+++ b/arch/sh/boards/mach-ap325rxa/sdram.S
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * AP325RXA sdram self/auto-refresh setup code
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/sys.h>
diff --git a/arch/sh/boards/mach-cayman/Makefile b/arch/sh/boards/mach-caym=
an/Makefile
index 00fa3ea..775a4be 100644
--- a/arch/sh/boards/mach-cayman/Makefile
+++ b/arch/sh/boards/mach-cayman/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Hitachi Cayman specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-cayman/irq.c b/arch/sh/boards/mach-cayman/=
irq.c
index 724e8b7..9108789 100644
--- a/arch/sh/boards/mach-cayman/irq.c
+++ b/arch/sh/boards/mach-cayman/irq.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/mach-cayman/irq.c - SH-5 Cayman Interrupt Support
  *
  * This file handles the board specific parts of the Cayman interrupt syst=
em
  *
  * Copyright (C) 2002 Stuart Menefy
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/io.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-cayman/panic.c b/arch/sh/boards/mach-cayma=
n/panic.c
index d1e6730..cfc4631 100644
--- a/arch/sh/boards/mach-cayman/panic.c
+++ b/arch/sh/boards/mach-cayman/panic.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2003  Richard Curnow, SuperH UK Limited
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/kernel.h>
diff --git a/arch/sh/boards/mach-cayman/setup.c b/arch/sh/boards/mach-cayma=
n/setup.c
index 9c292c2..4cec147 100644
--- a/arch/sh/boards/mach-cayman/setup.c
+++ b/arch/sh/boards/mach-cayman/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/mach-cayman/setup.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2002  David J. Mckay & Benedict Gaster
  * Copyright (C) 2003 - 2007  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/sh/boards/mach-dreamcast/Makefile b/arch/sh/boards/mach-d=
reamcast/Makefile
index 7b97546..8692cb3 100644
--- a/arch/sh/boards/mach-dreamcast/Makefile
+++ b/arch/sh/boards/mach-dreamcast/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Sega Dreamcast specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-drea=
mcast/irq.c
index 2789647..a929f76 100644
--- a/arch/sh/boards/mach-dreamcast/irq.c
+++ b/arch/sh/boards/mach-dreamcast/irq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/dreamcast/irq.c
  *
@@ -6,7 +7,6 @@
  * Copyright (c) 2001, 2002 M. R. Brown <mrbrown@0xd6.org>
  *
  * This file is part of the LinuxDC project (www.linuxdc.org)
- * Released under the terms of the GNU GPL v2.0
  */
 #include <linux/irq.h>
 #include <linux/io.h>
diff --git a/arch/sh/boards/mach-dreamcast/rtc.c b/arch/sh/boards/mach-drea=
mcast/rtc.c
index 061d657..e468dcc 100644
--- a/arch/sh/boards/mach-dreamcast/rtc.c
+++ b/arch/sh/boards/mach-dreamcast/rtc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/dreamcast/rtc.c
  *
@@ -5,9 +6,6 @@
  *
  * Copyright (c) 2001, 2002 M. R. Brown <mrbrown@0xd6.org>
  * Copyright (c) 2002 Paul Mundt <lethal@chaoticdreams.org>
- *
- * Released under the terms of the GNU GPL v2.0.
- *
  */
=20
 #include <linux/time.h>
diff --git a/arch/sh/boards/mach-dreamcast/setup.c b/arch/sh/boards/mach-dr=
eamcast/setup.c
index ad1a4db..54bbdb3 100644
--- a/arch/sh/boards/mach-dreamcast/setup.c
+++ b/arch/sh/boards/mach-dreamcast/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/dreamcast/setup.c
  *
@@ -8,8 +9,6 @@
  *
  * This file is part of the LinuxDC project (www.linuxdc.org)
  *
- * Released under the terms of the GNU GPL v2.0.
- *
  * This file originally bore the message (with enclosed-$):
  *	Id: setup_dc.c,v 1.5 2001/05/24 05:09:16 mrbrown Exp
  *	SEGA Dreamcast support
diff --git a/arch/sh/boards/mach-ecovec24/Makefile b/arch/sh/boards/mach-ec=
ovec24/Makefile
index e69bc82..d78d490 100644
--- a/arch/sh/boards/mach-ecovec24/Makefile
+++ b/arch/sh/boards/mach-ecovec24/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the R0P7724LC0011/21RL (EcoVec)
 #
@@ -6,4 +7,4 @@
 # for more details.
 #
=20
-obj-y	 :=3D setup.o sdram.o
\ No newline at end of file
+obj-y	 :=3D setup.o sdram.o
diff --git a/arch/sh/boards/mach-ecovec24/sdram.S b/arch/sh/boards/mach-eco=
vec24/sdram.S
index 3963c6f..d2f2691 100644
--- a/arch/sh/boards/mach-ecovec24/sdram.S
+++ b/arch/sh/boards/mach-ecovec24/sdram.S
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Ecovec24 sdram self/auto-refresh setup code
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/sys.h>
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-eco=
vec24/setup.c
index 06a8945..46467f8 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2009 Renesas Solutions Corp.
  *
  * Kuninori Morimoto <morimoto.kuninori@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <asm/clock.h>
 #include <asm/heartbeat.h>
diff --git a/arch/sh/boards/mach-highlander/irq-r7780mp.c b/arch/sh/boards/=
mach-highlander/irq-r7780mp.c
index 9893fd3..f466373 100644
--- a/arch/sh/boards/mach-highlander/irq-r7780mp.c
+++ b/arch/sh/boards/mach-highlander/irq-r7780mp.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Solutions Highlander R7780MP Support.
  *
  * Copyright (C) 2002  Atom Create Engineering Co., Ltd.
  * Copyright (C) 2006  Paul Mundt
  * Copyright (C) 2007  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-highlander/irq-r7780rp.c b/arch/sh/boards/=
mach-highlander/irq-r7780rp.c
index 0805b21..c61177e 100644
--- a/arch/sh/boards/mach-highlander/irq-r7780rp.c
+++ b/arch/sh/boards/mach-highlander/irq-r7780rp.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Solutions Highlander R7780RP-1 Support.
  *
  * Copyright (C) 2002  Atom Create Engineering Co., Ltd.
  * Copyright (C) 2006  Paul Mundt
  * Copyright (C) 2008  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-highlander/irq-r7785rp.c b/arch/sh/boards/=
mach-highlander/irq-r7785rp.c
index 558b248..0ebebbe 100644
--- a/arch/sh/boards/mach-highlander/irq-r7785rp.c
+++ b/arch/sh/boards/mach-highlander/irq-r7785rp.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Solutions Highlander R7785RP Support.
  *
  * Copyright (C) 2002  Atom Create Engineering Co., Ltd.
  * Copyright (C) 2006 - 2008  Paul Mundt
  * Copyright (C) 2007  Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-highlander/pinmux-r7785rp.c b/arch/sh/boar=
ds/mach-highlander/pinmux-r7785rp.c
index c77a2be..703179f 100644
--- a/arch/sh/boards/mach-highlander/pinmux-r7785rp.c
+++ b/arch/sh/boards/mach-highlander/pinmux-r7785rp.c
@@ -1,9 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2008 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/gpio.h>
diff --git a/arch/sh/boards/mach-highlander/psw.c b/arch/sh/boards/mach-hig=
hlander/psw.c
index 40e2b58..d445c54 100644
--- a/arch/sh/boards/mach-highlander/psw.c
+++ b/arch/sh/boards/mach-highlander/psw.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/renesas/r7780rp/psw.c
  *
  * push switch support for RDBRP-1/RDBREVRP-1 debug boards.
  *
  * Copyright (C) 2006  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/io.h>
 #include <linux/module.h>
diff --git a/arch/sh/boards/mach-highlander/setup.c b/arch/sh/boards/mach-h=
ighlander/setup.c
index 4a52590..533393d 100644
--- a/arch/sh/boards/mach-highlander/setup.c
+++ b/arch/sh/boards/mach-highlander/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/renesas/r7780rp/setup.c
  *
@@ -8,10 +9,6 @@
  *
  * This contains support for the R7780RP-1, R7780MP, and R7785RP
  * Highlander modules.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/sh/boards/mach-hp6xx/Makefile b/arch/sh/boards/mach-hp6xx=
/Makefile
index b312427..4b0fe29 100644
--- a/arch/sh/boards/mach-hp6xx/Makefile
+++ b/arch/sh/boards/mach-hp6xx/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the HP6xx specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c b/arch/sh/boards/mach-hp=
6xx/hp6xx_apm.c
index 865d8d6..e5c4c7d 100644
--- a/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
+++ b/arch/sh/boards/mach-hp6xx/hp6xx_apm.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * bios-less APM driver for hp680
  *
  * Copyright 2005 (c) Andriy Skulysh <askulysh@gmail.com>
  * Copyright 2008 (c) Kristoffer Ericson <kristoffer.ericson@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License.
  */
 #include <linux/module.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/boards/mach-hp6xx/pm.c b/arch/sh/boards/mach-hp6xx/pm.=
c
index 8b50cf7..fe505ec 100644
--- a/arch/sh/boards/mach-hp6xx/pm.c
+++ b/arch/sh/boards/mach-hp6xx/pm.c
@@ -1,10 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * hp6x0 Power Management Routines
  *
  * Copyright (c) 2006 Andriy Skulysh <askulsyh@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License.
  */
 #include <linux/init.h>
 #include <linux/suspend.h>
diff --git a/arch/sh/boards/mach-hp6xx/pm_wakeup.S b/arch/sh/boards/mach-hp=
6xx/pm_wakeup.S
index 4f18d44..0fd4330 100644
--- a/arch/sh/boards/mach-hp6xx/pm_wakeup.S
+++ b/arch/sh/boards/mach-hp6xx/pm_wakeup.S
@@ -1,10 +1,6 @@
-/*
- * Copyright (c) 2006 Andriy Skulysh <askulsyh@gmail.com>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
+/* SPDX-License-Identifier: GPL-2.0
  *
+ * Copyright (c) 2006 Andriy Skulysh <askulsyh@gmail.com>
  */
=20
 #include <linux/linkage.h>
diff --git a/arch/sh/boards/mach-hp6xx/setup.c b/arch/sh/boards/mach-hp6xx/=
setup.c
index 05797b3..2ceead6 100644
--- a/arch/sh/boards/mach-hp6xx/setup.c
+++ b/arch/sh/boards/mach-hp6xx/setup.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/hp6xx/setup.c
  *
  * Copyright (C) 2002 Andriy Skulysh
  * Copyright (C) 2007 Kristoffer Ericson <Kristoffer_e1@hotmail.com>
  *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
  * Setup code for HP620/HP660/HP680/HP690 (internal peripherials only)
  */
 #include <linux/types.h>
diff --git a/arch/sh/boards/mach-kfr2r09/Makefile b/arch/sh/boards/mach-kfr=
2r09/Makefile
index 60dd63f..4a4a35a 100644
--- a/arch/sh/boards/mach-kfr2r09/Makefile
+++ b/arch/sh/boards/mach-kfr2r09/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y	:=3D setup.o sdram.o
 ifneq ($(CONFIG_FB_SH_MOBILE_LCDC),)
 obj-y	+=3D  lcd_wqvga.o
diff --git a/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c b/arch/sh/boards/mach-=
kfr2r09/lcd_wqvga.c
index 355a78a..f6bbac1 100644
--- a/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
+++ b/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * KFR2R09 LCD panel support
  *
@@ -5,10 +6,6 @@
  *
  * Register settings based on the out-of-tree t33fb.c driver
  * Copyright (C) 2008 Lineo Solutions, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License. See the file COPYING in the main directory of this archive for
- * more details.
  */
=20
 #include <linux/delay.h>
diff --git a/arch/sh/boards/mach-kfr2r09/sdram.S b/arch/sh/boards/mach-kfr2=
r09/sdram.S
index 0c9f55b..f1b8985 100644
--- a/arch/sh/boards/mach-kfr2r09/sdram.S
+++ b/arch/sh/boards/mach-kfr2r09/sdram.S
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * KFR2R09 sdram self/auto-refresh setup code
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/sys.h>
diff --git a/arch/sh/boards/mach-landisk/Makefile b/arch/sh/boards/mach-lan=
disk/Makefile
index a696b42..6cba041 100644
--- a/arch/sh/boards/mach-landisk/Makefile
+++ b/arch/sh/boards/mach-landisk/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for I-O DATA DEVICE, INC. "LANDISK Series"
 #
diff --git a/arch/sh/boards/mach-landisk/gio.c b/arch/sh/boards/mach-landis=
k/gio.c
index 32c317f..1c0da99 100644
--- a/arch/sh/boards/mach-landisk/gio.c
+++ b/arch/sh/boards/mach-landisk/gio.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/landisk/gio.c - driver for landisk
  *
@@ -6,11 +7,6 @@
  *
  *   Copylight (C) 2006 kogiidena
  *   Copylight (C) 2002 Atom Create Engineering Co., Ltd. *
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-landisk/irq.c b/arch/sh/boards/mach-landis=
k/irq.c
index c00ace3..29b8b1f 100644
--- a/arch/sh/boards/mach-landisk/irq.c
+++ b/arch/sh/boards/mach-landisk/irq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/mach-landisk/irq.c
  *
@@ -8,10 +9,6 @@
  *
  * Copyright (C) 2001  Ian da Silva, Jeremy Siegel
  * Based largely on io_se.c.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-landisk/psw.c b/arch/sh/boards/mach-landis=
k/psw.c
index 5192b1f..e171d9a 100644
--- a/arch/sh/boards/mach-landisk/psw.c
+++ b/arch/sh/boards/mach-landisk/psw.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/landisk/psw.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2006-2007  Paul Mundt
  * Copyright (C) 2007  kogiidena
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/io.h>
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-landisk/setup.c b/arch/sh/boards/mach-land=
isk/setup.c
index f1147ca..16b4d8b 100644
--- a/arch/sh/boards/mach-landisk/setup.c
+++ b/arch/sh/boards/mach-landisk/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/landisk/setup.c
  *
@@ -7,10 +8,6 @@
  * Copyright (C) 2002 Paul Mundt
  * Copylight (C) 2002 Atom Create Engineering Co., Ltd.
  * Copyright (C) 2005-2007 kogiidena
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-lboxre2/Makefile b/arch/sh/boards/mach-lbo=
xre2/Makefile
index e9ed140..0fbd0822 100644
--- a/arch/sh/boards/mach-lboxre2/Makefile
+++ b/arch/sh/boards/mach-lboxre2/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the L-BOX RE2 specific parts of the kernel
 # Copyright (c) 2007 Nobuhiro Iwamatsu
diff --git a/arch/sh/boards/mach-lboxre2/irq.c b/arch/sh/boards/mach-lboxre=
2/irq.c
index 8aa171a..a250e3b 100644
--- a/arch/sh/boards/mach-lboxre2/irq.c
+++ b/arch/sh/boards/mach-lboxre2/irq.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/lboxre2/irq.c
  *
  * Copyright (C) 2007 Nobuhiro Iwamatsu
  *
  * NTT COMWARE L-BOX RE2 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/sh/boards/mach-lboxre2/setup.c b/arch/sh/boards/mach-lbox=
re2/setup.c
index 6660622..20d01b4 100644
--- a/arch/sh/boards/mach-lboxre2/setup.c
+++ b/arch/sh/boards/mach-lboxre2/setup.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/lbox/setup.c
  *
  * Copyright (C) 2007 Nobuhiro Iwamatsu
  *
  * NTT COMWARE L-BOX RE2 Support
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
=20
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-microdev/Makefile b/arch/sh/boards/mach-mi=
crodev/Makefile
index 4e3588e..05c5698 100644
--- a/arch/sh/boards/mach-microdev/Makefile
+++ b/arch/sh/boards/mach-microdev/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the SuperH MicroDev specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-microdev/fdc37c93xapm.c b/arch/sh/boards/m=
ach-microdev/fdc37c93xapm.c
index 458a7cf..2a04f72 100644
--- a/arch/sh/boards/mach-microdev/fdc37c93xapm.c
+++ b/arch/sh/boards/mach-microdev/fdc37c93xapm.c
@@ -1,5 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- *
  * Setup for the SMSC FDC37C93xAPM
  *
  * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
@@ -7,9 +7,6 @@
  * Copyright (C) 2004, 2005 Paul Mundt
  *
  * SuperH SH4-202 MicroDev board support.
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
 #include <linux/init.h>
 #include <linux/ioport.h>
diff --git a/arch/sh/boards/mach-microdev/io.c b/arch/sh/boards/mach-microd=
ev/io.c
index acdafb0..a76c127 100644
--- a/arch/sh/boards/mach-microdev/io.c
+++ b/arch/sh/boards/mach-microdev/io.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/superh/microdev/io.c
  *
@@ -6,9 +7,6 @@
  * Copyright (C) 2004 Paul Mundt
  *
  * SuperH SH4-202 MicroDev board support.
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
=20
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-microdev/irq.c b/arch/sh/boards/mach-micro=
dev/irq.c
index 9a8aff3..dc27492 100644
--- a/arch/sh/boards/mach-microdev/irq.c
+++ b/arch/sh/boards/mach-microdev/irq.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/superh/microdev/irq.c
  *
  * Copyright (C) 2003 Sean McGoogan (Sean.McGoogan@superh.com)
  *
  * SuperH SH4-202 MicroDev board support.
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
=20
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-microdev/setup.c b/arch/sh/boards/mach-mic=
rodev/setup.c
index 6c66ee4..706b48f 100644
--- a/arch/sh/boards/mach-microdev/setup.c
+++ b/arch/sh/boards/mach-microdev/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/superh/microdev/setup.c
  *
@@ -6,9 +7,6 @@
  * Copyright (C) 2004, 2005 Paul Mundt
  *
  * SuperH SH4-202 MicroDev board support.
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-migor/Makefile b/arch/sh/boards/mach-migor=
/Makefile
index 4601a89..c223d75 100644
--- a/arch/sh/boards/mach-migor/Makefile
+++ b/arch/sh/boards/mach-migor/Makefile
@@ -1,2 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y	 :=3D setup.o sdram.o
 obj-$(CONFIG_SH_MIGOR_QVGA)	+=3D  lcd_qvga.o
diff --git a/arch/sh/boards/mach-migor/lcd_qvga.c b/arch/sh/boards/mach-mig=
or/lcd_qvga.c
index 8bccd34..4ebf130 100644
--- a/arch/sh/boards/mach-migor/lcd_qvga.c
+++ b/arch/sh/boards/mach-migor/lcd_qvga.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Support for SuperH MigoR Quarter VGA LCD Panel
  *
@@ -5,10 +6,6 @@
  *
  * Based on lcd_powertip.c from Kenati Technologies Pvt Ltd.
  * Copyright (c) 2007 Ujjwal Pande <ujjwal@kenati.com>,
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
=20
 #include <linux/delay.h>
diff --git a/arch/sh/boards/mach-migor/sdram.S b/arch/sh/boards/mach-migor/=
sdram.S
index 614aa3a..3a6bee1 100644
--- a/arch/sh/boards/mach-migor/sdram.S
+++ b/arch/sh/boards/mach-migor/sdram.S
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * Migo-R sdram self/auto-refresh setup code
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/sys.h>
diff --git a/arch/sh/boards/mach-r2d/Makefile b/arch/sh/boards/mach-r2d/Mak=
efile
index 0d4c75a..7e7ac5e 100644
--- a/arch/sh/boards/mach-r2d/Makefile
+++ b/arch/sh/boards/mach-r2d/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the RTS7751R2D specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-r2d/setup.c b/arch/sh/boards/mach-r2d/setu=
p.c
index 4b98a52..3bc52f6 100644
--- a/arch/sh/boards/mach-r2d/setup.c
+++ b/arch/sh/boards/mach-r2d/setup.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Technology Sales RTS7751R2D Support.
  *
  * Copyright (C) 2002 - 2006 Atom Create Engineering Co., Ltd.
  * Copyright (C) 2004 - 2007 Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-rsk/Makefile b/arch/sh/boards/mach-rsk/Mak=
efile
index 6a4e1b5..43cca39 100644
--- a/arch/sh/boards/mach-rsk/Makefile
+++ b/arch/sh/boards/mach-rsk/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y				:=3D setup.o
 obj-$(CONFIG_SH_RSK7203)	+=3D devices-rsk7203.o
 obj-$(CONFIG_SH_RSK7264)	+=3D devices-rsk7264.o
diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mac=
h-rsk/devices-rsk7203.c
index a8089f7..e6b05d4 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Technology Europe RSK+ 7203 Support.
  *
  * Copyright (C) 2008 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/arch/sh/boards/mach-rsk/devices-rsk7264.c b/arch/sh/boards/mac=
h-rsk/devices-rsk7264.c
index 7251e37..eaf700a 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7264.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7264.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * RSK+SH7264 Support.
  *
  * Copyright (C) 2012 Renesas Electronics Europe
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/arch/sh/boards/mach-rsk/devices-rsk7269.c b/arch/sh/boards/mac=
h-rsk/devices-rsk7269.c
index 4a54459..4b1e386 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7269.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7269.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * RSK+SH7269 Support
  *
  * Copyright (C) 2012  Renesas Electronics Europe Ltd
  * Copyright (C) 2012  Phil Edworthy
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/arch/sh/boards/mach-rsk/setup.c b/arch/sh/boards/mach-rsk/setu=
p.c
index 6bc134b..9370c4f 100644
--- a/arch/sh/boards/mach-rsk/setup.c
+++ b/arch/sh/boards/mach-rsk/setup.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Technology Europe RSK+ Support.
  *
  * Copyright (C) 2008 Paul Mundt
  * Copyright (C) 2008 Peter Griffin <pgriffin@mpc-data.co.uk>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/arch/sh/boards/mach-sdk7780/Makefile b/arch/sh/boards/mach-sdk=
7780/Makefile
index 3d8f0be..37e857f 100644
--- a/arch/sh/boards/mach-sdk7780/Makefile
+++ b/arch/sh/boards/mach-sdk7780/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the SDK7780 specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-sdk7780/irq.c b/arch/sh/boards/mach-sdk778=
0/irq.c
index e5f7564..fa392f3 100644
--- a/arch/sh/boards/mach-sdk7780/irq.c
+++ b/arch/sh/boards/mach-sdk7780/irq.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/renesas/sdk7780/irq.c
  *
  * Renesas Technology Europe SDK7780 Support.
  *
  * Copyright (C) 2008  Nicholas Beck <nbeck@mpc-data.co.uk>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-sdk7780/setup.c b/arch/sh/boards/mach-sdk7=
780/setup.c
index 2241659..482761b 100644
--- a/arch/sh/boards/mach-sdk7780/setup.c
+++ b/arch/sh/boards/mach-sdk7780/setup.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/renesas/sdk7780/setup.c
  *
  * Renesas Solutions SH7780 SDK Support
  * Copyright (C) 2008 Nicholas Beck <nbeck@mpc-data.co.uk>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/types.h>
diff --git a/arch/sh/boards/mach-sdk7786/Makefile b/arch/sh/boards/mach-sdk=
7786/Makefile
index 45d32e3..731a87c 100644
--- a/arch/sh/boards/mach-sdk7786/Makefile
+++ b/arch/sh/boards/mach-sdk7786/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y	:=3D fpga.o irq.o nmi.o setup.o
=20
 obj-$(CONFIG_GPIOLIB)		+=3D gpio.o
diff --git a/arch/sh/boards/mach-sdk7786/fpga.c b/arch/sh/boards/mach-sdk77=
86/fpga.c
index 3e4ec66..6d2a3d3 100644
--- a/arch/sh/boards/mach-sdk7786/fpga.c
+++ b/arch/sh/boards/mach-sdk7786/fpga.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SDK7786 FPGA Support.
  *
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/io.h>
diff --git a/arch/sh/boards/mach-sdk7786/gpio.c b/arch/sh/boards/mach-sdk77=
86/gpio.c
index 4799701..c4587d1 100644
--- a/arch/sh/boards/mach-sdk7786/gpio.c
+++ b/arch/sh/boards/mach-sdk7786/gpio.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SDK7786 FPGA USRGPIR Support.
  *
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/interrupt.h>
diff --git a/arch/sh/boards/mach-sdk7786/irq.c b/arch/sh/boards/mach-sdk778=
6/irq.c
index 46943a0..340c306 100644
--- a/arch/sh/boards/mach-sdk7786/irq.c
+++ b/arch/sh/boards/mach-sdk7786/irq.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SDK7786 FPGA IRQ Controller Support.
  *
  * Copyright (C) 2010  Matt Fleming
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/irq.h>
 #include <mach/fpga.h>
diff --git a/arch/sh/boards/mach-sdk7786/nmi.c b/arch/sh/boards/mach-sdk778=
6/nmi.c
index edcfa1f..c2e09d7 100644
--- a/arch/sh/boards/mach-sdk7786/nmi.c
+++ b/arch/sh/boards/mach-sdk7786/nmi.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SDK7786 FPGA NMI Support.
  *
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/boards/mach-sdk7786/setup.c b/arch/sh/boards/mach-sdk7=
786/setup.c
index c29268b..65721c3 100644
--- a/arch/sh/boards/mach-sdk7786/setup.c
+++ b/arch/sh/boards/mach-sdk7786/setup.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas Technology Europe SDK7786 Support.
  *
  * Copyright (C) 2010  Matt Fleming
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-sdk7786/sram.c b/arch/sh/boards/mach-sdk77=
86/sram.c
index c81c3ab..d76cdb7 100644
--- a/arch/sh/boards/mach-sdk7786/sram.c
+++ b/arch/sh/boards/mach-sdk7786/sram.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SDK7786 FPGA SRAM Support.
  *
  * Copyright (C) 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
diff --git a/arch/sh/boards/mach-se/7206/Makefile b/arch/sh/boards/mach-se/=
7206/Makefile
index 5c9eaa0..b40b308 100644
--- a/arch/sh/boards/mach-se/7206/Makefile
+++ b/arch/sh/boards/mach-se/7206/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the 7206 SolutionEngine specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-se/7343/Makefile b/arch/sh/boards/mach-se/=
7343/Makefile
index 4c3666a..e058661 100644
--- a/arch/sh/boards/mach-se/7343/Makefile
+++ b/arch/sh/boards/mach-se/7343/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the 7343 SolutionEngine specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/734=
3/irq.c
index 6129aef..39a3175 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hitachi UL SolutionEngine 7343 FPGA IRQ Support.
  *
@@ -6,10 +7,6 @@
  *
  * Based on linux/arch/sh/boards/se/7343/irq.c
  * Copyright (C) 2007  Nobuhiro Iwamatsu
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define DRV_NAME "SE7343-FPGA"
 #define pr_fmt(fmt) DRV_NAME ": " fmt
diff --git a/arch/sh/boards/mach-se/770x/Makefile b/arch/sh/boards/mach-se/=
770x/Makefile
index 43ea14f..900d93c 100644
--- a/arch/sh/boards/mach-se/770x/Makefile
+++ b/arch/sh/boards/mach-se/770x/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the 770x SolutionEngine specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-se/7721/Makefile b/arch/sh/boards/mach-se/=
7721/Makefile
index 7f09030..09436f1 100644
--- a/arch/sh/boards/mach-se/7721/Makefile
+++ b/arch/sh/boards/mach-se/7721/Makefile
@@ -1 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y	 :=3D setup.o irq.o
diff --git a/arch/sh/boards/mach-se/7721/irq.c b/arch/sh/boards/mach-se/772=
1/irq.c
index d85022e..e6ef2a2 100644
--- a/arch/sh/boards/mach-se/7721/irq.c
+++ b/arch/sh/boards/mach-se/7721/irq.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/se/7721/irq.c
  *
  * Copyright (C) 2008  Renesas Solutions Corp.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-se/7721/setup.c b/arch/sh/boards/mach-se/7=
721/setup.c
index a0b3dba..3af724d 100644
--- a/arch/sh/boards/mach-se/7721/setup.c
+++ b/arch/sh/boards/mach-se/7721/setup.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/se/7721/setup.c
  *
  * Copyright (C) 2008 Renesas Solutions Corp.
  *
  * Hitachi UL SolutionEngine 7721 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-se/7722/Makefile b/arch/sh/boards/mach-se/=
7722/Makefile
index 8694373..a5e89c0 100644
--- a/arch/sh/boards/mach-se/7722/Makefile
+++ b/arch/sh/boards/mach-se/7722/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the HITACHI UL SolutionEngine 7722 specific parts of the ke=
rnel
 #
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/772=
2/irq.c
index 24c74a8..f6e3009 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Hitachi UL SolutionEngine 7722 FPGA IRQ Support.
  *
  * Copyright (C) 2007  Nobuhiro Iwamatsu
  * Copyright (C) 2012  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define DRV_NAME "SE7722-FPGA"
 #define pr_fmt(fmt) DRV_NAME ": " fmt
diff --git a/arch/sh/boards/mach-se/7722/setup.c b/arch/sh/boards/mach-se/7=
722/setup.c
index e04e2bc..2cd4a2e 100644
--- a/arch/sh/boards/mach-se/7722/setup.c
+++ b/arch/sh/boards/mach-se/7722/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/se/7722/setup.c
  *
@@ -5,11 +6,6 @@
  * Copyright (C) 2012 Paul Mundt
  *
  * Hitachi UL SolutionEngine 7722 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-se/7724/Makefile b/arch/sh/boards/mach-se/=
7724/Makefile
index a08b368..6c6112b 100644
--- a/arch/sh/boards/mach-se/7724/Makefile
+++ b/arch/sh/boards/mach-se/7724/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the HITACHI UL SolutionEngine 7724 specific parts of the ke=
rnel
 #
diff --git a/arch/sh/boards/mach-se/7724/irq.c b/arch/sh/boards/mach-se/772=
4/irq.c
index 64e681e..14ce302 100644
--- a/arch/sh/boards/mach-se/7724/irq.c
+++ b/arch/sh/boards/mach-se/7724/irq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/se/7724/irq.c
  *
@@ -9,10 +10,6 @@
  * Copyright (C) 2007  Nobuhiro Iwamatsu
  *
  * Hitachi UL SolutionEngine 7724 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-se/7724/sdram.S b/arch/sh/boards/mach-se/7=
724/sdram.S
index 6fa4734..61c1fe7 100644
--- a/arch/sh/boards/mach-se/7724/sdram.S
+++ b/arch/sh/boards/mach-se/7724/sdram.S
@@ -1,11 +1,8 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * MS7724SE sdram self/auto-refresh setup code
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/sys.h>
diff --git a/arch/sh/boards/mach-se/7751/Makefile b/arch/sh/boards/mach-se/=
7751/Makefile
index a338fd9..2406d3e 100644
--- a/arch/sh/boards/mach-se/7751/Makefile
+++ b/arch/sh/boards/mach-se/7751/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the 7751 SolutionEngine specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-se/7780/Makefile b/arch/sh/boards/mach-se/=
7780/Makefile
index 6b88ada..1f6669a 100644
--- a/arch/sh/boards/mach-se/7780/Makefile
+++ b/arch/sh/boards/mach-se/7780/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the HITACHI UL SolutionEngine 7780 specific parts of the ke=
rnel
 #
diff --git a/arch/sh/boards/mach-se/7780/irq.c b/arch/sh/boards/mach-se/778=
0/irq.c
index d5c9edc..d427dfd 100644
--- a/arch/sh/boards/mach-se/7780/irq.c
+++ b/arch/sh/boards/mach-se/7780/irq.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/se/7780/irq.c
  *
  * Copyright (C) 2006,2007  Nobuhiro Iwamatsu
  *
  * Hitachi UL SolutionEngine 7780 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/sh/boards/mach-se/7780/setup.c b/arch/sh/boards/mach-se/7=
780/setup.c
index ae5a1d8..309f268 100644
--- a/arch/sh/boards/mach-se/7780/setup.c
+++ b/arch/sh/boards/mach-se/7780/setup.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/se/7780/setup.c
  *
  * Copyright (C) 2006,2007  Nobuhiro Iwamatsu
  *
  * Hitachi UL SolutionEngine 7780 Support.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-sh03/Makefile b/arch/sh/boards/mach-sh03/M=
akefile
index 400306a..ab52d5a 100644
--- a/arch/sh/boards/mach-sh03/Makefile
+++ b/arch/sh/boards/mach-sh03/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Interface (CTP/PCI-SH03) specific parts of the kernel
 #
diff --git a/arch/sh/boards/mach-sh7763rdp/Makefile b/arch/sh/boards/mach-s=
h7763rdp/Makefile
index f6c0b55..d634131 100644
--- a/arch/sh/boards/mach-sh7763rdp/Makefile
+++ b/arch/sh/boards/mach-sh7763rdp/Makefile
@@ -1 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y    :=3D setup.o irq.o
diff --git a/arch/sh/boards/mach-sh7763rdp/irq.c b/arch/sh/boards/mach-sh77=
63rdp/irq.c
index add698c..efd382b 100644
--- a/arch/sh/boards/mach-sh7763rdp/irq.c
+++ b/arch/sh/boards/mach-sh7763rdp/irq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/renesas/sh7763rdp/irq.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2008 Renesas Solutions Corp.
  * Copyright (C) 2008  Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/init.h>
diff --git a/arch/sh/boards/mach-sh7763rdp/setup.c b/arch/sh/boards/mach-sh=
7763rdp/setup.c
index 6e62686..97e715e 100644
--- a/arch/sh/boards/mach-sh7763rdp/setup.c
+++ b/arch/sh/boards/mach-sh7763rdp/setup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * linux/arch/sh/boards/renesas/sh7763rdp/setup.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2008 Renesas Solutions Corp.
  * Copyright (C) 2008 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/mach-x3proto/Makefile b/arch/sh/boards/mach-x3p=
roto/Makefile
index 0cbe3d0..6caefa1 100644
--- a/arch/sh/boards/mach-x3proto/Makefile
+++ b/arch/sh/boards/mach-x3proto/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 obj-y +=3D setup.o ilsel.o
=20
 obj-$(CONFIG_GPIOLIB)		+=3D gpio.o
diff --git a/arch/sh/boards/mach-x3proto/gpio.c b/arch/sh/boards/mach-x3pro=
to/gpio.c
index cea88b0..efc992f 100644
--- a/arch/sh/boards/mach-x3proto/gpio.c
+++ b/arch/sh/boards/mach-x3proto/gpio.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/mach-x3proto/gpio.c
  *
  * Renesas SH-X3 Prototype Baseboard GPIO Support.
  *
  * Copyright (C) 2010 - 2012  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
diff --git a/arch/sh/boards/mach-x3proto/ilsel.c b/arch/sh/boards/mach-x3pr=
oto/ilsel.c
index 95e3461..f0d5eb4 100644
--- a/arch/sh/boards/mach-x3proto/ilsel.c
+++ b/arch/sh/boards/mach-x3proto/ilsel.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/mach-x3proto/ilsel.c
  *
  * Helper routines for SH-X3 proto board ILSEL.
  *
  * Copyright (C) 2007 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
diff --git a/arch/sh/boards/mach-x3proto/setup.c b/arch/sh/boards/mach-x3pr=
oto/setup.c
index d682e2b..95b85f2 100644
--- a/arch/sh/boards/mach-x3proto/setup.c
+++ b/arch/sh/boards/mach-x3proto/setup.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/boards/mach-x3proto/setup.c
  *
  * Renesas SH-X3 Prototype Board Support.
  *
  * Copyright (C) 2007 - 2010  Paul Mundt
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index cde370ca..c24970e 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SH generic board support, using device tree
  *
  * Copyright (C) 2015-2016 Smart Energy Instruments, Inc.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
=20
 #include <linux/of.h>
--=20
2.7.4

