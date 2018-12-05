Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827FEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D971206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="WV0zi8em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D971206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeLEICN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:02:13 -0500
Received: from mail-eopbgr1400108.outbound.protection.outlook.com ([40.107.140.108]:46448
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeLEICG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftO1TP+D5t5+qi+dJggcb4fcYo/steHOpWHTiPfQtyk=;
 b=WV0zi8emwNII3Sw721Lo+gHzqPiF9g+O0xfzPF5GxHfSd0IQHwbrACPiosh2lZtgpaZGCzcSoLrH75D2uvR4I4u7g1/sCNhk7GhD9vzoF08LriiwrZ6eMNE2gSyMqyhGLNVTwj4fahhkNd8vsCNot2943lEwClRBCT7GZYAl3TU=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB2254.jpnprd01.prod.outlook.com (52.133.179.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 08:01:24 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:01:24 +0000
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
Subject: [PATCH 10/13] sh: shmobile: convert to SPDX identifiers
Thread-Topic: [PATCH 10/13] sh: shmobile: convert to SPDX identifiers
Thread-Index: AQHUjHC3mvKRpkb+Nka/7vOWQ+nhMg==
Date:   Wed, 5 Dec 2018 08:01:24 +0000
Message-ID: <875zw8csxa.wl-kuninori.morimoto.gx@renesas.com>
References: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: KAWPR01CA0093.jpnprd01.prod.outlook.com
 (2603:1096:402:c::29) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2254;20:7XaV7Fyy5upQTpxfx6cYehN8f+/Xrt/Le7girRMZQV9MQfOLZwGrGTYraAHburIA8QXJeJOCEFEz2ajhDLKu4GUocuH4EkEoC4z1MGHEoC88TcvEdRX3JPysaRXVB0MDSUTcuwnu6iOmeSolz9MRsEWWaleOPUTHgeIpfUWSxEo=
x-ms-office365-filtering-correlation-id: b339bb95-8eb3-42c7-86aa-08d65a87d9b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2254;
x-ms-traffictypediagnostic: TYAPR01MB2254:
x-microsoft-antispam-prvs: <TYAPR01MB2254D721D974EC05E6319160D4A80@TYAPR01MB2254.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB2254;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB2254;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(53936002)(6436002)(6512007)(7736002)(305945005)(71190400001)(316002)(54906003)(110136005)(71200400001)(14454004)(99286004)(86362001)(2906002)(68736007)(5660300001)(97736004)(66066001)(8936002)(26005)(106356001)(6506007)(386003)(105586002)(6116002)(186003)(25786009)(256004)(52116002)(3846002)(8676002)(486006)(476003)(4326008)(478600001)(2616005)(446003)(11346002)(36756003)(102836004)(81156014)(76176011)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2254;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 6SH5Gv2AN8SGRT4kal8bNgUaG5mlUPetVUYuCjHEA7njxQYclxS0spugAOjofvyjyk097YCNnAp9y2bEnf8gj0aMJmome+/Zp5wrStVwqXRC4AOljIodaUm6InHbP+eF2zsP7bkfsByCetYTdRjFzBGnQH4xCHygccJ9h8sgIglHuEM9CDjBk9oRW64l0dYHYvDpMwu8wo7x46hn/lyNZeEsjauhVAxzMzLwwVzDa7VVvrp8J+ULtAe8MjiTck1A/mbR13CYtHwmgNX0XQwcqDKX7zuVqfuSHFmp7iHzoAnI5Z9E54ZxED10lK0G17yzPQ1ldyWlC89W+bc709zQDMELhnZqBHbFwfSqZgGmUoM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <607BA408F210224F8BD26B07CA83ACF9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b339bb95-8eb3-42c7-86aa-08d65a87d9b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:01:24.1272
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
 arch/sh/kernel/cpu/shmobile/Makefile  | 1 +
 arch/sh/kernel/cpu/shmobile/cpuidle.c | 5 +----
 arch/sh/kernel/cpu/shmobile/pm.c      | 5 +----
 arch/sh/kernel/cpu/shmobile/sleep.S   | 7 ++-----
 4 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/Makefile b/arch/sh/kernel/cpu/shmo=
bile/Makefile
index e8a5111..7581d5f 100644
--- a/arch/sh/kernel/cpu/shmobile/Makefile
+++ b/arch/sh/kernel/cpu/shmobile/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the Linux/SuperH SH-Mobile backends.
 #
diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shm=
obile/cpuidle.c
index c32e660..dbd2cde 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/shmobile/cpuidle.c
  *
  * Cpuidle support code for SuperH Mobile
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/shmobile/pm.c b/arch/sh/kernel/cpu/shmobile=
/pm.c
index fba2be5..ca9945f 100644
--- a/arch/sh/kernel/cpu/shmobile/pm.c
+++ b/arch/sh/kernel/cpu/shmobile/pm.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/kernel/cpu/shmobile/pm.c
  *
  * Power management support code for SuperH Mobile
  *
  *  Copyright (C) 2009 Magnus Damm
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
diff --git a/arch/sh/kernel/cpu/shmobile/sleep.S b/arch/sh/kernel/cpu/shmob=
ile/sleep.S
index e6aac65..f928c03 100644
--- a/arch/sh/kernel/cpu/shmobile/sleep.S
+++ b/arch/sh/kernel/cpu/shmobile/sleep.S
@@ -1,13 +1,10 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/kernel/cpu/sh4a/sleep-sh_mobile.S
  *
  * Sleep mode and Standby modes support for SuperH Mobile
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
--=20
2.7.4

