Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeECTui (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:50:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751115AbeECTuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:50:37 -0400
From: William Cohen <wcohen@redhat.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, William Cohen <wcohen@redhat.com>
Subject: [PATCH] Remove duplicated entry for westmereep-dp in mapfile.csv
Date: Thu,  3 May 2018 15:50:32 -0400
Message-Id: <20180503195032.28871-1-wcohen@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: William Cohen <wcohen@redhat.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 93656f2fd53a..7e3cce3bcf3b 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -29,7 +29,6 @@ GenuineIntel-6-4D,v13,silvermont,core
 GenuineIntel-6-4C,v13,silvermont,core
 GenuineIntel-6-2A,v15,sandybridge,core
 GenuineIntel-6-2C,v2,westmereep-dp,core
-GenuineIntel-6-2C,v2,westmereep-dp,core
 GenuineIntel-6-25,v2,westmereep-sp,core
 GenuineIntel-6-2F,v2,westmereex,core
 GenuineIntel-6-55,v1,skylakex,core
-- 
2.14.3
