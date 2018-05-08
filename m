Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbeEHCam (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 22:30:42 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.206]:57164 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753809AbeEHCak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 22:30:40 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUwTZxzH+9w97R3ILUeR8LMTkjUzcbgycCM
  5o1nIsrnbHzOL/kd84erOtllbyF3ruplNQLsYXxrtouOlY93GFnnxJRS2AoovmGgrG0s3ZTIE
  RZkKCsKyCKK4ux667b/P7/l87/f8nifP0aRxJ2WiRZ9HlNyC02xIxfbb1wnLzwsmi/Pj5YVc6
  Fizgfumy859UdFLcU0t73K/doQM3GDzEz2348AfFBf9rovghgJFnL+7HXO1O8f1XG1FAHGz0y
  FDEcN3350g+fYjjQQfOZzLt0wFKf5C1Szm99TOYX5ypB/zx1ovYb4nfI7iIxe38W0PX+f9DzL
  5v1py3mOK9Q63tdRXorff/+2CoWw839fdE8Hl6MnS3SiVNrI3ETT2HcBacQZBtO4aqRaY3UtC
  W6id0kyAgIaTIaQVAwiuBP/U70YptIF9CWJ3L5MqL2S3QGKmg1BDJPuZHvr8B5MiQxGPhqNIC
  9mg4s7YPC+HysePCZUx+yIc/PE8Vplh18OV4wMGlY2sD/7edy7ZJ4V9AwYr+iiVEZsNh4aHkt
  +SbBZ8eagmORCwLNSf6CU1zoQ7N+aUdVrJr4Xx1o3ashlqztTPx7Mh8dUepPF+PXT99KbGBXC
  +4VTyKoCd08NMMEhpxQ8IZk6F5jfIhejACKXxB3Cr8iih8QrYlfgda5wDjfuuz3MDCaNzSzRe
  DKGrXXg/yqv5zxk0fhnCnVMGjZfB91+PkTXJe0mHWPVNHEa4ES2VRWmrKFmWv5pnlRw2u8clO
  JyWgnwuzyXKsmATnYJVzttc6mpByovcrtOhKKrqfPssWkQT5kxmK54sNj5nLX3/I7sg2zdJXq
  con0WLadoMTHWq4tIl0Sb6tjicyrN+qoFOMy9k5BRFM3KZ4JIdNk3FkYVubg3uJY3YXeoWTVl
  MndqDVUN2r/tZi6c/RwJlmzIYpNPpjGllouRyeP7vR1EWjcwZzEq1S5rD7Xm206gyBKEMkX5t
  Qh3CI/yrTOXonRKmaVX4Xv+ygGNwtohF9VmrN08t8g/FYzg+PP3hW/6HOZdN3rGTG7alV12Nr
  H0lpV98UL294/RE9acrrb8Utp1el1jfP5a6xFuy5tFEp7enKZZmkWLZiVXeNS/c6C1YHa689V
  rdpYHpdZGM8ZFvA/HiE2LhvZnnP970+a6GoYu3PzFj2S4U5JKSLPwDf94sOhcEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-11.tower-218.messagelabs.com!1525746638!13456281!1
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
Subject: RE: [External]  [RFC PATCH v1 1/6] mm/memblock: Expand definition of
 flags to support NVDIMM
Thread-Topic: [External]  [RFC PATCH v1 1/6] mm/memblock: Expand definition of
 flags to support NVDIMM
Thread-Index: AQHT5nLlj23hhXTovUGRNOlgqiO3aqQlG8KQ
Date: Tue, 8 May 2018 02:30:23 +0000
Message-ID: <HK2PR03MB1684FC46E0F2F70F9EF1F6D1929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525746628-114136-1-git-send-email-yehs1@lenovo.com>
 <1525746628-114136-2-git-send-email-yehs1@lenovo.com>
In-Reply-To: <1525746628-114136-2-git-send-email-yehs1@lenovo.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.197.250.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0802;7:ffCxQIkMe5RB8ZoqY2OY1If4XEAar2D4b75n+008ZS5a5PfXN1ydZumz3Pc1e9L2hSfJ+S3V19d5F44EJlNetSaSNc0WlOMvJrgiVjmYeQZVAMDXY7saA6DaQCzP/Wq7acWQ/EuafsBalhexakZIxp2HcOgBvxJLFvFs1zLrYHvEkRMWEUnvpFASodjE5cnYt/Rv7RTR/t4JWyn3NgovUd2lU61D4CAuiGmfrlTaSGmd4TqWAE1hPz+Wsc4xSbNO;20:9AxTj+U/a7yhoP9Y+vWMKw9FcaDtG/+98mvPwMpJHcYlIpfa5LuXWxYyR22aqI0+7haE+MeQJmG8g9xirkqzWZXlFX5+c3MB8+Ap9ZoNuiHZnggm+XDmqBdwVWtns16t3hWgCkoqgiS4dZcF8VnbG6Cw83kYI/4FrW4P6QktgLlK82JclZoGIkCds/wjDQTF0UV9uG+7WvglKdbzfY5WaCQXbarBZjxH92RkmhaQuhimjCzRbtRKO6MlbKNRbgLmpRjqZt48dkPr3LiFTU9cx446WvMiFBIiic6gWwRhyfmEJnEp47yIHSwcJzn7m0OtmVdYlESg/d19luybntuL9A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39850400004)(396003)(346002)(199004)(189003)(14454004)(68736007)(6436002)(106356001)(8676002)(81166006)(81156014)(25786009)(478600001)(66066001)(8936002)(2906002)(110136005)(7736002)(97736004)(305945005)(54906003)(86362001)(3660700001)(3280700002)(229853002)(105586002)(26005)(55016002)(102836004)(53936002)(7696005)(186003)(76176011)(6506007)(3846002)(9686003)(7416002)(74316002)(5660300001)(446003)(11346002)(33656002)(476003)(486006)(2900100001)(4326008)(316002)(5250100002)(2501003)(99286004)(6116002)(6246003)(13296004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0802;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0802;
x-ms-traffictypediagnostic: HK2PR03MB0802:
x-microsoft-antispam-prvs: <HK2PR03MB080212CD298FE46D95987D98929A0@HK2PR03MB0802.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:HK2PR03MB0802;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0802;
x-forefront-prvs: 0666E15D35
x-microsoft-antispam-message-info: uuAKpIX2Ny2AAbHyk6F6XhquDmqgqZyIS9NdGWMRN64xHt5CsrEGfk9CgqhskQyiSoMMbZyinNUOTc4/54Yy+wgXpDb9LQcyU55brvgyqWbKtFIh60PG4GdLvQSNmhwNnxpMpvp4UI3QIO1NLm91LFS1SLwbTGWhRg+pxRJ7cKHOsYGeuxp6NZXDqpNsiWSm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 04153802-66a3-4182-c49d-08d5b48ba70a
X-MS-Exchange-CrossTenant-Network-Message-Id: 04153802-66a3-4182-c49d-08d5b48ba70a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 02:30:23.6295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0802
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w482UmeK006633

This patch makes mm to have capability to get special regions
from memblock.

During boot process, memblock marks NVDIMM regions with flag
MEMBLOCK_NVDIMM, also expands the interface of functions and
macros with flags.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 include/linux/memblock.h | 19 +++++++++++++++++++
 mm/memblock.c            | 46 +++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index f92ea77..cade5c8d 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -26,6 +26,8 @@ enum {
 	MEMBLOCK_HOTPLUG	= 0x1,	/* hotpluggable region */
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
+	MEMBLOCK_NVDIMM		= 0x8,	/* NVDIMM region */
+	MEMBLOCK_MAX_TYPE	= 0x10	/* all regions */
 };
 
 struct memblock_region {
@@ -89,6 +91,8 @@ bool memblock_overlaps_region(struct memblock_type *type,
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_mark_nvdimm(phys_addr_t base, phys_addr_t size);
+int memblock_clear_nvdimm(phys_addr_t base, phys_addr_t size);
 ulong choose_memblock_flags(void);
 
 /* Low level functions */
@@ -167,6 +171,11 @@ void __next_reserved_mem_region(u64 *idx, phys_addr_t *out_start,
 	     i != (u64)ULLONG_MAX;					\
 	     __next_reserved_mem_region(&i, p_start, p_end))
 
+static inline bool memblock_is_nvdimm(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_NVDIMM;
+}
+
 static inline bool memblock_is_hotpluggable(struct memblock_region *m)
 {
 	return m->flags & MEMBLOCK_HOTPLUG;
@@ -187,6 +196,11 @@ int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 			  unsigned long *out_end_pfn, int *out_nid);
+void __next_mem_pfn_range_with_flags(int *idx, int nid,
+				     unsigned long *out_start_pfn,
+				     unsigned long *out_end_pfn,
+				     int *out_nid,
+				     unsigned long flags);
 
 /**
  * for_each_mem_pfn_range - early memory pfn range iterator
@@ -201,6 +215,11 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 #define for_each_mem_pfn_range(i, nid, p_start, p_end, p_nid)		\
 	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid); \
 	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
+
+#define for_each_mem_pfn_range_with_flags(i, nid, p_start, p_end, p_nid, flags) \
+	for (i = -1, __next_mem_pfn_range_with_flags(&i, nid, p_start, p_end, p_nid, flags);\
+	     i >= 0; __next_mem_pfn_range_with_flags(&i, nid, p_start, p_end, p_nid, flags))
+
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
 /**
diff --git a/mm/memblock.c b/mm/memblock.c
index 48376bd..7699637 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -771,6 +771,16 @@ int __init_memblock memblock_clear_hotplug(phys_addr_t base, phys_addr_t size)
 	return memblock_setclr_flag(base, size, 0, MEMBLOCK_HOTPLUG);
 }
 
+int __init_memblock memblock_mark_nvdimm(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 1, MEMBLOCK_NVDIMM);
+}
+
+int __init_memblock memblock_clear_nvdimm(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NVDIMM);
+}
+
 /**
  * memblock_mark_mirror - Mark mirrored memory with flag MEMBLOCK_MIRROR.
  * @base: the base phys addr of the region
@@ -891,6 +901,10 @@ void __init_memblock __next_mem_range(u64 *idx, int nid, ulong flags,
 		if (nid != NUMA_NO_NODE && nid != m_nid)
 			continue;
 
+		/* skip nvdimm memory regions if needed */
+		if (!(flags & MEMBLOCK_NVDIMM) && memblock_is_nvdimm(m))
+			continue;
+
 		/* skip hotpluggable memory regions if needed */
 		if (movable_node_is_enabled() && memblock_is_hotpluggable(m))
 			continue;
@@ -1007,6 +1021,10 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid, ulong flags,
 		if (nid != NUMA_NO_NODE && nid != m_nid)
 			continue;
 
+		/* skip nvdimm memory regions if needed */
+		if (!(flags & MEMBLOCK_NVDIMM) && memblock_is_nvdimm(m))
+			continue;
+
 		/* skip hotpluggable memory regions if needed */
 		if (movable_node_is_enabled() && memblock_is_hotpluggable(m))
 			continue;
@@ -1070,12 +1088,9 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid, ulong flags,
 }
 
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
-/*
- * Common iterator interface used to define for_each_mem_range().
- */
-void __init_memblock __next_mem_pfn_range(int *idx, int nid,
+void __init_memblock __next_mem_pfn_range_with_flags(int *idx, int nid,
 				unsigned long *out_start_pfn,
-				unsigned long *out_end_pfn, int *out_nid)
+				unsigned long *out_end_pfn, int *out_nid, unsigned long flags)
 {
 	struct memblock_type *type = &memblock.memory;
 	struct memblock_region *r;
@@ -1085,6 +1100,16 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 
 		if (PFN_UP(r->base) >= PFN_DOWN(r->base + r->size))
 			continue;
+
+		/*
+		 *  Use "flags & r->flags " to find region with multi-flags
+		 *  Use "flags == r->flags" to include region flags of MEMBLOCK_NONE
+		 *  Set flags = MEMBLOCK_MAX_TYPE to ignore to check flags
+		 */
+
+		if ((flags != MEMBLOCK_MAX_TYPE) && (flags != r->flags) && !(flags & r->flags))
+			continue;
+
 		if (nid == MAX_NUMNODES || nid == r->nid)
 			break;
 	}
@@ -1101,6 +1126,17 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 		*out_nid = r->nid;
 }
 
+/*
+ * Common iterator interface used to define for_each_mem_range().
+ */
+void __init_memblock __next_mem_pfn_range(int *idx, int nid,
+				unsigned long *out_start_pfn,
+				unsigned long *out_end_pfn, int *out_nid)
+{
+	__next_mem_pfn_range_with_flags(idx, nid, out_start_pfn, out_end_pfn,
+						out_nid, MEMBLOCK_MAX_TYPE);
+}
+
 /**
  * memblock_set_node - set node ID on memblock regions
  * @base: base of area to set node ID for
-- 
1.8.3.1
