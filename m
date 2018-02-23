Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeBWPOk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:14:40 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56530 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751472AbeBWPOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:14:38 -0500
From: John Garry <john.garry@huawei.com>
To: <jolsa@redhat.com>, <ak@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>
CC: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhangshaokun@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 11/11] perf vendor events arm64: add HiSilicon hip08 JSON file
Date: Sat, 24 Feb 2018 00:05:32 +0800
Message-ID: <1519401932-205051-12-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the HiSilicon hip08 JSON file. This platform
follows the ARMv8 recommended IMPLEMENTATION DEFINED events, where
applicable.

The brief description is kept for readability, but is not strictly
required.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/hisilicon/hip08/core-imp-def.json   | 140 +++++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 2 files changed, 141 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
new file mode 100644
index 0000000..ca0be5e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
@@ -0,0 +1,140 @@
+[
+    {
+        "ArchStdEvent": "0x40",
+        "BriefDescription": "L1D cache access, read"
+    },
+    {
+        "ArchStdEvent": "0x41",
+        "BriefDescription": "L1D cache access, write"
+    },
+    {
+        "ArchStdEvent": "0x42",
+        "BriefDescription": "L1D cache refill, read"
+    },
+    {
+        "ArchStdEvent": "0x43",
+        "BriefDescription": "L1D cache refill, write"
+    },
+    {
+        "ArchStdEvent": "0x46",
+        "BriefDescription": "L1D cache Write-Back, victim"
+    },
+    {
+        "ArchStdEvent": "0x47",
+        "BriefDescription": "L1D cache Write-Back, cleaning and coherency"
+    },
+    {
+        "ArchStdEvent": "0x48",
+        "BriefDescription": "L1D cache invalidate"
+    },
+    {
+        "ArchStdEvent": "0x4C",
+        "BriefDescription": "L1D tlb refill, read"
+    },
+    {
+        "ArchStdEvent": "0x4D",
+        "BriefDescription": "L1D tlb refill, write"
+    },
+    {
+        "ArchStdEvent": "0x4E",
+        "BriefDescription": "L1D tlb access, read"
+    },
+    {
+        "ArchStdEvent": "0x4F",
+        "BriefDescription": "L1D tlb access, write"
+    },
+    {
+        "ArchStdEvent": "0x50",
+        "BriefDescription": "L2D cache access, read"
+    },
+    {
+        "ArchStdEvent": "0x51",
+        "BriefDescription": "L2D cache access, write"
+    },
+    {
+        "ArchStdEvent": "0x52",
+        "BriefDescription": "L2D cache refill, read"
+    },
+    {
+        "ArchStdEvent": "0x53",
+        "BriefDescription": "L2D cache refill, write"
+    },
+    {
+        "ArchStdEvent": "0x56",
+        "BriefDescription": "L2D cache Write-Back, victim"
+    },
+    {
+        "ArchStdEvent": "0x57",
+        "BriefDescription": "L2D cache Write-Back, cleaning and coherency"
+    },
+    {
+        "ArchStdEvent": "0x58",
+        "BriefDescription": "L2D cache invalidate"
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache prefetch access count",
+        "EventCode": "0x102e",
+        "EventName": "L1I_CACHE_PRF",
+        "BriefDescription": "L1I cache prefetch access count",
+    },
+    {
+        "PublicDescription": "Level 1 instruction cache miss due to prefetch access count",
+        "EventCode": "0x102f",
+        "EventName": "L1I_CACHE_PRF_REFILL",
+        "BriefDescription": "L1I cache miss due to prefetch access count",
+    },
+    {
+        "PublicDescription": "Instruction queue is empty",
+        "EventCode": "0x1043",
+        "EventName": "IQ_IS_EMPTY",
+        "BriefDescription": "Instruction queue is empty",
+    },
+    {
+        "PublicDescription": "Instruction fetch stall cycles",
+        "EventCode": "0x1044",
+        "EventName": "IF_IS_STALL",
+        "BriefDescription": "Instruction fetch stall cycles",
+    },
+    {
+        "PublicDescription": "Instructions can receive, but not send",
+        "EventCode": "0x2014",
+        "EventName": "FETCH_BUBBLE",
+        "BriefDescription": "Instructions can receive, but not send",
+    },
+    {
+        "PublicDescription": "Prefetch request from LSU",
+        "EventCode": "0x6013",
+        "EventName": "PRF_REQ",
+        "BriefDescription": "Prefetch request from LSU",
+    },
+    {
+        "PublicDescription": "Hit on prefetched data",
+        "EventCode": "0x6014",
+        "EventName": "HIT_ON_PRF",
+        "BriefDescription": "Hit on prefetched data",
+    },
+    {
+        "PublicDescription": "Cycles of that the number of issuing micro operations are less than 4",
+        "EventCode": "0x7001",
+        "EventName": "EXE_STALL_CYCLE",
+        "BriefDescription": "Cycles of that the number of issue ups are less than 4",
+    },
+    {
+        "PublicDescription": "No any micro operation is issued and meanwhile any load operation is not resolved",
+        "EventCode": "0x7004",
+        "EventName": "MEM_STALL_ANYLOAD",
+        "BriefDescription": "No any micro operation is issued and meanwhile any load operation is not resolved",
+    },
+    {
+        "PublicDescription": "No any micro operation is issued and meanwhile there is any load operation missing L1 cache and pending data refill",
+        "EventCode": "0x7006",
+        "EventName": "MEM_STALL_L1MISS",
+        "BriefDescription": "No any micro operation is issued and meanwhile there is any load operation missing L1 cache and pending data refill",
+    },
+    {
+        "PublicDescription": "No any micro operation is issued and meanwhile there is any load operation missing both L1 and L2 cache and pending data refill from L3 cache",
+        "EventCode": "0x7007",
+        "EventName": "MEM_STALL_L2MISS",
+        "BriefDescription": "No any micro operation is issued and meanwhile there is any load operation missing both L1 and L2 cache and pending data refill from L3 cache",
+    },
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index cf14e23..8f11aeb 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -14,3 +14,4 @@
 #Family-model,Version,Filename,EventType
 0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
+0x00000000480fd010,v1,hisilicon/hip08,core
-- 
1.9.1
