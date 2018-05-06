Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbeEFQR2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 12:17:28 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.16]:55871 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751714AbeEFQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 12:17:25 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgl+JIrShJLcpLzFFi42LJePGQSXeS1vs
  og3XfdS3mrF/DZrFoX4bF9Mbz7BarN/laXN41h83i3pr/rBY7lu5jsnj9bRmzRevhnSwWs1ve
  sVrMbuxjtPj9Yw6bA4/H4TfvmT12rl3F5LF5hZbHplWdbB6bPk1i9zgx4zeLx8ent1g8ziw4w
  u6x+XS1x9Zfdh6t30U9Pm+SC+CJYs3MS8qvSGDNOHr6HEtBa3DFsYPfmBoYL9l1MXJxCAk8YZ
  TYuvoaM4RziFHiwLSfbF2MnBwsAj3MEq3NThCJfiaJbzu+M0E4dxgl2r7vZgKpYhPQlDj5BqS
  dg0NEQEPizRYjkBpmgfssEiumbGIDiQsLREusPqsOUi4iECMxb3YzI4TtJvFlzSSoZSoS1xom
  gNm8QDUHvt+Auugyk8SXD0vBEpwC1hJf7r4GsxkFZCWmPboPdgOzgLjE3GmzWEFsCQEBiSV7z
  jND2KISLx//YwW5gVEgSOLdljiIsJLE0oO7oMplJS7N72YE2SUhMIFV4t6umewQCUOJ4yv3M0
  MkOtkkJjTcZYJwtjFKLF83hwmiSkti+s4zUHa2xOdNU2A6GCXu3fvPDuHMZJZYe+Qw1EIZiYe
  n3oDDRUggSWLt78wJjLqzkHwBYetILNj9iQ3C1pZYtvA18yxw0AhKnJz5hGUBI8sqRvXi1KKy
  1CJdU72kosz0jJLcxMwcXUNDI73c1OLixPTUnMSkYr3k/NxNjMB0WM/AwLiDcdk/n0OMkhxMS
  qK8XnFvooT4kvJTKjMSizPii0pzUosPMcpwcChJ8NZqvo8SEixKTU+tSMvMASZmmLQEB4+SCG
  8qSJq3uCAxtzgzHSJ1itGYY9qynh5mjjVbJvUwC7Hk5eelSonzRoCUCoCUZpTmwQ2CZYxLjLJ
  SwryMDAwMQjwFqUW5mSWo8q8YxTkYlYR5a0Cm8GTmlcDtewV0ChPQKcLvX4OcUpKIkJJqYDT+
  YGhseVhZov/AojXuOwNWr0i8yMDdLL59x+uCwshCAx6/8+ufSy58vfnz6q4r4kFV1o/2Xjkj3
  zNjVzqDY/LKslQvux/eGzKtliktqrCeM8PS+LLc9e57XfpzH/fZPLI6+j50P+/Z5Z9DbTLyuj
  /P1vnMdd3p48TQnI5TLde4Lz39vufevTVKLMUZiYZazEXFiQBP7g4kEwQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-11.tower-168.messagelabs.com!1525623440!68794450!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External]  Re: [PATCH 2/3] include/linux/gfp.h: use unsigned int
 in gfp_zone
Thread-Topic: [External]  Re: [PATCH 2/3] include/linux/gfp.h: use unsigned
 int in gfp_zone
Thread-Index: AQHT46zY0MF6WC61BUed7IoviL30RKQftP0AgAKu3ZCAAFaOAIAAIzyw
Date: Sun, 6 May 2018 16:17:06 +0000
Message-ID: <HK2PR03MB168447008C658172FFDA402992840@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525416729-108201-1-git-send-email-yehs1@lenovo.com>
 <1525416729-108201-3-git-send-email-yehs1@lenovo.com>
 <20180504133533.GR4535@dhcp22.suse.cz>
 <20180504154004.GB29829@bombadil.infradead.org>
 <HK2PR03MB168459A1C4FB2B7D3E1F6A4A92840@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180506134814.GB7362@bombadil.infradead.org>
In-Reply-To: <20180506134814.GB7362@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.253.21.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0868;7:8b3wBQsL1URWYrZA0xpDZoYE96gTvJ4vdgVqyrNOLDIAmDrDPonkP6YGQFU7LN6ic4QXDsAfq7ezUdCaILN8aOmVMfr+DGlh2qF31knKUFToAcFAWdTxvo6hVc3haPg8DYICbdWvYT2yTpGARfO/RjnZVZTe8AKd46Nm/RA36klI84Cp52RLs3Lrwqnsu7eMY16svOhYwQkk5osJp2CjfPvjDvKgT3J9fdEYnvxZlimRB6aEF3oQ+K3/U6892YhV;20:QhwNOE4DCyiSHU6l5uVXjAexXDDbnqyNKEGhjo4sbDz7KBsZziY5tYWO6ShgvGp/D1l4KsN8NDTzQMIElyc2Yt5M3jUCHJ5RAAudRjxeNXwwdsCbH9+E6YgCTMlkeZDE10YnR52lOzA2crtw4OUZOWWl+/oAMaEKevMGioCQ31T4bh7Q1kNgUZXNl30CVYde+XX1DY154PHpwEoaWcxX7bUC4IXoyNgR6dEmClfR/1N3+6jOnWLEiST5wkeXMVvPJhPZ3zdH903jaey24WLewHBRpPpnnJ8sG4RV/iLepgqJ5rbxutxoEPDH2nYoN0idD3Z4nPweUgNkNodyjiNcjg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(39840400004)(39380400002)(366004)(376002)(396003)(199004)(189003)(13464003)(33656002)(3846002)(99286004)(186003)(102836004)(26005)(76176011)(7696005)(6506007)(105586002)(53546011)(59450400001)(6116002)(5250100002)(11346002)(74316002)(229853002)(7736002)(106356001)(54906003)(53936002)(316002)(6916009)(66066001)(5660300001)(305945005)(6436002)(7416002)(476003)(446003)(486006)(2900100001)(97736004)(8936002)(14454004)(93886005)(2906002)(68736007)(3280700002)(25786009)(4326008)(81156014)(55016002)(81166006)(9686003)(86362001)(6246003)(8676002)(478600001)(3660700001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0868;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0868;
x-ms-traffictypediagnostic: HK2PR03MB0868:
x-microsoft-antispam-prvs: <HK2PR03MB0868CCA1D926BAD399E349B292840@HK2PR03MB0868.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(274141268393343)(3940261145250)(9452136761055)(788757137089)(146099531331640)(154440410675630);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:HK2PR03MB0868;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0868;
x-forefront-prvs: 06640999CA
x-microsoft-antispam-message-info: Wazch05T46pcP5l11yNfoE/8ZDQ5YtVzVPJLykFKVv2xKoQfA5Mcu1w2kOM7FU+4p5uH2yAwki6BxBGtAJzREIUrdPEe7KU27ABK9k2pEcE6QPHi9/IDEqzrKNwtb8ZcX6XhGQO0arh4GOQQbgPXqIy1twNrddSjuzYiG0Ey2KlA/+cVGIWUKx1B2I9gurFL
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 81341348-9607-436f-e4c3-08d5b36ccfe0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81341348-9607-436f-e4c3-08d5b36ccfe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2018 16:17:06.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0868
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w46GHZDf008521


> -----Original Message-----
> From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On
> Behalf Of Matthew Wilcox
> Sent: Sunday, May 06, 2018 9:48 PM
> To: Huaisheng HS1 Ye <yehs1@lenovo.com>
> Cc: Michal Hocko <mhocko@kernel.org>; akpm@linux-foundation.org;
> linux-mm@kvack.org; vbabka@suse.cz; mgorman@techsingularity.net;
> pasha.tatashin@oracle.com; alexander.levin@verizon.com;
> hannes@cmpxchg.org; penguin-kernel@I-love.SAKURA.ne.jp; colyli@suse.de;
> NingTing Cheng <chengnt@lenovo.com>; linux-kernel@vger.kernel.org
> Subject: Re: [External] Re: [PATCH 2/3] include/linux/gfp.h: use unsigned int in
> gfp_zone
> 
> On Sun, May 06, 2018 at 09:32:15AM +0000, Huaisheng HS1 Ye wrote:
> > This idea is great, we can replace GFP_ZONE_TABLE and GFP_ZONE_BAD with
> it.
> > I have realized it preliminarily based on your code and tested it on a 2 sockets
> platform. Fortunately, we got a positive test result.
> 
> Great!
> 
> > I made some adjustments for __GFP_HIGHMEM, this flag is special than
> others, because the return result of gfp_zone has two possibilities, which
> depend on ___GFP_MOVABLE has been enabled or disabled.
> > When ___GFP_MOVABLE has been enabled, ZONE_MOVABLE shall be
> returned. When disabled, OPT_ZONE_HIGHMEM shall be used.
> >
> > #define __GFP_DMA	((__force gfp_t)OPT_ZONE_DMA ^ ZONE_NORMAL)
> > #define __GFP_HIGHMEM	((__force gfp_t)ZONE_MOVABLE ^
> ZONE_NORMAL)
> 
> I'm not sure this is right ... Let me think about this a little.

Upload my current patch and testing platform info for reference. This patch has been tested 
on a two sockets platform.
Here is dmesg log about zones,

 397 [    0.000000] Zone ranges:
 398 [    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
 399 [    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
 400 [    0.000000]   Normal   [mem 0x0000000100000000-0x000000277fffffff]
 401 [    0.000000]   Device   empty
 402 [    0.000000] Movable zone start for each node
 403 [    0.000000] Early memory node ranges
 404 [    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
 405 [    0.000000]   node   0: [mem 0x0000000000100000-0x00000000a69c2fff]
 406 [    0.000000]   node   0: [mem 0x00000000a7654000-0x00000000a85eefff]
 407 [    0.000000]   node   0: [mem 0x00000000ab399000-0x00000000af3f6fff]
 408 [    0.000000]   node   0: [mem 0x00000000af429000-0x00000000af7fffff]
 409 [    0.000000]   node   0: [mem 0x0000000100000000-0x000000043fffffff]
 410 [    0.000000]   node   1: [mem 0x0000002380000000-0x000000277fffffff]

 416 [    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000043fffffff]
 417 [    0.000000] On node 0 totalpages: 4111666
 418 [    0.000000]   DMA zone: 64 pages used for memmap
 419 [    0.000000]   DMA zone: 23 pages reserved
 420 [    0.000000]   DMA zone: 3999 pages, LIFO batch:0
 421 [    0.000000] mminit::memmap_init Initialising map node 0 zone 0 pfns 1 -> 4096
 422 [    0.000000]   DMA32 zone: 10935 pages used for memmap
 423 [    0.000000]   DMA32 zone: 699795 pages, LIFO batch:31
 424 [    0.000000] mminit::memmap_init Initialising map node 0 zone 1 pfns 4096 -> 1048576
 425 [    0.000000]   Normal zone: 53248 pages used for memmap
 426 [    0.000000]   Normal zone: 3407872 pages, LIFO batch:31
 427 [    0.000000] mminit::memmap_init Initialising map node 0 zone 2 pfns 1048576 -> 4456448
 428 [    0.000000] Initmem setup node 1 [mem 0x0000002380000000-0x000000277fffffff]
 429 [    0.000000] On node 1 totalpages: 4194304
 430 [    0.000000]   Normal zone: 65536 pages used for memmap
 431 [    0.000000]   Normal zone: 4194304 pages, LIFO batch:31
 432 [    0.000000] mminit::memmap_init Initialising map node 1 zone 2 pfns 37224448 -> 41418752

 986 [    0.000000] mminit::zonelist general 0:DMA = 0:DMA
 987 [    0.000000] mminit::zonelist general 0:DMA32 = 0:DMA32 0:DMA
 988 [    0.000000] mminit::zonelist general 0:Normal = 0:Normal 0:DMA32 0:DMA 1:Normal
 989 [    0.000000] mminit::zonelist thisnode 0:DMA = 0:DMA
 990 [    0.000000] mminit::zonelist thisnode 0:DMA32 = 0:DMA32 0:DMA
 991 [    0.000000] mminit::zonelist thisnode 0:Normal = 0:Normal 0:DMA32 0:DMA
 992 [    0.000000] mminit::zonelist general 1:Normal = 1:Normal 0:Normal 0:DMA32 0:DMA
 993 [    0.000000] mminit::zonelist thisnode 1:Normal = 1:Normal
 994 [    0.000000] Built 2 zonelists, mobility grouping on.  Total pages: 8176164

Here is some information of ZONE_NORMAL which comes from /proc/zoneinfo
1131 Node 0, zone   Normal
1132   pages free     3171428
1133         min      9249
1134         low      12584
1135         high     15919
1136         spanned  3407872
1137         present  3407872
1138         managed  3335769
1139         protection: (0, 0, 0, 0, 0)
1140       nr_free_pages 3171428
1141       nr_zone_inactive_anon 12
1142       nr_zone_active_anon 13585
1143       nr_zone_inactive_file 37028
1144       nr_zone_active_file 12104
1145       nr_zone_unevictable 0
1146       nr_zone_write_pending 7
1147       nr_mlock     0
1148       nr_page_table_pages 1026
1149       nr_kernel_stack 10920
1150       nr_bounce    0
1151       nr_zspages   0
1152       nr_free_cma  0
1153       numa_hit     792300
1154       numa_miss    0
1155       numa_foreign 0
1156       numa_interleave 26268
1157       numa_local   768300
1158       numa_other   24000

1718 Node 1, zone   Normal
1747   pages free     3856001
1748         min      11405
1749         low      15518
1750         high     19631
1751         spanned  4194304
1752         present  4194304
1753         managed  4114482
1754         protection: (0, 0, 0, 0, 0)
1755       nr_free_pages 3856001
1756       nr_zone_inactive_anon 424
1757       nr_zone_active_anon 10679
1758       nr_zone_inactive_file 35274
1759       nr_zone_active_file 22189
1760       nr_zone_unevictable 0
1761       nr_zone_write_pending 0
1762       nr_mlock     0
1763       nr_page_table_pages 800
1764       nr_kernel_stack 9848
1765       nr_bounce    0
1766       nr_zspages   0
1767       nr_free_cma  0
1768       numa_hit     757099
1769       numa_miss    0
1770       numa_foreign 0
1771       numa_interleave 26314
1772       numa_local   712341
1773       numa_other   44758

Subject: [RFC PATCH v0.1] include/linux/gfp.h: Replace GFP_ZONE_TABLE with bit
 encoding

It works, but some drivers or subsystem shall be modified to fit
these new type __GFP flags.
They use these flags directly to realize bit manipulations like this
below.

eg.
swiotlb-xen.c (drivers\xen):    flags &= ~(__GFP_DMA | __GFP_HIGHMEM);
extent_io.c (fs\btrfs):         mask &= ~(__GFP_DMA32|__GFP_HIGHMEM);

Because of these flags have been encoded within this patch, the
above operations can cause problem.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 include/linux/gfp.h | 49 ++++++++++---------------------------------------
 1 file changed, 10 insertions(+), 39 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 1a4582b..1647385 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -16,9 +16,7 @@
  */

 /* Plain integer GFP bitmasks. Do not use this directly. */
-#define ___GFP_DMA             0x01u
-#define ___GFP_HIGHMEM         0x02u
-#define ___GFP_DMA32           0x04u
+#define ___GFP_ZONE_MASK       0x07u
 #define ___GFP_MOVABLE         0x08u
 #define ___GFP_RECLAIMABLE     0x10u
 #define ___GFP_HIGH            0x20u
@@ -53,11 +51,11 @@
* without the underscores and use them consistently. The definitions here may
  * be used in bit comparisons.
  */
-#define __GFP_DMA      ((__force gfp_t)___GFP_DMA)
-#define __GFP_HIGHMEM  ((__force gfp_t)___GFP_HIGHMEM)
-#define __GFP_DMA32    ((__force gfp_t)___GFP_DMA32)
+#define __GFP_DMA      ((__force gfp_t)OPT_ZONE_DMA ^ ZONE_NORMAL)
+#define __GFP_HIGHMEM  ((__force gfp_t)ZONE_MOVABLE ^ ZONE_NORMAL)
+#define __GFP_DMA32    ((__force gfp_t)OPT_ZONE_DMA32 ^ ZONE_NORMAL)
 #define __GFP_MOVABLE  ((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
-#define GFP_ZONEMASK   (__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE)
+#define GFP_ZONEMASK   ((__force gfp_t)___GFP_ZONE_MASK | ___GFP_MOVABLE)

 /*
  * Page mobility and placement hints
@@ -370,42 +368,15 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 #error GFP_ZONES_SHIFT too large to create GFP_ZONE_TABLE integer
 #endif

-#define GFP_ZONE_TABLE ( \
-       (ZONE_NORMAL << 0 * GFP_ZONES_SHIFT)                                   \
-       | (OPT_ZONE_DMA << ___GFP_DMA * GFP_ZONES_SHIFT)                       \
-       | (OPT_ZONE_HIGHMEM << ___GFP_HIGHMEM * GFP_ZONES_SHIFT)               \
-       | (OPT_ZONE_DMA32 << ___GFP_DMA32 * GFP_ZONES_SHIFT)                   \
-       | (ZONE_NORMAL << ___GFP_MOVABLE * GFP_ZONES_SHIFT)                    \
-       | (OPT_ZONE_DMA << (___GFP_MOVABLE | ___GFP_DMA) * GFP_ZONES_SHIFT)    \
-       | (ZONE_MOVABLE << (___GFP_MOVABLE | ___GFP_HIGHMEM) * GFP_ZONES_SHIFT)\
-       | (OPT_ZONE_DMA32 << (___GFP_MOVABLE | ___GFP_DMA32) * GFP_ZONES_SHIFT)\
-)
-
-/*
- * GFP_ZONE_BAD is a bitmap for all combinations of __GFP_DMA, __GFP_DMA32
- * __GFP_HIGHMEM and __GFP_MOVABLE that are not permitted. One flag per
- * entry starting with bit 0. Bit is set if the combination is not
- * allowed.
- */
-#define GFP_ZONE_BAD ( \
-       1 << (___GFP_DMA | ___GFP_HIGHMEM)                                    \
-       | 1 << (___GFP_DMA | ___GFP_DMA32)                                    \
-       | 1 << (___GFP_DMA32 | ___GFP_HIGHMEM)                                \
-       | 1 << (___GFP_DMA | ___GFP_DMA32 | ___GFP_HIGHMEM)                   \
-       | 1 << (___GFP_MOVABLE | ___GFP_HIGHMEM | ___GFP_DMA)                 \
-       | 1 << (___GFP_MOVABLE | ___GFP_DMA32 | ___GFP_DMA)                   \
-       | 1 << (___GFP_MOVABLE | ___GFP_DMA32 | ___GFP_HIGHMEM)               \
-       | 1 << (___GFP_MOVABLE | ___GFP_DMA32 | ___GFP_DMA | ___GFP_HIGHMEM)  \
-)
-
 static inline enum zone_type gfp_zone(gfp_t flags)
{
        enum zone_type z;
-       int bit = (__force int) (flags & GFP_ZONEMASK);
+       z = ((__force unsigned int)flags & ___GFP_ZONE_MASK) ^ ZONE_NORMAL;

-       z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
-                                        ((1 << GFP_ZONES_SHIFT) - 1);
-       VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
+       if (z > OPT_ZONE_HIGHMEM) {
+               z = OPT_ZONE_HIGHMEM +
+                       !!((__force unsigned int)flags & ___GFP_MOVABLE);
+       }
        return z;
 }

-- 
1.8.3.1
