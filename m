Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751938AbeCTGYS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:24:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46149 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeCTGYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:24:15 -0400
Date: Mon, 19 Mar 2018 23:23:44 -0700
From: tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-82e6fdd6c01257d64009defbbea19d12ba667670@git.kernel.org>
Cc: ganapatrao.kulkarni@cavium.com, wcohen@redhat.com, mingo@kernel.org,
        peterz@infradead.org, namhyung@kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, will.deacon@arm.com,
        alexander.shishkin@linux.intel.com, john.garry@huawei.com,
        ak@linux.intel.com, hpa@zytor.com, zhangshaokun@hisilicon.com,
        linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: tglx@linutronix.de, namhyung@kernel.org, mingo@kernel.org,
        peterz@infradead.org, wcohen@redhat.com,
        ganapatrao.kulkarni@cavium.com, acme@redhat.com,
        zhangshaokun@hisilicon.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com, hpa@zytor.com,
        john.garry@huawei.com, jolsa@redhat.com, will.deacon@arm.com
In-Reply-To: <1520506716-197429-7-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-7-git-send-email-john.garry@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events arm64: Relocate Cortex A53 JSONs
 to arm subdirectory
Git-Commit-ID: 82e6fdd6c01257d64009defbbea19d12ba667670
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

Commit-ID:  82e6fdd6c01257d64009defbbea19d12ba667670
Gitweb:     https://git.kernel.org/tip/82e6fdd6c01257d64009defbbea19d12ba667670
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Thu, 8 Mar 2018 18:58:31 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:54:29 -0300

perf vendor events arm64: Relocate Cortex A53 JSONs to arm subdirectory

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
