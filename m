Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EEEC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70654206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="Z/x7l2yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70654206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbeLEICH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:02:07 -0500
Received: from mail-eopbgr1410107.outbound.protection.outlook.com ([40.107.141.107]:43796
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbeLEICG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/Eq+XzVkO2UwmmgLrkRnuNzR2TnyobQYKQbDE99PnE=;
 b=Z/x7l2yqgxFNxOXFZS8+7RaG+SrOsOiQOVJKO4iYvNJCD2hkE814/0v9VmppA/eeY/221K14JgL8BhtRRkobqYD+CUj7moqjvO+xetyJwRBB2AWlxgUZkpsd+8Fhxbv3LLBQBWYQDwtDpnNW4T7jbr5wVWdH3Vy8a6GA+SJlA7s=
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com (20.178.137.210) by
 TYAPR01MB1998.jpnprd01.prod.outlook.com (52.133.178.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 08:01:59 +0000
Received: from TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7]) by TYAPR01MB3661.jpnprd01.prod.outlook.com
 ([fe80::70b6:5ef2:3f71:77c7%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 08:01:59 +0000
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
Subject: [PATCH 13/13] sh: lib: convert to SPDX identifiers
Thread-Topic: [PATCH 13/13] sh: lib: convert to SPDX identifiers
Thread-Index: AQHUjHDMQDJIcS+QDUWnAmSVafhawg==
Date:   Wed, 5 Dec 2018 08:01:58 +0000
Message-ID: <871s6wcswb.wl-kuninori.morimoto.gx@renesas.com>
References: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k1koct23.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: TY2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:404:42::13) To TYAPR01MB3661.jpnprd01.prod.outlook.com
 (2603:1096:404:c1::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuninori.morimoto.gx@renesas.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [211.11.155.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;TYAPR01MB1998;20:CiTyg8afY9+UYOrEr19WM3DJ0/5Oxxy34XIHlvak7EgGdifBqNxy39X86zpet7KcUu5Y5zT7RzwNGoQwROp91IoqSCj/s+xZIVoTSKRVyCX58e82LkFB6cnJOr946rEmgzCcXc1iUSunjmpxs2iQoWsTWlSlTowKIPl2vno1xYI=
x-ms-office365-filtering-correlation-id: 026298c4-e1d6-4d2d-004c-08d65a87ee5f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB1998;
x-ms-traffictypediagnostic: TYAPR01MB1998:
x-microsoft-antispam-prvs: <TYAPR01MB19983B7B4E251A7B6A2CE161D4A80@TYAPR01MB1998.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:TYAPR01MB1998;BCL:0;PCL:0;RULEID:;SRVR:TYAPR01MB1998;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(346002)(39860400002)(396003)(199004)(189003)(8676002)(26005)(186003)(476003)(102836004)(478600001)(6116002)(2906002)(3846002)(446003)(81166006)(11346002)(81156014)(6506007)(386003)(2616005)(8936002)(76176011)(71190400001)(256004)(4744004)(71200400001)(52116002)(19627235002)(14454004)(86362001)(5660300001)(486006)(36756003)(54906003)(110136005)(66066001)(99286004)(25786009)(97736004)(14444005)(68736007)(305945005)(7736002)(4326008)(6436002)(105586002)(53946003)(6512007)(316002)(106356001)(53936002)(6486002)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB1998;H:TYAPR01MB3661.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 7grpRqA9hhb2gHB4Bb14UTR5X9mPrnxpevteb9cS9ED+8gRYKFjJPNnSbdXOsmixOc7CXQJh9Jf2We4FiOFpfUki7n/EwsW+YQZsXifSY7tS2QrAwsXCB7URqSupPT6AtVaaLquSZT8fQ4O0r/Nt3dpJYsiVa5ERSUly0rnyXxPP6YG1dU0p5yRJuZwE7xCuffEP4uGepZ6U2al7IAH/Ve+iMpKOMQ3e5+fqQlqvCNGBjOoKAllJ09aSFk7sVaDYNKSAe9NcBK6OFvF7Z2P6N289/A3XpbMCDq2w3q/VO//mqZIbvftY/phiU8cX1hUYlEun6F43cvNI5iV3RcEhT0CTpH34Pdel/4O8rNqeUWA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <829C00212B8C4C409040663BDB68FBAD@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 026298c4-e1d6-4d2d-004c-08d65a87ee5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 08:01:58.8874
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
 arch/sh/lib/ashiftrt.S       | 29 ++++-------------------------
 arch/sh/lib/ashlsi3.S        | 29 ++++-------------------------
 arch/sh/lib/ashrsi3.S        | 29 ++++-------------------------
 arch/sh/lib/checksum.S       |  9 +++------
 arch/sh/lib/io.c             |  5 +----
 arch/sh/lib/libgcc.h         |  2 ++
 arch/sh/lib/lshrsi3.S        | 29 ++++-------------------------
 arch/sh/lib/mcount.S         |  7 ++-----
 arch/sh/lib/movmem.S         | 29 ++++-------------------------
 arch/sh/lib/udiv_qrnnd.S     | 29 ++++-------------------------
 arch/sh/lib/udivsi3.S        | 29 ++++-------------------------
 arch/sh/lib/udivsi3_i4i-Os.S | 29 ++++-------------------------
 arch/sh/lib/udivsi3_i4i.S    | 29 ++++-------------------------
 13 files changed, 44 insertions(+), 240 deletions(-)

diff --git a/arch/sh/lib/ashiftrt.S b/arch/sh/lib/ashiftrt.S
index 45ce865..0f7145e 100644
--- a/arch/sh/lib/ashiftrt.S
+++ b/arch/sh/lib/ashiftrt.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
=20
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/ashlsi3.S b/arch/sh/lib/ashlsi3.S
index 70a6434..4df4401 100644
--- a/arch/sh/lib/ashlsi3.S
+++ b/arch/sh/lib/ashlsi3.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
=20
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/ashrsi3.S b/arch/sh/lib/ashrsi3.S
index 602599d..bf3c4e03 100644
--- a/arch/sh/lib/ashrsi3.S
+++ b/arch/sh/lib/ashrsi3.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
=20
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
index 356c8ec9..97b5c2d 100644
--- a/arch/sh/lib/checksum.S
+++ b/arch/sh/lib/checksum.S
@@ -1,4 +1,6 @@
-/* $Id: checksum.S,v 1.10 2001/07/06 13:11:32 gniibe Exp $
+/* SPDX-License-Identifier: GPL-2.0+
+ *
+ * $Id: checksum.S,v 1.10 2001/07/06 13:11:32 gniibe Exp $
  *
  * INET		An implementation of the TCP/IP protocol suite for the LINUX
  *		operating system.  INET is implemented using the  BSD Socket
@@ -21,11 +23,6 @@
  *                   converted to pure assembler
  *
  * SuperH version:  Copyright (C) 1999  Niibe Yutaka
- *
- *		This program is free software; you can redistribute it and/or
- *		modify it under the terms of the GNU General Public License
- *		as published by the Free Software Foundation; either version
- *		2 of the License, or (at your option) any later version.
  */
=20
 #include <asm/errno.h>
diff --git a/arch/sh/lib/io.c b/arch/sh/lib/io.c
index 88dfe6e..ebcf7c0 100644
--- a/arch/sh/lib/io.c
+++ b/arch/sh/lib/io.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/sh/lib/io.c - SH32 optimized I/O routines
  *
@@ -6,10 +7,6 @@
  *
  * Provide real functions which expand to whatever the header file defined=
.
  * Also definitions of machine independent IO functions.
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <linux/module.h>
 #include <linux/io.h>
diff --git a/arch/sh/lib/libgcc.h b/arch/sh/lib/libgcc.h
index 05909d58..58ada9e 100644
--- a/arch/sh/lib/libgcc.h
+++ b/arch/sh/lib/libgcc.h
@@ -1,3 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
 #ifndef __ASM_LIBGCC_H
 #define __ASM_LIBGCC_H
=20
diff --git a/arch/sh/lib/lshrsi3.S b/arch/sh/lib/lshrsi3.S
index f2a6959..b79b817 100644
--- a/arch/sh/lib/lshrsi3.S
+++ b/arch/sh/lib/lshrsi3.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
=20
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/mcount.S b/arch/sh/lib/mcount.S
index 7a8572f..c6ca90c 100644
--- a/arch/sh/lib/mcount.S
+++ b/arch/sh/lib/mcount.S
@@ -1,12 +1,9 @@
-/*
+/* SPDX-License-Identifier: GPL-2.0
+ *
  * arch/sh/lib/mcount.S
  *
  *  Copyright (C) 2008, 2009  Paul Mundt
  *  Copyright (C) 2008, 2009  Matt Fleming
- *
- * This file is subject to the terms and conditions of the GNU General Pub=
lic
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 #include <asm/ftrace.h>
 #include <asm/thread_info.h>
diff --git a/arch/sh/lib/movmem.S b/arch/sh/lib/movmem.S
index 62075f6..8ac54d6 100644
--- a/arch/sh/lib/movmem.S
+++ b/arch/sh/lib/movmem.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
=20
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/udiv_qrnnd.S b/arch/sh/lib/udiv_qrnnd.S
index 32b9a36..28938da 100644
--- a/arch/sh/lib/udiv_qrnnd.S
+++ b/arch/sh/lib/udiv_qrnnd.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
=20
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/udivsi3.S b/arch/sh/lib/udivsi3.S
index 72157ab..09ed1f9 100644
--- a/arch/sh/lib/udivsi3.S
+++ b/arch/sh/lib/udivsi3.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
=20
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
diff --git a/arch/sh/lib/udivsi3_i4i-Os.S b/arch/sh/lib/udivsi3_i4i-Os.S
index 4835553e..fa4e4df 100644
--- a/arch/sh/lib/udivsi3_i4i-Os.S
+++ b/arch/sh/lib/udivsi3_i4i-Os.S
@@ -1,28 +1,7 @@
-/* Copyright (C) 2006 Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+ *
+ * Copyright (C) 2006 Free Software Foundation, Inc.
+ */
=20
 /* Moderately Space-optimized libgcc routines for the Renesas SH /
    STMicroelectronics ST40 CPUs.
diff --git a/arch/sh/lib/udivsi3_i4i.S b/arch/sh/lib/udivsi3_i4i.S
index f1a79d9..6944eb6 100644
--- a/arch/sh/lib/udivsi3_i4i.S
+++ b/arch/sh/lib/udivsi3_i4i.S
@@ -1,30 +1,9 @@
-/* Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
+/* SPDX-License-Identifier: GPL-2.0+ WITH GCC-exception-2.0
+
+   Copyright (C) 1994, 1995, 1997, 1998, 1999, 2000, 2001, 2002, 2003,
    2004, 2005, 2006
    Free Software Foundation, Inc.
-
-This file is free software; you can redistribute it and/or modify it
-under the terms of the GNU General Public License as published by the
-Free Software Foundation; either version 2, or (at your option) any
-later version.
-
-In addition to the permissions in the GNU General Public License, the
-Free Software Foundation gives you unlimited permission to link the
-compiled version of this file into combinations with other programs,
-and to distribute those combinations without any restriction coming
-from the use of this file.  (The General Public License restrictions
-do apply in other respects; for example, they cover modification of
-the file, and distribution when not linked into a combine
-executable.)
-
-This file is distributed in the hope that it will be useful, but
-WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; see the file COPYING.  If not, write to
-the Free Software Foundation, 51 Franklin Street, Fifth Floor,
-Boston, MA 02110-1301, USA.  */
+*/
=20
 !! libgcc routines for the Renesas / SuperH SH CPUs.
 !! Contributed by Steve Chamberlain.
--=20
2.7.4

