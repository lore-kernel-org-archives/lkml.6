Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754096AbeEHCdr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:33:47 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.208]:33116 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753723AbeEHCdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:33:43 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTb1AUZRjA793d21svVl8WkScUP9w4Vld3I2c
  f1v4Nac7sTDXRRykH9mK927o/zO3JXOlMMHRMAf6dwew49SpFRBgKKBQVJsgBwWI6JEsNUjAN
  SDy1QTmybm9Pq2+/5/09z/M+z867DMkFDdmMFPBLPo/oMtFGynn9MmGpTIsVrLpZ/xwfbmmi+
  c+6nPzH5UMG/mjrq/xwZ5jmR5v+1vMVuy4a+GOHugh+bHseH+w9TvF1H9zQ83Xl2xEfvxum81
  ihd3qGFI43NxJCW4NZaL212yD0741TQnXdfUqIXb1ACS3tI5RwNvKtQWgb3CJ8NfeCEJzNFG6
  3Ls9nC/Syx+4NFOmdU1+2USWzfOD2/Dxdhq5aqpCR4fAEgr7Rs0gLehBcnJym1YDCNSS0lEcI
  zWwj4LfTlaQWXEIwNl1HVaEFDI2fgDPTP5IqL8abIHqvM1lB4ko9nA/WJkUGLobamgFCS5Jh/
  /WyBDMJtkHo85XqMYVXwEddvcl0Fr8J586PG1TmcAAic4eTvACvhb3XriQZ4RzYc2Us2ZLEWb
  BvT0ivMmAMB08OkRpnwu/j91PnJgh9czDFORA9UJ3cGfBOPXRc+4vWRC70HekmNVFNw0BNBaU
  FXyMYPj2YKjfDoe8vURq/A5P3hlO8Bj6M/pTi5dC47XKq+AgJP7SfQJpYBuFfuih1fQ7boTku
  70TW0H+20PgpiJy4RWv8JNR/OkWGkl8mHc58MkFFENWIHlckX6nks9iettp9ssPpd4uyy5K7i
  re6JUURHZJLtCvWt7zuVpR4ku/rdOgY+m5qQw96lCFMmWwpFSvgFtq9xe86RcVZ6NvskpQetI
  xhTMC+/kjCpfskhxTYJLsS7/qBBibNtJgdNSY0q5SIbkV2aGoAWZim9t01JEd5vB4pO4tdovb
  AapJzs+dhiwd/RxTlZGewSKfTcWklks8t+//vJ1EWg0wZrFntkiZ7/A9vmkwMQSSGSP91Rh3C
  L/6rssvQEi9XPD80s2713I74xoFC4tkVq5dufTFoXrd+34YvHAcm8u7aonndzA7jKaLI9Fhs0
  S7rqZPvObj+3vG+kY7wrPLMRNXKO/W22pGXnl+I85v/HOxeUxpMD24pdNyI57fk/+x9pWLjG/
  1vbw0VvWy8ea6hYe2dsqMd62MNrxlsSzsv/IFNlOIUc82kTxH/AdpOw28YBAAA
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-8.tower-128.messagelabs.com!1525746822!68836764!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "mhocko@suse.com" <mhocko@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "Ocean HY1 He" <hehy1@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: [External]  [RFC PATCH v1 3/6] mm, zone_type: create ZONE_NVM and
 fill into GFP_ZONE_TABLE
Thread-Topic: [External]  [RFC PATCH v1 3/6] mm, zone_type: create ZONE_NVM
 and fill into GFP_ZONE_TABLE
Thread-Index: AQHT5nLzy/4k5ASDlU6ANqYChIyrIKQlHNwQ
Date: Tue, 8 May 2018 02:33:30 +0000
Message-ID: <HK2PR03MB1684653383FFEDAE9B41A548929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525746628-114136-1-git-send-email-yehs1@lenovo.com>
 <1525746628-114136-4-git-send-email-yehs1@lenovo.com>
In-Reply-To: <1525746628-114136-4-git-send-email-yehs1@lenovo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.197.250.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1490;7:NVihKtGCXJgQLXP9Z2Ojm2OOgUkq0W/8Gb5nudkko3FFO3oAiZt0s4EqR0g4f07Es0ssDYpeFLR3BpZx7Hvz0yKVpg5Mq/HexfDer1IG48XoNyfoaaocOBugaVEQ/mE5+hryC8BMetflSFzD2602q+x09kXI3e1Fjd2Tqdgnq0noPweB4Z/k9DSvlXa9lni1RLy0tSxZYy/XUCRG6y06a79quRqLYAAUkzUl6DVKwtdfZjBqp73uiCnO6WBuvSo7;20:mixslv69UXj+IK8YsDyfHRCLUOLqKVSVcPG9fHky6soWuVNwbOKERl0a9ezoVRnDcM6VoZ2Dtg5ON4rwMb0JF2yo/4bRbzbh9DU43RzgqG6qu/Z9Whem3W5+lS5EvrNHYhe5KWipxEgreLWNY3aIkQa4B+79btkbsDPnJsH0IEnVzY0KmAmNZM4H0S7vb3Xzl8xT10uQSWZDL7N4FVR7lBVz/SMD6VBT7QjKNGZqHSTX8CQaYLc7yy0p0NZ0Ntk/IburJTpxEzVFKUAc6OQE6f798qDaD2UlDujPX7xsXNW/z7fEncmiIOMvq6ttMvl/gorD899NUKH0CPM9wHCvAA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39850400004)(39380400002)(376002)(199004)(189003)(186003)(4326008)(68736007)(11346002)(476003)(99286004)(33656002)(6346003)(446003)(25786009)(6436002)(102836004)(53936002)(9686003)(7736002)(81166006)(8936002)(26005)(81156014)(8676002)(316002)(55016002)(486006)(54906003)(110136005)(305945005)(76176011)(59450400001)(7416002)(2900100001)(6506007)(6116002)(3846002)(2906002)(14454004)(66066001)(5660300001)(74316002)(86362001)(3660700001)(105586002)(106356001)(478600001)(97736004)(5250100002)(2501003)(575784001)(7696005)(3280700002)(13296004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1490;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1490;
x-ms-traffictypediagnostic: HK2PR03MB1490:
x-microsoft-antispam-prvs: <HK2PR03MB14903DF04331466ADBBEE303929A0@HK2PR03MB1490.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HK2PR03MB1490;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1490;
x-forefront-prvs: 0666E15D35
x-microsoft-antispam-message-info: aDa7kJL8Ls2wySFCbNREZqE3TV+2u0WpZaCpnVQ5U8zE0HDkFxoKFfg9ZqyNRq1HrEnMsPjVgfCgbY2MAjTGmjL44in61XBuicB6r6GxUJkFd7KsgLuv7C0GoTxq2oNs4u4/6uQwrvx63elhy2mNGtf3/gjpN3NcB+PXzhi8Mjri+i8OI+cjqHulM2lc+9Kw
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b38e2dde-16af-4b9e-d70f-08d5b48c16aa
X-MS-Exchange-CrossTenant-Network-Message-Id: b38e2dde-16af-4b9e-d70f-08d5b48c16aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 02:33:30.9837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1490
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w482Xqt6006681

Expand ZONE_NVM into enum zone_type, and create GFP_NVM
which represents gfp_t flag for NVM zone.

Because there is no lower plain integer GFP bitmask can be
used for ___GFP_NVM, a workable way is to get space from
GFP_ZONE_BAD to fill ZONE_NVM into GFP_ZONE_TABLE.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 include/linux/gfp.h    | 57 +++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/mmzone.h |  3 +++
 mm/Kconfig             | 16 ++++++++++++++
 mm/page_alloc.c        |  3 +++
 4 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 1a4582b..9e4d867 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -39,6 +39,9 @@
 #define ___GFP_DIRECT_RECLAIM	0x400000u
 #define ___GFP_WRITE		0x800000u
 #define ___GFP_KSWAPD_RECLAIM	0x1000000u
+#ifdef CONFIG_ZONE_NVM
+#define ___GFP_NVM		0x4000000u
+#endif
 #ifdef CONFIG_LOCKDEP
 #define ___GFP_NOLOCKDEP	0x2000000u
 #else
@@ -57,7 +60,12 @@
 #define __GFP_HIGHMEM	((__force gfp_t)___GFP_HIGHMEM)
 #define __GFP_DMA32	((__force gfp_t)___GFP_DMA32)
 #define __GFP_MOVABLE	((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
+#ifdef CONFIG_ZONE_NVM
+#define __GFP_NVM	((__force gfp_t)___GFP_NVM)  /* ZONE_NVM allowed */
+#define GFP_ZONEMASK	(__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE|__GFP_NVM)
+#else
 #define GFP_ZONEMASK	(__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE)
+#endif
 
 /*
  * Page mobility and placement hints
@@ -205,7 +213,8 @@
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (25 + IS_ENABLED(CONFIG_LOCKDEP) + \
+				(IS_ENABLED(CONFIG_ZONE_NVM) << 1))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /*
@@ -283,6 +292,9 @@
 #define GFP_TRANSHUGE_LIGHT	((GFP_HIGHUSER_MOVABLE | __GFP_COMP | \
 			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
 #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
+#ifdef CONFIG_ZONE_NVM
+#define GFP_NVM		__GFP_NVM
+#endif
 
 /* Convert GFP flags to their corresponding migrate type */
 #define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
@@ -342,7 +354,7 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
  *       0x0    => NORMAL
  *       0x1    => DMA or NORMAL
  *       0x2    => HIGHMEM or NORMAL
- *       0x3    => BAD (DMA+HIGHMEM)
+ *       0x3    => NVM (DMA+HIGHMEM), now it is used by NVDIMM zone
  *       0x4    => DMA32 or DMA or NORMAL
  *       0x5    => BAD (DMA+DMA32)
  *       0x6    => BAD (HIGHMEM+DMA32)
@@ -370,6 +382,29 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 #error GFP_ZONES_SHIFT too large to create GFP_ZONE_TABLE integer
 #endif
 
+#ifdef CONFIG_ZONE_NVM
+#define ___GFP_NVM_BIT (___GFP_DMA | ___GFP_HIGHMEM)
+#define GFP_ZONE_TABLE ( \
+	((__force unsigned long)ZONE_NORMAL <<				       \
+			0 * GFP_ZONES_SHIFT)				       \
+	| ((__force unsigned long)OPT_ZONE_DMA <<			       \
+			___GFP_DMA * GFP_ZONES_SHIFT)			       \
+	| ((__force unsigned long)OPT_ZONE_HIGHMEM <<			       \
+			___GFP_HIGHMEM * GFP_ZONES_SHIFT)		       \
+	| ((__force unsigned long)OPT_ZONE_DMA32 <<			       \
+			___GFP_DMA32 * GFP_ZONES_SHIFT)			       \
+	| ((__force unsigned long)ZONE_NORMAL <<			       \
+			___GFP_MOVABLE * GFP_ZONES_SHIFT)		       \
+	| ((__force unsigned long)OPT_ZONE_DMA <<			       \
+			(___GFP_MOVABLE | ___GFP_DMA) * GFP_ZONES_SHIFT)       \
+	| ((__force unsigned long)ZONE_MOVABLE <<			       \
+			(___GFP_MOVABLE | ___GFP_HIGHMEM) * GFP_ZONES_SHIFT)   \
+	| ((__force unsigned long)OPT_ZONE_DMA32 <<			       \
+			(___GFP_MOVABLE | ___GFP_DMA32) * GFP_ZONES_SHIFT)     \
+	| ((__force unsigned long)ZONE_NVM <<				       \
+			___GFP_NVM_BIT * GFP_ZONES_SHIFT)                      \
+)
+#else
 #define GFP_ZONE_TABLE ( \
 	(ZONE_NORMAL << 0 * GFP_ZONES_SHIFT)				       \
 	| (OPT_ZONE_DMA << ___GFP_DMA * GFP_ZONES_SHIFT)		       \
@@ -380,6 +415,7 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 	| (ZONE_MOVABLE << (___GFP_MOVABLE | ___GFP_HIGHMEM) * GFP_ZONES_SHIFT)\
 	| (OPT_ZONE_DMA32 << (___GFP_MOVABLE | ___GFP_DMA32) * GFP_ZONES_SHIFT)\
 )
+#endif
 
 /*
  * GFP_ZONE_BAD is a bitmap for all combinations of __GFP_DMA, __GFP_DMA32
@@ -387,6 +423,17 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
  * entry starting with bit 0. Bit is set if the combination is not
  * allowed.
  */
+#ifdef CONFIG_ZONE_NVM
+#define GFP_ZONE_BAD ( \
+	1 << (___GFP_DMA | ___GFP_DMA32)				      \
+	| 1 << (___GFP_DMA32 | ___GFP_HIGHMEM)				      \
+	| 1 << (___GFP_DMA | ___GFP_DMA32 | ___GFP_HIGHMEM)		      \
+	| 1 << (___GFP_MOVABLE | ___GFP_HIGHMEM | ___GFP_DMA)		      \
+	| 1 << (___GFP_MOVABLE | ___GFP_DMA32 | ___GFP_DMA)		      \
+	| 1 << (___GFP_MOVABLE | ___GFP_DMA32 | ___GFP_HIGHMEM)		      \
+	| 1 << (___GFP_MOVABLE | ___GFP_DMA32 | ___GFP_DMA | ___GFP_HIGHMEM)  \
+)
+#else
 #define GFP_ZONE_BAD ( \
 	1 << (___GFP_DMA | ___GFP_HIGHMEM)				      \
 	| 1 << (___GFP_DMA | ___GFP_DMA32)				      \
@@ -397,12 +444,16 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 	| 1 << (___GFP_MOVABLE | ___GFP_DMA32 | ___GFP_HIGHMEM)		      \
 	| 1 << (___GFP_MOVABLE | ___GFP_DMA32 | ___GFP_DMA | ___GFP_HIGHMEM)  \
 )
+#endif
 
 static inline enum zone_type gfp_zone(gfp_t flags)
 {
 	enum zone_type z;
 	int bit = (__force int) (flags & GFP_ZONEMASK);
-
+#ifdef CONFIG_ZONE_NVM
+	if (bit & __GFP_NVM)
+		bit = (__force int)___GFP_NVM_BIT;
+#endif
 	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
 					 ((1 << GFP_ZONES_SHIFT) - 1);
 	VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7522a69..f38e4a0 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -345,6 +345,9 @@ enum zone_type {
 	 */
 	ZONE_HIGHMEM,
 #endif
+#ifdef CONFIG_ZONE_NVM
+	ZONE_NVM,
+#endif
 	ZONE_MOVABLE,
 #ifdef CONFIG_ZONE_DEVICE
 	ZONE_DEVICE,
diff --git a/mm/Kconfig b/mm/Kconfig
index c782e8f..5fe1f63 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -687,6 +687,22 @@ config ZONE_DEVICE
 
 	  If FS_DAX is enabled, then say Y.
 
+config ZONE_NVM
+	bool "Manage NVDIMM (pmem) by memory management (EXPERIMENTAL)"
+	depends on NUMA && X86_64
+	depends on HAVE_MEMBLOCK_NODE_MAP
+	depends on HAVE_MEMBLOCK
+	depends on !IA32_EMULATION
+	default n
+
+	help
+	  This option allows you to use memory management subsystem to manage
+	  NVDIMM (pmem). With it mm can arrange NVDIMMs into real physical zones
+	  like NORMAL and DMA32. That means buddy system and swap can be used
+	  directly to NVDIMM zone. This feature is beneficial to recover
+	  dirty pages from power fail or system crash by storing write cache
+	  to NVDIMM zone.
+
 config ARCH_HAS_HMM
 	bool
 	default y
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 266c065..d8bd20d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -228,6 +228,9 @@ bool pm_suspended_storage(void)
 	 "DMA32",
 #endif
 	 "Normal",
+#ifdef CONFIG_ZONE_NVM
+	 "NVM",
+#endif
 #ifdef CONFIG_HIGHMEM
 	 "HighMem",
 #endif
-- 
1.8.3.1
