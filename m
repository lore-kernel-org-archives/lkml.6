Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933338AbeCMMGZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:06:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933209AbeCMMGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:06:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA032178D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>, William Cohen <wcohen@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 16/31] perf vendor events arm64: Relocate Cortex A53 JSONs to arm subdirectory
Date: Tue, 13 Mar 2018 09:04:53 -0300
Message-Id: <20180313120508.29327-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

Since jevents now supports vendor subdirectory, relocate the Cortex-A53
JSONs to arm subdirectory.

Signed-off-by: John Garry <john.garry@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1520506716-197429-7-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/branch.json   | 0
 tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/bus.json      | 0
 tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/cache.json    | 0
 tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/memory.json   | 0
 tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/other.json    | 0
 tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/pipeline.json | 0
 tools/perf/pmu-events/arch/arm64/mapfile.csv                        | 2 +-
 7 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/branch.json (100%)
 rename tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/bus.json (100%)
 rename tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/cache.json (100%)
 rename tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/memory.json (100%)
 rename tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/other.json (100%)
 rename tools/perf/pmu-events/arch/arm64/{ => arm}/cortex-a53/pipeline.json (100%)

diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/cortex-a53/branch.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a53/branch.json
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/cortex-a53/bus.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a53/bus.json
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/cortex-a53/cache.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a53/cache.json
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/memory.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/cortex-a53/memory.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a53/memory.json
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/other.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/cortex-a53/other.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a53/other.json
diff --git a/tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/cortex-a53/pipeline.json
rename to tools/perf/pmu-events/arch/arm64/arm/cortex-a53/pipeline.json
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 952a05cbf675..cf14e23b6404 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -12,5 +12,5 @@
 #
 #
 #Family-model,Version,Filename,EventType
+0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
-0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
-- 
2.14.3
