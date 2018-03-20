Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751828AbeCTGXt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:23:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54793 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeCTGXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:23:46 -0400
Date: Mon, 19 Mar 2018 23:23:17 -0700
From: tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-e3b9f1e81de2083f359bacd2a94bf1c024f2ede0@git.kernel.org>
Cc: peterz@infradead.org, namhyung@kernel.org, jolsa@redhat.com,
        john.garry@huawei.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, wcohen@redhat.com,
        ganapatrao.kulkarni@cavium.com, alexander.shishkin@linux.intel.com,
        zhangshaokun@hisilicon.com, hpa@zytor.com, acme@redhat.com,
        ak@linux.intel.com, mingo@kernel.org, will.deacon@arm.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, wcohen@redhat.com,
        ganapatrao.kulkarni@cavium.com, peterz@infradead.org, jolsa@redhat.com,
        john.garry@huawei.com, namhyung@kernel.org, will.deacon@arm.com,
        hpa@zytor.com, zhangshaokun@hisilicon.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org, acme@redhat.com,
        ak@linux.intel.com
In-Reply-To: <1520506716-197429-6-git-send-email-john.garry@huawei.com>
References: <1520506716-197429-6-git-send-email-john.garry@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf vendor events arm64: Relocate ThunderX2 JSON
 to cavium subdirectory
Git-Commit-ID: e3b9f1e81de2083f359bacd2a94bf1c024f2ede0
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

Commit-ID:  e3b9f1e81de2083f359bacd2a94bf1c024f2ede0
Gitweb:     https://git.kernel.org/tip/e3b9f1e81de2083f359bacd2a94bf1c024f2ede0
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Thu, 8 Mar 2018 18:58:30 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:54:23 -0300

perf vendor events arm64: Relocate ThunderX2 JSON to cavium subdirectory

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
