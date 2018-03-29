Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbeC2OBB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:01:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeC2OA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:00:59 -0400
Date: Thu, 29 Mar 2018 07:00:50 -0700
From: tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-3fb1a23155e91bd00281425041ec2381e435dcc2@git.kernel.org>
Cc: acme@redhat.com, brueckner@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        tmricht@linux.vnet.ibm.com, schwidefsky@de.ibm.com, hpa@zytor.com,
        tglx@linutronix.de, heiko.carstens@de.ibm.com
Reply-To: brueckner@linux.vnet.ibm.com, acme@redhat.com,
        heiko.carstens@de.ibm.com, hpa@zytor.com, tglx@linutronix.de,
        schwidefsky@de.ibm.com, mingo@kernel.org, tmricht@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20180326082538.2258-3-tmricht@linux.vnet.ibm.com>
References: <20180326082538.2258-3-tmricht@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events s390: Add JSON files for IBM
 zEC12 zBC12
Git-Commit-ID: 3fb1a23155e91bd00281425041ec2381e435dcc2
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

Commit-ID:  3fb1a23155e91bd00281425041ec2381e435dcc2
Gitweb:     https://git.kernel.org/tip/3fb1a23155e91bd00281425041ec2381e435dcc2
Author:     Thomas Richter <tmricht@linux.vnet.ibm.com>
AuthorDate: Mon, 26 Mar 2018 10:25:36 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 27 Mar 2018 13:13:38 -0300

perf vendor events s390: Add JSON files for IBM zEC12 zBC12

Add CPU measurement counter facility event description files (json
files) for IBM zEC12 and zBC12.

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180326082538.2258-3-tmricht@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../arch/s390/{cf_z10 => cf_zec12}/basic.json      |   0
 .../arch/s390/{cf_z10 => cf_zec12}/crypto.json     |   0
 .../pmu-events/arch/s390/cf_zec12/extended.json    | 212 +++++++++++++++++++++
 tools/perf/pmu-events/arch/s390/mapfile.csv        |   1 +
 4 files changed, 213 insertions(+)

diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/basic.json b/tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
similarity index 100%
copy from tools/perf/pmu-events/arch/s390/cf_z10/basic.json
copy to tools/perf/pmu-events/arch/s390/cf_zec12/basic.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_z10/crypto.json b/tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
similarity index 100%
copy from tools/perf/pmu-events/arch/s390/cf_z10/crypto.json
copy to tools/perf/pmu-events/arch/s390/cf_zec12/crypto.json
diff --git a/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json b/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
new file mode 100644
index 000000000000..8682126aabb2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_zec12/extended.json
@@ -0,0 +1,212 @@
+[
+	{
+		"EventCode": "128",
+		"EventName": "DTLB1_MISSES",
+		"BriefDescription": "DTLB1 Misses",
+		"PublicDescription": "Level-1 Data TLB miss in progress. Incremented by one for every cycle a DTLB1 miss is in progress."
+	},
+	{
+		"EventCode": "129",
+		"EventName": "ITLB1_MISSES",
+		"BriefDescription": "ITLB1 Misses",
+		"PublicDescription": "Level-1 Instruction TLB miss in progress. Incremented by one for every cycle a ITLB1 miss is in progress."
+	},
+	{
+		"EventCode": "130",
+		"EventName": "L1D_L2I_SOURCED_WRITES",
+		"BriefDescription": "L1D L2I Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Instruction cache"
+	},
+	{
+		"EventCode": "131",
+		"EventName": "L1I_L2I_SOURCED_WRITES",
+		"BriefDescription": "L1I L2I Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the Level-2 Instruction cache"
+	},
+	{
+		"EventCode": "132",
+		"EventName": "L1D_L2D_SOURCED_WRITES",
+		"BriefDescription": "L1D L2D Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the Level-2 Data cache"
+	},
+	{
+		"EventCode": "133",
+		"EventName": "DTLB1_WRITES",
+		"BriefDescription": "DTLB1 Writes",
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer"
+	},
+	{
+		"EventCode": "135",
+		"EventName": "L1D_LMEM_SOURCED_WRITES",
+		"BriefDescription": "L1D Local Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache where the installed cache line was sourced from memory that is attached to the same book as the Data cache (Local Memory)"
+	},
+	{
+		"EventCode": "137",
+		"EventName": "L1I_LMEM_SOURCED_WRITES",
+		"BriefDescription": "L1I Local Memory Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache where the installed cache line was sourced from memory that is attached to the same book as the Instruction cache (Local Memory)"
+	},
+	{
+		"EventCode": "138",
+		"EventName": "L1D_RO_EXCL_WRITES",
+		"BriefDescription": "L1D Read-only Exclusive Writes",
+		"PublicDescription": "A directory write to the Level-1 D-Cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line"
+	},
+	{
+		"EventCode": "139",
+		"EventName": "DTLB1_HPAGE_WRITES",
+		"BriefDescription": "DTLB1 One-Megabyte Page Writes",
+		"PublicDescription": "A translation entry has been written to the Level-1 Data Translation Lookaside Buffer for a one-megabyte page"
+	},
+	{
+		"EventCode": "140",
+		"EventName": "ITLB1_WRITES",
+		"BriefDescription": "ITLB1 Writes",
+		"PublicDescription": "A translation entry has been written to the Level-1 Instruction Translation Lookaside Buffer"
+	},
+	{
+		"EventCode": "141",
+		"EventName": "TLB2_PTE_WRITES",
+		"BriefDescription": "TLB2 PTE Writes",
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Page Table Entry arrays"
+	},
+	{
+		"EventCode": "142",
+		"EventName": "TLB2_CRSTE_HPAGE_WRITES",
+		"BriefDescription": "TLB2 CRSTE One-Megabyte Page Writes",
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays for a one-megabyte large page translation"
+	},
+	{
+		"EventCode": "143",
+		"EventName": "TLB2_CRSTE_WRITES",
+		"BriefDescription": "TLB2 CRSTE Writes",
+		"PublicDescription": "A translation entry has been written to the Level-2 TLB Common Region Segment Table Entry arrays"
+	},
+	{
+		"EventCode": "144",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On Chip Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "145",
+		"EventName": "L1D_OFFCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "146",
+		"EventName": "L1D_OFFBOOK_L3_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Book L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Book Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "147",
+		"EventName": "L1D_ONBOOK_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D On-Book L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On Book Level-4 cache"
+	},
+	{
+		"EventCode": "148",
+		"EventName": "L1D_OFFBOOK_L4_SOURCED_WRITES",
+		"BriefDescription": "L1D Off-Book L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
+	},
+	{
+		"EventCode": "149",
+		"EventName": "TX_NC_TEND",
+		"BriefDescription": "Completed TEND instructions in non-constrained TX mode",
+		"PublicDescription": "A TEND instruction has completed in a nonconstrained transactional-execution mode"
+	},
+	{
+		"EventCode": "150",
+		"EventName": "L1D_ONCHIP_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D On-Chip L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from a On Chip Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "151",
+		"EventName": "L1D_OFFCHIP_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D Off-Chip L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "152",
+		"EventName": "L1D_OFFBOOK_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1D Off-Book L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off Book Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "153",
+		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Chip Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "154",
+		"EventName": "L1I_OFFCHIP_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Chip L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "155",
+		"EventName": "L1I_OFFBOOK_L3_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Book L3 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Book Level-3 cache without intervention"
+	},
+	{
+		"EventCode": "156",
+		"EventName": "L1I_ONBOOK_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I On-Book L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Book Level-4 cache"
+	},
+	{
+		"EventCode": "157",
+		"EventName": "L1I_OFFBOOK_L4_SOURCED_WRITES",
+		"BriefDescription": "L1I Off-Book L4 Sourced Writes",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Book Level-4 cache"
+	},
+	{
+		"EventCode": "158",
+		"EventName": "TX_C_TEND",
+		"BriefDescription": "Completed TEND instructions in constrained TX mode",
+		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode"
+	},
+	{
+		"EventCode": "159",
+		"EventName": "L1I_ONCHIP_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I On-Chip L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On Chip Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "160",
+		"EventName": "L1I_OFFCHIP_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I Off-Chip L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Chip/On Book Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "161",
+		"EventName": "L1I_OFFBOOK_L3_SOURCED_WRITES_IV",
+		"BriefDescription": "L1I Off-Book L3 Sourced Writes with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off Book Level-3 cache with intervention"
+	},
+	{
+		"EventCode": "177",
+		"EventName": "TX_NC_TABORT",
+		"BriefDescription": "Aborted transactions in non-constrained TX mode",
+		"PublicDescription": "A transaction abort has occurred in a nonconstrained transactional-execution mode"
+	},
+	{
+		"EventCode": "178",
+		"EventName": "TX_C_TABORT_NO_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode not using special completion logic",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete"
+	},
+	{
+		"EventCode": "179",
+		"EventName": "TX_C_TABORT_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete"
+	},
+]
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index b9c673087011..c57f8e75fa23 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -1,3 +1,4 @@
 Family-model,Version,Filename,EventType
 209[78],1,cf_z10,core
 281[78],1,cf_z196,core
+282[78],1,cf_zec12,core
