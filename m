Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165173AbeCBScy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 13:32:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:30438 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1165155AbeCBScx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 13:32:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,413,1515484800";
   d="scan'208";a="35041273"
From: Joe Konno <joe.konno@linux.intel.com>
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org
Subject: [PATCH] powercap / RAPL: add support for Cannon Lake
Date: Fri,  2 Mar 2018 10:32:51 -0800
Message-Id: <20180302183251.139493-1-joe.konno@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Konno <joe.konno@intel.com>

RAPL MSRs and handling for Cannon Lake are similar to Sky Lake and Kaby
Lake.

Signed-off-by: Joe Konno <joe.konno@intel.com>
---
 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 35636e1d8a3d..295d8dcba48c 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1162,6 +1162,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(INTEL_FAM6_SKYLAKE_X,		rapl_defaults_hsw_server),
 	RAPL_CPU(INTEL_FAM6_KABYLAKE_MOBILE,	rapl_defaults_core),
 	RAPL_CPU(INTEL_FAM6_KABYLAKE_DESKTOP,	rapl_defaults_core),
+	RAPL_CPU(INTEL_FAM6_CANNONLAKE_MOBILE,	rapl_defaults_core),
 
 	RAPL_CPU(INTEL_FAM6_ATOM_SILVERMONT1,	rapl_defaults_byt),
 	RAPL_CPU(INTEL_FAM6_ATOM_AIRMONT,	rapl_defaults_cht),
-- 
2.14.1
