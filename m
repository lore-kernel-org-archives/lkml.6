Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965559AbeCHK7v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:59:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60432 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S935072AbeCHK7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:59:49 -0500
From: John Garry <john.garry@huawei.com>
To: <jolsa@redhat.com>, <ak@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>
CC: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhangshaokun@hisilicon.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v3 11/11] perf vendor events arm64: add HiSilicon hip08 JSON file
Date: Thu, 8 Mar 2018 18:58:36 +0800
Message-ID: <1520506716-197429-12-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-1-git-send-email-john.garry@huawei.com>
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

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/hisilicon/hip08/core-imp-def.json   | 122 +++++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 2 files changed, 123 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json

diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
new file mode 100644
index 0000000..9f0f15d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
@@ -0,0 +1,122 @@
+[
+    {
+        "ArchStdEvent": "L1D_CACHE_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL",
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
