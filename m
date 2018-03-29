Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbeC2OA3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:00:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33889 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeC2OA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:00:28 -0400
Date: Thu, 29 Mar 2018 07:00:09 -0700
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-0a73d21e9bdf43124241c3253dadc5044e239647@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tmricht@linux.vnet.ibm.com, heiko.carstens@de.ibm.com,
        mingo@kernel.org, acme@redhat.com, schwidefsky@de.ibm.com,
        brueckner@linux.vnet.ibm.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, heiko.carstens@de.ibm.com,
        tmricht@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, acme@redhat.com, schwidefsky@de.ibm.com,
        mingo@kernel.org
In-Reply-To: <20180326082538.2258-2-tmricht@linux.vnet.ibm.com>
References: <20180326082538.2258-2-tmricht@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events s390: Add JSON files for IBM
 z196
Git-Commit-ID: 0a73d21e9bdf43124241c3253dadc5044e239647
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0a73d21e9bdf43124241c3253dadc5044e239647
Gitweb:     https://git.kernel.org/tip/0a73d21e9bdf43124241c3253dadc5044e239647
Author:     Thomas Richter <tmricht@linux.vnet.ibm.com>
AuthorDate: Mon, 26 Mar 2018 10:25:35 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 27 Mar 2018 13:13:38 -0300

perf vendor events s390: Add JSON files for IBM z196

Add CPU measurement counter facility event description files (json
files) for IBM z196.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180326082538.2258-2-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/s390/{cf_z10 => cf_z196}/basic.json       |   0
 .../arch/s390/{cf_z10 => cf_z196}/crypto.json      |   0
 .../pmu-events/arch/s390/cf_z196/extended.json     | 146 +++++++++++++++++++++
 tools/perf/pmu-events/arch/s390/mapfile.csv        |   1 +
 4 files changed, 147 insertions(+)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json b/tools/perf/pmu-events/arch/s390/cf_z196/basic.json
similarity index 100%
copy from tools/perf/pmu-events/arch/s390/cf_z10/basic.json
copy to tools/perf/pmu-events/arch/s390/cf_z196/basic.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json b/tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
similarity index 100%
copy from tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
copy to tools/perf/pmu-events/arch/s390/cf_z196/crypto.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_z196/extended.json b/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
new file mode 100644
index 000000000000..b6d7fec7c2e7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z196/extended.json
@@ -0,0 +1,146 @@
+[
+	{
+		"EventCode": "128",
+		"EventName": "L1D_L2_SOURCED_WRITES",
+		"BriefDescription": "L1D L2 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from the Level-2 cache"
+	},
+	{
+		"EventCode": "129",
+		"EventName": "L1I_L2_SOURCED_WRITES",
+		"BriefDescription": "L1I L2 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from the Level-2 cache"
+	},
+	{
+		"EventCode": "130",
+		"EventName": "DTLB1_MISSES",
+		"BriefDescription": "DTLB1 Misses",
+		"PublicDescription": "Level-1 Data TLB miss in progress. Incremented by one for every cycle a DTLB1 miss is in progress."
+	},
+	{
+		"EventCode": "131",
+		"EventName": "ITLB1_MISSES",
+		"BriefDescription": "ITLB1 Misses",
+		"PublicDescription": "Level-1 Instruction TLB miss in progress. Incremented by one for every cycle a ITLB1 miss is in progress."
+	},
+	{
+		"EventCode": "133",
+		"EventName": "L2C_STORES_SENT",
+		"BriefDescription": "L2C Stores Sent",
+		"PublicDescription": "Incremented by one for every store sent to Level-2 cache"
+	},
+	{
+		"EventCode": "134",
+		"EventName": "L1D_OFFBOOK_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Book L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an Off Book Level-3 cache"
+	},
+	{
+		"EventCode": "135",
+		"EventName": "L1D_ONBOOK_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Book L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an On Book Level-4 cache"
+	},
+	{
+		"EventCode": "136",
+		"EventName": "L1I_ONBOOK_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Book L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an On Book Level-4 cache"
+	},
+	{
+		"EventCode": "137",
+		"EventName": "L1D_RO_EXCL_WRITES",
+		"BriefDescription": "L1D Read-only Exclusive Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+	},
+	{
+		"EventCode": "138",
+		"EventName": "L1D_OFFBOOK_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Book L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
+	},
+	{
+		"EventCode": "139",
+		"EventName": "L1I_OFFBOOK_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Book L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
+	},
+	{
+		"EventCode": "140",
+		"EventName": "DTLB1_HPAGE_WRITES",
+		"BriefDescription": "DTLB1 One-Megabyte Page Writes",
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page"
+	},
+	{
+		"EventCode": "141",
+		"EventName": "L1D_LMEM_SOURCED_WRITES",
+		"BriefDescription": "L1D Local Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache where the installed cache line was sourced from memory that is attached to the same book as the Data cache (Local Memory)"
+	},
+	{
+		"EventCode": "142",
+		"EventName": "L1I_LMEM_SOURCED_WRITES",
+		"BriefDescription": "L1I Local Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache where the installed cache line was sourced from memory that is attached to the same book as the Instruction cache (Local Memory)"
+	},
+	{
+		"EventCode": "143",
+		"EventName": "L1I_OFFBOOK_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Book L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Book Level-3 cache"
+	},
+	{
+		"EventCode": "144",
+		"EventName": "DTLB1_WRITES",
+		"BriefDescription": "DTLB1 Writes",
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer"
+	},
+	{
+		"EventCode": "145",
+		"EventName": "ITLB1_WRITES",
+		"BriefDescription": "ITLB1 Writes",
+		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer"
+	},
+	{
+		"EventCode": "146",
+		"EventName": "TLB2_PTE_WRITES",
+		"BriefDescription": "TLB2 PTE Writes",
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays"
+	},
+	{
+		"EventCode": "147",
+		"EventName": "TLB2_CRSTE_HPAGE_WRITES",
+		"BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes",
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays for a one-megabyte large page translation"
+	},
+	{
+		"EventCode": "148",
+		"EventName": "TLB2_CRSTE_WRITES",
+		"BriefDescription": "TLB2 CRSTE Writes",
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays"
+	},
+	{
+		"EventCode": "150",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an On Chip Level-3 cache"
+	},
+	{
+		"EventCode": "152",
+		"EventName": "L1D_OFFCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache"
+	},
+	{
+		"EventCode": "153",
+		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an On Chip Level-3 cache"
+	},
+	{
+		"EventCode": "155",
+		"EventName": "L1I_OFFCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 I-Cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index 735159593c2c..b9c673087011 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -1,2 +1,3 @@
 Family-model,Version,Filename,EventType
 209[78],1,cf_z10,core
+281[78],1,cf_z196,core
