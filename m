Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeCIOiB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:38:01 -0500
Received: from 123-192-241-158.dynamic.kbronet.com.tw ([123.192.241.158]:45036
        "EHLO E6440" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751145AbeCIOhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:37:47 -0500
From: Harry Pan <harry.pan@intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, Harry Pan <harry.pan@intel.com>, rjw@rjwysocki.net,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/3] powercap: intel_rapl: Add support for Cannon Lake
Date: Fri,  9 Mar 2018 20:15:46 +0800
Message-Id: <20180309121549.630-1-harry.pan@intel.com>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cannon Lake microarchitecture is similar to Kaby Lake in terms of
RAPL, this patch enables CNL RAPL support.

Signed-off-by: Harry Pan <harry.pan@intel.com>
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
2.13.5
