Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeENLnP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:43:15 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:42225 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752655AbeENLnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:43:12 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180514114310epoutp021fb5a7cb3ffb87cb9bff8d63dd6c2f1c~ugB4Jg8iR1663216632epoutp02w
X-AuditID: b6c32a47-bdfff70000001011-10-5af9764da734
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 02/14] thermal: ti-soc-thermal: fix comment in
 omap5xxx-bandgap.h
Date: Mon, 14 May 2018 13:42:09 +0200
Message-id: <1526298141-14045-3-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCmqa5v2c8og5UHhCw2zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsEroz9j+YwF7xhq9g1ewJjA+M/1i5GTg4JAROJGY9OMnYxcnEICexg
        lNi4+xOU851R4lnXdEaYqqlTpzNDJHYzShw7tJcVwvnFKHGmdwozSBWbgJXExPZVYB0iAm4S
        s5b8AbOZBaYySmyaUA9iCwsES3Qe3csGYrMIqEos3rGDqYuRg4NXwEPi4xl2iGVyEiePTQY7
        j1PAU2JD+0s2kF0SAhPYJOZdPg51kYvEip+7oH4Qlnh1fAtUs7TEs1UbGSEamhklvu3YwwyR
        mMAosWe9EIRtLXH4+EVWiOP4JDoO/2UHOUJCgFeiow2qxEPi8oKdTBC2o8TyO9OgHp7DKNG/
        eCrzBEapBYwMqxjFUguKc9NTi40KjPWKE3OLS/PS9ZLzczcxguNSy30H47ZzPocYBTgYlXh4
        A5b/iBJiTSwrrsw9xCjBwawkwrvb6GeUEG9KYmVValF+fFFpTmrxIUZpDhYlcd41Sl+jhATS
        E0tSs1NTC1KLYLJMHJxSDYwKDBff7O/PMelu1Xpy3Vb19TvBvdzzNRsm81fN0NnhcZhzy6uP
        iVImLAULDA5Lrfx+7sXk8pDbFdM7etr4v27/p8W+4eNrc8eDFy/vz1+yKVrRJmwPy5undfb3
        H70PnDrF6Nb7GAOZmd2nTDIPp2vfPXxsx6qw5tPB35duZPs4+5XNRI8FhpZvlFiKMxINtZiL
        ihMBujMTP8cCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphluLIzCtJLcpLzFFi42I5/e+xgK5P2c8og5PrjS02zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsEroz9j+YwF7xhq9g1ewJjA+M/1i5GTg4JAROJqVOnM3cxcnEICexk
        lLjz4iSU84tR4vSNH2wgVWwCVhIT21cxgtgiAm4Ss5b8YQQpYhaYyigx+dMpsCJhgWCJzqN7
        wWwWAVWJxTt2MHUxcnDwCnhIfDzDDrFNTuLksclgmzkFPCU2tL8EKxcCKrn9u4VtAiPPAkaG
        VYySqQXFuem5xUYFRnmp5XrFibnFpXnpesn5uZsYgWG07bBW/w7Gx0viDzEKcDAq8fAGLP8R
        JcSaWFZcmXuIUYKDWUmEd7fRzygh3pTEyqrUovz4otKc1OJDjNIcLErivPz5xyKFBNITS1Kz
        U1MLUotgskwcnFINjBttn8XU2C4XcJZtPHIo4MyaE731DIrcv4NUV3y9FLadK+fjKUFhpUMu
        Wc/eBrmbl12KPXloqu+kp1XL109+GTvP8kN1qu/HQwIyV5cGCQqZXvVcbPPFSr73cNCbTftS
        NPJO3lO5X7bBYmKc95aPyhllErbPfzOKVU158PJrj0vF9CjTo3nz1iuxFGckGmoxFxUnAgAp
        8w0VHwIAAA==
X-CMS-MailID: 20180514114308epcas2p3bba580c5500889f22d50549994b227db
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180514114308epcas2p3bba580c5500889f22d50549994b227db
X-RootMTR: 20180514114308epcas2p3bba580c5500889f22d50549994b227db
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114308epcas2p3bba580c5500889f22d50549994b227db@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment for OMAP5430.CORE register offsets is incorrect. Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
index 9096403..dcbf903 100644
--- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
@@ -55,7 +55,7 @@
 #define OMAP5430_BGAP_DTEMP_MPU_1_OFFSET		0x1E4
 #define OMAP5430_BGAP_DTEMP_MPU_2_OFFSET		0x1E8
 
-/* OMAP5430.MPU register offsets */
+/* OMAP5430.CORE register offsets */
 #define OMAP5430_FUSE_OPP_BGAP_CORE			0x8
 #define OMAP5430_TEMP_SENSOR_CORE_OFFSET		0x154
 #define OMAP5430_BGAP_THRESHOLD_CORE_OFFSET		0x1AC
-- 
1.9.1
