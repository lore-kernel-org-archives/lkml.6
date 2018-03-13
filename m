Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933338AbeCMMLm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933295AbeCMMGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:06:17 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CDE2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will.deacon@arm.com>, William Cohen <wcohen@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/31] perf vendor events arm64: Relocate ThunderX2 JSON to cavium subdirectory
Date: Tue, 13 Mar 2018 09:04:52 -0300
Message-Id: <20180313120508.29327-16-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Garry <john.garry@huawei.com>

Since jevents now supports vendor subdirectory, relocate
the ThunderX2 JSON to Cavium subdirectory.

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1520506716-197429-6-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../cavium/{thunderx2-imp-def.json => thunderx2/core-imp-def.json}      | 0
 tools/perf/pmu-events/arch/arm64/mapfile.csv                            | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/perf/pmu-events/arch/arm64/cavium/{thunderx2-imp-def.json => thunderx2/core-imp-def.json} (100%)

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
similarity index 100%
rename from tools/perf/pmu-events/arch/arm64/cavium/thunderx2-imp-def.json
rename to tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index e61c9ca6cf9e..952a05cbf675 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -12,5 +12,5 @@
 #
 #
 #Family-model,Version,Filename,EventType
-0x00000000420f5160,v1,cavium,core
+0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
-- 
2.14.3
