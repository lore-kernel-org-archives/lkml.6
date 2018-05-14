Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeENLno (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:43:44 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:22542 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752659AbeENLnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:43:37 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180514114335epoutp01e2ecc174135eb27ce2830cc7d1e027d1~ugCPq-F4O0604106041epoutp01i
X-AuditID: b6c32a37-511ff70000001030-d7-5af976678882
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 07/14] thermal: ti-soc-thermal: remove
 ->tshut_[hot,cold]_mask fields
Date: Mon, 14 May 2018 13:42:14 +0200
Message-id: <1526298141-14045-8-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCmrm562c8og/Zp7BYbZ6xntZh/5Rqr
        xantTUwWl3fNYbOYvaSfxeJz7xFGiycP+9gc2D12zrrL7rF4z0smj74tqxg9jt/YzuTxeZNc
        AGsUl01Kak5mWWqRvl0CV8avk8+YCybqVUw5/pCxgfGNehcjJ4eEgInEhjOtrF2MXBxCAjsY
        Jc7taWSHcL4zSqz4PZsNpurgxQMsEIndjBJbtv5mhnB+MUrMXLyKGaSKTcBKYmL7KkYQW0TA
        TWLWkj9gNrPAVEaJTRPqQWxhgXCJ/xOeAk3i4GARUJWYcCYRJMwr4CFxdNITqGVyEiePTWYF
        sTkFPCU2tL9kA9klITCBTeLs7t2sIL0SAi4Sn6YmQNQLS7w6voUdIiwtcemoLUR5M6PEtx17
        mCFqJjBK7FkvBGFbSxw+fpEV4jQ+iXdfe6BG8kp0tEGVeEhc+vcMqtVR4mt/E9S7cxglNj67
        xDaBUWoBI8MqRrHUguLc9NRiwwJjveLE3OLSvHS95PzcTYzgmNQy38G44ZzPIUYBDkYlHt6A
        5T+ihFgTy4orcw8xSnAwK4nw7jb6GSXEm5JYWZValB9fVJqTWnyIUZqDRUmcd47S1yghgfTE
        ktTs1NSC1CKYLBMHp1QDY4+D07J7UXnSlzdOvNwyQyfml0TbmsyJs+dN1juzcWZ4xJHfCjm3
        FYqjhKb/1byRVdLzbebeW9UH1QVXaz38t+7d2ejv37kcurmVL39hWN6fIbPj8OysQw0npXtf
        H/L24U274HJf1U/95vv2sDtfWJpC23ct+Bd+yzmi/de8DGnetmzZR5oO+kosxRmJhlrMRcWJ
        AIG0Z7HFAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42I5/e+xgG5a2c8og/fzJC02zljPajH/yjVW
        i1Pbm5gsLu+aw2Yxe0k/i8Xn3iOMFk8e9rE5sHvsnHWX3WPxnpdMHn1bVjF6HL+xncnj8ya5
        ANYoLpuU1JzMstQifbsEroxfJ58xF0zUq5hy/CFjA+Mb9S5GTg4JAROJgxcPsIDYQgI7GSXu
        PWPtYuQCsn8xSkz9fIcZJMEmYCUxsX0VI4gtIuAmMWvJH0aQImaBqYwSkz+dYuti5OAQFgiX
        uPDNDsRkEVCVmHAmEaScV8BD4uikJ2wQu+QkTh6bzApicwp4Smxof8kGsddD4vbvFrYJjDwL
        GBlWMUqmFhTnpucWGxUY5qWW6xUn5haX5qXrJefnbmIEhtC2w1p9OxjvL4k/xCjAwajEw7ti
        5Y8oIdbEsuLK3EOMEhzMSiK8u41+RgnxpiRWVqUW5ccXleakFh9ilOZgURLnvZ13LFJIID2x
        JDU7NbUgtQgmy8TBKdXAuDVgTcrPQ86W0zvsmZ2ZrSPS52+ZJTCv12evhaCu5dyZ/FeTAp75
        KRd/W3Pjy+bYbD6zdzfFDYXOibDEHDY/Y2f58ZHgXenTd9a0/ZkQ91qgzmjGnRqT493Xkic0
        C2ndtPd+UhS6s60nmUk9vSDlm9e81DD1tautBbbM3nmnt3TFmVeFnjW/lFiKMxINtZiLihMB
        cQmnDB0CAAA=
X-CMS-MailID: 20180514114334epcas1p4c1b268d8253cda369826e67b06b4c28b
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180514114334epcas1p4c1b268d8253cda369826e67b06b4c28b
X-RootMTR: 20180514114334epcas1p4c1b268d8253cda369826e67b06b4c28b
References: <1526298141-14045-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180514114334epcas1p4c1b268d8253cda369826e67b06b4c28b@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.tshut_[hot,cold]_mask fields are set to identical values for
all sensors supporting TSHUT_CONFIG feature so remove them and
use common defines instead.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/ti-soc-thermal/omap4-thermal-data.c | 2 --
 drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h   | 4 ----
 drivers/thermal/ti-soc-thermal/omap5-thermal-data.c | 6 ------
 drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h   | 4 ----
 drivers/thermal/ti-soc-thermal/ti-bandgap.c         | 8 ++++----
 drivers/thermal/ti-soc-thermal/ti-bandgap.h         | 8 ++++----
 6 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
index 9545fe3..74d05cc 100644
--- a/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap4-thermal-data.c
@@ -110,8 +110,6 @@
 	.bgap_threshold = OMAP4460_BGAP_THRESHOLD_OFFSET,
 
 	.tshut_threshold = OMAP4460_BGAP_TSHUT_OFFSET,
-	.tshut_hot_mask = OMAP4460_TSHUT_HOT_MASK,
-	.tshut_cold_mask = OMAP4460_TSHUT_COLD_MASK,
 
 	.bgap_status = OMAP4460_BGAP_STATUS_OFFSET,
 	.status_hot_mask = OMAP4460_HOT_FLAG_MASK,
diff --git a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
index c1da37d..5ba4c62 100644
--- a/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h
@@ -130,10 +130,6 @@
 /* OMAP4460.BANDGAP_COUNTER bits */
 #define OMAP4460_COUNTER_MASK				(0xffffff << 0)
 
-/* OMAP4460.TSHUT_THRESHOLD bits */
-#define OMAP4460_TSHUT_HOT_MASK				(0x3ff << 16)
-#define OMAP4460_TSHUT_COLD_MASK			(0x3ff << 0)
-
 /* OMAP4460.BANDGAP_STATUS bits */
 #define OMAP4460_HOT_FLAG_MASK				BIT(1)
 #define OMAP4460_COLD_FLAG_MASK				BIT(0)
diff --git a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
index 51a6ab4..a7ca3b6 100644
--- a/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
+++ b/drivers/thermal/ti-soc-thermal/omap5-thermal-data.c
@@ -44,8 +44,6 @@
 	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_MPU_OFFSET,
 
 	.tshut_threshold = OMAP5430_BGAP_TSHUT_MPU_OFFSET,
-	.tshut_hot_mask = OMAP5430_TSHUT_HOT_MASK,
-	.tshut_cold_mask = OMAP5430_TSHUT_COLD_MASK,
 
 	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
 	.status_hot_mask = OMAP5430_HOT_MPU_FLAG_MASK,
@@ -75,8 +73,6 @@
 	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_GPU_OFFSET,
 
 	.tshut_threshold = OMAP5430_BGAP_TSHUT_GPU_OFFSET,
-	.tshut_hot_mask = OMAP5430_TSHUT_HOT_MASK,
-	.tshut_cold_mask = OMAP5430_TSHUT_COLD_MASK,
 
 	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
 	.status_hot_mask = OMAP5430_HOT_GPU_FLAG_MASK,
@@ -107,8 +103,6 @@
 	.bgap_threshold = OMAP5430_BGAP_THRESHOLD_CORE_OFFSET,
 
 	.tshut_threshold = OMAP5430_BGAP_TSHUT_CORE_OFFSET,
-	.tshut_hot_mask = OMAP5430_TSHUT_HOT_MASK,
-	.tshut_cold_mask = OMAP5430_TSHUT_COLD_MASK,
 
 	.bgap_status = OMAP5430_BGAP_STATUS_OFFSET,
 	.status_hot_mask = OMAP5430_HOT_CORE_FLAG_MASK,
diff --git a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
index ec536d8..e931ae0 100644
--- a/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h
@@ -93,10 +93,6 @@
 #define OMAP5430_MASK_HOT_MPU_MASK			BIT(1)
 #define OMAP5430_MASK_COLD_MPU_MASK			BIT(0)
 
-/* OMAP5430.TSHUT_THRESHOLD */
-#define OMAP5430_TSHUT_HOT_MASK				(0x3ff << 16)
-#define OMAP5430_TSHUT_COLD_MASK			(0x3ff << 0)
-
 /* OMAP5430.BANDGAP_STATUS */
 #define OMAP5430_HOT_CORE_FLAG_MASK			BIT(5)
 #define OMAP5430_COLD_CORE_FLAG_MASK			BIT(4)
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index cb9a27e..4d45160 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1003,10 +1003,10 @@ int ti_bandgap_probe(struct platform_device *pdev)
 
 		if (TI_BANDGAP_HAS(bgp, TSHUT_CONFIG)) {
 			/* Set initial Tshut thresholds */
-			RMW_BITS(bgp, i, tshut_threshold,
-				 tshut_hot_mask, ts_data->tshut_hot);
-			RMW_BITS(bgp, i, tshut_threshold,
-				 tshut_cold_mask, ts_data->tshut_cold);
+			RMW_BITS2(bgp, i, tshut_threshold,
+				 OMAP_TSHUT_HOT_MASK, ts_data->tshut_hot);
+			RMW_BITS2(bgp, i, tshut_threshold,
+				 OMAP_TSHUT_COLD_MASK, ts_data->tshut_cold);
 		}
 	}
 
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index 2e5b146..4d5b54a 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -72,6 +72,10 @@
 #define OMAP_T_HOT_MASK		(0x3ff << 16)
 #define OMAP_T_COLD_MASK	(0x3ff << 0)
 
+/* TSHUT_THRESHOLD */
+#define OMAP_TSHUT_HOT_MASK	(0x3ff << 16)
+#define OMAP_TSHUT_COLD_MASK	(0x3ff << 0)
+
 /**
  * struct temp_sensor_registers - descriptor to access registers and bitfields
  * @temp_sensor_ctrl: TEMP_SENSOR_CTRL register offset
@@ -90,8 +94,6 @@
  * @counter_mask: mask to bandgap_counter.counter
  * @bgap_threshold: BANDGAP_THRESHOLD register offset (TALERT thresholds)
  * @tshut_threshold: TSHUT_THRESHOLD register offset (TSHUT thresholds)
- * @tshut_hot_mask: mask to tshut_threhold.thot
- * @tshut_cold_mask: mask to tshut_threhold.thot
  * @bgap_status: BANDGAP_STATUS register offset
  * @status_hot_mask: mask to bandgap_status.hot
  * @status_cold_mask: mask to bandgap_status.cold
@@ -130,8 +132,6 @@ struct temp_sensor_registers {
 	u32	bgap_threshold;
 
 	u32	tshut_threshold;
-	u32	tshut_hot_mask;
-	u32	tshut_cold_mask;
 
 	u32	bgap_status;
 	u32	status_hot_mask;
-- 
1.9.1
